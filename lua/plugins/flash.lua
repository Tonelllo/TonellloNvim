return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        jump = {
            autojump = true
        },
        modes = {
            search = {
                enabled = false,
                highlight = {
                    backdrop = true
                },
                jump = {
                    autojump = true
                }
            },
            char = {
                enabled = false,
                highlight = {
                    backdrop = true,
                }
            }
        },
    },
    -- stylua: ignore
}
