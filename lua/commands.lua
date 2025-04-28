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
  -- Could be improved with a --model command to try out different models if desired... or have this in opts if this is a plugin in the future
  local model = 'qwen2.5-coder'
  local prompt = opts.args
  local language = vim.bo.filetype
  prompt = prompt .. '\\nProvide all code in this programming langauge: ' .. language
  -- TODO: Need to handle if user puts a ' character or something (add \ I think)... right now it will end the string and throw an error
  -- TODO: Could consider adding separate commands: one for chatting and one for code generation
  -- Check this link out for structure: https://m4xshen.dev/posts/develop-a-neovim-plugin-in-lua. Probably go with lua/[plugin-name]/init.lua structure
  -- TODO: will this be just an ollama wrapper? if not, would need to support huggingface... which is way hardeer I think
  -- Looks to me like this has already been done with CodeCompanion https://github.com/olimorris/codecompanion.nvim
  local payload = '{"model":"' .. model .. '","prompt":"' .. prompt .. '","stream":false}'
  
  -- Build the curl command
  local cmd = "curl -s localhost:11434/api/generate -d '" .. payload .. "'"
  local result = vim.fn.system(cmd)

  -- Parse JSON response
  local success, parsed = pcall(vim.fn.json_decode, result)

  if success and parsed.response then
    -- Get the response text
    local text = parsed.response
    
    -- Replace literal \n with actual newlines
    text = text:gsub("\\n", "\n")

    -- Extract code
    -- TODO: Handle cases where this pattern doesn't match... just say there was an issue finding the code (might come up if the model doesn't provide code).
    local pattern = '```' .. language .. '(.-)```'
    text = text:match(pattern)
    
    -- Split into lines
    local lines = vim.split(text, "\n")
    
    -- Insert the lines at cursor position
    vim.api.nvim_put(lines, 'l', true, true)
  else
    vim.api.nvim_echo({{"Error: Could not get response from Ollama", "ErrorMsg"}}, false, {})
  end
end

vim.api.nvim_create_user_command('DiffWithSaved', diff_with_saved, {})
vim.api.nvim_create_user_command('MyCodeLLM', run_ollama_model, {nargs = '*'})

