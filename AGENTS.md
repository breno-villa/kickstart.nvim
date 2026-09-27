# AGENTS.md

Personal fork of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) (remote: `breno-villa/kickstart.nvim`) used as the live Neovim config. `~/.config/nvim` is a symlink to this directory, so edits take effect immediately on the next nvim start.

## Upstream sync

The fork tracks upstream by hand (no merge commits); `upstream` points at `https://github.com/nvim-lua/kickstart.nvim.git`.

**Current sync point: `cd7adee` (2026-04-20)** — the last upstream commit before the config migrated from lazy.nvim to Neovim's built-in `vim.pack` (`c460542`, 2026-04-20). This fork intentionally stays on lazy.nvim, so **do not sync past `cd7adee`** without migrating the whole config and `lua/custom/plugins/init.lua` to `vim.pack` (Neovim 0.12+).

| Upstream commit | Date       | Notes                                                                                                                                                    |
| --------------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `4120893`       | 2024-09-24 | Base the fork was originally hand-synced to (`fix: update lazy uninstall information link`), plus selected later fixes (`c92ea7c` `vim.o`, `6ba2408` `vim.hl.on_yank`, ...). |
| `cd7adee`       | 2026-04-20 | Full lazy-era sync. All upstream changes `5aeddfd..cd7adee` ported while keeping the fork's customizations.                                              |

To sync further within the lazy era: `git fetch upstream`, diff against the recorded sync point, and hand-port. Upstream files the fork does not customize can be copied wholesale from the upstream commit.

## Structure

- `init.lua` is the entire core config (kickstart's single-file style); nearly all settings, keymaps, and plugin specs live here.
- `lua/custom/plugins/init.lua` is the fork's custom plugin spec, loaded via `{ import = 'custom.plugins' }` at `init.lua:1089`. Add personal plugins here. `dartls` is started by `flutter-tools.nvim`, not by the `servers` table in `init.lua`.
- `lua/plugins/caelestia.lua` and `colors/caelestia.lua` are 100% commented-out and are **not** loaded (no `{ import = 'plugins' }`). Don't assume they do anything.
- Active colorscheme is catppuccin (`init.lua:852`, applied at `init.lua:906`); tokyonight is installed but unused.
- Completion uses blink.cmp (upstream default); `lazydev`/`nvim-cmp` are no longer used.
- `lua/kickstart/health.lua` exposes `:checkhealth kickstart`.
- `README.md` is unmodified upstream kickstart install docs, not fork-specific guidance.

## Commands

- Verify config loads headlessly: `nvim --headless "+qa"` (errors print to stderr).
- Health/setup check: `nvim --headless "+checkhealth kickstart" +qa`.
- Plugin management happens inside nvim: `:Lazy`, `:Lazy update`, `:Lazy sync`; tools via `:Mason`.
- No test suite. Only lint/format check is stylua.

## Formatting

- `.stylua.toml`: 2-space indent, single quotes, column width 160, no call parentheses, `collapse_simple_statement = "Always"`.
- `stylua` is configured as an LSP server (`init.lua:637`); `lua_ls` formatting is disabled. Autoformat on save is opt-in (empty whitelist in conform's `format_on_save`), so format manually with `<leader>f` or `:lua require('conform').format()` (falls back to LSP/stylua).
- The `stylua` binary comes from Mason and is not on the system PATH outside nvim; run formatting through nvim.
- `.github/workflows/stylua.yml` only runs when `github.repository == 'nvim-lua/kickstart.nvim'`, so CI does not check this fork.

## Gotchas

- `lazy-lock.json` is intentionally gitignored and untracked; do not `git add -f` it.
- Language focus is Flutter/Dart: `flutter-tools` (starts `dartls`) and neotest-dart (runs `flutter test`) are configured in `lua/custom/plugins/init.lua`; the `servers` table (`lua_ls`, `stylua`) is in `init.lua`.
- lualine is the statusline; the upstream mini.statusline setup was removed from `init.lua` (keep it that way when syncing). lualine's theme is `catppuccin-nvim` (catppuccin has no plain `catppuccin` lualine theme).
- The nvim-treesitter spec requires the `main` branch (`init.lua:1016`) and builds parsers with the `tree-sitter` CLI; it is installed via Mason through the `ensure_installed` list (`init.lua:684`, a fork addition). If the installed plugin is still on `master`, run `:Lazy sync` after pulling config changes.
- git history is a mix of upstream kickstart commits and the owner's commits; keep fork changes small and separable.
