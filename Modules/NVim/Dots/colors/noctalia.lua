vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#e5e1e6", bg = "#141316" })
hl("NormalFloat",  { fg = "#e5e1e6", bg = "#141316" })
hl("Cursor",       { fg = "#141316", bg = "#c7bfff" })

hl("CursorLine",   { bg = "#2a292d" })
hl("LineNr",       { fg = "#928f99" })
hl("CursorLineNr", { fg = "#c7bfff", bold = true })

hl("Comment",      { fg = "#928f99", italic = true })
hl("Keyword",      { fg = "#c7bfff", bold = true })
hl("Function",     { fg = "#c7bfff" })
hl("String",       { fg = "#e5e1e6" })
hl("Identifier",   { fg = "#e5e1e6" })
hl("Constant",     { fg = "#c8c3dc" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#ecb8ce" })
hl("DiagnosticInfo",  { fg = "#c7bfff" })
hl("DiagnosticHint",  { fg = "#e5e1e6" })

hl("WinSeparator", { fg = "#c7bfff" })
hl("Pmenu",        { fg = "#e5e1e6", bg = "#201f23" })
hl("PmenuSel",     { fg = "#141316", bg = "#c7bfff" })
