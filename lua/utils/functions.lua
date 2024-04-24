local barbar = require('barbar.api')
local nvimTree = require('nvim-tree.api')

local M = {}

M.HowClose = function()
    local tbl = vim.fn.getbufinfo()
    local count = 0
    for _, v in pairs(tbl) do
        if v.listed == 1 then
            count = count + 1
        end
    end
    if count > 1 then
        vim.cmd("bp")
        vim.cmd("bd #")
    else
        vim.cmd("q")
    end
end

M.TreeToggleBarBar =  function()
    if not nvimTree.tree.is_visible() then
        barbar.set_offset(30, 'NvimTree')
    else
        barbar.set_offset(0)
    end
end

return M
