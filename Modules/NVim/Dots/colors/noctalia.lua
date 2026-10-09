vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#e8e0e5", bg = "#151215" })
hl("NormalFloat",  { fg = "#e8e0e5", bg = "#151215" })
hl("Cursor",       { fg = "#151215", bg = "#f1afff" })

hl("CursorLine",   { bg = "#2d292c" })
hl("LineNr",       { fg = "#988e97" })
hl("CursorLineNr", { fg = "#f1afff", bold = true })

hl("Comment",      { fg = "#988e97", italic = true })
hl("Keyword",      { fg = "#f1afff", bold = true })
hl("Function",     { fg = "#f1afff" })
hl("String",       { fg = "#e8e0e5" })
hl("Identifier",   { fg = "#e8e0e5" })
hl("Constant",     { fg = "#d6c0d6" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#f5b7b1" })
hl("DiagnosticInfo",  { fg = "#f1afff" })
hl("DiagnosticHint",  { fg = "#e8e0e5" })

hl("WinSeparator", { fg = "#f1afff" })
hl("Pmenu",        { fg = "#e8e0e5", bg = "#221f22" })
hl("PmenuSel",     { fg = "#151215", bg = "#f1afff" })
