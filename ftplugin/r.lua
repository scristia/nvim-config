vim.b.slime_cell_delimiter = '#\\s\\=%%'
-- system R's bundled readline (5.7) predates bracketed paste; only radian handles it
vim.b.slime_bracketed_paste = vim.fn.executable 'radian' == 1 and 1 or 0
