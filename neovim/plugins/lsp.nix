{ lib, config, ... }:
{
  vim = {
    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      mappings = lib.mapAttrs (_: _: null) config.vim.lsp.mappings;
      lightbulb.enable = true;
      lspkind.enable = true;
      trouble = {
        enable = true;
        mappings = lib.mapAttrs (_: _: null) (
          lib.filterAttrs (k: _: k != "toggle") config.vim.lsp.trouble.mappings
        );
      };
    };
  };

  synnax.keys = {
    Code = {
      rootKey = "<leader>c";
      icon = "";
      iconColor = "orange";
      maps = [
        {
          key = "i";
          mode = [ "n" ];
          action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
          desc = "List impl / symbos/ refs";
        }

        {
          key = "l";
          mode = [ "n" ];
          action = "<cmd>Trouble loclist toggle<cr>";
          desc = "Location list";
        }

        {
          key = "q";
          mode = [ "n" ];
          action = "<cmd>Trouble quickfix toggle<cr>";
          desc = "Quickfix list";
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
          key = "n";
          mode = [ "n" ];
          action = "vim.diagnostic.goto_next";
          desc = "Go to next diagnostic";
          lua = true;
        }

        {
          key = "p";
          mode = [ "n" ];
          action = "vim.diagnostic.goto_prev";
          desc = "Go to previous diagnostic";
          lua = true;
        }

        {
          key = "e";
          mode = [ "n" ];
          action = "<cmd>Trouble diagnostics focus=true<cr>";
          desc = "Open diagnostics";
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
          action = "<cmd>Trouble symbols toggle focus=false<cr>";
          desc = "List document symbols";
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
