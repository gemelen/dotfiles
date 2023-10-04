local f = require("api.functions")
local api = vim.api
local global = vim.g
local fn = vim.fn
local opt = f.opt

local M = {}

-- neotree {
M.setup_neo_tree = function()
    global["neo_tree_remove_legacy_commands"] = 1
end
-- }
-- Pandoc {
M.setup_pandoc = function()
    global["vim_markdown_toc_autofit"] = 1
    opt("w", "conceallevel", 2)
end
--}
-- nvim-cmp {
M.setup_cmp = function()
    local cmp = require('cmp')
    cmp_config = {
        snippet = {
            expand = function(args)
                fn["vsnip#anonymous"](args.body)
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
            { name = 'vsnip' },
            { name = 'buffer' },
        },
        experimental = {
            ghost_text = true,
        }
    }
    cmp.setup(cmp_config)
end
-- }
-- metals {
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

  api.nvim_create_augroup("LSPMetals", {})
  api.nvim_create_autocmd(
    "FileType",
    { 
      group = "LSPMetals", 
      desc = "Metals initialization for a file", 
      pattern = {"scala", "sbt"}, 
      command = "lua require('metals').initialize_or_attach(metals_config)"
    }
  )
  api.nvim_create_autocmd(
    "FileType",
    {
      group = "LSPMetals",
      desc = "Attach Metals completion function",
      pattern = {"scala"},
      command = "setlocal omnifunc=v:lua.vim.lsp.omnifunc"
    }
  )
  api.nvim_create_autocmd(
    "BufWritePre",
    {
      group = "LSPMetals",
      pattern = {"*.scala"}, -- double check if pattern is correct
      command = "lua vim.lsp.buf.format()"
    }
  )
  api.nvim_create_autocmd(
    "CursorHold",
    {
      group = "LSPMetals",
      pattern = "<buffer>",
      command = "lua vim.lsp.buf.document_highlight()"
    }
  )
  api.nvim_create_autocmd(
    {"BufEnter, CursorHold, InsertLeave"},
    {
      group = "LSPMetals",
      pattern = "<buffer>",
      command = "lua vim.lsp.codelens.refresh()"
    }
  )
  api.nvim_create_autocmd(
    "CursorMoved",
    {
      group = "LSPMetals",
      pattern = "<buffer>",
      command = "lua vim.lsp.buf.clear_references()"
    }
  )

end
-- }
-- LSP/Java {
M.setup_java = function()
    local project_name = fn.fnamemodify(fn.getcwd(), ':p:h:t')
    local workspace_dir = '/tmp/jdtls-workspace/' .. project_name
    -- update is required if JDTLS changed/upgraded
    local jdtls_path_macos = '/opt/homebrew/Cellar/jdtls/1.24.0/libexec'
    local jdtls_path_linux = '$HOME/bin/jdt-ls/latest'
    local launcher_plugin_path = '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'
    -- MacOS as a special case and Linux as "all others"
    local function launcher_paths ()
        if vim.loop.os_uname().sysname == 'Darwin' then 
            return (jdtls_path_macos .. launcher_plugin_path), (jdtls_path_macos .. '/config_mac')
        else 
            return (fn.expand(jdtls_path_linux .. launcher_plugin_path)), (fn.expand(jdtls_path_linux .. '/config_linux'))
        end
    end

    local jar, jdtlscfg = launcher_paths()
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

      root_dir = require('jdtls.setup').find_root({'pom.xml', 'mvnw', 'gradlew'}),

      settings = {
        java = {
        }
      },

      init_options = {
        bundles = {}
      },
    }

  vim.lsp.handlers['language/status'] = function() end

  api.nvim_create_augroup("LSPJava", {})
  api.nvim_create_autocmd(
    "FileType",
    {
      group = "LSPJava",
      desc = "JDTLS initialization for a file",
      pattern = "java",
      command = "lua require('jdtls').start_or_attach(jdtls_config)"
    }
  )
  api.nvim_create_autocmd(
    "BufReadPre",
    {
      group = "LSPJava",
      desc = "Assign 'java' filetype to pom.xml file",
      pattern = "pom.xml",
      command = "setlocal filetype=java"
    }
  )
