local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node


return {
  s("const Foo () => {...}", {
    t("const "),
    i(1, "foo"),
    t(" = ("),
    i(2, "args"),
    t(")"),
    t({ " => {", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
}
