return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.install").compilers = { "clang", "gcc" }
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        -- Required by Treesitter
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "bash",
        "css",
        "csv",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "javascript",
        "jq",
        "json",
        "python",
        "sql",
        "terraform",
        "toml",
        "typescript",
        "vue",
        "xml",
        "yaml",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
