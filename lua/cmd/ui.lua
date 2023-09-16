local M = {}

-- NOTE: from "https://github.com/mfussenegger/nvim-dap/blob/b3d4408e29d924fe130c9397a7c3b3630b3ea671/lua/dap/ui.lua#L42"
function M.pick_one_sync(items, prompt, label_fn)
  local choices = { prompt }
  for i, item in ipairs(items) do
    table.insert(choices, string.format('%d: %s', i, label_fn(item)))
  end
  local choice = vim.fn.inputlist(choices)
  if choice < 1 or choice > #items then
    return nil
  end
  return items[choice]
end

-- NOTE: from "https://github.com/mfussenegger/nvim-dap/blob/b3d4408e29d924fe130c9397a7c3b3630b3ea671/lua/dap/ui.lua#L55C1-L79C1"
function M.pick_one(items, prompt, label_fn, cb)
  local co
  if not cb then
    co = coroutine.running()
    if co then
      cb = function(item)
        coroutine.resume(co, item)
      end
    end
  end
  cb = vim.schedule_wrap(cb)
  if vim.ui then
    vim.ui.select(items, {
      prompt = prompt,
      format_item = label_fn,
    }, cb)
  else
    local result = M.pick_one_sync(items, prompt, label_fn)
    cb(result)
  end
  if co then
    return coroutine.yield()
  end
end

return M
