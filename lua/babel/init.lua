---@class Babel Main plugin module
---@field setup fun(opts?: BabelOptions) Initialize plugin
---@field translate fun(text: string) Translate text
---@field translate_word fun() Translate word under cursor

---@type BabelConfig
local config = require("babel.config")

local translate = require("babel.translate")
local utils = require("babel.utils")

---@class Babel
local M = {}

---Initialize plugin
---@param opts? BabelOptions
function M.setup(opts)
  config.setup(opts)

  -- Setup keymaps from config
  local keymaps = config.options.keymaps

  -- Visual mode: translate selection
  vim.keymap.set("v", keymaps.translate, function()
    -- Exit VM first, then translate
    M.translate_selection()
  end, { desc = "Babel: Translate selection" })

  -- Normal mode: translate word under cursor
  vim.keymap.set("n", keymaps.translate_word, function()
    M.translate_word()
  end, { desc = "Babel: Translate word" })
end

---Translate text
---@param text string Text to translate
function M.translate(text)
  translate.translate(text)
end

---Translate visual selection
function M.translate_selection()
  local text = utils.get_visual_selection()
  translate.translate(text)
end

---Translate word under cursor
function M.translate_word()
  local text = utils.get_word_under_cursor()
  translate.translate(text)
end

return M
