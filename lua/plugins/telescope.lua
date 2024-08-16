return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        "nvim-telescope/telescope-file-browser.nvim",
        'nvim-lua/plenary.nvim',
        "nvim-telescope/telescope-project.nvim"
    },
    config = function()
        local project_actions = require("telescope._extensions.project.actions")
        require("telescope").setup {
            pickers = {
                theme = "ivy",
                buffers = {
                    theme = "ivy",
                },
                command_history = {
                    theme = "ivy",
                },
                find_files = {
                    theme = "ivy",
                },
                live_grep = {
                    theme = "ivy",
                },
                help_tags = {
                    theme = "ivy",
                },
                oldfiles = {
                    theme = "ivy",
                },
            },
            extensions = {
                file_browser = {
                    theme = "ivy",
                    hijack_netrw = true,
                    prompt_path = true
                },
                project = {
                    base_dirs = {
                        "~/Desktop",
                        "~/Documents",
                    },
                    theme = "ivy",
                    hidden_files = true,
                    search_by = "title",
                    sync_with_nvim_tree = true,
                    on_project_selected = function(prompt_bufnr)
                        local project_path = project_actions.get_selected_path()
                        vim.cmd.tabnew()
                        require("nvim-tree.api").tree.toggle({ focus = true, find_file = true, })
                        vim.cmd.bd("#")
                        require('telescope.builtin').find_files({cwd = project_path, hidden = false})
                    end
                }
            }
        }
    end
}
