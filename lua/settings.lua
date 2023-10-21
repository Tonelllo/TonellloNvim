require "helpers/globals"
require "helpers/keyboard"

vim.cmd[[colorscheme neon]]
-- vim.cmd[[colorscheme nord]]

cmd[[filetype plugin on]]

opt.expandtab = true                -- Use spaces by default
opt.shiftwidth = 4                  -- Set amount of space characters, when we press "<" or ">"
opt.tabstop = 4                     -- 1 tab equal 2 spaces
opt.smartindent = true

opt.clipboard = 'unnamedplus' -- Use system clipboard
opt.fixeol = false

opt.foldmethod = 'syntax'

opt.ignorecase = true               -- Ignore case if all characters in lower case
opt.joinspaces = false              -- Join multiple spaces in search
opt.smartcase = true                -- When there is a one capital letter search for exact match
opt.showmatch = true                -- Highlight search instances

opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new vertical splits to right

opt.wildmenu = true
opt.wildmode = "longest:full,full"

opt.number = true
opt.relativenumber = true

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
-- disable folding at startup
opt.foldenable = false

opt.termguicolors = true

opt.scrolloff = 10
