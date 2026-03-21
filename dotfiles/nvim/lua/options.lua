require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.opt.number = true
vim.opt.relativenumber = true

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only load the session if you run `nvim` with no arguments
    if vim.fn.argc() == 0 then
      require("persistence").load()
    end
  end,
  nested = true,
})
