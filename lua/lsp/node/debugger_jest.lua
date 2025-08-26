local pick_one_sync = require("cmd.ui").pick_one_sync
local home_directory = os.getenv("HOME")

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "yarn",
      runtimeArgs = function()
        local test_cmds = require("cmd.run_package_json_script").get_scripts_from_package_json("^test:[^.]+")

        table.sort(test_cmds or {})

        local env = pick_one_sync(test_cmds, "Select Test Cmd", function(item)
          return item
        end)

        print("Picked Test Env\n" .. env)
        return {
          env,
        }
      end,
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      program = "${file}",
      internalConsoleOptions = "neverOpen",
      env = {
        -- env required to run test container in Colima
        -- ref: https://node.testcontainers.org/supported-container-runtimes/#colima
        TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE = "/var/run/docker.sock",
        DOCKER_HOST = "unix://" .. home_directory .. "/.colima/default/docker.sock",
      },
    },
  }
end
