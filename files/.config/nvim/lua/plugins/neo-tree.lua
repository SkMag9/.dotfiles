return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    vim.keymap.set(
      "n",
      "<C-n>",
      ":Neotree toggle filesystem reveal left<CR>",
      {}
    )
    vim.keymap.set(
      "n",
      "<leader>e",
      ":Neotree focus filesystem reveal left<CR>",
      {}
    )
    vim.keymap.set(
      "n",
      "<leader>gs",
      ":Neotree toggle git_status reveal float<CR>",
      {}
    )

    require("neo-tree").setup({
      close_if_last_window = false,
      enable_git_status = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      default_component_configs = {
        modified = {
          symbol = "[~]",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "[A]",
            modified = "[M]",
            deleted = "[D]",
            renamed = "[R]",
            -- Status type
            untracked = "[/]",
            ignored = "[I]",
            unstaged = "[U]",
            staged = "[S]",
            conflict = "[C]",
          },
        },
      },
      window = {
        mappings = {
          ["P"] = {
            "toggle_preview", config = {
              use_float = true,
            }
          },
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
          ["a"] = {
            "add",
            config = {
              show_path = "relative"
            }
          },
          
        },
      },
    })
  end,
}
