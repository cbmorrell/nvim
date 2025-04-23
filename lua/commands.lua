-- Command to see the difference between current and last saved version of file
function DiffWithSaved()
  local filetype = vim.bo.filetype
  vim.cmd('diffthis')
  vim.cmd('vnew | r # | normal! 1Gdd')
  vim.cmd('diffthis')
  vim.cmd('setlocal bt=nofile bh=wipe nobl noswf ro ft=' .. filetype)
end

vim.cmd('command! DiffWithSaved lua DiffWithSaved()')

