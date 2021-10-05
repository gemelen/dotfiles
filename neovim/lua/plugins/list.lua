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
        use({ "nvim-lua/completion-nvim" })
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
        use({
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make"
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
end)
