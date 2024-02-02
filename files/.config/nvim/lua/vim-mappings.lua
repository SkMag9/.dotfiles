-- View Keybinds
vim.keymap.set("n", "<leader>vs", ":vsplit<CR>",
  { desc = "window: vertical split", })

vim.keymap.set("n", "<leader>vh", ":split<CR>",
  { desc = "window: horizontal split", })

vim.keymap.set("n", "<leader>x", ":q<CR>",
  { desc = "window: close", })

-- View Nav Keybinds
vim.keymap.set({ "n", "v", "i" }, "<C-h>", "<C-w>h",
  { desc = "window: switch to the left", })

vim.keymap.set({ "n", "v", "i" }, "<C-j>", "<C-w>j",
  { desc = "window: switch down" })

vim.keymap.set({ "n", "v", "i" }, "<C-k>", "<C-w>k",
  { desc = "window: switch up" })

vim.keymap.set({ "n", "v", "i" }, "<C-l>", "<C-w>l",
  { desc = "window: switch to the right" })

-- Terminal
vim.keymap.set("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true),
  { desc = "terminal: close" })
