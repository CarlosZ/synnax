{
  vim = {
    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      mappings = {
        goToDefinition = "<leader>cd";
        goToDeclaration = "<leader>cD";
        goToType = "<leader>cy";
        listImplementations = "<leader>ci";
        listReferences = "<leader>cR";
        nextDiagnostic = "<leader>cdn";
        previousDiagnostic = "<leader>cdp";
        openDiagnosticFloat = "<leader>ce";
        documentHighlight = "<leader>ch";
        listDocumentSymbols = "<leader>cs";
        hover = "<leader>ck";
        signatureHelp = "<leader>cS";
        renameSymbol = "<leader>cr";
        codeAction = "<leader>ca";
        format = "<leader>cf";
        toggleFormatOnSave = null;
        addWorkspaceFolder = null;
        removeWorkspaceFolder = null;
        listWorkspaceFolders = null;
        listWorkspaceSymbols = null;
      };
      lightbulb.enable = true;
      lspkind.enable = true;
    };

    maps = {
      normal = {
        # Diagnostics
        "<leader>cden" = {
          action = "function() vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR}) end";
          lua = true;
          desc = "Next error";
        };
        "<leader>cdep" = {
          action = "function() vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR}) end";
          lua = true;
          desc = "Previous error";
        };
        "<leader>cdwn" = {
          action = "function() vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN}) end";
          lua = true;
          desc = "Next warning";
        };
        "<leader>cdwp" = {
          action = "function() vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN}) end";
          lua = true;
          desc = "Previous warning";
        };
      };

      insert = {
        # LSP in insert mode
        "<C-k>" = {
          action = "vim.lsp.buf.signature_help";
          lua = true;
          desc = "Signature help";
        };
      };

      visual = {
        # Code/LSP in visual mode
        "<leader>ca" = {
          action = "vim.lsp.buf.code_action";
          lua = true;
          desc = "Code actions";
        };
        "<leader>cf" = {
          action = "vim.lsp.buf.format";
          lua = true;
          desc = "Format selection";
        };
      };
    };
  };
}
