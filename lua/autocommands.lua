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
    local manpage = data.file:match("^/proc/+%d+/fd/+%d+$") ~= nil

    if not real_file and not no_name then
        return
    end

    if manpage then
        return
    end

    -- open the tree, find the file but don't focus it
    require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
    vim.api.nvim_exec_autocmds('BufWinEnter', { buffer = require('nvim-tree.view').get_bufnr() })
end
api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

api.nvim_create_autocmd({ "BufEnter", "BufLeave" }, {
    pattern = "*.pddl",
    callback = function()
        cmd("RainbowParentheses")
    end
})

function installProgram(name, cmd)
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

api.nvim_create_autocmd({ "VimEnter" }, {
    pattern = "VeryLazy",
    callback = function()
        local remoteInstalled = require('lazy.core.config').plugins["remote-nvim.nvim"] ~= nil
        local devpodInstalled = vim.fn.executable("devpod") == 1
        if remoteInstalled and not devpodInstalled then
            installProgram("devpod",
                [[curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64" && sudo install -c -m 0755 devpod /usr/local/bin && rm -f devpod]])
        end
        if not vim.fn.executable("ripgrep") then
            installProgram("ripgrep", [[sudo apt install ripgrep]])
        end
    end
})
