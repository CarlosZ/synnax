{ lib, config, ... }:
{
  vim.utility = {
    grug-far-nvim.enable = true;
    mkdir.enable = true;
    undotree.enable = true;
    motion.flash-nvim = {
      enable = true;
      setupOpts = {
        label.rainbow.enabled = true;
        modes = {
          search.enabled = true;
          char.jump_labels = true;
        };
      };
      mappings = lib.mapAttrs (_: _: null) config.vim.utility.motion.flash-nvim.mappings;
    };
  };

  synnax.keys."_".maps = [
    {
      key = "s";
      mode = [
        "n"
        "x"
        "o"
      ];
      action = ''
        function()
          require("flash").jump()
        end
      '';
      desc = "Flash";
      lua = true;
    }
    {
      key = "S";
      mode = [
        "n"
        "x"
        "o"
      ];
      action = ''
        function()
          require("flash").treesitter()
        end
      '';
      desc = "Flash Treesitter";
      lua = true;
    }
    {
      key = "<c-space>";
      mode = [
        "n"
        "x"
        "o"
      ];
      action = ''
        function()
          require("flash").treesitter({
            actions = {
              ["<c-space>"] = "next",
              ["<BS>"] = "prev"
            }
          })
        end
      '';
      desc = "Treesitter incremental selection";
      lua = true;
    }
    {
      key = "r";
      mode = [ "o" ];
      action = ''
        function()
          require("flash").remote()
        end
      '';
      desc = "Remote Flash";
      lua = true;
    }
    {
      key = "R";
      mode = [
        "x"
        "o"
      ];
      action = ''
        function()
          require("flash").treesitter_search()
        end
      '';
      desc = "Treesitter Search";
      lua = true;
    }
    {
      key = "<c-s>";
      mode = [ "c" ];
      action = ''
        function()
          require("flash").toggle()
        end
      '';
      desc = "Toggle Flash Search";
      lua = true;
    }
  ];
}
