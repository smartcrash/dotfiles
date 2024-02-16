local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

local function open_win_config()
  local screen_w = vim.opt.columns:get()
  local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
  local window_w = screen_w * WIDTH_RATIO
  local window_h = screen_h * HEIGHT_RATIO
  local window_w_int = math.floor(window_w)
  local window_h_int = math.floor(window_h)
  local center_x = (screen_w - window_w) / 2
  local center_y = ((vim.opt.lines:get() - window_h) / 2)
      - vim.opt.cmdheight:get()
  return {
    border = 'rounded',
    relative = 'editor',
    row = center_y,
    col = center_x,
    width = window_w_int,
    height = window_h_int,
  }
end

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function edit_or_open()
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
      -- expand or collapse folder
      api.node.open.edit()
    else
      -- open file
      api.node.open.edit()
      -- Close the tree if file was opened
      api.tree.close()
    end
  end

  -- open as vsplit on current node
  local function vsplit_preview()
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
      -- expand or collapse folder
      api.node.open.edit()
    else
      -- open file as vsplit
      api.node.open.vertical()
    end

    -- Finally refocus on tree if it was lost
    api.tree.focus()
  end

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
  vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
  vim.keymap.set("n", "<Esc>", api.tree.close, opts("Close"))
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  config = function()
    require("nvim-tree").setup({
      renderer = {
        root_folder_label = false,
        icons = {
          show = {
            file = true,
            folder = false,
            folder_arrow = true,
            git = false,
          },
        },
      },
      on_attach = on_attach,
      view = {
        side = "right",
        -- float = {
        --   enable = true,
        --   open_win_config = open_win_config
        -- },
        -- width = function()
        --   return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        -- end,
      },
    })

    -- custom mappings
    vim.keymap.set(
      'n',
      '<leader>t',
      function() require("nvim-tree.api").tree.find_file({ open = true, focus = true }) end,
      { desc = 'nvim-tree: Open the [T]ree', noremap = true, silent = true, nowait = true }
    )
  end,
}
