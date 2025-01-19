-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        dartls = {},
      },
    },
  },

  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- 'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      'sidlatau/neotest-dart',
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-dart') {
               command = 'flutter', -- Command being used to run tests. Defaults to `flutter`
                                    -- Change it to `fvm flutter` if using FVM
                                    -- change it to `dart` for Dart only tests
               use_lsp = true,      -- When set Flutter outline information is used when constructing test name.
               -- Useful when using custom test names with @isTest annotation
               custom_test_method_names = {},
          }
        }
      })

      vim.keymap.set('n', '<leader>tr', function()
        require('neotest').run.run()
      end, { desc = 'Run closest test' })

      vim.keymap.set('n', '<leader>td', function()
        require('neotest').run.run { strategy = 'dap' }
      end, { desc = 'Debug closest test' })

      vim.keymap.set('n', '<leader>ta', function()
        require('neotest').run.run({suite = true})
      end, { desc = 'Run all tests' })

      vim.keymap.set('n', '<leader>to', function()
        require('neotest').output.open { enter = true }
      end, { desc = 'Open test output' })

      vim.keymap.set('n', '<leader>top', function()
        require('neotest').output_panel.toggle()
      end, { desc = 'Toggle test output panel' })

      vim.keymap.set('n', '<leader>tw', function()
        require('neotest').watch.toggle()
      end, { desc = 'Toggle test watcher' })

      vim.keymap.set('n', '<leader>ts', function()
        require('neotest').summary.toggle()
      end, { desc = 'Toggle test summary' })
    end,
  },
}
 
