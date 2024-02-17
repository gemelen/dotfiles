return {
  { "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- 🤷 https://github.com/hrsh7th/nvim-cmp/issues/304#issuecomment-939279715
      {"hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
      {"neovim/nvim-lspconfig"},
      {"hrsh7th/cmp-buffer"},
      {"hrsh7th/cmp-vsnip"},
      {"hrsh7th/vim-vsnip"},
      {"hrsh7th/cmp-nvim-lsp-signature-help"},
      { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
      { "L3MON4D3/LuaSnip", event = "InsertEnter", 
	dependencies = { "rafamadriz/friendly-snippets", },
      },
      { "hrsh7th/cmp-nvim-lua" }
    }
  }
}
