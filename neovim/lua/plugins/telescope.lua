return {
  { "nvim-telescope/telescope.nvim", lazy = false, dependencies = {
      {"nvim-lua/popup.nvim"},
      {"nvim-lua/plenary.nvim"}
    }
  },
  { "nvim-telescope/telescope-fzf-native.nvim", lazy = false, build = "make", dependencies = {
      { "nvim-telescope/telescope.nvim" }
    }
  },
  { "nvim-telescope/telescope-ui-select.nvim", dependencies = {
      { "nvim-telescope/telescope.nvim" }
    }
  }
}
