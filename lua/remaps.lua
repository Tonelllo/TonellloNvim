local nvimTree = require('nvim-tree.api')
local utils = require("utils.functions")
local wk = require('which-key')

vim.g.mapleader = " "


wk.register({
    ["<leader>"] = {
        b = {
            name = "+Buffer",
            n = { "<cmd>bnext<CR>", "Next buffer" },
            p = { "<cmd>bprevious<CR>", "Previous buffer" },
            N = { "<cmd>BufferMoveNext<CR>", "Move to next buffer" },
            P = { "<cmd>BufferMovePrevious<CR>", "Move to previous buffer" },
            s = { "<cmd>w<CR>", "Save buffer" },
            k = { function() utils.HowClose() end, "Save and quit buffer" },
            r = { "<cmd>BufferRestore<cr>", "Restore closed buffer" },
            b = { "<cmd>BufferPick<cr>", "Pick a buffer" },
            D = { "<cmd>BufferPickDelete<cr>", "Delete a selected buffer" }
        },
        n = { function()
            utils.TreeToggleBarBar(); nvimTree.tree.toggle({focus = false}); 
        end, "Toggle neotree" },
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
        R = {"<cmd>so %<cr>", "Reload config file"}
    }
})
