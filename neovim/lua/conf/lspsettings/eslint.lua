local conditional_features = function (client, bufnr)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.buf.inlay_hint(bufnr, true)
    end
end

local eslint_settings = { settings = {
  eslint = {
    filetypes = {
      "javascript",
      "typescript",
      "typescript.glimmer",
      "javascript.glimmer",
      "json",
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
    conditional_features(client, bufnr)
  end,
}}

return { eslint_settings }
