-- Command to see the difference between current and last saved version of file
local function diff_with_saved()
  local filetype = vim.bo.filetype
  vim.cmd('diffthis')
  vim.cmd('vnew | r # | normal! 1Gdd')
  vim.cmd('diffthis')
  vim.cmd('setlocal bt=nofile bh=wipe nobl noswf ro ft=' .. filetype)
end

-- Command to prompt an LLM running locally on ollama
local function run_ollama_model(opts)
  -- Could be improved with a --model command to try out different models if desired
  local prompt = opts.args
  local command = 'ollama run qwen2.5 "' .. prompt .. '"'
  local handle = io.popen(command)
  if not handle then
    vim.notify('Failed to run command: ' .. command, vim.log.levels.ERROR)
    return
  end
  local result = handle:read("*a")
  handle:close()



  result = result:gsub("%z", "")
  print(prompt)
  print(command)
  print(result)
  vim.api.nvim_put({result}, 'c', true, true)
end

vim.api.nvim_create_user_command('DiffWithSaved', diff_with_saved, {})
vim.api.nvim_create_user_command('MyCodeLLM', run_ollama_model, {nargs = '*'})

