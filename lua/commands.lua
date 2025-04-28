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
  local model = 'qwen2.5'
  local prompt = opts.args
  -- TODO: Need to handle if user puts a ' character or something (add \ I think)... right now it will end the string and throw an error
  local payload = '{"model":"' .. model .. '","prompt":"' .. opts.args .. '","stream":false}'
  
  -- Build the curl command
  local cmd = "curl -s localhost:11434/api/generate -d '" .. payload .. "'"
  local result = vim.fn.system(cmd)

  -- Parse JSON response
  local success, parsed = pcall(vim.fn.json_decode, result)
  
  if success and parsed.response then
    -- Insert the response at cursor position
    vim.api.nvim_put({parsed.response}, 'l', true, true)
  else
    vim.api.nvim_echo({{"Error: Could not get response from Ollama", "ErrorMsg"}}, false, {})
  end
end

vim.api.nvim_create_user_command('DiffWithSaved', diff_with_saved, {})
vim.api.nvim_create_user_command('MyCodeLLM', run_ollama_model, {nargs = '*'})


