return {
    -- 'HiPhish/nvim-ts-rainbow2',
    {
        "github/copilot.vim",
        lazy = false,
    },
    {
        "stevearc/dressing.nvim",
        opts = {},
    },
    "windwp/nvim-ts-autotag",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    {
        "jose-elias-alvarez/null-ls.nvim",
        ft = { "python" },
    },
    "burntsushi/ripgrep",
    {
        "rest-nvim/rest.nvim",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    { "kosayoda/nvim-lightbulb" },
    {
        "mcauley-penney/tidy.nvim",
        opts = {
            enabled_on_save = false,
            filetype_exclude = { "markdown", "diff" },
        },
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "aurum77/live-server.nvim",
        run = function()
            require("live_server.util").install()
        end,
        cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
    },
    -- {
    -- 	"nvim-tree/nvim-tree.lua",
    -- 	version = "*",
    -- 	lazy = false,
    -- 	dependencies = {
    -- 		"nvim-tree/nvim-web-devicons",
    -- 	},
    -- 	config = function()
    -- 		require("nvim-tree").setup({})
    -- 	end,
    -- },
    --
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    }

    { "numToStr/Comment.nvim",  opts = {} },

    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",

            "hrsh7th/cmp-nvim-lsp",
        },
    },
    {
        "ThePrimeagen/harpoon",
    },

    "folke/neodev.nvim",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}, -- this is equalent to setup({}) function
    },

    { "nvim-treesitter/nvim-treesitter",    build = ":TSUpdate" },

    { "lukas-reineke/indent-blankline.nvim" },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    },
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000, -- Ensure it loads first
    },

    {
        "nyoom-engineering/nyoom.nvim",
        priority = 1000,
        name = nyoom,
    },

    { "ellisonleao/gruvbox.nvim", priority = 1000 },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },

    { "catppuccin/nvim",          name = "catppuccin", priority = 1000 },
    { "ThePrimeagen/vim-be-good" },
}
