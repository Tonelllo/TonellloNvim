return {
    'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
    config = function ()
        require('gitsigns').setup()
    end
}
