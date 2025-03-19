local M = {}

---@param client vim.lsp.Client
---@param bufnr integer?
M.on_attach = function(client, bufnr)
  if client.supports_method(client, "textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, {})
  end

end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument.diagnostic.dynamicRegistration = true
  capabilities.textDocument.foldingRange.dynamicRegistration = true
  capabilities.textDocument.signatureHelp.dynamicRegistration = true
  capabilities.textDocument.references.dynamicRegistration = true

  return capabilities
end

function M.setup()
  local mason_servers = {
    "bashls",
    "dockerls",
    "lua_ls",
    "pyright",
    "jsonls",
    "yamlls",
    "dotls",
    "gradle_ls",
    "helm_ls",
    "terraformls",
    "ts_ls",
    "clangd",
    "neocmake"
  }
  ---@diagnostic disable-next-line: unused-local
  local manually_handled_servers = {
    "scala",
    "java",
  }
  local servers = vim.tbl_deep_extend("force", mason_servers, {})
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = mason_servers,
    automatic_installation = false
  })
  local lspconfig = require("lspconfig")

  require("lspconfig.ui.windows").default_options.border = "rounded"

  for _, server in pairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = M.common_capabilities(),
    }

    local require_ok, settings = pcall(require, "conf.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    if server == "lua_ls" then
      require("neodev").setup({})
    end

    lspconfig[server].setup(opts)
  end
end

return M
