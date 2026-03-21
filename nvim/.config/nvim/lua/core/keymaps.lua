vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
-- keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
-- keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Move selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection downwards" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection upwards" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<leader>ee", ":lua MiniFiles.open()<CR>", { desc = "Open MiniFiles" })

vim.keymap.set("n", "<leader>ld", "<CMD>LazyDocker<CR>", { desc = "Open LazyDocker" })

vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<c-j>", "<c-\\><c-n><c-w>j", { desc = "Navigate to bottom window in terminal" })
vim.keymap.set("t", "<c-k>", "<c-\\><c-n><c-w>k", { desc = "Navigate to top window in terminal" })
vim.keymap.set("t", "<c-l>", "<c-\\><c-n><c-w>l", { desc = "Navigate to right window in terminal" })
vim.keymap.set("t", "<c-h>", "<c-\\><c-n><c-w>h", { desc = "Navigate to left window in terminal" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center cursor on page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center cursor on page up" })

-- Source init.lua
vim.keymap.set("n", "<leader>sc", function()
	package.loaded["init"] = nil
	print("Reloaded init.lua")
	return require("init")
end, { desc = "Source the nvimrc" })

vim.keymap.set("n", "<Esc>", "<Esc>:noh<CR>", { desc = "Clear search highlights" })
vim.keymap.set("i", "<Esc>", "<Esc>:noh<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<leader><leader>sc", "<cmd>source %<CR>", { desc = "Source current config file" })

vim.keymap.set("n", "<leader>ng", function()
	require("neogit").open()
end, { desc = "Open neogit" })

vim.keymap.set("n", "<leader>p", ":Telescope projects<CR>", { desc = "Open project" })

vim.keymap.set(
	"n",
	"<leader>wt",
	"<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
	{ desc = "Show all git worktrees" }
)

vim.keymap.set(
	"n",
	"<leader>wn",
	"<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
	{ desc = "Create new git worktrees" }
)