end
-- }
-- LSP/Python {
M.setup_python = function()
    require('lspconfig').pyright.setup{}
end
-- }
-- LSP/Mason+Ember+other-frontend-stuff {
M.setup_ember_with_mason = function()
    local lsp = require('lspconfig')

    local function readFile(filePath)
      local file = io.open(filePath, "r")

      if not file then
        return nil
      end

      local contents = file:read("*all")

      file:close()

      return contents;
    end -- readFile

    local function read_nearest_ts_config(fromFile)
      local rootDir = lsp.util.root_pattern('tsconfig.json')(fromFile);

      if not rootDir then
        return nil
      end

      local tsConfig = rootDir .. "/tsconfig.json"
      local contents = readFile(tsConfig)

      if not contents then
        return nil
      end

      
      local isGlint = string.find(contents, '"glint"')

      return {
        isGlint = not not isGlint,
        rootDir = rootDir,
      };
    end -- read_nearest_ts_config

    local function is_glint_project(filename, bufnr) 
      local result = read_nearest_ts_config(filename)
      
      if not result then 
        return nil
      end

      if (not result.isGlint) then 
        return nil
      end

      return result.rootDir
    end -- is_glint_project

    local function is_ts_project(filename, bufnr) 
      local result = read_nearest_ts_config(filename)

      if not result then
        return nil
      end 

      if (result.isGlint) then 
        return nil
      end

      return result.rootDir
    end -- is_glint_project

    -- via https://github.com/NullVoxPopuli/dotfiles/blob/main/home/.config/nvim/lua/plugin-config/lsp/init.lua
    local servers = {
        -- Languages
        "html", "cssls", "tsserver",
        -- Frameworks
        "ember", "glint",
        -------------- Tools
        "graphql", "tailwindcss", "graphql",
        -------------- Linting / Formatting
        "eslint"
    }
    -- eslint config, see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
    local settings = {
      tailwindcss = {
        tailwindCSS = {
          includeLanguages = {
            markdown = "html",
            handlebars = "html",
            javascript = {
              glimmer = "javascript"
            },
            typescript = {
              glimmer = "javascript"
            }
          }
        }
      },
      tsserver = {
        maxTsServerMemory = 8000,
        implicitProjectConfig = {
          experimentalDecorators = true
        },
      }
    }

    require('mason').setup {
      ui = {
        icons = {
          server_installed = "✓",
          server_pending = "➜",
          server_uninstalled = "✗"
        }
      }
    }

    require('mason-lspconfig').setup {
      ensure_installed = servers,
      automatic_installation = false
    }

    local capabilities = require('cmp_nvim_lsp').default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )

    local conditional_features = function (client, bufnr) 
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.buf.inlay_hint(bufnr, true)
        end
    end

    for _, serverName in ipairs(servers) do
      local server = lsp[serverName]

      if (server) then
        if (serverName == 'tsserver') then 
          server.setup({
            single_file_support = false,
            root_dir = is_ts_project,
            capabilities = capabilities,
            settings = settings[serverName],
            on_attach = function(client, bufnr)
              keymap(bufnr)
              conditional_features(client, bufnr)
            end
          })
        elseif (serverName == 'glint') then 
          server.setup({
            root_dir = is_glint_project,
            capabilities = capabilities,
            settings = settings[serverName],
            on_attach = function(client, bufnr)
              keymap(bufnr)
              conditional_features(client, bufnr)
            end
          })
        elseif (serverName == 'eslint') then 
          server.setup({
            filetypes = { 
              "javascript", "typescript", 
              "typescript.glimmer", "javascript.glimmer", 
              "json", 
              "markdown" 
            },
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
              })
              conditional_features(client, bufnr)
            end,
          })
        else
          server.setup({
            capabilities = capabilities,
            settings = settings[serverName],
            on_attach = function(client, bufnr)
              keymap(bufnr)
              conditional_features(client, bufnr)
            end
          })
        end
      end
    end
end
-- }
-- Telescope {
M.setup_telescope = function()
    local telescope = require('telescope')
    extensions_config = {
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
    telescope.load_extension('scaladex')
    telescope.load_extension('ui-select')
end
-- }
-- Tree-sitter {
M.setup_tree_sitter = function()
    local tree_sitter = require('nvim-treesitter.configs')
    t_s_config = {
        ensure_installed = {
            "java", "python", "scala", "lua", "bash",
            "hcl",
            "javascript", "typescript", "glimmer",
            "dockerfile", "hocon", "json", "yaml", "toml", "comment", "regex",
            "sql"
        },
        highlight = {
            enable = true
        },
    }
    tree_sitter.setup(t_s_config)
end
-- }
-- Terraform {
M.setup_terraform = function()
    require('lspconfig').terraformls.setup{}
    require('lspconfig').tflint.setup{}
end
-- }
-- virtual lines {
M.setup_virtual_lines = function()
    vim.diagnostic.config({ virtual_text = false, })
    require('lsp_lines').setup()
end
-- }
-- all not included above {
M.setup_stuff = function()
  api.nvim_create_autocmd(
    {"CursorHold", "CursorHoldI"},
    {
      desc = "Attach lightbulb plugin",
      pattern = "*",
      command = "lua require('nvim-lightbulb').update_lightbulb()"
    }
  )
  api.nvim_create_autocmd(
    "BufWritePost",
    {
      desc = "Run packer compile every time list of plugins changed",
      pattern = "plugins/list.lua",
      command = "PackerCompile"
    }
  )
end
-- }
M.setup = function()
    M.setup_neo_tree()
    M.setup_pandoc()
    M.setup_cmp()
    M.setup_metals()
    M.setup_java()
    M.setup_python()
    M.setup_ember_with_mason()
    M.setup_telescope()
    M.setup_tree_sitter()
    M.setup_terraform()
    M.setup_virtual_lines()
    M.setup_stuff()
end

return M
