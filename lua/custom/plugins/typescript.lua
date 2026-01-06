-- TypeScript/JavaScript/Svelte language-specific configuration
return {
  -- Configure TypeScript and Svelte servers
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        -- Enable Svelte language server
        svelte = {},
        -- Enable tsserver
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
      },
    },
  },

  -- Configure matchit for HTML/JSX/Svelte tags
  {
    'andymass/vim-matchup',
    event = 'VimEnter',
    config = function()
      -- Enable all matchup features
      vim.g.matchup_enabled = 1
      vim.g.matchup_matchparen_enabled = 1
      vim.g.matchup_motion_enabled = 1
      vim.g.matchup_text_obj_enabled = 1

      -- Show matching pair in popup if offscreen
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }

      -- Define custom match words for Svelte components
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'svelte', 'html', 'jsx', 'tsx' },
        callback = function()
          -- Add support for component tags and custom elements
          vim.b.match_words = vim.b.match_words or ''
          if vim.b.match_words == '' then
            vim.b.match_words = '<:>,<\\@<!/:>'
          end
        end,
      })
    end,
  },
}
