local ua = 
[[lark.exceptions.UnexpectedCharacters: No terminal matches ')' in the current parser context, at line 6 col 1

)
^
Expected one of: 
	* LPAR

Previous tokens: Token('RPAR', ')')"]]
-- local regex = [[line (%d+) col (%d+)\n\n(.+)]]
local regex ="line (%d+) col (%d+)(.*)"

print(string.match(ua, regex))
print(ua:gsub("\n","c"))
