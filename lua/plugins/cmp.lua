return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "lukas-reineke/cmp-under-comparator",
    },
    config = function()
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        local luasnip = require("luasnip")
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require 'cmp'
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
        local lspkind = require('lspkind')
        local cmp = require('cmp')
        cmp.setup {
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text',  -- show only symbol annotations
                    maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    expandable_indicator = false,
                    -- The function below will be called before any actual modifications from lspkind
                    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    before = function(entry, vim_item)
                        return vim_item
                    end
                })
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    require "cmp-under-comparator".under,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- they way you will only jump inside the snippet region
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer',
                    option = {
                        -- Every indexing_interval read indexing_batch_size lines
                        indexing_batch_size = 500,
                        indexing_interval = 500,
                        get_bufnrs = function()
                          local buf = vim.api.nvim_list_bufs()
                          -- local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                          -- if byte_size > 2048 * 2048 then -- 1 Megabyte max
                          --   return {}
                          -- end
                          return buf
                        end
                    }
                },
            })

            -- Set configuration for specific filetype.
        }
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
                { name = 'buffer' },
            })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })



        -- Set up lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require('lspconfig').matlab_ls.setup {
            -- cmd = { "matlab-language-server", "--stdio" , "--matlabLaunchCommandArgs", "\"\\\"-r \\\"addpath('CoopLab1/matlab_scripts_bimanual/simulation_scripts');\\\"\\\"\""},
            -- cmd = { "matlab-language-server", "--stdio" , "--matlabLaunchCommandArgs", "\"\\\"-r \\\"disp('CoopLab1/matlab_scripts_bimanual/simulation_scripts');\\\"\\\"\""},
            settings = {
                MATLAB = {
                    indexWorkspace = true,
                    -- telemetry = false,
                    -- matlabLaunchCommandArgs = "\"\\\"-r \\\"disp('/home/tonello/Documents/RobotEngPersonal/Y2S1/COOP/Franka/CoopLab1/matlab_scripts_bimanual/simulation_scripts');\\\"\\\"\"",
                }
            },
            capabilities = capabilities,
        }
        require('lspconfig').pyright.setup {
            settings = {
                pyright = {
                    -- Using Ruff's import organizer
                    disableOrganizeImports = true,
                },
                python = {
                    analysis = {
                        -- Ignore all files for analysis to exclusively use Ruff for linting
                        ignore = { '*' },
                    },
                },
            },
        }


        -- Disabling autocompletion for buffers that are too long
        -- vim.api.nvim_create_autocmd({"BufWinEnter", "BufEnter"},{
        --     pattern = "*",
        --     callback = function()
        --         if vim.api.nvim_buf_line_count(0) then
        --               print("Autocompleting with timeout because file too long")
        --               require('cmp').setup.buffer({enabled = false})
        --             local timer = nil
        --             vim.api.nvim_create_autocmd({ "TextChangedI", "CmdlineChanged" }, {
        --               pattern = "*",
        --               callback = function()
        --                 if timer then
        --                   vim.loop.timer_stop(timer)
        --                   timer = nil
        --                 end
        --
        --                 timer = vim.loop.new_timer()
        --                 timer:start(300, 0, vim.schedule_wrap(function()
        --                   require('cmp').complete({ reason = require('cmp').ContextReason.Auto })
        --                 end))
        --               end
        --             })
        --         end
        --     end
        -- })
    end
}
