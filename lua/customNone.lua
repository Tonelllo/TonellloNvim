local null_ls = require("null-ls")
local h = require("null-ls.helpers")
-- https://github.com/nvimtools/none-ls.nvim/blob/88821b67e6007041f43b802f58e3d9fa9bfce684/lua/null-ls/builtins/diagnostics/tfsec.lua#L26

local pddl_diag = {
    name = "pddl diagnostics",
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    filetypes = { "pddl" },
    generator = null_ls.generator({
        command = "pddl",
        args = function()
            local filetype = (vim.fn.expand("%")):match([[(%w*)%.pddl]]);
            return { filetype, "$FILENAME" }
        end,
        from_stderr = true,
        format = "raw",
        check_exit_code = function(code)
            return code <= 1
        end,

        on_output = function(params, done)
            local diagnostics = {};
            -- report any unexpected errors, such as partial file attempts
            if params.err then
                table.insert(diagnostics, { row = 1, col = 1, message = params.err })
            end
            -- nothing to do TODO
            if not params.output then
                return done(diagnostics)
            end
            local regex = "line (%d+) col (%d+)(.*)"

            local _row, _col, _message = string.match(params.output, regex)
            table.insert(diagnostics, {
                row = _row,
                col = _col,
                message = _message
            })
            done(diagnostics)
        end
    }),
}
local pddl_format = {
    name = "pddl formatting",
    method = null_ls.methods.FORMATTING,
    filetypes = { "pddl" },
    generator = null_ls.formatter({
        command = "pddl",
        args = function()
            local filetype = (vim.fn.expand("%")):match([[(%w*)%.pddl]]);
            return { filetype, "$FILENAME" }
        end,
    })
}

null_ls.register(pddl_diag)
null_ls.register(pddl_format)
