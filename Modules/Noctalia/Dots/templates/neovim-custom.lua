vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "{{ colors.on_surface.default.hex }}", bg = "{{ colors.surface.default.hex }}" })
hl("NormalFloat",  { fg = "{{ colors.on_surface.default.hex }}", bg = "{{ colors.surface.default.hex }}" })
hl("Cursor",       { fg = "{{ colors.surface.default.hex }}", bg = "{{ colors.primary.default.hex }}" })

hl("CursorLine",   { bg = "{{ colors.surface_container_high.default.hex }}" })
hl("LineNr",       { fg = "{{ colors.outline.default.hex }}" })
hl("CursorLineNr", { fg = "{{ colors.primary.default.hex }}", bold = true })

hl("Comment",      { fg = "{{ colors.outline.default.hex }}", italic = true })
hl("Keyword",      { fg = "{{ colors.primary.default.hex }}", bold = true })
hl("Function",     { fg = "{{ colors.primary.default.hex }}" })
hl("String",       { fg = "{{ colors.on_surface.default.hex }}" })
hl("Identifier",   { fg = "{{ colors.on_surface.default.hex }}" })
hl("Constant",     { fg = "{{ colors.secondary.default.hex }}" })

hl("DiagnosticError", { fg = "{{ colors.error.default.hex }}" })
hl("DiagnosticWarn",  { fg = "{{ colors.tertiary.default.hex }}" })
hl("DiagnosticInfo",  { fg = "{{ colors.primary.default.hex }}" })
hl("DiagnosticHint",  { fg = "{{ colors.on_surface.default.hex }}" })

hl("WinSeparator", { fg = "{{ colors.primary.default.hex }}" })
hl("Pmenu",        { fg = "{{ colors.on_surface.default.hex }}", bg = "{{ colors.surface_container.default.hex }}" })
hl("PmenuSel",     { fg = "{{ colors.surface.default.hex }}", bg = "{{ colors.primary.default.hex }}" })
