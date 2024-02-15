return {
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      {
	"nvim-treesitter/nvim-treesitter-context",
	name = "treesitter-context",
	config = true,
      }
    }
  }
}
