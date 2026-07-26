vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#e1e3e4", bg = "#111415" })
hl("NormalFloat",  { fg = "#e1e3e4", bg = "#111415" })
hl("Cursor",       { fg = "#111415", bg = "#52d7f0" })

hl("CursorLine",   { bg = "#272a2b" })
hl("LineNr",       { fg = "#899295" })
hl("CursorLineNr", { fg = "#52d7f0", bold = true })

hl("Comment",      { fg = "#899295", italic = true })
hl("Keyword",      { fg = "#52d7f0", bold = true })
hl("Function",     { fg = "#52d7f0" })
hl("String",       { fg = "#e1e3e4" })
hl("Identifier",   { fg = "#e1e3e4" })
hl("Constant",     { fg = "#b2cbd1" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#bdc5eb" })
hl("DiagnosticInfo",  { fg = "#52d7f0" })
hl("DiagnosticHint",  { fg = "#e1e3e4" })

hl("WinSeparator", { fg = "#52d7f0" })
hl("Pmenu",        { fg = "#e1e3e4", bg = "#1d2021" })
hl("PmenuSel",     { fg = "#111415", bg = "#52d7f0" })
