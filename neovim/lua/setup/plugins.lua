-- vi:nospell
local M = {}

-- nvim-cmp {
M.setup_cmp = function()
    local cmp = require('cmp')

    local is_a_comment = function()
          -- disable completion in comments
          local context = require('cmp.config.context')
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == 'c' then
            return true
          else
            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
          end
        end

    local cmp_config = {
        enabled = is_a_comment,
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        mapping = {
            ['<Tab>']   = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
            ['<Down>']  = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
            ['<Up>']    = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
            ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_document_symbol' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'buffer' },
            { name = 'nvim_lua' },
        },
        window = {
          documentation = cmp.config.window.bordered(),
        },
        view = { entries = "custom", selection_order = 'near_cursor' },
        experimental = {
            ghost_text = false,
        }
    }
    cmp.setup(cmp_config)
end
-- }
-- Neo-tree {
M.setup_neotree = function ()
  local function copy_path(state)
    -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
    -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
    local node = state.tree:get_node()
    local filepath = node:get_id()
    local filename = node.name
    local modify = vim.fn.fnamemodify

    local results = {
      filepath,
      modify(filepath, ":."),
      modify(filepath, ":~"),
      filename,
      modify(filename, ":r"),
      modify(filename, ":e"),
    }

    -- TODO: redo index to result mapping so the list could be rearranged
    vim.ui.select({
      "1. Absolute path: " .. results[1],
      "2. Path relative to CWD: " .. results[2],
      "3. Path relative to HOME: " .. results[3],
      "4. Filename: " .. results[4],
      "5. Filename without extension: " .. results[5],
      "6. Extension of the filename: " .. results[6],
    }, { prompt = "Choose to copy to clipboard:" }, function(choice)
        if choice then
          local i = tonumber(choice:sub(1, 1))
          if i then
            local result = results[i]
            vim.fn.setreg('+', result)
            vim.notify("Copied: " .. result)
          else
            vim.notify("Invalid selection")
          end
        else
          vim.notify("Selection cancelled")
        end
      end)
  end

  local conf = {
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
          file_size = { enabled = false, },
          type = { enabled = false, },
          last_modified = { enabled = false, },
          created = { enabled = false, },
    },
    window = { mappings = { ["Y"] = copy_path } },
    filesystem = {
      filtered_items = { never_show = { ".git" }, never_show_by_pattern = { "*.zwc" } },
      follow_current_file = { enabled = true }
    },
  }
  require("neo-tree").setup(conf)
end
-- }
-- LSP/Scala {
M.setup_metals = function()
  METALS_CONFIG = require('metals').bare_config()
  METALS_CONFIG.settings = {
    -- https://github.com/scalameta/metals/blob/main/metals/src/main/scala/scala/meta/internal/metals/UserConfiguration.scala
    -- https://github.com/scalameta/nvim-metals/blob/main/doc/metals.txt#L175
    autoImportBuild = "all",
    bloopJvmProperties = {"-XX:+UseZGC", "-XX:+ZGenerational", "-Xmx2G"},
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    showInferredType = true,
    superMethodLensesEnabled = true,
  }

  METALS_CONFIG.init_options.statusBarProvider = "on"

  -- add completion
  METALS_CONFIG.capabilities = require('cmp_nvim_lsp').default_capabilities()

  METALS_CONFIG.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = '◈',
      }
    }
  )

  local init = function ()
    require('metals').initialize_or_attach(METALS_CONFIG)
    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
  end

  local lsp_scala_gid = vim.api.nvim_create_augroup("lsp-scala", {})
  vim.api.nvim_create_autocmd( "FileType", {
      group = lsp_scala_gid,
      desc = "Metals: init or attach language server, setup completion",
      pattern = {"scala", "sbt"},
      callback = init
    }
  )
  vim.api.nvim_create_autocmd( "FileType", {
      group = lsp_scala_gid,
      desc = "Spell: set check options",
      pattern = {"scala", "sbt"},
      command = "lua vim.bo.spellcapcheck=''"
    }
  )
