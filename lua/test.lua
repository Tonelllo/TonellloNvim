local ua = 
[[
Errors: 1, warnings: 1
/home/tonello/Desktop/test/problem.pddl: line: 9: Warning: Undeclared requirement :typing 
/home/tonello/Desktop/test/problem.pddl: line: 10: Error: Syntax error in problem definition.
]]
-- local regex = [[line (%d+) col (%d+)\n\n(.+)]]
local regex ="line: (%d*): (%w*): (.*)"

print(string.match(ua, regex))
-- print(ua:gsub("\n","c"))
