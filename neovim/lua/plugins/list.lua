require("lazy").setup({
    { "myusuf3/numbers.vim" },
    { url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
    { "lukas-reineke/indent-blankline.nvim" },
    { "xiyaowong/transparent.nvim" }, -- Switch on/off/Toggle transparency for editor itself
    { "kevinhwang91/nvim-ufo", dependencies = { 
            "kevinhwang91/promise-async"
        } 
    },      -- Folding configuration
    { "kevinhwang91/nvim-bqf" },
    { "hrsh7th/nvim-cmp", dependencies = {
            {"neovim/nvim-lspconfig"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"hrsh7th/cmp-buffer"},
            -- 🤷 https://github.com/hrsh7th/nvim-cmp/issues/304#issuecomment-939279715
            {"hrsh7th/cmp-vsnip"},
            {"hrsh7th/vim-vsnip"},
            {"hrsh7th/cmp-nvim-lsp-signature-help"}
        }
    },
    { "nvim-neo-tree/neo-tree.nvim", lazy = false, dependencies = {
            {"nvim-lua/plenary.nvim"},
            {"kyazdani42/nvim-web-devicons"},
            {"MunifTanjim/nui.nvim"},
        }
    },
    { "tomtom/tcomment_vim" },
    { "nvim-telescope/telescope.nvim", dependencies = {
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
    },
    { "vim-pandoc/vim-pandoc-syntax" },
    { "vim-pandoc/vim-pandoc" },
    { "npxbr/glow.nvim" },
    { "tpope/vim-fugitive" },
    { "nvim-treesitter/nvim-treesitter" },
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim", dependencies = {
            { "neovim/nvim-lspconfig"},
            { "williamboman/mason.nvim"},
        }
    },
    { "scalameta/nvim-metals" },
    { "mfussenegger/nvim-jdtls" },
    { "kosayoda/nvim-lightbulb" }
})
