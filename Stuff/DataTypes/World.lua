local wf = require("windfield")
local World_metatable = {}
World_metatable.__Type = "World"
World_metatable.__index = World_metatable --What if I disable this?
local Default_World = nil


function World_metatable.__newindex(t, key, value)
  error("err; attempted to set ' " .. key .. " ' of World to: " .. value)
  -- prevents user from adding new values to the DataType
end



function GenerateDefaultWorld()
  Default_World = World_metatable:New()
end

function World_metatable.GetDefaultWorld(self)
  return Default_World
end



function World_metatable.New(self)
  local obj = wf.newWorld(0, 0, false )
  -- default gravity of 0,0
  -- default does not sleep
  obj.GetDefaultWorld = function() return Default_World end
  
  return obj
end






GenerateDefaultWorld()
return World_metatable