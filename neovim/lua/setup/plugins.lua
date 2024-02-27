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
-- LSP/Scala {
M.setup_metals = function()
  metals_config = require('metals').bare_config()
  metals_config.settings = {
     showInferredType = true,
     showImplicitArguments = true,
     showImplicitConversionsAndClasses = true
  }

  metals_config.init_options.statusBarProvider = "on"

  -- add completion
  metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

  metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = '◈',
      }
    }
  )

  vim.api.nvim_create_augroup("lsp-scala", {})
  vim.api.nvim_create_autocmd(
    "FileType",
    {
      group = "lsp-scala",
      desc = "Metals: init or attach language server",
      pattern = {"scala", "sc", "sbt"},
      command = "lua require('metals').initialize_or_attach(metals_config)",
    }
  )
  vim.api.nvim_create_autocmd(
    "FileType",
    {
      group = "lsp-scala",
      desc = "Metals: setup completion",
      pattern = {"scala", "sbt"},
      command = "setlocal omnifunc=v:lua.vim.lsp.omnifunc"
    }
  )
  vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
      group = "lsp-scala",
      desc = "Metals: run scalafmt on write",
      pattern = {"scala", "sbt"},
      command = "lua vim.lsp.buf.format()"
    }
  )
  vim.api.nvim_create_autocmd(
    "CursorHold",
    {
      group = "lsp-scala",
      pattern = "<buffer>",
      command = "lua vim.lsp.buf.document_highlight()"
    }
  )
  vim.api.nvim_create_autocmd(
    {"BufEnter", "CursorHold", "InsertLeave"},
    {
      group = "lsp-scala",
      pattern = "<buffer>",
      command = "lua vim.lsp.codelens.refresh()"
    }
  )
  vim.api.nvim_create_autocmd(
    "CursorMoved",
    {
      group = "lsp-scala",
      pattern = "<buffer>",
      command = "lua vim.lsp.buf.clear_references()"
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

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local workspace_dir = '/tmp/jdtls-workspace/' .. project_name
    -- symlink update is required if JDTLS changed/upgraded
    local jdtls_path_macos = '$HOME/bin/jdt-ls/latest/libexec'
    local jdtls_path_linux = '$HOME/bin/jdt-ls/latest'
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
        bundles = {
          vim.fn.glob(vim.fn.expand('$HOME/bin/com.microsoft.java.debug.plugin.jar'), 1)
        },
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
    t_s_config = {
        ensure_installed = {
            "java", "python", "scala", "lua", "bash", "sql",
            "hcl", "dot", "dockerfile",
            "javascript", "typescript", "glimmer",
            "markdown", "markdown_inline",
            "hocon", "json", "yaml", "toml",
            "comment", "regex", "vim", "vimdoc"
        },
        highlight = {
            enable = true
        },
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
-- UFO {
M.setup_ufo = function()
    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- method 3 (via documentation), depends on Tree-sitter
    require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
            return {'treesitter', 'indent'}
        end
    })
end
-- }
-- all not included above {
M.setup_stuff = function()
  -- Terraform
  vim.api.nvim_create_augroup("lsp-terraform", {})
  vim.api.nvim_create_autocmd(
    "FileType",
    {
      group = "lsp-terraform",
      desc = "Spacing configuration for Terraform files",
      pattern = {"terraform"},
      command = "setlocal shiftwidth=2"
    }
  )
  vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
      group = "lsp-terraform",
      pattern = {"terraform"},
      command = "lua vim.lsp.buf.format({ async = false})",
    }
  )
  end
-- }
M.setup = function()
    M.setup_cmp()
    M.setup_metals()
    M.setup_java()
    M.setup_telescope()
    M.setup_tree_sitter()
    M.setup_virtual_lines()
    M.setup_ufo()
    M.setup_stuff()
end

return M
