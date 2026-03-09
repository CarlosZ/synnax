{
  lib,
  config,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.lua) toLuaObject;
  inherit (lib.nvim.dag) entryBefore;

  mkBinding = mode: key: binding: "vim.keymap.set(${toLuaObject mode}, ${toLuaObject key}, ${binding.action}, {buffer=bufnr, noremap=true, silent=true, desc=${toLuaObject binding.desc}})";

  mappings = {
    normal = {
      "<leader>cD" = {
        action = "vim.lsp.buf.declaration";
        desc = "Go to declaration";
      };

      "<leader>cd" = {
        action = "vim.lsp.buf.definition";
        desc = "Go to definition";
      };

      "<leader>cy" = {
        action = "vim.lsp.buf.type_definition";
        desc = "Go to type";
      };

      "<leader>ci" = {
        action = "vim.lsp.buf.implementation";
        desc = "List implementations";
      };

      "<leader>cR" = {
        action = "vim.lsp.buf.references";
        desc = "List references";
      };

      "<leader>cxn" = {
        action = "vim.diagnostic.goto_next";
        desc = "Go to next diagnostic";
      };

      "<leader>cxp" = {
        action = "vim.diagnostic.goto_prev";
        desc = "Go to previous diagnostic";
      };

      "<leader>cxen" = {
        action = "function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end";
        desc = "Next error";
      };

      "<leader>cxep" = {
        action = "function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end";
        desc = "Previous error";
      };

      "<leader>cxwn" = {
        action = "function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end";
        desc = "Next warning";
      };

      "<leader>cxwp" = {
        action = "function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end";
        desc = "Previous warning";
      };

      "<leader>ce" = {
        action = "vim.diagnostic.open_float";
        desc = "Open diagnostic float";
      };

      "<leader>ch" = {
        action = "vim.lsp.buf.document_highlight";
        desc = "Document highlight";
      };

      "<leader>cs" = {
        action = "vim.lsp.buf.document_symbol";
        desc = "List document symbols";
      };

      "<leader>ck" = {
        action = "vim.lsp.buf.hover";
        desc = "Trigger hover";
      };

      "<leader>cS" = {
        action = "vim.lsp.buf.signature_help";
        desc = "Signature help";
      };

      "<leader>cr" = {
        action = "vim.lsp.buf.rename";
        desc = "Rename symbol";
      };

      "<leader>ca" = {
        action = "vim.lsp.buf.code_action";
        desc = "Code action";
      };

      "<leader>cf" = {
        action = "vim.lsp.buf.format";
        desc = "Format";
      };
    };

    insert = {
      # LSP in insert mode
      "<C-k>" = {
        action = "vim.lsp.buf.signature_help";
        desc = "Signature help";
      };
    };

    visual = {
      # Code/LSP in visual mode
      "<leader>ca" = {
        action = "vim.lsp.buf.code_action";
        desc = "Code actions";
      };
      "<leader>cf" = {
        action = "vim.lsp.buf.format";
        desc = "Format selection";
      };
    };
  };

  augroup = "synnax_lsp";
in {
  vim = {
    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      mappings = lib.mapAttrs (_: _: null) config.vim.lsp.mappings;
      lightbulb.enable = true;
      lspkind.enable = true;
    };

    augroups = [{name = augroup;}];
    autocmds = [
      {
        group = augroup;
        event = ["LspAttach"];
        desc = "LSP on-attach add custom keybinds";
        callback = mkLuaInline ''
          function(event)
            local bufnr = event.buf
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            attach_keymaps_custom(client, bufnr)
          end
        '';
      }
    ];

    pluginRC.lsp-setup = entryBefore ["autocmds"] ''
      local attach_keymaps_custom = function(client, bufnr)
        local wk = require("which-key")
        wk.add({
          { "<leader>c", desc = "+Code", icon = { icon = "", color = "orange" } },
          { "<leader>cx", desc = "+Diagnostics", icon = { icon = "󰩂", color = "blue" } },
          { "<leader>cxe", desc = "+Errors", icon = { icon = "", color = "red" } },
          { "<leader>cxw", desc = "+Warnings", icon = { icon = "", color = "yellow" } },
        })
        ${lib.concatStringsSep "\n" (lib.mapAttrsToList (mkBinding "n") mappings.normal)}
        ${lib.concatStringsSep "\n" (lib.mapAttrsToList (mkBinding "i") mappings.insert)}
        ${lib.concatStringsSep "\n" (lib.mapAttrsToList (mkBinding "v") mappings.visual)}
      end
    '';
  };
}
