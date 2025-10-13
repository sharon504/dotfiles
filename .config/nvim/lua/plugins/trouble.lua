return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false, -- TODO: set to true later
  opts = {
    modes = {
      -- Add a custom mode for TODO comments
      todos = {
        mode = "diagnostics",
        filter = {
          any = {
            buf = 0,
            {
              severity = vim.diagnostic.severity.HINT,
              function(item)
                return item.message:match("TODO")
                  or item.message:match("FIXME")
                  or item.message:match("HACK")
                  or item.message:match("NOTE")
                  or item.message:match("WARNING")
              end,
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    require("trouble").setup(opts)
  end,
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
    {
      "<leader>xt",
      "<cmd>Trouble todo <cr>",
      desc = "TODOs (Trouble)",
    },
  },
}
