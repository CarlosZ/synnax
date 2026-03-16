{
  inputs',
  flakeInputs,
  pkgs,
  lib,
  isDev,
  ...
}:
let
  agenticNvimPkg =
    (pkgs.vimUtils.buildVimPlugin {
      name = "agentic-nvim";
      src = flakeInputs.agentic-nvim;

      nvimSkipModules = [
        "agentic.ui.tool_call_diff.test"
        "agentic.ui.hunk_navigation.test"
        "agentic.ui.permission_manager.test"
        "agentic.ui.widget_layout.test"
        "agentic.ui.code_selection.test"
        "agentic.ui.todo_list.test"
        "agentic.ui.diff_preview.test"
        "agentic.ui.chat_history.test"
        "agentic.ui.chat_widget.test"
        "agentic.ui.diagnostics_context.test"
        "agentic.ui.diff_split_view.test"
        "agentic.ui.file_picker.test"
        "agentic.ui.file_list.test"
        "agentic.ui.message_writer.test"
        "agentic.ui.diagnostics_list.test"
        "agentic.session_registry.test"
        "agentic.utils.diff_highlighter.test"
        "agentic.utils.buf_helpers.test"
        "agentic.utils.text_matcher.test"
        "agentic.utils.object.test"
        "agentic.acp.agent_modes.test"
        "agentic.acp.slash_commands.test"
        "agentic.session_restore.test"
        "agentic.session_manager.test"
      ];
    }).overrideAttrs
      (_: {
        name = "agentic-nvim";
      });
in
{
  config = lib.mkIf isDev {
    vim = {
      lazy.plugins.agentic-nvim = {
        package = agenticNvimPkg;
        setupModule = "agentic";
        setupOpts = {
          provider = "claude-agent-acp";
          acp_providers = {
            claude-agent-acp = {
              command = "${inputs'.llm-agents.packages.claude-code-acp}/bin/claude-agent-acp";
            };
          };
        };
      };
    };

    synnax.keys = {
      "Agentic" = {
        rootKey = "<leader>a";
        icon = "";
        iconColor = "orange";
        maps = [
          {
            key = "t";
            mode = [ "n" ];
            action = ''
              function() require("agentic").toggle() end
            '';
            desc = "Toggle Agentic Chat";
            lua = true;
          }
          {
            key = "a";
            mode = [ "n" ];
            action = ''
              function() require("agentic").add_selection_or_file_to_context() end
            '';
            desc = "Add file or sel to Agentic Chat";
            lua = true;
          }
          {
            key = "n";
            mode = [ "n" ];
            action = ''
              function() require("agentic").new_session() end
            '';
            desc = "New Agentic Chat Session";
            lua = true;
          }
          {
            key = "r";
            mode = [ "n" ];
            action = ''
              function() require("agentic").restore_session() end
            '';
            desc = "Restore Agentic Chat Session";
            lua = true;
          }
          {
            key = "l";
            mode = [ "n" ];
            action = ''
              function() require("agentic").add_current_line_diagnostics() end
            '';
            desc = "Add line diagnostics to Agentic Chat";
            lua = true;
          }
          {
            key = "d";
            mode = [ "n" ];
            action = ''
              function() require("agentic").add_buffer_diagnostics() end
            '';
            desc = "Add buffer diagnostics to Agentic Chat";
            lua = true;
          }
        ];
      };
    };
  };
}
