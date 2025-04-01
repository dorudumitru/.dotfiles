return {
  "GustavEikaas/easy-dotnet.nvim",
  -- 'nvim-telescope/telescope.nvim' or 'ibhagwan/fzf-lua' or 'folke/snacks.nvim'
  -- are highly recommended for a better experience
  dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
  config = function()
    local function get_secret_path(secret_guid)
      local path = ""
      local home_dir = vim.fn.expand("~")
      if require("easy-dotnet.extensions").isWindows() then
        local secret_path = home_dir
          .. "\\AppData\\Roaming\\Microsoft\\UserSecrets\\"
          .. secret_guid
          .. "\\secrets.json"
        path = secret_path
      else
        local secret_path = home_dir .. "/.microsoft/usersecrets/" .. secret_guid .. "/secrets.json"
        path = secret_path
      end
      return path
    end

    local dotnet = require("easy-dotnet")
    -- Options are not required
    dotnet.setup({
      ---@type TestRunnerOptions
      test_runner = {
        ---@type "split" | "float" | "buf"
        viewmode = "float",
        enable_buffer_test_execution = true, --Experimental, run tests directly from buffer
        noBuild = true,
        noRestore = true,
        icons = {
          passed = "",
          skipped = "",
          failed = "",
          success = "",
          reload = "",
          test = "",
          sln = "󰘐",
          project = "󰘐",
          dir = "",
          package = "",
        },
        mappings = {
          run_test_from_buffer = { lhs = "", desc = "run test from buffer" },
          filter_failed_tests = { lhs = "", desc = "filter failed tests" },
          debug_test = { lhs = "", desc = "debug test" },
          debug_test_from_buffer = { lhs = "", desc = "debug test from buffer" },
          go_to_file = { lhs = "", desc = "got to file" },
          run_all = { lhs = "", desc = "run all tests" },
          run = { lhs = "", desc = "run test" },
          peek_stacktrace = { lhs = "", desc = "peek stacktrace of failed test" },
          expand = { lhs = "", desc = "expand" },
          expand_node = { lhs = "", desc = "expand node" },
          expand_all = { lhs = "", desc = "expand all" },
          collapse_all = { lhs = "", desc = "collapse all" },
          close = { lhs = "", desc = "close testrunner" },
          refresh_testrunner = { lhs = "", desc = "refresh testrunner" },
        },
        --- Optional table of extra args e.g "--blame crash"
        additional_args = {},
      },
      ---@param action "test" | "restore" | "build" | "run"
      terminal = function(path, action, args)
        local commands = {
          run = function()
            return string.format("dotnet run --project %s %s", path, args)
          end,
          test = function()
            return string.format("dotnet test %s %s", path, args)
          end,
          restore = function()
            return string.format("dotnet restore %s %s", path, args)
          end,
          build = function()
            return string.format("dotnet build %s %s", path, args)
          end,
        }

        local command = commands[action]() .. "\r"
        vim.cmd("vsplit")
        vim.cmd("term " .. command)
      end,
      secrets = {
        path = get_secret_path,
      },
      csproj_mappings = true,
      auto_bootstrap_namespace = {
        --block_scoped, file_scoped
        type = "file_scoped",
        enabled = true,
      },
      -- choose which picker to use with the plugin
      -- possible values are "telescope" | "fzf" | "snacks" | "basic"
      -- if no picker is specified, the plugin will determine
      -- the available one automatically with this priority:
      -- telescope -> fzf -> snacks ->  basic
      picker = "snacks",
    })

    -- Example command
    vim.api.nvim_create_user_command("Secrets", function()
      dotnet.secrets()
    end, {})
  end,
}
