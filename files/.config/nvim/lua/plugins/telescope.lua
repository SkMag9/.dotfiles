return {
  "nvim-telescope/telescope.nvim", 
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local telescope_builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
    vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})
  end,
}
