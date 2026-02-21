local M = {}

function M.get_visual_selection()
  local saved_reg = vim.fn.getreg("v")
  local saved_regtype = vim.fn.getregtype("v")
  vim.cmd('noautocmd normal! "vy')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", saved_reg, saved_regtype)
  return text
end

function M.get_word_under_cursor()
  return vim.fn.expand("<cword>")
end

return M
