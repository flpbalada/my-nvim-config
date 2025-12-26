local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  s("throw new Error(...)", {
    t("throw new Error("),
    i(0),
    t(")"),
  }),

  s("throw new AggregateError(...)", {
    t("throw new AggregateError([], "),
    i(0),
    t(")"),
  }),
}
