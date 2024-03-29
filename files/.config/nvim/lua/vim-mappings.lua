-- View Keybinds
vim.keymap.set("n", "<leader>vs", ":vsplit<CR>",
  { desc = "window: vertical split", })

vim.keymap.set("n", "<leader>vh", ":split<CR>",
  { desc = "window: horizontal split", })

vim.keymap.set("n", "<leader>x", ":q<CR>",
  { desc = "window: close", })

-- Terminal
vim.keymap.set("n", "<leader>tv", ":vsplit<CR><C-w>l:term<CR>i",
  { desc = "split vertically and open terminal in new window" })

vim.keymap.set("n", "<leader>th", ":split<CR><C-w>j:term<CR>i",
  { desc = "aplit horizontally and open terminal in new window" })

vim.keymap.set("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true),
  { desc = "terminal: close" })

-- Editor
--local augroup_numtoggle = vim.api.nv
