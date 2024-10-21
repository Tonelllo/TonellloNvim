return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- event = {"VeryLazy"},
    lazy = false,
    config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup {
            indent = {
                enable = true,
                disable = function(lang, bufnr)
                    return vim.api.nvim_buf_line_count(bufnr) > 100000
                end
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                disable = function(lang, bufnr)
                    return vim.api.nvim_buf_line_count(bufnr) > 100000
                end
            },
            -- rainbow = {
            --     enable = true,
            --     extended_mode = true,
            --     max_file_lines = nil,
            -- },
            ensure_installed = {
                "bash",
                "c",
                "latex",
                "lua",
                "markdown_inline",
                "markdown",
                "matlab",
                "org",
                "python",
                "rust"
            },
            auto_install = true
        }
        vim.treesitter.language.register('commonlisp', 'pddl')
    end
}
