-- Autocmds are automatically loaded on the VeryLazy event.
-- Default autocmds: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local group = vim.api.nvim_create_augroup("gerardo_editor", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "*",
  callback = function(event)
    if vim.bo[event.buf].binary or not vim.bo[event.buf].modifiable then
      return
    end

    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
  desc = "Trim trailing whitespace on save",
})
