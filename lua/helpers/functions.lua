local M = {}

local nvimTree = require('nvim-tree.api')
-- local barbar   = require('barbar.api')

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
        -- barbar.set_offset(30, 'NvimTree')
    else
        -- barbar.set_offset(0)
    end
end

M.lazygit_toggle = function()
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit  = Terminal:new({ cmd = "lazygit -p " .. vim.fn.getcwd(), hidden = false, direction = "float" })

    vim.print("lazygit -p " .. vim.fn.getcwd())
    lazygit:toggle()
end

M.installProgram = function(name, cmd)
    local ret = vim.fn.confirm("Devpod not installed. Install?", "&Yes\n&No", 2)
    if ret == 1 then
        vim.notify("Installing " .. name)
        vim.cmd("split")
        vim.cmd("resize 15")
        local buf = vim.api.nvim_create_buf(false, true) -- [listed=false, scratch=true]

        vim.api.nvim_set_current_buf(buf)

        vim.fn.termopen(
            cmd,
            {
                on_exit = function(_, code)
                    if code == 0 then
                        vim.schedule(function()
                            vim.api.nvim_buf_delete(buf, { force = true })
                        end)
                    else
                        vim.defer_fn(function()
                            vim.schedule(function()
                                vim.notify("Command failed (exit code " .. code .. ")", vim.log.levels.ERROR)
                                vim.api.nvim_buf_delete(buf, { force = true })
                            end)
                        end, 1500)
                    end
                end
            })
        vim.cmd("startinsert")
    end
end

return M
