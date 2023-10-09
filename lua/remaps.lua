require "helpers/globals"
require "helpers/keyboard"

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

local wk = require("which-key")
local builtin = require('telescope.builtin')
local tel = require('telescope')
local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

wk.register({
    ["<leader>"] = {
        b = {
            name = "+Buffer",
            n = { "<cmd>bnext<CR>", "Next buffer" },
            p = { "<cmd>bprevious<CR>", "Previous buffer" },
            s = { "<cmd>w<CR>", "Save buffer" },
            q = { "<cmd>wq<cr>", "Save and quit buffer" },
        },
        s = {
            name = "+Split",
            v = { "<cmd>vertical split<CR>" },
            o = { "<cmd>split<CR>" }
        },
        w = {
            name = "+Window",
            l = { "<c-w>l", "Go to the right split" },
            h = { "<c-w>h", "Go to the left split" },
            j = { "<c-w>j", "Go to the lower split" },
            k = { "<c-w>k", "Go to the higer split" },
            q = { "<cmd>wq<CR>", "Save and quit window" },
        },
        t = {
            name = "+Telescope",
            f = { builtin.find_files, "Telescope find file" },
            g = { builtin.live_grep, "Telescope grep" },
            b = { builtin.buffers, "Telescope find buffer" },
            h = { builtin.help_tags, "Telescope find tags" },
            n = { tel.extensions.notify.notify, "Telescope find notifications" },
            o = { tel.extensions.notify.notify, "Telescope find notifications" }
        },
        n = { "<cmd>Neotree toggle<cr>", "Toggle neotree" },
        f = {
            name = "+File",
            o = { function() vim.lsp.buf.format { async = true } end, "Format current file" }
        },
        l = {"<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Open lazygit"},
        D = {
            name = "+Diagnostics",
            o = {vim.diagnostic.open_float, "Open diagnostic float"},
            p = {vim.diagnostic.goto_prev, "Go to previous diagnostic"},
            n = {vim.diagnostic.goto_next, "Go to next diagnostic"},
            l = {vim.diagnostic.setloclist, "Set local list"},
        }
    }
})

tm([[<c-\>]], [[<c-\><c-n>:q<cr>]])

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
        vim.keymap.set('n', '<space>Dg', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>fo', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
