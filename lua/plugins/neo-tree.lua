return {
    "nvim-neo-tree/neo-tree.nvim",
--    keys = {
--        { "<leader>n", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
--    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        {
            's1n7ax/nvim-window-picker',
            version = '2.*',
            config = function()
                require 'window-picker'.setup({
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        -- filter using buffer options
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { 'terminal', "quickfix" },
                        },
                    },
                })
            end,
        }
    },
    config = function()
        require('neo-tree').setup({
            window = {
                width = 30,
                mappings = {
                    ["<cr>"] = "open_with_window_picker"
                }
            },
        })
    end
}
