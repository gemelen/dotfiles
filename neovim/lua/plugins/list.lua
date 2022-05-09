return require("packer").startup(function(use)
    -- plugin manager
        use({ "wbthomason/packer.nvim" })
    -- Look and feel
        use({ "flazz/vim-colorschemes" })
        -- relative/absolue line numbers
        use({ "myusuf3/numbers.vim" })
        -- visual indentation
        use({ "lukas-reineke/indent-blankline.nvim" })
    -- Behaviour
        -- completion
        use({
            "hrsh7th/nvim-cmp",
            requires = {
                "neovim/nvim-lspconfig",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                -- 🤷
                -- https://github.com/hrsh7th/nvim-cmp/issues/304#issuecomment-939279715
                "hrsh7th/cmp-vsnip",
                "hrsh7th/vim-vsnip"
            }
        })
        -- file explorer
        use({ "scrooloose/nerdtree" })
        -- better-quick-fix
        use({ "kevinhwang91/nvim-bqf" })
        -- commenting
        use({ "tomtom/tcomment_vim" })
        -- telescope stuff
        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim"
            }
        })
        -- telescope extensions
        use({
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            requires = {
                "nvim-telescope/telescope.nvim"
            }
        })
        use({
            "softinio/scaladex.nvim",
            requires = {
                "nvim-telescope/telescope.nvim"
            }
        })
        use({
            "nvim-telescope/telescope-ui-select.nvim",
            requires = {
                "nvim-telescope/telescope.nvim"
            }
        })
    -- filetypes
        -- HOCON
        use({ "satabin/hocon-vim" })
        -- pandoc
        use({ "vim-pandoc/vim-pandoc-syntax" })
    -- Tools
        -- pandoc
        use({ "vim-pandoc/vim-pandoc" })
        -- glow inside neovim
        use({
            "npxbr/glow.nvim",
            run = ":GlowInstall",
            lock = true
        })
        -- git
        use({ "tpope/vim-fugitive" })
        -- tree-sitter
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        })
    -- LSP stuff
        -- client glue for many languages
        use({ 'neovim/nvim-lspconfig' })
        -- Scala
        use({ "scalameta/nvim-metals" })
        -- Java
        use({ "mfussenegger/nvim-jdtls" })
        -- code actions look&feel enhancement
        use({ "kosayoda/nvim-lightbulb" })
end)
