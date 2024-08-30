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
                        local buffers = vim.api.nvim_list_bufs()
                        local actual = {}

                        -- Filter out nofile buffers created by plugins
                        for i = 1, #buffers, 1 do
                            local current = buffers[i]
                            local buftype = vim.bo[current].buftype

                            if buftype ~= "nofile" then table.insert(actual, current) end
                        end


                        local alphad = false
                        if #actual == 1 then
                            local last_buf = actual[1]
                            local bufname = vim.api.nvim_buf_get_name(last_buf)
                            if bufname == "" then
                                alphad = true
                            end
                        end

                        local project_path = project_actions.get_selected_path()
                        if not alphad then
                            vim.cmd.tabnew()
                        end
                        if alphad then
                            -- vim.cmd([[echo "Alpha detected"]])
                            vim.cmd("enew!")
                        end
                        vim.cmd.cd(project_path)
                        require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
                        -- vim.cmd.bd("#")
                        require('telescope.builtin').find_files({ cwd = project_path, hidden = false })
                    end
                }
            }
        }
    end
}
