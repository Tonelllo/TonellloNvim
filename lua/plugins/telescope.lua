return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        "nvim-telescope/telescope-file-browser.nvim",
        'nvim-lua/plenary.nvim',
        "nvim-telescope/telescope-project.nvim"
    },
    config = function()
        require("telescope").setup {
            extensions = {
                file_browser = {
                    theme = "ivy",
                    hijack_netrw = true,
                    prompt_path = true
                },
                project = {

                }
            }
        }
    end
}
