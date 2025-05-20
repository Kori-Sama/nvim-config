return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
          ['<S-tab>'] = { 'select_prev', 'fallback' },
          ['<tab>'] = { 'select_next', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'mono'
      },

      completion = { documentation = { auto_show = false } },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local icons = require("config.icons")

      local lsp_servers = {
        "pyright", "lua_ls", "clangd", "gopls"
      }

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      for _, lsp_server in pairs(lsp_servers) do
        vim.lsp.config(lsp_server, {
          capabilities = capabilities,
        })
        vim.lsp.enable(lsp_server)
      end

      vim.diagnostic.config(
        {
          -- disable virtual text
          virtual_text = { prefix = icons.ui.VirtualPrefix },
          -- show signs
          signs = false,
          update_in_insert = true,
          underline = true,
          severity_sort = true,
          float = {
            focusable = false,
            style = "minimal",
            border = "single",
            header = "",
            prefix = "",
          },
        }
      )
    end
  }

}
