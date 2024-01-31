-- View Keybinds
vim.keymap.set("n", "<leader>vs", ":vsplit<CR>", {}) -- vertical split
vim.keymap.set("n", "<leader>vh", ":split<CR>", {}) -- horizontal split
vim.keymap.set("n", "<leader>x", ":q<CR>", {}) -- close Window

-- View Nav Keybinds
vim.keymap.set({ "n", "v", "i" }, "<C-h>", "<C-w>h", {})
vim.keymap.set({ "n", "v", "i" }, "<C-j>", "<C-w>j", {})
vim.keymap.set({ "n", "v", "i" }, "<C-k>", "<C-w>k", {})
vim.keymap.set({ "n", "v", "i" }, "<C-l>", "<C-w>l", {})
