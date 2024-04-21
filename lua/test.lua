local ua = 
[[
/cane/gatto/topo/domain.pddl
]]
-- local regex = [[line (%d+) col (%d+)\n\n(.+)]]
local regex ="%/(%w*)%.pddl"

print(string.match(ua, regex))
print(ua:gsub("\n","c"))
