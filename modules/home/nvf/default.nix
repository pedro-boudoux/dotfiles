{pkgs, ...}: {
  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        git.enable = true;
        # LUA CONFIGS TO IGNORE WARNINGS
        luaConfigRC = {
          "000_no_deprecation_warnings" = ''
            local _notify = vim.notify
            vim.notify = function(msg, ...)
              if not msg then return _notify(msg, ...) end
              if string.find(msg, "framework.*is deprecated") then return end
              _notify(msg, ...)
            end
          '';
        };

        viAlias = true;
        vimAlias = true;
        # THEMING
        theme = {
          enable = true; # Must be true or nvf breaks
          transparent = false;
        };

        # DARCULA THEME
        extraPlugins = with pkgs.vimPlugins; {
          git-conflict-nvim = {
            package = git-conflict-nvim;
            setup = "require('git-conflict').setup()";
          };
          vim-svelte = {
            package = pkgs.vimPlugins.vim-svelte;
          };
          darcula-solid = {
            package = pkgs.vimUtils.buildVimPlugin {
              name = "darcula-dark.nvim";
              src = pkgs.fetchFromGitHub {
                owner = "xiantang";
                repo = "darcula-dark.nvim";
                rev = "main";
                hash = "sha256-gRisO9JusksNozqNdxZiAX3okNk31VfxACV2UqGw8c4=";
              };
            };
            #    setup = ''
            #  vim.opt.termguicolors = true
            #  pcall(vim.cmd, "colorscheme darcula-dark")
            #'';
          };
          melange = {
            package = melange-nvim;
            setup = "vim.cmd.colorscheme('melange')";
          };
          everforest = {
            package = everforest;
          };
          vim-matchup = {
            package = vim-matchup;
            setup = "require('nvim-treesitter.configs').setup { matchup = {enable = true }}";
          };
          referencer = {
            package = pkgs.vimUtils.buildVimPlugin {
              name = "referencer.nvim";
              src = pkgs.fetchFromGitHub {
                owner = "romus204";
                repo = "referencer.nvim";
                rev = "master"; # or a specific commit hash if you want stability
                hash = "sha256-E/mET4xmT0qshUUDQpi6rMZZOu/90v2ejLMsUDZFHOw="; # replace this with the actual hash
              };
            };
            setup = "require('referencer').setup()";
          };
        };

        # VISUALS
        visuals = {
          nvimWebDevicons.enable = true;
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        treesitter = {
          enable = true;
          addDefaultGrammars = true;
          grammars = [pkgs.vimPlugins.nvim-treesitter-parsers.svelte];
        };
        autopairs.nvim-autopairs.enable = true;

        # LANGUAGES

        extraPackages = [pkgs.nodePackages.svelte-language-server];

        lsp.lspconfig.sources.svelte = ''
                lspconfig.svelte.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "svelte" },
          })
        '';

        lsp.enable = true;

        lsp.null-ls.enable = true;

        languages = {
          enableTreesitter = true;

          nix = {
            enable = true;
            lsp.enable = true;
            format.enable = true;
            format.type = "alejandra";
          };

          clang = {
            enable = true;
          };

          python = {
            enable = true;
            format.enable = true;
          };

          java = {
            enable = true;
          };

          rust = {
            enable = true;
            crates.enable = true;
          };

          ts = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            format = {
              enable = true;
              type = "prettier";
            };
          };

          html.enable = true;
          css.enable = true;
          tailwind.enable = true;

          #          json.enable = true;
          markdown.enable = true;
        };

        # OPTIONS
        options = {
          shiftwidth = 2;
          tabstop = 2;
          relativenumber = true;
          number = true;
          wrap = true;
          clipboard = "unnamedplus";
        };

        utility.smart-splits = {
          enable = true;

          #mappings = {
          #enableMappings = true;
          #};
        };

        # KEYBINDS
        maps.normal = {
          "<leader>e" = {action = ":NvimTreeToggle<CR>";};
          "<C-p>" = {action = ":Telescope find_files<CR>";};

          "<C-h>" = {action = "<C-w>h";};
          "<C-j>" = {action = "<C-w>j";};
          "<C-k>" = {action = "<C-w>k";};
          "<C-l>" = {action = "<C-w>l";};

          "<leader>d" = {action = ":lua vim.diagnostic.open_float()<CR>";};
          "[d" = {action = ":lua vim.diagnostic.goto_prev()<CR>";};
          "]d" = {action = ":lua vim.diagnostic.goto_next()<CR>";};

          "<leader>Y" = {
            action = ":lua vim.lsp.buf.format()<CR>";
            silent = true;
            desc = "Format Code";
          };
        };

        # PLUGINS
        filetree.nvimTree = {
          enable = true;
          setupOpts = {
            view.width = 30;
            view.side = "left";
            renderer.indent_markers.enable = true;
          };
        };
      };
    };
  };
}
