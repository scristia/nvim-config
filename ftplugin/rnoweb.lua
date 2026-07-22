-- covers .Rnw and .Rtex (both detected as rnoweb)
-- cell boundaries are the noweb chunk header <<...>>= and terminator @,
-- so slime#send_cell() sends only the R code between them
vim.b.slime_cell_delimiter = [[^\s*<<.*>>=\|^@\s*$]]
-- system R's bundled readline (5.7) predates bracketed paste; only radian handles it
vim.b.slime_bracketed_paste = vim.fn.executable 'radian' == 1 and 1 or 0

-- wrap text, but by word no character
-- indent the wrappped line
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.wo.showbreak = '|'

-- override the global markdown-fence chunk inserter with a noweb one
local insert_noweb_chunk = function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'n', true)
  local keys = vim.api.nvim_replace_termcodes([[o<<>>=<cr>@<esc>O]], true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end

vim.keymap.set({ 'n', 'i' }, '<m-i>', insert_noweb_chunk, { buffer = true, desc = 'noweb code chunk' })
