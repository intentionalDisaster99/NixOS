vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#e2e2e5", bg = "#121416" })
hl("NormalFloat",  { fg = "#e2e2e5", bg = "#121416" })
hl("Cursor",       { fg = "#121416", bg = "#96ccff" })

hl("CursorLine",   { bg = "#282a2d" })
hl("LineNr",       { fg = "#8c9198" })
hl("CursorLineNr", { fg = "#96ccff", bold = true })

hl("Comment",      { fg = "#8c9198", italic = true })
hl("Keyword",      { fg = "#96ccff", bold = true })
hl("Function",     { fg = "#96ccff" })
hl("String",       { fg = "#e2e2e5" })
hl("Identifier",   { fg = "#e2e2e5" })
hl("Constant",     { fg = "#b9c8da" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#d3bfe6" })
hl("DiagnosticInfo",  { fg = "#96ccff" })
hl("DiagnosticHint",  { fg = "#e2e2e5" })

hl("WinSeparator", { fg = "#96ccff" })
hl("Pmenu",        { fg = "#e2e2e5", bg = "#1e2022" })
hl("PmenuSel",     { fg = "#121416", bg = "#96ccff" })
