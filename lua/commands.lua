-- Command to see the difference between current and last saved version of file
local function diff_with_saved()
  local filetype = vim.bo.filetype
  vim.cmd('diffthis')
  vim.cmd('vnew | r # | normal! 1Gdd')
  vim.cmd('diffthis')
  vim.cmd('setlocal bt=nofile bh=wipe nobl noswf ro ft=' .. filetype)
end

vim.api.nvim_create_user_command('DiffWithSaved', diff_with_saved, {})

