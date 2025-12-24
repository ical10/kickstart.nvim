# Agent Guidelines for Neovim Configuration

## Build/Lint/Test Commands
- **Format Lua code**: `stylua .` (formats all Lua files)
- **Check formatting**: `stylua --check .` (CI validation)
- **Health check**: Run `:checkhealth` inside Neovim
- **Plugin status**: Run `:Lazy` inside Neovim
- **No test suite**: This is a config repository, test by running `nvim`

## Code Style

### Formatting (via .stylua.toml)
- **Indentation**: 2 spaces, no tabs
- **Line width**: 160 characters max
- **Quotes**: Auto-prefer single quotes
- **Call parentheses**: None (Lua style: `require 'module'` not `require('module')`)

### Structure
- **Main config**: All plugins in `init.lua` (single-file by design)
- **Custom plugins**: Add to `lua/custom/plugins/*.lua` (imported via `{ import = 'custom.plugins' }`)
- **Language configs**: Create in `lua/custom/<language>.lua`, require at end of init.lua

### Conventions
- Use `opts = {}` for simple plugin setup (calls `setup()` automatically)
- Use `config = function() ... end` for complex plugin configuration
- Lazy-load plugins with `event`, `cmd`, `keys`, or `ft` (see existing patterns)
- Follow existing comment style: brief inline comments, longer block comments above
- Use Telescope for LSP mappings (see `gd`, `gr`, etc. in init.lua:531-563)
