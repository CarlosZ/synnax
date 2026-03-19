{ lib, config, ... }:
let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.options) mkOption literalMD;
  inherit (lib.types)
    attrsOf
    either
    listOf
    nullOr
    str
    submodule
    ;
  inherit (lib.nvim.config) mkBool;
  inherit (lib.nvim.dag) entryAfter;

  toLua' = lib.generators.toLua { };

  mapType = submodule {
    options = {
      desc = mkOption {
        type = nullOr str;
        default = null;
        description = "A description of this map to be shown in which-key.";
      };
      key = mkOption {
        type = str;
        description = "The key that triggers this map.";
      };
      mode = mkOption {
        type = either str (listOf str);
        description = ''
          The short-name of the mode to set the mapping for. Passing an empty string is the equivalent of `:map`.

          See `:help map-modes` for a list of modes.
        '';
        example = literalMD ''`["n" "v" "c"]` for normal, visual and command mode'';
      };
      action = mkOption {
        type = str;
        description = "The command to execute.";
      };
      lua = mkBool false ''
        If true, `action` is considered to be lua code.
        Thus, it will not be wrapped in `""`.
      '';

      silent = mkBool true "Whether this mapping should be silent. Equivalent to adding <silent> to a map.";
      nowait = mkBool false "Whether to wait for extra input on ambiguous mappings. Equivalent to adding <nowait> to a map.";
      script = mkBool false "Equivalent to adding <script> to a map.";
      expr = mkBool false "Means that the action is actually an expression. Equivalent to adding <expr> to a map.";
      unique = mkBool false "Whether to fail if the map is already defined. Equivalent to adding <unique> to a map.";
      noremap = mkBool true "Whether to use the 'noremap' variant of the command, ignoring any custom mappings on the defined action. It is highly advised to keep this on, which is the default.";
      has = mkOption {
        type = nullOr (either str (listOf str));
        default = null;
        description = "Only register this mapping if the given feature(s) are available via in LSP.";
      };
      enabled = mkOption {
        type = nullOr str;
        default = null;
        description = "Lua expression passed as the `enabled` condition to Snacks.keymap.set.";
      };
    };
  };

  groupType = submodule {
    options = {
      name = mkOption {
        type = nullOr str;
        default = null;
        description = "A description of this group to be shown in which-key.";
      };
      rootKey = mkOption {
        type = nullOr str;
        default = null;
        description = "The root key for this group. If null, bindings are registered without a group prefix.";
      };
      icon = mkOption {
        type = nullOr str;
        default = null;
        description = "The icon to be used by the mappings in this group.";
      };
      iconColor = mkOption {
        type = nullOr str;
        default = null;
        description = "The icon color to be used by the mappings in this group.";
      };
      expand = mkOption {
        type = nullOr str;
        default = null;
        description = "Expansion function for group";
      };
      maps = mkOption {
        type = listOf mapType;
        description = "Custom which-key keybindings.";
        example = ''
           [
            {
              key = "m";
              mode = "n";
              silent = true;
              action = ":make<CR>";
            }
            {
              key = "l";
              mode = ["n" "x"];
              silent = true;
              action = "<cmd>cnext<CR>";
            }
          ];
        '';
        default = [ ];
      };
    };
  };

  mkIcon =
    group:
    let
      iconAttrs =
        lib.optionalAttrs (group ? icon && group.icon != null) { inherit (group) icon; }
        // lib.optionalAttrs (group ? iconColor && group.iconColor != null) { color = group.iconColor; };
    in
    lib.optionalAttrs (iconAttrs != { }) { icon = iconAttrs; };

  mkRest =
    attrs:
    builtins.concatStringsSep ", " (lib.mapAttrsToList (k: v: "[${toLua' k}] = ${toLua' v}") attrs);

  mkWkGroups =
    inputSet:
    let
      mkGroupEntry =
        name: group:
        let
          finalName = if group.name == null then name else group.name;
        in
        mkLuaInline "{ ${toLua' group.rootKey}, group = ${toLua' finalName}, ${
          mkRest (
            (mkIcon group)
            // (lib.optionalAttrs (group ? expand && group.expand != null) {
              expand = mkLuaInline group.expand;
            })
          )
        } }";
    in
    lib.concatLists (
      lib.attrsets.mapAttrsToList (
        name: group: lib.optional (group.rootKey != null) (mkGroupEntry name group)
      ) inputSet
    );

  mkMappings =
    inputSet:
    let
      mkAction = binding: if binding ? lua && binding.lua then binding.action else toLua' binding.action;
      mkCall =
        group: binding:
        let
          fullKey = if group.rootKey != null then "${group.rootKey}${binding.key}" else binding.key;
          normalizeMethod = h: if lib.hasInfix "/" h then h else "textDocument/${h}";
          lspOpt =
            if binding.has == null then
              { }
            else if builtins.isString binding.has then
              {
                lsp = {
                  method = normalizeMethod binding.has;
                };
              }
            else
              { lsp = map (h: { method = normalizeMethod h; }) binding.has; };
          opts =
            lib.filterAttrs (_: v: v != null) (
              removeAttrs binding [
                "action"
                "mode"
                "key"
                "lua"
                "has"
                "enabled"
              ]
            )
            // lspOpt
            // lib.optionalAttrs (binding.enabled != null) {
              enabled = mkLuaInline binding.enabled;
              buffer = true;
            };
        in
        "Snacks.keymap.set(${toLua' binding.mode}, ${toLua' fullKey}, ${mkAction binding}, { ${mkRest opts} })";
    in
    builtins.concatStringsSep "\n" (
      lib.concatMap (group: map (mkCall group) group.maps) (builtins.attrValues inputSet)
    );
