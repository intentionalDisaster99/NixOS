vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#e6e1e6", bg = "#141316" })
hl("NormalFloat",  { fg = "#e6e1e6", bg = "#141316" })
hl("Cursor",       { fg = "#141316", bg = "#d3bbff" })

hl("CursorLine",   { bg = "#2b292d" })
hl("LineNr",       { fg = "#948f99" })
hl("CursorLineNr", { fg = "#d3bbff", bold = true })

hl("Comment",      { fg = "#948f99", italic = true })
hl("Keyword",      { fg = "#d3bbff", bold = true })
hl("Function",     { fg = "#d3bbff" })
hl("String",       { fg = "#e6e1e6" })
hl("Identifier",   { fg = "#e6e1e6" })
hl("Constant",     { fg = "#cdc2db" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#f0b7c5" })
hl("DiagnosticInfo",  { fg = "#d3bbff" })
hl("DiagnosticHint",  { fg = "#e6e1e6" })

hl("WinSeparator", { fg = "#d3bbff" })
hl("Pmenu",        { fg = "#e6e1e6", bg = "#211f22" })
hl("PmenuSel",     { fg = "#141316", bg = "#d3bbff" })
