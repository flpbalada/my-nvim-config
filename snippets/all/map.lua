local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s({ trig = ".map((item, index) => {...}", trigEngine = "plain" }, {
    t(".map((item, index) => {"),
    t({ "", "\t" }),
    i(0),
    t({ "", "})" }),
  }),
}
