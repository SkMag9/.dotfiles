return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()

    vim.keymap.set("n", "<leader>gd", ":Gitsigns preview_hunk<CR>",
      {silent=true, desc="preview git hunk"})
  end
}
