local M = {}

local nvimTree = require('nvim-tree.api')
-- local barbar   = require('barbar.api')

M.HowClose = function()
  local tbl = fn.getbufinfo()
  local count = 0
  for _, v in pairs(tbl) do
    if v.listed == 1 then
      count = count + 1
    end
  end
  if count > 1 then
    cmd("bp")
    cmd("bd #")
  else
    cmd("q")
  end
end

M.getTreePath = function()
  local node = nvimTree.tree.get_nodes()
  if node == nil then
    return "~"
  end
  return node.absolute_path
end

M.TreeToggleBarBar = function()
  if not nvimTree.tree.is_visible() then
    -- barbar.set_offset(30, 'NvimTree')
  else
    -- barbar.set_offset(0)
  end
end

M.lazygit_toggle = function()
  local Terminal = require('toggleterm.terminal').Terminal
  local lazygit  = Terminal:new({ cmd = "lazygit -p " .. vim.fn.getcwd(), hidden = false, direction = "float" })

  vim.print("lazygit -p " .. vim.fn.getcwd())
  lazygit:toggle()
end

M.howFormat = function()
  if vim.bo.filetype == "cpp" then
    vim.cmd("w")
    vim.lsp.buf.format {
      async = true,
      filter = function(client)
        return client.name == "null-ls"
      end
    }
  else
    vim.lsp.buf.format { async = true }
  end
end

-- M.betterPaste = function(opts)
--   print(opts)
--   vim.api.nvim_feedkeys('p', 'ni', false)
  -- local col = vim.api.nvim_win_get_cursor(0)[2]
  -- vim.api.nvim_paste("test", true, -1);
  -- local newRow = vim.api.nvim_win_get_cursor(0)[1]
  -- vim.api.nvim_win_set_cursor(0, { newRow, col })
-- end

return M
