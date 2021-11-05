local Event_metatable = {}
Event_metatable.__Type = "Event"
Event_metatable.__index = Event_metatable --What if I disable this?


function Event_metatable.__newindex(t, key, value)
  error("err; attempted to set ' " .. key .. " ' of Event to: " .. value)
  -- prevents user from adding new values to the DataType
end

local function FireFunc(self, ...)
    for _, func in pairs(self.callbacks) do
        func(...)
    end
end

local function ConnectFunc(self, newfunc)
    table.insert(self.callbacks, newfunc)
end


function Event_metatable.New(self, arg1, arg2)
  assert(self == self, "Error, must use : instead of .")
  local obj = {
      Fire = FireFunc,
      Connect = ConnectFunc,
      callbacks = {},
  }
  return setmetatable( obj, Vector2_metatable )
end




return Event_metatable