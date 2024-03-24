return {
  { "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context", name = "treesitter-context", config = true, }
    }
  }
}
