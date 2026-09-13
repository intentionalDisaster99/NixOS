vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#e3e3dc", bg = "#121410" })
hl("NormalFloat",  { fg = "#e3e3dc", bg = "#121410" })
hl("Cursor",       { fg = "#121410", bg = "#a5d576" })

hl("CursorLine",   { bg = "#292a26" })
hl("LineNr",       { fg = "#8e9285" })
hl("CursorLineNr", { fg = "#a5d576", bold = true })

hl("Comment",      { fg = "#8e9285", italic = true })
hl("Keyword",      { fg = "#a5d576", bold = true })
hl("Function",     { fg = "#a5d576" })
hl("String",       { fg = "#e3e3dc" })
hl("Identifier",   { fg = "#e3e3dc" })
hl("Constant",     { fg = "#bfcbad" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#a0cfcc" })
hl("DiagnosticInfo",  { fg = "#a5d576" })
hl("DiagnosticHint",  { fg = "#e3e3dc" })

hl("WinSeparator", { fg = "#a5d576" })
hl("Pmenu",        { fg = "#e3e3dc", bg = "#1f201c" })
hl("PmenuSel",     { fg = "#121410", bg = "#a5d576" })
