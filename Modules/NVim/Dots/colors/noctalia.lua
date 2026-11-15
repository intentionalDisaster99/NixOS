vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#e0e3e3", bg = "#101414" })
hl("NormalFloat",  { fg = "#e0e3e3", bg = "#101414" })
hl("Cursor",       { fg = "#101414", bg = "#4dd9e5" })

hl("CursorLine",   { bg = "#272b2b" })
hl("LineNr",       { fg = "#899393" })
hl("CursorLineNr", { fg = "#4dd9e5", bold = true })

hl("Comment",      { fg = "#899393", italic = true })
hl("Keyword",      { fg = "#4dd9e5", bold = true })
hl("Function",     { fg = "#4dd9e5" })
hl("String",       { fg = "#e0e3e3" })
hl("Identifier",   { fg = "#e0e3e3" })
hl("Constant",     { fg = "#b1cbce" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#b7c7ea" })
hl("DiagnosticInfo",  { fg = "#4dd9e5" })
hl("DiagnosticHint",  { fg = "#e0e3e3" })

hl("WinSeparator", { fg = "#4dd9e5" })
hl("Pmenu",        { fg = "#e0e3e3", bg = "#1d2021" })
hl("PmenuSel",     { fg = "#101414", bg = "#4dd9e5" })
