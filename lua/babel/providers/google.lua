local M = {}
local NEWLINE_MARKER = " @@000@@ "

local function url_encode(str)
  if vim.uri_encode then
    return vim.uri_encode(str)
  end
  return string.gsub(str, "([^%w%-_.~])", function(c)
    return string.format("%%%02X", string.byte(c))
  end)
end

function M.translate(text, source, target, callback)
  local clean_text = text:gsub("\n", NEWLINE_MARKER)
  local encoded_text = url_encode(clean_text)

  local cmd = {
    "curl",
    "-s",
    "-X",
    "POST",
    "-H",
    "Content-Type: application/x-www-form-urlencoded",
    "-d",
    string.format("client=gtx&sl=%s&tl=%s&dt=t&q=%s", source, target, encoded_text),
    "https://translate.googleapis.com/translate_a/single",
  }

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      local response = table.concat(data, "")

      if response == "" then
        callback(nil, "Empty response")
        return
      end
      local ok, json = pcall(vim.json.decode, response)
      if not ok then
        callback(nil, "JSON parse error")
        return
      end
      local translated = ""

      if json[1] then
        for _, segment in ipairs(json[1]) do
          if segment[1] then
            translated = translated .. segment[1]
          end
        end
      end

      translated = translated:gsub(NEWLINE_MARKER, "\n")
      translated = translated:gsub("@@000@@", "\n")

      callback(translated, nil)
    end,
  })
end

return M
