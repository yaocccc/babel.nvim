local M = {}
local config = require("babel.config")
local translate = require("babel.translate")
local utils = require("babel.utils")

function M.setup(opts)
  config.setup(opts)

  local keymaps = config.options.keymaps
  vim.keymap.set("v", keymaps.translate, function()
    M.translate_selection()
  end, { desc = "Babel: Translate selection" })
  vim.keymap.set("n", keymaps.translate_word, function()
    M.translate_word()
  end, { desc = "Babel: Translate word" })
end

function M.translate(text)
  translate.translate(text)
end

function M.translate_selection()
  local text = utils.get_visual_selection()
  translate.translate(text)
end

function M.translate_word()
  local text = utils.get_word_under_cursor()
  translate.translate(text)
end

return M
