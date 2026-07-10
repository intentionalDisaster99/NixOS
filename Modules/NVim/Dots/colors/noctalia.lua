vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#e8e0e5", bg = "#151216" })
hl("NormalFloat",  { fg = "#e8e0e5", bg = "#151216" })
hl("Cursor",       { fg = "#151216", bg = "#e5b4ff" })

hl("CursorLine",   { bg = "#2c292c" })
hl("LineNr",       { fg = "#978e98" })
hl("CursorLineNr", { fg = "#e5b4ff", bold = true })

hl("Comment",      { fg = "#978e98", italic = true })
hl("Keyword",      { fg = "#e5b4ff", bold = true })
hl("Function",     { fg = "#e5b4ff" })
hl("String",       { fg = "#e8e0e5" })
hl("Identifier",   { fg = "#e8e0e5" })
hl("Constant",     { fg = "#d3c0d8" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#f4b7b8" })
hl("DiagnosticInfo",  { fg = "#e5b4ff" })
hl("DiagnosticHint",  { fg = "#e8e0e5" })

hl("WinSeparator", { fg = "#e5b4ff" })
hl("Pmenu",        { fg = "#e8e0e5", bg = "#221f22" })
hl("PmenuSel",     { fg = "#151216", bg = "#e5b4ff" })
