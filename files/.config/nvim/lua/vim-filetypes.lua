vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("jenkinsfile_detect", {}),
  pattern = { "Jenkinsfile" },
  callback = function ()
    vim.cmd("set filetype=groovy")
  end
})
