local function my_on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', 'l', api.node.open.preview, opts('Open Preview'))
    vim.keymap.set('n', 'h', api.node.open.preview, opts('Close Preview'))
    -- your removals and mappings go here
end

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            on_attach = my_on_attach,
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            disable_netrw = true,
            hijack_netrw = true,
            hijack_cursor = true,
            update_focused_file = {
                enable = true,
                update_root = true
            },
            filters = {
                git_ignored = false
            },
        }
    end,
}
