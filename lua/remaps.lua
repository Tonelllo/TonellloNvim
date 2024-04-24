require "helpers/globals"
require "helpers/keyboard"

local wk       = require("which-key")
local builtin  = require('telescope.builtin')
local tel      = require('telescope')
local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
local flash    = require('flash')
local utils    = require("helpers.functions")
local nvimTree = require('nvim-tree.api')

tm([[<c-\>]], [[<c-\><c-n>:q<cr>]])


-- mappings for normal mode
wk.register({
    ["<leader>"] = {
        a = {
            name = "+Dap",
            b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
            r = { "<cmd>lua require'dap'.continue()<CR>", "Start debugger" },
            c = { "<cmd>lua require'dap'.close()<cr>", "Close debugging windows" }
        },
        b = {
            name = "+Buffer",
            n = { "<cmd>bnext<CR>", "Next buffer" },
            p = { "<cmd>bprevious<CR>", "Previous buffer" },
            N = { "<cmd>BufferMoveNext<CR>", "Move to next buffer" },
            P = { "<cmd>BufferMovePrevious<CR>", "Move to previous buffer" },
            s = { "<cmd>w<CR>", "Save buffer" },
            k = { utils.HowClose, "Save and quit buffer" },
            r = { "<cmd>BufferRestore<cr>", "Restore closed buffer" },
            b = { "<cmd>BufferPick<cr>", "Pick a buffer" },
            D = { "<cmd>BufferPickDelete<cr>", "Delete a selected buffer" }
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
            q = { "<cmd>q<cr>", "Save and quit window" },
        },
        t = {
            name = "+Telescope",
            f = { function() builtin.find_files({ cwd = utils.getTreePath() }) end, "Telescope find file" },
            g = { function() builtin.live_grep({ cwd = utils.getTreePath() }) end, "Telescope grep" },
            b = { builtin.buffers, "Telescope find buffer" },
            h = { builtin.help_tags, "Telescope find tags" },
            n = { tel.extensions.notify.notify, "Telescope find notifications" },
        },
        n = { function()
            utils.TreeToggleBarBar(); nvimTree.tree.toggle({focus = false});
        end, "Toggle neotree" },
        f = {
            name = "+File",
            o = { function() vim.lsp.buf.format { async = true } end, "Format current file" }
        },
        l = { utils.lazygit_toggle, "Open lazygit" },
        -- d = {
        --     name = "+Diagnostics",
        --     o = { vim.diagnostic.open_float, "Open diagnostic float" },
        --     p = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
        --     n = { vim.diagnostic.goto_next, "Go to next diagnostic" },
        --     l = { vim.diagnostic.setloclist, "Set local list" },
        -- },
        c = {
            name = "+Cmake",
            -- r = { "<cmd>CMakeRun<cr>", "Cmake run" },
            b = { "<cmd>CMakeBuild<cr>", "Cmake build" },
            c = { "<cmd>CMakeClean<cr>", "Cmake clean" },
            I = { "<cmd>CMakeInstall<cr>", "Cmake install" },
            d = { "<cmd>CMakeDebug<cr>", "Cmake debug" },
            t = { "<cmd>CMakeSelectBuildType<cr>", "Cmake select build type" }
        },
        h = {
            name = "+Flash",
            s = { flash.jump, "Flash jump" },
            t = { flash.treesitter, "Flash treesitter" },
            f = { flash.treesitter_search, "Flash treesitter search" },
        },
        T = {
            name = "+Tabs",
            t = { "<cmd>tabnew<cr>", "Open a new tab" },
            c = { "<cmd>tabclose<cr>", "Close tab" },
            n = { "<cmd>tabnext<cr>", "Next tab" },
            p = { "<cmd>tabprevious<cr>", "Previous tab" },
        },
        rn = { "<cmd>Lspsaga rename<cr>", "Rename file" },
        ca = { "<cmd>Lspsaga code_action<cr>", "Code action" },
        pd = { "<cmd>Lspsaga peek_definition<cr>", "Lspsaga peek definition" },
        gd = { "<cmd>Lspsaga goto_definition<cr>", "Lspsaga peek definition" },
        pt = { "<cmd>Lspsaga peek_type_definition<cr>", "Lspsaga peek type definition" },
        gt = { "<cmd>Lspsaga goto_type_definition<cr>", "Lspsaga goto type definition" },
        d = {
            name = "+Diagnostics",
            o = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Lspsaga show line diagnostic" },
            n = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Lspsaga next diagnostic" },
            p = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Lspsaga prev diagnostic" },
        },
        o = { "<cmd>Lspsaga outline<cr>", "Lspsaga open outline" },
        F = { "<cmd>NvimTreeFocus<cr>", "Neotree focus" },
        R = { "<cmd>so %<cr>", "Reload configuration file"}
    }
})

-- keep the highlight while moving the indent
vm('>', ">gv")
vm('<', "<gv")

wk.register({
    K = { "<cmd>Lspsaga hover_doc<cr>", "Lspsaga hover doc" },
    ["<F8>"] = { function()
        local ft = vim.bo.filetype
        if ft == 'ruby' then
            cmd("w")
            cmd("!ruby %")
        elseif ft == 'pddl' then
            cmd("w")
            cmd([[TermExec cmd="popf domain.pddl problem.pddl"]])
        end
    end, "Quickrun" },
})


-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        --vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>ws', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        --vim.keymap.set('n', '<space>Dg', vim.lsp.buf.type_definition, opts)
        --vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        --vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>fo', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
