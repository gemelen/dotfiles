return {
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim", dependencies = {
      { "neovim/nvim-lspconfig"},
      { "williamboman/mason.nvim"},
    }
  },
  { "scalameta/nvim-metals" },
  { "mfussenegger/nvim-jdtls" }
}
