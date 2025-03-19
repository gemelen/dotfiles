return {
  { "williamboman/mason-lspconfig.nvim", lazy = false,
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig", dependencies = { { "folke/neodev.nvim", } } }
    }
  },
  { "scalameta/nvim-metals", lazy = false },
  { "mfussenegger/nvim-jdtls", lazy = false },
  { "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
        { "neovim/nvim-lspconfig" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope.nvim" },
    },
  },
  { "folke/trouble.nvim", opts = {}, cmd = "Trouble", },
  { "rktjmp/paperplanes.nvim" }
}
