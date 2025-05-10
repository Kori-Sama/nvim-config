return {
    {
        "Shatur/neovim-ayu",
        lazy = false,
        config = function()
            require('ayu').setup({
                overrides = {
                    Normal = { bg = "None" },
                    NormalFloat = { bg = "none" },
                    CursorLine = { bg = "#5C6166" },
                    -- VM_Cursor = { bg = "#E7EEF7", sp = "#5C6166", underline = true },
                },
            })
            vim.cmd.colorscheme("ayu-mirage")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "ayu",
            },
        }
    }
}
