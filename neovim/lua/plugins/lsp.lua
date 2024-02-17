return {
  { "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig",
	dependencies = {
	  { "folke/neodev.nvim", }
	}
      }
    }
  },
  { "scalameta/nvim-metals" },
  { "mfussenegger/nvim-jdtls" }
}
