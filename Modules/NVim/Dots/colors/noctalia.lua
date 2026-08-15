vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#ece0db", bg = "#18120f" })
hl("NormalFloat",  { fg = "#ece0db", bg = "#18120f" })
hl("Cursor",       { fg = "#18120f", bg = "#ffb68d" })

hl("CursorLine",   { bg = "#2f2925" })
hl("LineNr",       { fg = "#9f8d84" })
hl("CursorLineNr", { fg = "#ffb68d", bold = true })

hl("Comment",      { fg = "#9f8d84", italic = true })
hl("Keyword",      { fg = "#ffb68d", bold = true })
hl("Function",     { fg = "#ffb68d" })
hl("String",       { fg = "#ece0db" })
hl("Identifier",   { fg = "#ece0db" })
hl("Constant",     { fg = "#e5beaa" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#cdc991" })
hl("DiagnosticInfo",  { fg = "#ffb68d" })
hl("DiagnosticHint",  { fg = "#ece0db" })

hl("WinSeparator", { fg = "#ffb68d" })
hl("Pmenu",        { fg = "#ece0db", bg = "#241e1b" })
hl("PmenuSel",     { fg = "#18120f", bg = "#ffb68d" })
