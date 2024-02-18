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
  { "mfussenegger/nvim-jdtls" },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
        { "neovim/nvim-lspconfig" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope.nvim" },
    },
  }
}
