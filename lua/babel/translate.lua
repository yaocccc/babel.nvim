local M = {}

local config = require("babel.config")
local ui = require("babel.ui")

-- Provider registry
local providers = {
  google = require("babel.providers.google"),
}

---Get providers by name
---@param name string
---@return table?
local function get_provider(name)
  return providers[name]
end

---Translates text
---@param text string Text to translate
function M.translate(text)
  local opts = config.options
  local provider = get_provider(opts.provider)

  if not provider then
    vim.notify("Babel: Unknown provider: " .. opts.provider, vim.log.levels.ERROR)
    return
  end
  if text == "" then
    vim.notify("Babel: No text to translate", vim.log.levels.WARN)
    return
  end

  provider.translate(text, opts.source, opts.target, function(result, err)
    if err then
      vim.notify("Babel: " .. err, vim.log.levels.ERROR)
      return
    end
    -- Pass both translated and original text to UI
    ui.show(result, text)
  end)
end

return M
