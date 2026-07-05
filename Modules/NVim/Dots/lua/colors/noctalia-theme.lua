local config_path = vim.fn.stdpath("config")
local palette_path = config_path .. "/colors/noctalia.lua"

local load_palette = loadfile(palette_path)

if not load_palette then
  vim.notify("Could not find palette at " .. palette_path, vim.log.levels.ERROR)
  return
end

local noctalia = load_palette()

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "noctalia_theme"

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = noctalia.fg, bg = noctalia.bg }) 
hl("NormalFloat",  { fg = noctalia.fg, bg = noctalia.bg }) 
hl("Cursor",       { fg = noctalia.bg, bg = noctalia.accent })
hl("CursorLine",   { bg = "#252326" })                     
hl("LineNr",       { fg = "#555555" })                     
hl("CursorLineNr", { fg = noctalia.accent, bold = true })  

hl("Comment",      { fg = "#777777", italic = true })      
hl("Keyword",      { fg = noctalia.accent, bold = true })
hl("Function",     { fg = noctalia.accent })
hl("String",       { fg = noctalia.fg })
hl("Identifier",   { fg = noctalia.fg })
hl("Constant",     { fg = noctalia.warning })

hl("DiagnosticError", { fg = noctalia.error })
hl("DiagnosticWarn",  { fg = noctalia.warning })
hl("DiagnosticInfo",  { fg = noctalia.accent })
hl("DiagnosticHint",  { fg = noctalia.fg })

hl("WinSeparator", { fg = noctalia.accent })               
hl("Pmenu",        { fg = noctalia.fg, bg = "#252326" })   
hl("PmenuSel",     { fg = noctalia.bg, bg = noctalia.accent })
