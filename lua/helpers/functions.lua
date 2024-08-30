local M = {}

local nvimTree = require('nvim-tree.api')
local barbar   = require('barbar.api')

M.HowClose = function()
    local tbl = fn.getbufinfo()
    local count = 0
    for _, v in pairs(tbl) do
        if v.listed == 1 then
            count = count + 1
        end
    end
    if count > 1 then
        cmd("bp")
        cmd("bd #")
    else
        cmd("q")
    end
end

M.getTreePath = function()
    local node = nvimTree.tree.get_nodes()
    if node == nil then
        return "~"
    end
    return node.absolute_path
end

M.TreeToggleBarBar = function()
    if not nvimTree.tree.is_visible() then
        barbar.set_offset(30, 'NvimTree')
    else
        barbar.set_offset(0)
    end
end

M.lazygit_toggle = function()
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit  = Terminal:new({ cmd = "lazygit -p " .. vim.fn.getcwd(), hidden = false, direction = "float" })

    vim.print("lazygit -p " .. vim.fn.getcwd())
    lazygit:toggle()
end

return M
