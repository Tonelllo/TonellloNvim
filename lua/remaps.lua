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
local gs = package.loaded.gitsigns
local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

-- mappings for normal mode
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
            v = { "<cmd>vertical split<CR>", "Vertical split" },
            o = { "<cmd>split<CR>", "Horizzontal Split" }
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
        n = { "<cmd>Neotree toggle show<cr>", "Toggle neotree" },
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
        },
        g = {
            name = "+Gitsigns",
            s = {gs.stage_hunk, "Stage hunk"},
            r = {gs.reset_hunk, "Reset hunk"},
            S = {gs.stage_buffer, "Stage buffer"},
            h = {gs.undo_stage_hunk, "Unstage hunk"},
            R = {gs.reset_buffer, "Reset buffer"},
            p = {gs.preview_hunk, "Preview hunk"},
            b = {function() gs.blame_line { full = true } end, "Line blame"},
            B = {gs.toglge_cunnent_line_blame, "Toggle blame"},
            d = {gs.diffthis, "Diff this"},
            D = {function() gs.diffthis('~') end, "Diff this"},
            t = {gs.toggle_deleted, "Toggle deleted"}
        }
    }
})

-- mapping for visual mode
wk.register({
    ["<leader>"] = {
        g = {
            name = "+Gitsigns",
            s = {function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Stage hunk"},
            r = {function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Stage hunk"}
        }
    }
},
{ mode = 'v'})

                -- Actions
                map('n', '<leader>hS', gs.stage_buffer)
                map('n', '<leader>hu', gs.undo_stage_hunk)
                map('n', '<leader>hR', gs.reset_buffer)
                map('n', '<leader>hp', gs.preview_hunk)
                map('n', '<leader>hb', function() gs.blame_line { full = true } end)
                map('n', '<leader>Tb', gs.toggle_current_line_blame)
                map('n', '<leader>hd', gs.diffthis)
                map('n', '<leader>hD', function() gs.diffthis('~') end)
                map('n', '<leader>td', gs.toggle_deleted)
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
