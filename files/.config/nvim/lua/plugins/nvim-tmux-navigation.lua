return {
  "alexghergh/nvim-tmux-navigation",
  config = function()
    local nvim_tmux_nav = require("nvim-tmux-navigation")
    nvim_tmux_nav.setup({})

    -- View Nav Keybinds
    vim.keymap.set({ "n", "v", "i" }, "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft,
      { desc = "window: switch to the left", })

    vim.keymap.set({ "n", "v", "i" }, "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown,
      { desc = "window: switch down" })

    vim.keymap.set({ "n", "v", "i" }, "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp,
      { desc = "window: switch up" })

    vim.keymap.set({ "n", "v", "i" }, "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight,
      { desc = "window: switch to the right" })
  end
}
