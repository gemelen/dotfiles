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
--metals {
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
        prefix = '',
      }
    }
  )
end
--}

M.setup = function()
    M.setup_nerd_tree()
    M.setup_pandoc()
    M.setup_metals()
end

return M
