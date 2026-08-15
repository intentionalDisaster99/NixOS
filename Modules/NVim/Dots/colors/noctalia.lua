vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#e4e1e6", bg = "#131316" })
hl("NormalFloat",  { fg = "#e4e1e6", bg = "#131316" })
hl("Cursor",       { fg = "#131316", bg = "#b8c3ff" })

hl("CursorLine",   { bg = "#2a2a2d" })
hl("LineNr",       { fg = "#90909a" })
hl("CursorLineNr", { fg = "#b8c3ff", bold = true })

hl("Comment",      { fg = "#90909a", italic = true })
hl("Keyword",      { fg = "#b8c3ff", bold = true })
hl("Function",     { fg = "#b8c3ff" })
hl("String",       { fg = "#e4e1e6" })
hl("Identifier",   { fg = "#e4e1e6" })
hl("Constant",     { fg = "#c3c5dd" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#e4bad9" })
hl("DiagnosticInfo",  { fg = "#b8c3ff" })
hl("DiagnosticHint",  { fg = "#e4e1e6" })

hl("WinSeparator", { fg = "#b8c3ff" })
hl("Pmenu",        { fg = "#e4e1e6", bg = "#1f1f23" })
hl("PmenuSel",     { fg = "#131316", bg = "#b8c3ff" })
