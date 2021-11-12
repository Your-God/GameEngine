local Color3_metatable = {}
Color3_metatable.__Type = "Color3"
Color3_metatable.__index = Color3_metatable --What if I disable this?


function Color3_metatable.__newindex(t, key, value)
  error("err; attempted to set ' " .. key .. " ' of Vector2 to: " .. value)
  -- prevents user from adding new values to the DataType
end

function Color3_metatable.__tostring(self)
  return "Color3 (" .. self.r .. ", " .. self.g .. ", " .. self.b .. ")"
end


function Color3_metatable.New(self, r, g, b)
  -- colors from 0-1
  r = r or 1
  g = g or r
  b = b or g
  local obj = { 
    r = r,
    g = g,
    b = b,
    -- I did it like this so :New(0.5) will set all values to 0.5
    -- Or :New(1,0.3) will set r = 1, g&b = 0.3
  }
  return setmetatable( obj, Color3_metatable )
end

function Color3_metatable.FromRGB(self, r, g, b)
  -- colors from 0-255
  r = r or 255
  g = g or r
  b = b or g
  local obj = { 
    r = r / 255,
    g = g / 255,
    b = b / 255,
    -- I did it like this so :New(0.5) will set all values to 0.5
    -- Or :New(1,0.3) will set r = 1, g&b = 0.3
  }
  return setmetatable( obj, Color3_metatable )
end







return Color3_metatable