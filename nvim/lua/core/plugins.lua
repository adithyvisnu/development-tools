-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data").."/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git","clone","--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

-- Theme
{
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("tokyonight")
  end
},

-- File tree
{
  "nvim-tree/nvim-tree.lua",
  dependencies = {"nvim-tree/nvim-web-devicons"},
  config = function()
    require("nvim-tree").setup()
  end
},

-- Status line
{
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = { theme = "tokyonight" }
    })
  end
},

-- Git signs
{
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()
  end
},

-- Telescope
{
  "nvim-telescope/telescope.nvim",
  dependencies = {"nvim-lua/plenary.nvim"},
},

-- Treesitter
-- {
  -- "nvim-treesitter/nvim-treesitter",
  -- build=":TSUpdate",
  -- event={"BufReadPost","BufNewFile"},
  -- -- lazy=false,
  -- config=function()
    -- require("nvim-treesitter.configs").setup({
      -- ensure_installed={
        -- "lua","go","javascript","typescript","php","java","json"
      -- },
      -- highlight={enable=true},
      -- indent={enable=true},
    -- })
  -- end
-- },

-- Autopairs
{
  "windwp/nvim-autopairs",
  config=function()
    require("nvim-autopairs").setup()
  end
},

-- Completion
{
  "hrsh7th/nvim-cmp",
  dependencies={
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip"
  },
  config=function()

    local cmp=require("cmp")
    local luasnip=require("luasnip")

    cmp.setup({
      snippet={
        expand=function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      mapping=cmp.mapping.preset.insert({
        ["<CR>"]=cmp.mapping.confirm({select=true}),
        ["<C-Space>"]=cmp.mapping.complete(),
      }),
      sources={
        {name="nvim_lsp"},
        {name="buffer"},
        {name="path"},
      }
    })

  end
},

-- Mason
{
  "williamboman/mason.nvim",
  config=function()
    require("mason").setup()
  end
},

{
  "williamboman/mason-lspconfig.nvim",
  config=function()
    require("mason-lspconfig").setup({
      ensure_installed={
        "gopls",
        "ts_ls",
        "jdtls",
        "intelephense"
      }
    })
  end
},

-- LSP
{
  "neovim/nvim-lspconfig",
  config=function()

    vim.lsp.config("gopls",{})
    vim.lsp.enable("gopls")

    vim.lsp.config("ts_ls",{})
    vim.lsp.enable("ts_ls")

    vim.lsp.config("jdtls",{})
    vim.lsp.enable("jdtls")

    vim.lsp.config("intelephense",{})
    vim.lsp.enable("intelephense")

  end
},

-- Snacks
{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- enable the snacks you want
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
},

-- Claude Code
{
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  lazy = false,
  config = true,
  keys = {
    { "<leader>a",  nil,                             desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>",           desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",      desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",  desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>",desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>",desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",      desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>",       mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
  },
}

})
