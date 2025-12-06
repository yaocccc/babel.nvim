local M = {}

---Get visually selected text
---@return string Selected text or empty string if nothing selected
function M.get_visual_selection()
  -- Save current register content
  local saved_reg = vim.fn.getreg("v")
  local saved_regtype = vim.fn.getregtype("v")

  -- Yank selection to register "v"
  vim.cmd('noautocmd normal! "vy')

  -- Get yanked text
  local text = vim.fn.getreg("v")

  -- Restore register
  vim.fn.setreg("v", saved_reg, saved_regtype)

  return text
end

---Get word under cursor
---@return string Word under cursor
function M.get_word_under_cursor()
  return vim.fn.expand("<cword>")
end

return M
