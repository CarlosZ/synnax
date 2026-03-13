{ lib, config, ... }:
let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.dag) entryBefore;

  augroup = "synnax_lsp";
in
{
  vim = {
    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      mappings = lib.mapAttrs (_: _: null) config.vim.lsp.mappings;
      lightbulb.enable = true;
      lspkind.enable = true;
    };

    augroups = [ { name = augroup; } ];
    autocmds = [
      {
        group = augroup;
        event = [ "LspAttach" ];
        desc = "LSP on-attach add custom keybinds";
        callback = mkLuaInline ''
          function(event)
            local bufnr = event.buf
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            attach_keymap_groups(client, bufnr)
          end
        '';
      }
    ];

    luaConfigRC.lspkeymapgroups = entryBefore [ "lsp-setup" "autocmds" ] ''
      local attach_keymap_groups = function()
        local wk = require("which-key")
        wk.add({
          { "<leader>cx", desc = "+Diagnostics", icon = { icon = "󰩂", color = "blue" } },
          { "<leader>cxe", desc = "+Errors", icon = { icon = "", color = "red" } },
          { "<leader>cxw", desc = "+Warnings", icon = { icon = "", color = "yellow" } },
        })
      end
    '';
  };

  synnax.keys = {
    Code = {
      rootKey = "<leader>c";
      icon = "";
      iconColor = "orange";
      maps = [
        {
          key = "D";
          mode = [ "n" ];
          action = "vim.lsp.buf.declaration";
          desc = "Go to declaration";
          lua = true;
          has = "declaration";
        }

        {
          key = "d";
          mode = [ "n" ];
          action = "vim.lsp.buf.definition";
          desc = "Go to definition";
          lua = true;
          has = "definition";
        }

        {
          key = "y";
          mode = [ "n" ];
          action = "vim.lsp.buf.type_definition";
          desc = "Go to type";
          lua = true;
          has = "typeDefinition";
        }

        {
          key = "i";
          mode = [ "n" ];
          action = "vim.lsp.buf.implementation";
          desc = "List implementations";
          lua = true;
          has = "implementation";
        }

        {
          key = "R";
          mode = [ "n" ];
          action = "vim.lsp.buf.references";
          desc = "List references";
          lua = true;
          has = "references";
        }

        {
          key = "xn";
          mode = [ "n" ];
          action = "vim.diagnostic.goto_next";
          desc = "Go to next diagnostic";
          lua = true;
          enabled = ''
            function(bufnr)
              return #(vim.diagnostic.get(bufnr)) > 0
            end
          '';
        }

        {
          key = "xp";
          mode = [ "n" ];
          action = "vim.diagnostic.goto_prev";
          desc = "Go to previous diagnostic";
          lua = true;
          enabled = ''
            function(bufnr)
              return #(vim.diagnostic.get(bufnr)) > 0
            end
          '';
        }

        {
          key = "xen";
          mode = [ "n" ];
          action = "function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end";
          desc = "Next error";
          lua = true;
          enabled = ''
            function(bufnr)
              return #(vim.diagnostic.get(bufnr)) > 0
            end
          '';
        }

        {
          key = "xep";
          mode = [ "n" ];
          action = "function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end";
          desc = "Previous error";
          lua = true;
          enabled = ''
            function(bufnr)
              return #(vim.diagnostic.get(bufnr)) > 0
            end
          '';
        }

        {
          key = "xwn";
          mode = [ "n" ];
          action = "function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end";
          desc = "Next warning";
          lua = true;
          enabled = ''
            function(bufnr)
              return #(vim.diagnostic.get(bufnr)) > 0
            end
          '';
        }

        {
          key = "xwp";
          mode = [ "n" ];
          action = "function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end";
          desc = "Previous warning";
          lua = true;
          enabled = ''
            function(bufnr)
              return #(vim.diagnostic.get(bufnr)) > 0
            end
          '';
        }

        {
          key = "e";
          mode = [ "n" ];
          action = "vim.diagnostic.open_float";
          desc = "Open diagnostic float";
          lua = true;
          enabled = ''
            function(bufnr)
              vim.print("bufnr: " .. bufnr)
              vim.print("diags: " .. #(vim.diagnostic.get(bufnr)))
              return #(vim.diagnostic.get(bufnr)) > 0
            end
          '';
        }

        {
          key = "h";
          mode = [ "n" ];
          action = "vim.lsp.buf.document_highlight";
          desc = "Document highlight";
          lua = true;
          has = "documentHighlight";
        }

        {
          key = "s";
          mode = [ "n" ];
          action = "vim.lsp.buf.document_symbol";
          desc = "List document symbols";
          lua = true;
          has = "documentSymbol";
        }

        {
          key = "k";
          mode = [ "n" ];
          action = "vim.lsp.buf.hover";
          desc = "Trigger hover";
          lua = true;
          has = "hover";
        }

        {
          key = "S";
          mode = [ "n" ];
          action = "vim.lsp.buf.signature_help";
          desc = "Signature help";
          lua = true;
          has = "signatureHelp";
        }

        {
          key = "r";
          mode = [ "n" ];
          action = "vim.lsp.buf.rename";
          desc = "Rename symbol";
          lua = true;
          has = "rename";
        }

        {
          key = "a";
          mode = [ "n" ];
          action = "vim.lsp.buf.code_action";
          desc = "Code action";
          lua = true;
          has = "codeAction";
        }

        {
          key = "f";
          mode = [ "n" ];
          action = "vim.lsp.buf.format";
          desc = "Format";
          lua = true;
          has = "formatting";
        }

        # LSP in insert mode
        {
          key = "<C-k>";
          mode = [ "i" ];
          action = "vim.lsp.buf.signature_help";
          desc = "Signature help";
          lua = true;
          has = "signatureHelp";
        }

        # Code/LSP in visual mode
        {
          key = "a";
          mode = [ "v" ];
          action = "vim.lsp.buf.code_action";
          desc = "Code actions";
          lua = true;
          has = "codeAction";
        }
        {
          key = "f";
          mode = [ "v" ];
          action = "vim.lsp.buf.format";
          desc = "Format selection";
          lua = true;
          has = "rangeFormatting";
        }
      ];
    };
  };
}
