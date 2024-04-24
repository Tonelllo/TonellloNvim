-- vim.cmd [[colorscheme catppuccin-frappe]]

-- changing line numbers color
vim.api.nvim_set_hl(0, 'LineNr', { fg = 'lightgray' })

vim.cmd [[filetype plugin on]]

vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.cursorline = true
vim.opt.conceallevel = 3   -- hide italic and bold markup

vim.opt.signcolumn = "yes" -- keep the sign column
vim.opt.showmode = false   -- no show mode because there is status line

vim.opt.expandtab = true   -- Use spaces by default
vim.opt.shiftwidth = 4     -- Set amount of space characters, when we press "<" or ">"
vim.opt.tabstop = 4        -- 1 tab equal 2 spaces
vim.opt.smartindent = true

vim.opt.virtualedit = "block" -- ollow to go where there is no text in block mode

vim.opt.fillchars = {
    foldopen = " ",
    foldclose = " ",
    fold = " ",
    foldsep = " ",
    diff = "/",
    eob = " "
}

vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.fixeol = false

vim.opt.foldmethod = 'syntax'

vim.opt.ignorecase = true  -- Ignore case if all characters in lower case
vim.opt.joinspaces = false -- Join multiple spaces in search
vim.opt.smartcase = true   -- When there is a one capital letter search for exact match
vim.opt.showmatch = true   -- Highlight search instances

vim.opt.splitbelow = true  -- Put new windows below current
vim.opt.splitright = true  -- Put new vertical splits to right

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- disable folding at startup
vim.opt.foldenable = false

vim.opt.termguicolors = true

vim.opt.scrolloff = 10

vim.opt.cmdheight = 0

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

if vim.fn.has("nvim-0.10") == 1 then
    vim.opt.smoothscroll = true
end

if vim.g.neovide then
    vim.opt.guifont = "CaskaydiaCove Nerd Font Mono:h18"
end
