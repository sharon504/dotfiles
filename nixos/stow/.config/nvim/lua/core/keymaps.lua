vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

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
vim.keymap.set("n", "[d", vim.diagnostic.jump, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<leader>ee", ":lua MiniFiles.open()<CR>", { desc = "Open MiniFiles" })

vim.keymap.set("n", "<leader>ld", "<CMD>LazyDocker<CR>", { desc = "Open LazyDocker" })

-- Copilot chat
vim.keymap.set("n", "<leader>aa", function()
	require("CopilotChat").toggle()
end, { desc = "AI Toggle" })

vim.keymap.set("v", "<leader>aa", function()
	require("CopilotChat").toggle()
end, { desc = "AI Open" })

vim.keymap.set("n", "<leader>ax", function()
	require("CopilotChat").reset()
end, { desc = "AI Reset" })

vim.keymap.set("n", "<leader>as", function()
	require("CopilotChat").stop()
end, { desc = "AI Stop" })

vim.keymap.set("n", "<leader>am", function()
	require("CopilotChat").select_model()
end, { desc = "AI Model" })

vim.keymap.set(
	"n",
	"<c-f>",
	":ToggleTerm size=40 dir=~/Desktop direction=float<CR>",
	{ desc = "Open terminal in float" }
)

vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "to exit terminal mode" })
vim.keymap.set("t", "<c-j>", "<c-\\><c-n><c-w>j", { desc = "To navigate to the bottom window" })
vim.keymap.set("t", "<c-k>", "<c-\\><c-n><c-w>k", { desc = "To navigate to the top window" })
vim.keymap.set("t", "<c-l>", "<c-\\><c-n><c-w>l", { desc = "To navigate to the right window" })
vim.keymap.set("t", "<c-h>", "<c-\\><c-n><c-w>h", { desc = "To navigate to the left window" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center the cursor when Ctrl-D " })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center the cursor when Ctrl-U " })

-- Source init.lua
vim.keymap.set("n", "<leader>sc", function()
	package.loaded["init"] = nil
	print("Reloaded init.lua")
	return require("init")
end, { desc = "Source the nvimrc" })

vim.keymap.set("n", "<Esc>", "<Esc>:noh<CR>", { desc = "remap <Esc> key to remove search highlights" })
vim.keymap.set("i", "<Esc>", "<Esc>:noh<CR>", { desc = "remap <Esc> key to remove search highlights" })

vim.keymap.set("n", "<leader><leader>sc", "<cmd>source %<CR>", { desc = "source config files" })

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>a", function()
	vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
	-- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })
vim.keymap.set(
	"n",
	"K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
		vim.cmd.RustLsp({ "hover", "actions" })
	end,
	{ silent = true, buffer = bufnr }
)
vim.keymap.set("n", "<leader>ng", function()
	require("neogit").open()
end, { desc = "Open neogit" })
