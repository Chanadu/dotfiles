return {
	"VonHeikemen/lsp-zero.nvim",
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "neovim/nvim-lspconfig" },
		{ "onsails/lspkind.nvim" },
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
		},
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
	},
	config = function()
		local lsp_zero = require("lsp-zero")

		local lsp_attach = function(_, bufnr)
			local opts = { buffer = bufnr }

			local keymap = vim.keymap
			keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
			keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
			keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
			keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
			keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
			keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
			keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
			keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
			keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
			keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
		end

		lsp_zero.extend_lspconfig({
			sign_text = true,
			lsp_attach = lsp_attach,
			float_border = "rounded",
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			servers = {},
			inlay_hints = {
				enabled = true,
			},
		})

		require("mason").setup({})
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			},
			ensure_installed = {},
		})

		local cmp = require("cmp")
		local cmp_action = lsp_zero.cmp_action()
		-- this is the function that loads the extra snippets
		-- from rafamadriz/friendly-snippets
		require("luasnip.loaders.from_vscode").lazy_load()
		local luasnip = require("luasnip")

		local s = luasnip.snippet
		local t = luasnip.text_node
		local i = luasnip.insert_node
		luasnip.add_snippets("all", {
			s("scc", {
				t({ '<script lang="ts">', "", "</script>" }),
				t({ "", "<div>", "" }),
				i(1),
				t({ "</div>", "", '<style lang="postcss">', "", "</style>" }),
			}),
		})

		local lspkind = require("lspkind")

		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "copilot" },
				{ name = "path" },
				{ name = "luasnip", keyword_length = 2 },
				{ name = "buffer", keyword_length = 3 },
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-3),
				["<C-f>"] = cmp.mapping.scroll_docs(3),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),

				-- navigate between snippet placeholders
				["<C-n>"] = cmp_action.luasnip_jump_forward(),
				["<C-m>"] = cmp_action.luasnip_jump_backward(),
			}),
			experimental = {
				ghost_text = true,
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = lspkind.cmp_format({
					mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
					maxwidth = 100, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					menu = { -- showing type in menu
						nvim_lsp = "[LSP]",
						path = "[Path]",
						buffer = "[Buffer]",
						luasnip = "[LuaSnip]",
						copilot = "[Copilot]",
					},
				}),
			},
		})

		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
}
