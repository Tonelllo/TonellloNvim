require "helpers/globals"
require "helpers/keyboard"

-- vim.cmd[[colorscheme neon]]
-- vim.cmd[[colorscheme nord]]

vim.cmd.colorscheme "catppuccin-frappe"

-- changing line numbers color
api.nvim_set_hl(0, 'LineNr', { fg = 'lightgray' })

-- cmd [[filetype plugin on]]

opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true
opt.conceallevel = 3   -- hide italic and bold markup

opt.signcolumn = "yes" -- keep the sign column
opt.showmode = false   -- no show mode because there is status line

opt.expandtab = true   -- Use spaces by default
opt.shiftwidth = 2     -- Set amount of space characters, when we press "<" or ">"
opt.tabstop = 2        -- 1 tab equal 2 spaces
-- opt.smartindent = true

opt.virtualedit = "block" -- ollow to go where there is no text in block mode

opt.fillchars = {
    foldopen = " ",
    foldclose = " ",
    fold = " ",
    foldsep = " ",
    diff = "/",
    eob = " "
}

opt.clipboard = 'unnamedplus' -- Use system clipboard
-- opt.fixeol = false

-- opt.foldmethod = 'syntax' -- Makes the startup extremely slow

opt.ignorecase = true  -- Ignore case if all characters in lower case
opt.joinspaces = false -- Join multiple spaces in search
opt.smartcase = true   -- When there is a one capital letter search for exact match
opt.showmatch = true   -- Highlight search instances

opt.splitbelow = true  -- Put new windows below current
opt.splitright = true  -- Put new vertical splits to right

opt.wildmenu = true
opt.wildmode = "longest:full,full"

opt.number = true
opt.relativenumber = true

opt.swapfile = false
--
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- -- disable folding at startup
-- opt.foldenable = false
opt.termguicolors = true

opt.scrolloff = 10

lsp.set_log_level("off")

-- opt.cmdheight = 0

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.diagnostic.config{
--     virtual_lines = true
-- }

if vim.fn.has("nvim-0.10") == 1 then
    opt.smoothscroll = true
end

if vim.g.neovide then
    opt.guifont = "CaskaydiaCove Nerd Font Mono:h18"
end
