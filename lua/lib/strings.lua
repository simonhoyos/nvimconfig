local strings = {}

--- Remove white spaces from the beginning and end of a string
---
--- @param str string
--- @return string
function strings.string_strip_whitespace(str)
  local s = string.gsub(str, "^%s+", "")

  s = string.gsub(s, "%s+$", "")
  s = string.gsub(s, "[\n\r]+", " ")

  return s
end

return strings
