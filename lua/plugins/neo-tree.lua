return {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
        { "<leader>t", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require('neo-tree').setup({
            window = {
                width = 30
            }
        })
    end
}
