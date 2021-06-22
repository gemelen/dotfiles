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
-- metals {
M.setup_metals = function()
  metals_config = require('metals').bare_config
  metals_config.settings = {
     showInferredType = true,
     showImplicitArguments = true,
     showImplicitConversionsAndClasses = true
  }

  metals_config.on_attach = function()
    require('completion').on_attach();
  end

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
    local rust_on_attach = function(client)
        require('completion').on_attach(client);
    end

    local lsp_config = require('lspconfig')
    rust_config = {
        on_attach = rust_on_attach,
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
            enable = true,
            ignore = {"scala"}
        }
    }
    tree_sitter.setup(t_s_config)
end
-- }
M.setup = function()
    M.setup_nerd_tree()
    M.setup_pandoc()
    M.setup_metals()
    M.setup_rust()
    M.setup_telescope()
    M.setup_tree_sitter()
end

return M
