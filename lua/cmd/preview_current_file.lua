local io = require("cmd.io")

local M = {}

-- Todo: improve to better search
local function is_oas_file(file_path)
  local file_str = io.read_file_as_string(file_path)

  -- only support OAS 3.x.x
  return string.match(file_str, 'openapi: 3.[%d]+.[%d]+')
end

function M.run()
  local current_file = io.get_current_file()

  if io.is_file_ext('md') ~= nil then
    -- this required 'iamcco/markdown-preview.nvim'
    return vim.cmd('MarkdownPreview')
  end

  if io.is_file_ext('yaml') ~= nil or io.is_file_ext('yml') ~= nil then
    -- this required 'vinnymeller/swagger-preview.nvim'
    if is_oas_file(current_file) ~= nil then
      return vim.cmd('SwaggerPreviewToggle')
    end
  end

  print("No preview action matched with" .. current_file)
end

return M
