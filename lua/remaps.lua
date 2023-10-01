require "helpers/globals"
require "helpers/keyboard"

nm("<leader>bn", "<cmd>:bnext<CR>")
nm("<leader>bp", "<cmd>:bprevious<CR>")
nm("<leader>vs", "<cmd>:vertical split<CR>")
nm("<leader>ss", "<cmd>:split<CR>")
nm("<leader>wl", "<c-w>l")
nm("<leader>wh", "<c-w>h")
nm("<leader>wj", "<c-w>j")
nm("<leader>wk", "<c-w>k")
nm("<leader>wq", "<cmd>wq<CR>")
nm("<leader>bs", "<cmd>w<CR>")
nm("<leader>bsq", "<cmd>enew<bar>bd #<CR>")

function HowClose()
    api.nvim_exec([[
        function! HowClose()
            echo "hello"
            if len(getbufinfo({'buflisted':1})) > 1
                execute "bp"
                execute "bd #"
            else
                execute ":q"
                endif
        endfunction
    ]],false)
end


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

tm([[<c-\>]],[[<c-\><c-n>:q<cr>]])

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

nm("<leader>l","<cmd>lua _LAZYGIT_TOGGLE()<cr>");
