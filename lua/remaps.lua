require "helpers/globals"
require "helpers/keyboard"

local wk       = require("which-key")
local builtin  = require('telescope.builtin')
local tel      = require('telescope')
-- local flash    = require('flash')
local utils    = require("helpers.functions")
local nvimTree = require('nvim-tree.api')

tm([[<c-\>]], [[<c-\><c-n>:q<cr>]])

local function recompile()
  local dir = vim.fn.expand("%:p:h")

  vim.cmd([[TermExec cmd='cd ]] ..
    dir .. [[ && cmake ../../../ -B../../../build && make -C ../../../build && ./sol?_[0-9]*.o']])
end

local function compile()
  local oldDir = vim.fn.getcwd()
  local dir = vim.fn.expand("%:h")
  -- vim.api.nvim_create_autocmd("BufWrite", {
  --     once = true,
  --     pattern = "messages",
  --     callback = function ()
  --         print("ricevuto")
  --     end
  -- })
  -- vim.fn.chdir(dir)
  -- vim.api.nvim_create_autocmd("ChanOpen", {
  --     once = true,
  --     -- pattern = "*bash", -- TODO this won't work on windows
  --     callback = function()
  --         vim.api.nvim_create_autocmd("CmdLineChanged", {
  --             once = true,
  --             callback = function ()
  --                 print("cane")
  --                 vim.fn.chdir(oldDir)
  --             end
  --         })
  --         -- local eventInfo = vim.v.event.info
  --         -- vim.print(vim.inspect(vim.api.nvim_get_chan_info(eventInfo.id)))
  --         -- runCounter = runCounter + 1
  --         -- if runCounter == 2 then
  --         --     print("cane")
  --         --     vim.fn.chdir("-")
  --         -- end
  --     end
  -- })
  -- vim.cmd("Compile")
end

-- mappings for terminal mode
wk.add({
  mode = "t",
  { "<Esc>", [[<c-\><c-n>]], desc = "Exit terminal input" },
})

wk.add({
  mode = "v",
  { "<leader>x", "<cmd>lua<CR>", desc = "Execute lua selection" },
})


-- mappings for normal mode
wk.add({
  mode = { "n" },
  { "j",          "gj",                                            desc = "Go down in visual lines" },
  { "k",          "gk",                                            desc = "Go up in visual lines" },
  -- { "p",          utils.betterPaste,                                            desc = "Go up in visual lines" },
  -- { "v",          "m`v",                                           desc = "Save previous position after visual selection",      noremap = true },
  -- { "V",          "m`V",                                           desc = "Save previous position after visual line selection", noremap = true },
  -- { ":",          ":<c-f>i",                                               desc = "Better commandline" },
  { "<leader>a",  group = "Dap" },
  { "<leader>ab", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle breakpoint" },
  { "<leader>ar", "<cmd>lua require'dap'.continue()<CR>",          desc = "Start debugging" },
  { "<leader>ac", "<cmd>lua require'dap'.close()<cr>",             desc = "Close dubgging windows" },

  { "<leader>b",  group = "Buffer" },
  { "<leader>bn", "<cmd>bnext<CR>",                                desc = "Next buffer" },
  { "<leader>bp", "<cmd>bprevious<CR>",                            desc = "Previous buffer" },
  { "<leader>bN", "<cmd>BufferMoveNext<CR>",                       desc = "Move to next buffer" },
  { "<leader>bP", "<cmd>BufferMovePrevious<CR>",                   desc = "Move to previous buffer" },
  { "<leader>bs", "<cmd>w<CR>",                                    desc = "Save buffer" },
  { "<leader>bk", utils.HowClose,                                  desc = "Save and quit buffer" },
  { "<leader>br", "<cmd>BufferRestore<cr>",                        desc = "Restore closed buffer" },
  { "<leader>bb", "<cmd>BufferPick<cr>",                           desc = "Pick a buffer" },
  { "<leader>bD", "<cmd>BufferPickDelete<cr>",                     desc = "Delete a selected buffer" },

  { "<leader>cb", "<cmd>CMakeBuild<cr>",                           desc = "Cmake build" },
  { "<leader>cc", "<cmd>CMakeClean<cr>",                           desc = "Cmake clean" },
  { "<leader>cd", "<cmd>CMakeDebug<cr>",                           desc = "Cmake debug" },
  { "<leader>ct", "<cmd>CMakeSelectBuildType<cr>",                 desc = "Cmake select builtd type" },
  { "<leader>cI", "<cmd>CMakeInstall<cr>",                         desc = "Cmake install" },
  { "<leader>Cc", compile,                                         desc = "Compilation Mode" },
  { "<leader>CC", recompile,                                       desc = "Recompilation Mode" },

  { "<leader>d",  group = "Diagnostics" },
  { "<leader>do", "<cmd>Lspsaga show_line_diagnostics<cr>",        desc = "Lspsaga show live diagnostic" },
  { "<leader>dn", "<cmd>Lspsaga diagnostic_jump_next<cr>",         desc = "Lspsaga next diagnostic" },
  { "<leader>dp", "<cmd>Lspsaga diagnostic_jump_prev<cr>",         desc = "Lspsaga prev diagnostic" },

  { "<leader>fo", utils.howFormat,                                 desc = "Format current file" },

  -- { "<leader>h",  group = "Flash" },
  -- { "gs",         flash.jump,                                         desc = "Flash jump" },
  -- { "<leader>ht", flash.treesitter,                                   desc = "Flash treesitter" },
  -- { "<leader>hf", flash.treesitter_search,                            desc = "Flash treesitter search" },
  --
  { "<leader>l",  utils.lazygit_toggle,                            desc = "Open lazygit" },

  {
    "<leader>n",
    function()
      utils.TreeToggleBarBar(); nvimTree.tree.toggle({ focus = false });
    end,
    desc = "Toggle NvimTree"
  },

  { "<leader>s",  group = "Split" },
  { "<leader>sv", "<cmd>vertical split<CR>",                                        desc = "Vertical split" },
  { "<leader>so", "<cmd>split<CR>",                                                 desc = "Horizzontal Split" },

    { "<leader>t",  group = "Telescope" },
    { "<leader>tb", builtin.buffers,                                                  desc = "Telescope find buffer" },
    { "<leader>td", builtin.diagnostics,                                              desc = "Telescope find diagnostic" },
    { "<leader>tc", builtin.command_history,                                          desc = "Telescope commands" },
    { "<leader>tf", function() builtin.find_files({ cwd = utils.getTreePath() }) end, desc = "Telescope find file" },
    { "<leader>tg", function() builtin.live_grep({ cwd = utils.getTreePath() }) end,  desc = "Telescope grep" },
    { "<leader>th", builtin.help_tags,                                                desc = "Telescope find help" },
    { "<leader>tk", builtin.keymaps,                                                  desc = "Telescope find keymap" },
    -- { "<leader>tn", tel.extensions.notify.notify,                                     desc = "Telescope find notifications" },
    { "<leader>tp", tel.extensions.project.project,                                   desc = "Telescope find project" },
    { "<leader>tr", "<cmd>Telescope oldfiles<cr>",                                    desc = "Telescope oldfiles" },
    { "<leader>t.", "<cmd>Telescope file_browser<cr>",                                desc = "Telescope file browser" },

  { "<leader>w",  proxy = "<c-w>",                                                  group = "Window" },
  { "<leader>wq", "<cmd>q<cr>",                                                     desc = "Quit window" },

  { "<leader>T",  group = "Tabs" },
  { "<leader>Tt", "<cmd>tabnew<cr>",                                                desc = "Open a new tab" },
  { "<leader>Tc", "<cmd>tabclose<cr>",                                              desc = "Close tab" },
  { "<leader>Tn", "<cmd>tabnext<cr>",                                               desc = "Next tab" },
  { "<leader>Tp", "<cmd>tabprevious<cr>",                                           desc = "Previous tab" },

  -- Commands that have no group
  { "<leader>o",  "<cmd>Lspsaga outline<cr>",                                       desc = "Lspsaga open outline" },
  { "<leader>ca", "<cmd>Lspsaga code_action<cr>",                                   desc = "Code action" },
  { "<leader>gd", "<cmd>Lspsaga goto_definition<cr>",                               desc = "Lspsaga goto definition" },
  { "<leader>gt", "<cmd>Lspsaga goto_type_definition<cr>",                          desc = "Lspsaga goto type definition" },
  { "<leader>pd", "<cmd>Lspsaga peek_definition<cr>",                               desc = "Lspsaga peek definition" },
  { "<leader>pt", "<cmd>Lspsaga peek_type_definition<cr>",                          desc = "Lspsaga peek type definition" },
  { "<leader>rn", "<cmd>Lspsaga rename<cr>",                                        desc = "Rename file" },
  { "<leader>F",  "<cmd>NvimTreeFocus<cr>",                                         desc = "NvimTree focus" },
  { "<leader>K",  "<cmd>Lspsaga hove_doc<cr>",                                      desc = "Lspsaga hover doc" },
  { "<leader>R",  "<cmd>so %<cr>",                                                  desc = "Rename file" },

  {
    "<F8>",
    function()
      local ft = vim.bo.filetype
      if ft == 'ruby' then
        cmd("w")
        cmd("!ruby %")
      elseif ft == 'pddl' then
        cmd("w")
        cmd([[TermExec cmd="popf domain.pddl problem.pddl"]])
      end
    end,
    desc = "Quickrun"
  }
})

-- keep the highlight while moving the indent
vm('>', ">gv")
vm('<', "<gv")

-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    --vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>ws', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    --vim.keymap.set('n', '<space>Dg', vim.lsp.buf.type_definition, opts)
    --vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    --vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', '<space>fo', function()
    --   vim.lsp.buf.format { async = true }
    -- end, opts)
  end,
})
