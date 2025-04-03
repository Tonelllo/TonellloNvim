return {
  "neovim/nvim-lspconfig",
  config = function ()
    require'lspconfig'.clangd.setup{}
    require'lspconfig'.cmake.setup{}
    require'lspconfig'.pylsp.setup{}
    require'lspconfig'.lua_ls.setup{}
  end
}
