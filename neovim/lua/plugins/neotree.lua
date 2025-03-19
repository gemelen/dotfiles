return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    branch = "v3.x",
    dependencies = {
      {"nvim-lua/plenary.nvim"},
      {"kyazdani42/nvim-web-devicons"},
      {"MunifTanjim/nui.nvim"},
    }
  },
  {
    "antosha417/nvim-lsp-file-operations",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function() require("lsp-file-operations").setup() end,
  },
}