end
-- }
-- LSP/Java {
M.setup_java = function()
    local jdtls_project_marker = {
        'pom.xml', 'build.gradle', -- main project file
        '.gradle',                 -- or directory
        'mvnw', 'gradlew'          -- or a wrapper for Maven/Gradle
    }

    local capabilities = {
        workspace = {
            configuration = true
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true
                }
            }
        }
    }
    local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
    extendedClientCapabilities.progressReportProvider = true
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    extendedClientCapabilities.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints"

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local workspace_dir = '/tmp/jdtls-workspace/' .. project_name
    -- symlink update is required if JDTLS changed/upgraded
    local jdtls_path_macos = '${XDG_DATA_HOME}/jdt-ls/latest/libexec'
    local jdtls_path_linux = '${XDG_DATA_HOME}/jdt-ls/latest'
    local launcher_plugin_path = vim.fn.expand('/plugins/org.eclipse.equinox.launcher_*.jar')
    local jdtls_path = 'FIXME if you see that'
    local config_name = 'FIXME if you see that'
    if vim.loop.os_uname().sysname == 'Darwin' then
        jdtls_path = jdtls_path_macos
        config_name = '/config_mac'
    else
        jdtls_path = jdtls_path_linux
        config_name = '/config_linux'
    end
    local jar = vim.fn.expand(jdtls_path .. launcher_plugin_path)
    local jdtlscfg = vim.fn.expand(jdtls_path .. config_name)
    jdtls_config = {
      cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', jar,
        '-configuration', jdtlscfg,
        '-data', workspace_dir
      },

      root_dir = require('jdtls.setup').find_root(jdtls_project_marker),

      flags = {
        allow_incremental_sync = true,
      },
      capabilities = capabilities,

      settings = {
        java = {
            configuration = {}
        }
      },

      init_options = {
        bundles = { vim.fn.glob(vim.fn.expand('${XDG_DATA_HOME}/jdt-ls/com.microsoft.java.debug.plugin.*.jar'), true) },
        extendedClientCapabilities = extendedClientCapabilities,
      },
    }

  vim.lsp.handlers['language/status'] = function() end

  -- UI
  local finders = require'telescope.finders'
  local sorters = require'telescope.sorters'
  local actions = require'telescope.actions'
  local pickers = require'telescope.pickers'

  require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
    local opts = {}
    pickers.new(opts, {
      prompt_title = prompt,
      finder    = finders.new_table {
        results = items,
        entry_maker = function(entry)
          return {
            value = entry,
            display = label_fn(entry),
            ordinal = label_fn(entry),
          }
        end,
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr)
        actions.goto_file_selection_edit:replace(function()
          local selection = actions.get_selected_entry(prompt_bufnr)
          actions.close(prompt_bufnr)

          cb(selection.value)
        end)

        return true
      end,
    }):find()
  end

  vim.api.nvim_create_augroup("lsp-java", {})
  vim.api.nvim_create_autocmd(
    "FileType",
    {
      group = "lsp-java",
      desc = "JDTLS: init or attach",
      pattern = "java",
      command = "lua require('jdtls').start_or_attach(jdtls_config)"
    }
  )
end
-- }
-- Telescope {
M.setup_telescope = function()
    local telescope = require('telescope')
    local extensions_config = {
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = false,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {}
            }
        }
    }
    telescope.setup(extensions_config)
    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
    telescope.load_extension('git_worktree')
    telescope.load_extension('yaml_schema')
end
-- }
-- Tree-sitter {
M.setup_tree_sitter = function()
    local tree_sitter = require('nvim-treesitter.configs')
    local t_s_config = {
        ensure_installed = {
            "java", "python", "scala", "lua", "sql",
            "c", "cpp",
            "go", "gomod", "gosum",
            "javascript", "typescript",
            "bash", "regex", "cmake", "make",
            "gitcommit", "git_config", "git_rebase", "diff",
            "hcl", "dot", "dockerfile", "helm", "terraform",
            "markdown", "markdown_inline",
            "hocon", "json", "yaml", "toml", "dhall", "ebnf", "ini", "xml",
            "comment", "vim", "vimdoc",
            "cue"
        },
        highlight = {
            enable = true,
            ---@diagnostic disable-next-line: unused-local
            disable = function(lang, buf)
                local max_filesize = 10 * 1024 * 1024 -- 10 MiB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        },
        incremental_selection = {
            enable = true,
        },
        indent = {
          enable = true,
        }
    }
    tree_sitter.setup(t_s_config)
end
-- }
-- virtual lines {
M.setup_virtual_lines = function()
    vim.diagnostic.config({ virtual_text = false, })
    require('lsp_lines').setup()
end
-- }
-- mini.nvim modules {
M.setup_mini = function()
  require('mini.ai').setup()
  require('mini.pick').setup()
  require('mini.extra').setup()
  require('mini.surround').setup()
end
-- }
-- easypick {
M.setup_easypick = function()
  local easypick = require("easypick")
  -- Recipies https://github.com/axkirillov/easypick.nvim/wiki
  easypick.setup({
    pickers = {
      -- list files inside current folder with default previewer
      {
        -- name for your custom picker, that can be invoked using :Easypick <name> (supports tab completion)
        name = "ls",
        -- the command to execute, output has to be a list of plain text entries
        command = "ls",
        -- specify your custom previwer, or use one of the easypick.previewers
        previewer = easypick.previewers.default()
      },
    }
  })
end
-- }
-- stuff: all not included above {
M.setup_stuff = function()
  -- LSP
  vim.api.nvim_create_autocmd( "BufWritePre" , {
      callback = function ()
        if vim.g.formatonsave then
          vim.notify("Format on save disabled", vim.log.levels.WARN)
          return
        end
        vim.lsp.buf.format({async = false, formatting_options = nil })
      end
    }
  )
  vim.api.nvim_create_autocmd( "CursorMoved" , {
      command = "lua vim.lsp.buf.clear_references()"
    }
  )
  -- Terraform
  vim.api.nvim_create_augroup("lsp-terraform", {})
  vim.api.nvim_create_autocmd( "FileType", {
      group = "lsp-terraform",
      desc = "Spacing configuration for Terraform files",
      pattern = {"terraform"},
      command = "setlocal shiftwidth=2"
    }
  )
  vim.api.nvim_create_autocmd( "BufWritePre", {
      group = "lsp-terraform",
      pattern = {"terraform"},
      command = "lua vim.lsp.buf.format({ async = false})",
    }
  )
  -- paperplanes (send text to an online paste bin
  require("paperplanes").setup({
    register = "+",
    provider = "0x0.st",
    provider_options = {},
    notifier = vim.notify or print,
  })
  -- legendary, see https://github.com/mrjones2014/legendary.nvim
  require('legendary').setup({})
  end
-- }
M.setup = function()
    M.setup_cmp()
    M.setup_neotree()
    M.setup_metals()
    M.setup_java()
    M.setup_telescope()
    M.setup_tree_sitter()
    M.setup_virtual_lines()
    M.setup_mini()
    M.setup_easypick()
    M.setup_stuff()
end

return M
