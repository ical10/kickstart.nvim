# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **modular Neovim configuration** based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), a teaching-focused starting point for Neovim. It combines the core kickstart setup with custom language-specific configurations and plugins.

## Architecture

### Three-Layer Structure

1. **init.lua** (entry point, ~1154 lines)
   - Core editor settings and options
   - Basic keymaps and autocommands
   - Lazy.nvim plugin manager configuration
   - Main plugin specifications and setups

2. **lua/kickstart/** (core plugins)
   - `health.lua`: System health checks (run `:checkhealth`)
   - `plugins/`: Plugin configurations (debug, indent_line, lint, autopairs, neo-tree, gitsigns)
   - Bundled with the project, provides base functionality

3. **lua/custom/** (user customizations)
   - `plugins/`: Custom plugin additions (currently empty, meant for extensibility)
   - `typescript.lua`: Language-specific configuration (TypeScript/JavaScript LSP settings)
   - No merge conflicts with upstream kickstart updates

### Plugin Management

- **Lazy.nvim**: Plugin manager that lazy-loads plugins for performance
- Plugin specs use `lazy`, `cmd`, `keys`, `event` to defer loading until needed
- LSP configured via `nvim-lspconfig` with `mason.nvim` for tool installation
- Telescope for fuzzy finding, completion via nvim-cmp with LuaSnip
- Treesitter for syntax highlighting and code navigation

## Key Commands

### Running the Configuration

```bash
# Start Neovim with this config
nvim

# View all installed plugins and their status
:Lazy
```

### Development Tasks

```bash
# Check system requirements (Neovim version, external tools like git, rg)
:checkhealth

# Format code using conform.nvim (respects stylua.toml)
# Triggered on save if enabled, or via :Format

# Lint code using nvim-lint
# Configured for various languages, triggered on save/events

# Debug programs
# Configured for Go (nvim-dap), keymaps: <F5> continue, <F1> step into, <F2> step over
```

### Editor Keymaps (Reference)

- `<space>` = leader key
- `<C-h/j/k/l>` = switch between splits
- `<C-s>` = save file (all modes)
- `<Esc>` = clear search highlights
- `<space>sh` = search help documentation (Telescope)
- `<space>sr` = resume last Telescope search
- `<leader>lg` = open LazyGit
- LSP: `gd` = definition, `gr` = references, `gI` = implementations, `<leader>D` = type definition
- More keymaps are in init.lua and can be viewed via `:which-key`

## Code Organization

### init.lua Sections (in order)

1. **Leader key setup** - Must happen before plugins load
2. **Editor options** - vim.opt settings (line numbers, mouse, clipboard, indentation, etc.)
3. **Basic keymaps** - Clear search, save file, diagnostics, navigation
4. **Autocommands** - Highlight on yank, filetype detection
5. **Lazy.nvim setup** - Plugin manager initialization
6. **Plugin specifications** - All plugins defined as Lua tables with their configs
7. **Language-specific config** - `require 'custom.typescript'` at the end

### Plugin Organization

Each plugin in `lua/kickstart/plugins/` is a self-contained Lua module that:
- Returns a Lua table matching Lazy.nvim's plugin spec format
- Can be required or commented out
- Includes comprehensive comments explaining configuration

### Styling

- **Stylua**: Lua code formatter with `column_width = 160`, Unix line endings, 2-space indentation
- Config in `.stylua.toml`

## Common Development Patterns

### Adding a Plugin

1. Add to `lua/custom/plugins/init.lua`:
   ```lua
   return {
     {
       'author/plugin-name',
       opts = { /* config */ },
       keys = { /* lazy-load keymaps */ },
     }
   }
   ```

2. Or add directly to init.lua's plugin spec table before the `lazy.nvim` setup

3. Run `:Lazy sync` to install

### Adding LSP Configuration

1. Edit `lua/custom/typescript.lua` (or create new language file)
2. Return a table with LSP server config under `opts.servers`
3. Require it at end of init.lua: `require 'custom.language'`

### Creating Plugin-Specific Config

- Create files in `lua/kickstart/plugins/` following the pattern of existing plugins
- Each should be a self-contained module returning a Lazy.nvim spec
- Include keymaps under the `keys` table for lazy-loading

## External Dependencies

- **Required**: `git`, `make`, `unzip`, C compiler (`gcc`)
- **Recommended**: `ripgrep` (rg) for fast searching
- **Optional**: Nerd Font (set `vim.g.have_nerd_font = true` in init.lua)
- **For specific languages**: Install language servers via `:Mason` or Mason commands

## Git Workflow

- Current branch: `dev-config`
- Main branch for PRs: `master`
- Keep `lazy-lock.json` in version control (tracks exact plugin versions)

## Health Checks

Run `:checkhealth` to verify:
- Neovim version (needs 0.10 or later)
- External tools (git, make, unzip, rg)
- Plugin-specific requirements

## Important Files

- `.stylua.toml`: Lua code style configuration
- `lazy-lock.json`: Locked dependency versions
- `init.lua`: All configuration and plugins in one file (by design)
- `README.md`: Installation and setup instructions
