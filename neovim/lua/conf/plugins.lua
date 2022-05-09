local f = require("api.functions")
local h = require("api.hacks")
local global = vim.g
local fn = vim.fn
local opt = f.opt

local M = {}

-- NERDTree {
M.setup_nerd_tree = function()
    global["NERDTreeMinimalUI"] = 1
    global["NERDTreeDirArrows"] = 1
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
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  metals_config.capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = '◈',
      }
    }
  )


  h.create_augroup({
    {
      "FileType",
      "scala,sbt",
      "lua require('metals').initialize_or_attach(metals_config)"
    },
    {
      "FileType",
      "scala",
      "setlocal omnifunc=v:lua.vim.lsp.omnifunc"
    },
    {
      "BufWritePre",
      "scala",
      "lua vim.lsp.buf.formatting()"
    },
    {
      "CursorHold",
      "<buffer>",
      "lua vim.lsp.buf.document_highlight()"
    },
    {
      "BufEnter,CursorHold,InsertLeave",
      "<buffer>",
      "lua vim.lsp.codelens.refresh()"
    },
    {
      "CursorMoved",
      "<buffer>",
      "lua vim.lsp.buf.clear_references()"
    },
  }, "LSPMetals")
end
-- }
-- LSP/Rust {
M.setup_rust = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local lsp_config = require('lspconfig')
    rust_config = {
        -- add completion
        capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
        settings = {
            ["rust-analyzer"] = {
                assist = {
                    importMergeBehavior = "last",
                    importPrefix = "by_self",
                },
                cargo = { loadOutDirsFromCheck = true },
                procMacro = { enable = true },
            }
        }
    }

    lsp_config.rust_analyzer.setup(rust_config)
end
-- }
-- LSP/Java {
M.setup_java = function()
    local project_name = fn.fnamemodify(fn.getcwd(), ':p:h:t')
    local workspace_dir = '/tmp/jdtls-workspace/' .. project_name
    -- update is required if JDTLS changed/upgraded
    local jdtls_path_macos = '/usr/local/Cellar/jdtls/1.9.0-202203031534/libexec'
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

  h.create_augroup({
    {
        "BufReadPre",
        "pom.xml",
        "setlocal filetype=java"
    },
    {
        "FileType",
        "java",
        "lua require('jdtls').start_or_attach(jdtls_config)"
    }
  }, "LSPJava")
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
        ensure_installed = {"bash", "dockerfile", "java", "lua", "rust", "scala", "yaml", "python"},
        highlight = {
            enable = true
        }
    }
    tree_sitter.setup(t_s_config)
end
-- }
-- all not included above {
M.setup_stuff = function()
  h.create_augroup({
    {
      "CursorHold,CursorHoldI",
      "*",
      "lua require('nvim-lightbulb').update_lightbulb()"
    },
  }, "LSPCodeActions")

  h.create_augroup({
    {
      "BufWritePost",
      "list.lua",
      "PackerCompile"
    }
  }, "PackerAutoCompile")
end
-- }
M.setup = function()
    M.setup_nerd_tree()
    M.setup_pandoc()
    M.setup_cmp()
    M.setup_metals()
    M.setup_rust()
    M.setup_java()
    M.setup_telescope()
    M.setup_tree_sitter()
    M.setup_stuff()
end

return M
