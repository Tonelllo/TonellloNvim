return {
    "akinsho/toggleterm.nvim",
    config = function()
        require('toggleterm').setup({
            size = 10,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_filenames = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = 'horizontal',
            close_on_exit = true,
            shell = vim.o.shell,
            on_create = function(term)
                if (vim.fn.expand('#')):find(".pddl") ~= nil then
                    -- term.cmd = "planutils activate"
                    cmd([[TermExec cmd="planutils activate"]])
                end
            end
        })
    end
}
