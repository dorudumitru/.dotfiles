return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          -- Your JDTLS configuration goes here
          jdtls = {
            handlers = {
              -- By assigning an empty function, you can remove the notifications
              -- printed to the cmd
              ["$/progress"] = function() end,
              -- This should remove the inlay hints bug
              ["textDocument/inlayHint"] = function() end,
            },
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    {
                      name = "Java-21",
                      path = "~/.sdkman/candidates/java/21.0.6-tem",
                    },
                    {
                      name = "Java-17",
                      path = "~/.sdkman/candidates/java/17.0.14-tem",
                    },
                  },
                },
              },
            },
          },
        },
        setup = {
          jdtls = function()
            -- Your nvim-java configuration goes here
            require("java").setup({
              jdk = {
                auto_install = false,
              },
              -- root_markers = {
              --   "settings.gradle",
              --   "settings.gradle.kts",
              --   "pom.xml",
              --   "build.gradle",
              --   "mvnw",
              --   "gradlew",
              --   "build.gradle",
              --   "build.gradle.kts",
              -- },
            })
          end,
        },
      },
    },
  },
}
