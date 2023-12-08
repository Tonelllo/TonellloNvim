return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require 'nvim-treesitter.configs'.setup {
            indent = {
                enable = true
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
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
            }
        }
        vim.treesitter.language.register('commonlisp', 'pddl')
    end
}
