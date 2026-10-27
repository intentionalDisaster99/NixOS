vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#e4e2e6", bg = "#131316" })
hl("NormalFloat",  { fg = "#e4e2e6", bg = "#131316" })
hl("Cursor",       { fg = "#131316", bg = "#b1c5ff" })

hl("CursorLine",   { bg = "#292a2d" })
hl("LineNr",       { fg = "#8f9099" })
hl("CursorLineNr", { fg = "#b1c5ff", bold = true })

hl("Comment",      { fg = "#8f9099", italic = true })
hl("Keyword",      { fg = "#b1c5ff", bold = true })
hl("Function",     { fg = "#b1c5ff" })
hl("String",       { fg = "#e4e2e6" })
hl("Identifier",   { fg = "#e4e2e6" })
hl("Constant",     { fg = "#c0c6dd" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#e1bbdd" })
hl("DiagnosticInfo",  { fg = "#b1c5ff" })
hl("DiagnosticHint",  { fg = "#e4e2e6" })

hl("WinSeparator", { fg = "#b1c5ff" })
hl("Pmenu",        { fg = "#e4e2e6", bg = "#1f1f23" })
hl("PmenuSel",     { fg = "#131316", bg = "#b1c5ff" })
