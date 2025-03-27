vim.lsp.config['clangd'] = {
    cmd = { '/home/tonello/.local/share/nvim/mason/bin/clangd' },
    root_markers = { '.clangd', 'compile_commands.json' },
    filetypes = { 'c', 'cpp' },
}
