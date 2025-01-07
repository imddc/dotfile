return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui", -- UI 插件
    "theHamsta/nvim-dap-virtual-text", -- 虚拟文本
    "mxsdev/nvim-dap-vscode-js", -- JavaScript 调试适配器
  },
  config = function()
    -- 配置 dap-ui
    require("dapui").setup()
    require("nvim-dap-virtual-text").setup({})

    -- 配置 nvim-dap
    local dap = require("dap")

    -- 配置 JavaScript 调试适配器
    require("dap-vscode-js").setup({
      node_path = "node", -- Node.js 可执行文件路径
      debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
      adapters = { "pwa-node", "node-terminal", "pwa-chrome" },
    })

    -- JavaScript 调试配置
    dap.configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
  end,
}
