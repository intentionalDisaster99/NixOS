require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Press <Space> + q + s to restore the session for the current directory
map("n", "<leader>qs", function() require("persistence").load() end, { desc = "Load Session" })

-- Press <Space> + q + l to restore the last session you were working on, regardless of directory
map("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Load Last Session" })
