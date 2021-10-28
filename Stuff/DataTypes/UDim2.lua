local UDim2_metatable = {}
UDim2_metatable.__Type = "UDim2"
UDim2_metatable.__index = UDim2_metatable --What if I disable this?


function UDim2_metatable.__newindex(t, key, value)
  error("err; attempted to set ' " .. key .. " ' of Vector2 to: " .. value)
  -- prevents user from adding new values to the DataType
end

function UDim2_metatable.__tostring(self)
  return "UDim2 {x = (" .. self.x.Scale .. ", " .. self.x.Offset .. "),"
  ..  "y = (" .. self.y.Scale .. ", " .. self.y.Offset .. ")}"
end




function UDim2_metatable.New(self, Sx, Ox, Sy, Oy)
  local obj = { 
    x = {Scale = Sx or 0, Offset = Ox or 0},
    y = {Scale = Sy or 0, Offset = Oy or 0} 
  }
  return setmetatable( obj, UDim2_metatable )
end







return UDim2_metatable