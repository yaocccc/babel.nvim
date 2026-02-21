local M = {}

function M.show_float(text, _original, opts)
  local lines = vim.split(text, "\n")

  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end
  width = math.min(width + 2, 80)
  local height = math.min(#lines, 20)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "babel"

  local win = vim.api.nvim_open_win(buf, false, {
    relative = "cursor",
    width = math.max(width, 10),
    height = height,
    row = 1,
    col = 0,
    style = "minimal",
    border = "rounded",
    title = "",
  })

  vim.wo[win].wrap = true
  vim.wo[win].cursorline = false
  vim.api.nvim_create_autocmd("CursorMoved", { callback = function() pcall(vim.api.nvim_win_close, win, true) end, once = true })
end

function M.show(text, original)
    M.show_float(text, original)
end

return M