in
{
  options.synnax.keys = mkOption {
    type = attrsOf groupType;
    description = "Custom which-key keybindings.";
    example = ''
      synnax.keys = {
        make = {
          name = "+Make";
          rootKey = "<leader>m";
          icon = "";
          iconColor = "red";
          maps = [
            {
              key = "m";  # final keymap "<leader>mm"
              mode = "n";
              silent = true;
              action = ":make<CR>";
            }
          ];
        };
      };
    '';
    default = { };
  };

  config = {
    vim = {
      globals = {
        mapleader = " ";
        maplocalleader = ",";
      };

      startPlugins = [ "which-key-nvim" ];

      luaConfigRC.synnax-keys = entryAfter [ "mappings" ] ''
        local wk = require("which-key")
        wk.setup({
          preset = "helix",
          icons = {
            rules = false,
          },
        });
        wk.add(${toLua' (mkWkGroups config.synnax.keys)})
        ${mkMappings config.synnax.keys}
      '';
    };

    synnax.keys."_".maps = [
      {
        key = "<leader><leader>";
        mode = [ "n" ];
        action = ''
          function()
            require("snacks").picker.smart()
          end
        '';
        desc = "Smart find";
        lua = true;
      }
      {
        key = "<esc>";
        mode = [
          "i"
          "n"
          "s"
        ];
        action = ''
          function()
            vim.cmd("noh")
            return "<esc>"
          end
        '';
        desc = "Escape and Clear hlsearch";
        expr = true;
        lua = true;
      }
      # Annoyances
      {
        key = "q:";
        mode = [ "n" ];
        action = "<nop>";
      }

      # Keep selection after indent
      {
        key = "<";
        mode = [ "v" ];
        action = "<gv";
        desc = "Indent left";
      }
      {
        key = ">";
        mode = [ "v" ];
        action = ">gv";
        desc = "Indent right";
      }
      {
        key = "p";
        mode = [ "v" ];
        action = ''
          function()
            return 'pgv"' .. vim.v.register .. "y"
          end
        '';
        noremap = true;
        expr = true;
        lua = true;
      }

      # Window management
      {
        key = "<leader>-";
        mode = [ "n" ];
        action = "<C-w>s";
        desc = "Split window horizontally";
      }
      {
        key = "<leader>|";
        mode = [ "n" ];
        action = "<C-w>v";
        desc = "Split window vertically";
      }
    ];
  };
}
