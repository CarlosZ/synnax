{ lib, ... }:
let
  toVimLList = l: lib.concatStringsSep "," l;
  attrsToVimLList = attrs: toVimLList (lib.mapAttrsToList (name: value: "${name}:${value}") attrs);
in
{
  vim = {
    options = {
      backup = false;
      writebackup = false;
      swapfile = false;

      # Editing behavior
      confirm = true; # confirm on unsaved changes instead of erroring
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      undofile = true; # persistent undo across sessions
      undolevels = 10000;

      # Search and completion
      completeopt = toVimLList [
        "fuzzy"
        "menu"
        "menuone"
        "noselect"
      ];
      ignorecase = true;
      smartcase = true;

      # UI and visuals
      breakindent = true; # indent wrapped lines to match the original line
      cursorline = true;
      linebreak = true;
      list = true; # show invisible characters
      listchars = attrsToVimLList {
        tab = "» "; # tabs
        trail = "·"; # trailing spaces
        nbsp = "␣"; # non-breaking space
        extends = "▶"; # line extends to the right
        precedes = "◀"; # line extends to the left
      };
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      termguicolors = true;
      wrap = false;

      # Scrolling and windowing
      scrolloff = 8; # keep context lines above/below cursor
      sidescrolloff = 8; # keep context columns left/right of cursor

      # Panes
      splitbelow = true;
      splitright = true;

      # Input and interaction
      clipboard = "unnamedplus";
      pumheight = 10; # max items in completion pop-up
      shortmess = "IWFotCclTO";
      timeoutlen = 400; # mapped sequence timeout (ms)
      ttimeoutlen = 10; # key code timeout (ms)
      updatetime = 250; # faster swap/diagnostic updates (ms)
    };

    theme = {
      enable = true;
      name = "tokyonight";
      style = "moon";
    };

    # Diagnostic display
    diagnostics.config = {
      virtual_text = {
        source = "if_many";
      };
      signs = true;
      underline = true;
      update_in_insert = false;
      severity_sort = true;
    };
  };
}
