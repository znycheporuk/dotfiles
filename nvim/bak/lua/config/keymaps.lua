-- Core keymaps configuration

local keymap = vim.keymap.set

-- Better up/down
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Save file
keymap({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Quit
keymap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Clear search with <esc>
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Move lines with Option+arrows (alternative to Option+hjkl)
keymap("n", "<M-Up>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
keymap("n", "<M-Down>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
keymap("i", "<M-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
keymap("i", "<M-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
keymap("v", "<M-Up>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })
keymap("v", "<M-Down>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
