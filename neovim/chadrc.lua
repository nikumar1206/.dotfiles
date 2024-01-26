---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"
M.ui = {
  extended_integrations = {"trouble" },
  theme = "onenord",
  nvdash = {
    load_on_startup = true,
    header = {
          [[                                                                       ]],
          [[                                                                     ]],
          [[       ████ ██████           █████      ██                     ]],
          [[      ███████████             █████                             ]],
          [[      █████████ ███████████████████ ███   ███████████   ]],
          [[     █████████  ███    █████████████ █████ ██████████████   ]],
          [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
          [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
          [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
          [[                                                                       ]],
        },
    buttons = {}
  },
  hl_override = highlights.override,
  hl_add = highlights.add,
  statusline = {
    theme = "minimal",
    separator_style = "round",
    overriden_modules = function(modules)
      local config = require("core.utils").load_config().ui.statusline
      local sep_style = config.separator_style
      sep_style = (sep_style ~= "round" and sep_style ~= "block" and sep_style ~= "") and "block" or sep_style


      local default_sep_icons = {
        round = { left = "", right = "" },
        block = { left = "█", right = "█" },
        arrow = { left = "", right = "" },
      }


      local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]


      local sep_l = separators["left"]
      local sep_r = "%#St_sep_r#" .. separators["right"] .. " %#ST_EmptySpace#"


      local function gen_block(icon, txt, sep_l_hlgroup, iconHl_group, txt_hl_group)
        return sep_l_hlgroup .. sep_l .. iconHl_group .. icon .. " " .. txt_hl_group .. " " .. txt .. sep_r
      end


      local noice_ok, noice = pcall(require, "noice.api")
      modules[6] = (function()
        if noice_ok and noice.status.command.has() then
          return "%#NoTexthl#" .. noice.status.command.get() .. " "
        else
          return " "
        end
      end)()
       modules[9] = (function()
        local clients = {}
        local buf = vim.api.nvim_get_current_buf()


        -- Iterate through all the clients for the current buffer
        for _, client in pairs(vim.lsp.get_active_clients { bufnr = buf }) do
          -- Add the client name to the `clients` table
          if client.name ~= "null-ls" then
            table.insert(clients, client.name)
          end
        end


        local conform_ok, conform = pcall(require, "conform")
        if conform_ok then
          local formatters = conform.list_formatters(0)
          for _, formatter in pairs(formatters) do
            if formatter.name ~= "null-ls" then
              table.insert(clients, formatter.name)
            end
          end
        end


        if #clients == 0 then
          return ""
        else
          return (
            vim.o.columns > 100
            and gen_block("", table.concat(clients, ", "), "%#St_lsp_sep#","%#St_lsp_bg#", "%#St_lsp_txt#")
          ) or "  LSP "
        end
      end)()

    modules[10] = (function() -- removes filetype
      return ""
    end)()

    modules[11] = (function () -- removes line number
      return ""
    end)()

    modules[7] = (function () -- removes 'utf-8'
      return ""
    end)()

    modules[3] = (function () -- removes git module
      return ""
    end)()


    end,
  },
  status = {
    colorizer = true,
    dashboard = true,
    telescope_media = true,
  }

}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
