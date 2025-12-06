vim.api.nvim_create_user_command("Babel", function(opts)
  local babel = require("babel")
  if opts.args ~= "" then
    babel.translate(opts.args)
  else
    babel.translate_selection()
  end
end, { nargs = "?", range = true, desc = "Translate text" })

vim.api.nvim_create_user_command("BabelWord", function()
  require("babel").translate_word()
end, { desc = "Translate word under cursor " })
