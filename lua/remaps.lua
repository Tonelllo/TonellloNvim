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
    ]], false)
end

local builtin = require('telescope.builtin')
local tel = require('telescope')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fn', tel.extensions.notify.notify, {})

tm([[<c-\>]], [[<c-\><c-n>:q<cr>]])

local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

nm("<leader>l", "<cmd>lua _LAZYGIT_TOGGLE()<cr>");

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)


-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>ws', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>fo', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
