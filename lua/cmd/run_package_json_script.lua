local pick_one = require('cmd.ui').pick_one
local M = {}

function M.get_scripts_from_package_json(filter)
  local path = vim.fn.getcwd() .. "/package.json"

  local file_str = require("cmd.io").read_file_as_string(path)

  if file_str == nil then
    print(path .. 'not found')

    return
  end

  local scripts = {}

  local decoded_table = vim.json.decode(file_str)

  if decoded_table == nil then
    error('decode json error, path:' .. path)
  end

  local scripts_table = decoded_table.scripts or {}

  for k in pairs(scripts_table) do
    if filter == nil or string.match(k, filter) ~= nil then
      table.insert(scripts, k)
    end
  end

  return scripts
end

function M.select_and_run_script()
  local scripts = M.get_scripts_from_package_json()

  if scripts == nil then
    return
  end

  table.sort(scripts)

  local script = pick_one(scripts, 'Select Cmd', function(item)
    return item
  end, function(result)
    print('Picked Script\n' .. result)
    if result ~= nil then
      vim.cmd({
        cmd = 'term',
        args = {
          'yarn',
          result
        }
      })
    end
  end)
end

return M
