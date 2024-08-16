require "helpers/globals"

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.md", "*.latex" },
    callback = function()
        cmd("set tw=80")
    end
})

api.nvim_create_autocmd("QuitPre", {
    callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = api.nvim_list_wins()
        for _, w in ipairs(wins) do
            local bufname = api.nvim_buf_get_name(api.nvim_win_get_buf(w))
            if bufname:match("NvimTree_") ~= nil then
                table.insert(tree_wins, w)
            end
            if api.nvim_win_get_config(w).relative ~= '' then
                table.insert(floating_wins, w)
            end
        end
        if 1 == #wins - #floating_wins - #tree_wins then
            -- Should quit, so we close all invalid windows.
            for _, w in ipairs(tree_wins) do
                api.nvim_win_close(w, true)
            end
        end
    end
})

local function open_nvim_tree(data)
    -- buffer is a real file on the disk
    local real_file = fn.filereadable(data.file) == 1

    -- buffer is a [No Name]
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

    if not real_file and not no_name then
        return
    end

    -- open the tree, find the file but don't focus it
    require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
	vim.api.nvim_exec_autocmds('BufWinEnter', {buffer = require('nvim-tree.view').get_bufnr()})
end
api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

api.nvim_create_autocmd({"BufEnter", "BufLeave"}, {
    pattern = "*.pddl",
    callback = function ()
        cmd("RainbowParentheses")
    end
})
