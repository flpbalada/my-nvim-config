local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  s("interface Foo {...}", {
    t("interface "),
    i(1, "Name"),
    t({ " {", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
}
