return {
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require('mason').setup()

      require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {}
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["clangd"] = function()
          local cmp_nvim_lsp = require "cmp_nvim_lsp"
          require("lspconfig").clangd.setup {
            capabilities = cmp_nvim_lsp.default_capabilities(),
            cmd = {
              "clangd",
              "--offset-encoding=utf-16",
            },
          }
        end
        -- ["qmlls"] = function()
        --     require("qmlls").setup {
        --         cmd = { "/home/tonello/Qt/Tools/QtDesignStudio/qt6_design_studio_reduced_version/bin/qmlls" }
        --     }
        -- end
      }
    end
  }
}
