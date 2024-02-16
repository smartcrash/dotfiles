return {
  'ThePrimeagen/harpoon',
  config = function()
    require('harpoon').setup({
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
      },
    })

    local ui = require("harpoon.ui")
    local mark = require("harpoon.mark")

    vim.keymap.set('n', '<leader>b', ui.toggle_quick_menu, { desc = 'harpoon: toggle quick menu' })
    vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'harpoon: [A]dd file' })

    vim.keymap.set('n', '<C-n>', ui.nav_prev, { desc = 'harpoon: Navigate to previous mark' })
    vim.keymap.set('n', '<C-m>', ui.nav_next, { desc = 'harpoon: Navigate to next mark' })

    vim.keymap.set('n', '<leader>1', function() require("harpoon.ui").nav_file(1) end)
    vim.keymap.set('n', '<leader>2', function() require("harpoon.ui").nav_file(2) end)
    vim.keymap.set('n', '<leader>3', function() require("harpoon.ui").nav_file(3) end)
    vim.keymap.set('n', '<leader>4', function() require("harpoon.ui").nav_file(4) end)
    vim.keymap.set('n', '<leader>5', function() require("harpoon.ui").nav_file(5) end)
  end,
}
