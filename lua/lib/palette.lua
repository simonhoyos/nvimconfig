--- Dracula colors, by name.
---
--- Plugins that auto-derive a palette (Neogit, for one) read colors out of
--- semantic groups such as `String` or `Macro`. Dracula does not map those to
--- the color you would guess -- `Type` is cyan, `Function` is green, and
--- `ErrorMsg` is reversed, so its "foreground" is the editor background. Pass
--- these values explicitly instead of letting a plugin guess.
local palette = {
  bg         = "#282a36",
  bg_darker  = "#21222c",
  fg         = "#f8f8f2",
  selection  = "#44475a",
  comment    = "#6272a4",
  red        = "#ff5555",
  orange     = "#ffb86c",
  yellow     = "#f1fa8c",
  green      = "#50fa7b",
  cyan       = "#8be9fd",
  blue       = "#8be9fd",
  purple     = "#bd93f9",
  pink       = "#ff79c6",
}

--- Mix `color` over `bg` at `alpha` opacity.
---
--- @param color string hex color, e.g. "#50fa7b"
--- @param bg string hex color to blend against
--- @param alpha number 0..1
--- @return string
function palette.blend(color, bg, alpha)
  local function channel(from, to)
    local c = tonumber(color:sub(from, to), 16)
    local b = tonumber(bg:sub(from, to), 16)

    return string.format("%02x", math.floor(c * alpha + b * (1 - alpha)))
  end

  return "#" .. channel(2, 3) .. channel(4, 5) .. channel(6, 7)
end

return palette
