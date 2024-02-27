-- Overall usage pattern:
-- I'm interested only in completion, but not in snippets,
-- however completion plugin doesn't allow this without an 
-- engine selected.
-- See 🤷 https://github.com/hrsh7th/nvim-cmp/issues/304#issuecomment-939279715
return {
  { "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      --
      { "neovim/nvim-lspconfig" },
      -- sources
      { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
      { "hrsh7th/cmp-buffer", event = "InsertEnter" },
      { "hrsh7th/cmp-nvim-lsp-signature-help", event = "InsertEnter" },
      { "hrsh7th/cmp-nvim-lua", event = "InsertEnter"  },
      { "hrsh7th/cmp-nvim-lsp-document-symbol", event = "InsertEnter" },
      { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
      -- engine
      { "L3MON4D3/LuaSnip", version = "v2.*", event = "InsertEnter", dependencies = { "rafamadriz/friendly-snippets", }, },
    }
  }
}
