local f = require("api.functions")
local global = vim.g
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
                vim.fn["vsnip#anonymous"](args.body)
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
            }
        }
    }
    telescope.setup(extensions_config)
    telescope.load_extension('fzf')
end
-- }
-- Tree-sitter {
M.setup_tree_sitter = function()
    local tree_sitter = require('nvim-treesitter.configs')
    t_s_config = {
        ensure_installed = {"bash", "dockerfile", "java", "lua", "rust", "scala", "yaml"},
        highlight = {
            enable = true
        }
    }
    tree_sitter.setup(t_s_config)
end
-- }
M.setup = function()
    M.setup_nerd_tree()
    M.setup_pandoc()
    M.setup_cmp()
    M.setup_metals()
    M.setup_rust()
    M.setup_telescope()
    M.setup_tree_sitter()
end

return M
