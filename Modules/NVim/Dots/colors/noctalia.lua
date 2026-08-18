vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#e3e2e6", bg = "#121316" })
hl("NormalFloat",  { fg = "#e3e2e6", bg = "#121316" })
hl("Cursor",       { fg = "#121316", bg = "#a8c8ff" })

hl("CursorLine",   { bg = "#292a2d" })
hl("LineNr",       { fg = "#8e9099" })
hl("CursorLineNr", { fg = "#a8c8ff", bold = true })

hl("Comment",      { fg = "#8e9099", italic = true })
hl("Keyword",      { fg = "#a8c8ff", bold = true })
hl("Function",     { fg = "#a8c8ff" })
hl("String",       { fg = "#e3e2e6" })
hl("Identifier",   { fg = "#e3e2e6" })
hl("Constant",     { fg = "#bdc7dc" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#dbbce1" })
hl("DiagnosticInfo",  { fg = "#a8c8ff" })
hl("DiagnosticHint",  { fg = "#e3e2e6" })

hl("WinSeparator", { fg = "#a8c8ff" })
hl("Pmenu",        { fg = "#e3e2e6", bg = "#1e2023" })
hl("PmenuSel",     { fg = "#121316", bg = "#a8c8ff" })
