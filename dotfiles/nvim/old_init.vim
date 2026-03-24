set nu rnu
set nowrap
set tabstop=4
set shiftwidth=4
set expandtab

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/site/plugged')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

call plug#end()

set completeopt=menu,menuone,noselect

set termguicolors
colorscheme witchhazel
" set background=light
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE

lua << EOF

-- Mappings.
vim.g.mapleader = ' '

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local cmp = require "cmp"

cmp.setup {
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        --["<C-y>"] = cmp.mapping.confirm{
        ['<CR>'] = cmp.mapping.confirm{
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        ["<C-space>"] = cmp.mapping.complete(),
        -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        {name = "nvim_lsp"},
        {name = "path"},
        {name = "luasnip"},
        {name = "buffer"},
    }),
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    -- expiremental = {
    --     native_menu = false,
    --     ghost_text = false,
    -- },
}

local servers = { 'ccls', 'rust_analyzer', 'zls', 'wgsl_analyzer', 'glslls', 'cssls', 'jsonls', 'html'}

for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            --vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
        end,
        capabilities = capabilities,
        flags = {
            -- This is the default in Nvim 0.7+
            debounce_text_changes = 150,
        }
    }
end

require'lspconfig'.glslls.setup{
    cmd = {"glslls"},
    filetypes = {"glsl, frag, vert"},
    root_dir = require 'lspconfig.util'.root_pattern(".git"),
}

require'lspconfig'.wgsl_analyzer.setup{
    cmd = {"wgsl_analyzer"},
    filetypes = {"wgsl"},
    root_dir = require 'lspconfig.util'.root_pattern(".git"),
}

require'lspconfig'.glslls.setup{
    cmd = { 'glslls', '--stdin' },
    filetypes = {"glsl"},
    root_dir = require 'lspconfig.util'.root_pattern(".git"),
    single_file_support = true,
}

vim.cmd [[ autocmd BufNewFile,BufRead *.wgsl set filetype=wgsl ]]
vim.cmd [[ autocmd BufNewFile,BufRead *.glsl set filetype=glsl ]]
vim.cmd [[ autocmd BufNewFile,BufRead *.frag set filetype=glsl ]]
vim.cmd [[ autocmd BufNewFile,BufRead *.vert set filetype=glsl ]]

local comment = require "Comment"

comment.setup {
    opleader = {
        line = 'gc',
        block = 'gb',
    },
    mappings = {
        basic = true,
        extra = true,
    },
}

-- Keymaps for Luasnip
local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set("i", "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

local luasnip = require "luasnip"
local types = require "luasnip.util.types"

luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    --ext_opts {
    --    [types.choiceNode] = {
    --        active = {
    --            virt_text = {{"", "Error"}}
    --        }
    --    }
    --}
}


_G.tel_find = function(path)
    local utils = require('telescope.utils')
    local builtin = require('telescope.builtin')
    local _, ret, stderr = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
    if ret == 0 then
        builtin.git_files()
    else
        builtin.find_files()
    end
end

local telescope = require("telescope")
telescope.load_extension "file_browser"

--Telescope Bindings
vim.keymap.set("n", "<leader>ff", ":Telescope grep_string<CR>")
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h<CR>")

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "lua", "rust", "zig", "glsl", "wgsl", "javascript", "cmake", "bash" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
