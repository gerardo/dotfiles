return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local blocked = {
        debugpy = true,
        hadolint = true,
        ["js-debug-adapter"] = true,
      }

      opts.ensure_installed = vim.tbl_filter(function(tool)
        return not blocked[tool]
      end, opts.ensure_installed or {})
    end,
  },
}
