local M = {}
M.options = {}

local defaults = {
  source = "auto",
  target = "zh",
  provider = "google",
  picker = "auto",
  keymaps = {
    translate = "<leader>tr",
    translate_word = "<leader>tw",
  },
  deepl = {
    api_key = nil,
    pro = nil,
    formality = "default",
  },
}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", defaults, opts or {})
end

return M
