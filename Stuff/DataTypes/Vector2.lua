local Vector2_metatable = {}
Vector2_metatable.__Type = "Vector2"
Vector2_metatable.__index = Vector2_metatable --What if I disable this?


function Vector2_metatable.__newindex(t, key, value)
  error("err; attempted to set ' " .. key .. " ' of Vector2 to: " .. value)
  -- prevents user from adding new values to the DataType
end

function Vector2_metatable.__tostring(self)
  return "Vector2 (" .. self.x .. ", " .. self.y .. ")"
end

function Vector2_metatable.New(self, arg1, arg2)
  assert(self == self, "Error, must use : instead of .")
  local obj = { x = arg1 or 0, y = arg2 or 0 }
  return setmetatable( obj, Vector2_metatable )
end

function Vector2_metatable.GetMagnitude(self)
  return math.sqrt(self.x * self.x + self.y * self.y)
end



--------- vvvv      math      vvvv ---------

function Vector2_metatable.__add(x, y)
  if not (getmetatable(x) == Vector2_metatable and getmetatable(y) == Vector2_metatable) then
    error("failed to add: '" .. tostring(x) .. "' and '" .. tostring(y) .. "' ... incompatible types")
  end
  return Vector2_metatable:new(x.x + y.x, x.y + y.y)
end

function Vector2_metatable.__sub(x, y)
  if not (getmetatable(x) == Vector2_metatable and getmetatable(y) == Vector2_metatable) then
    error("failed to subtract: '" .. tostring(x) .. "' and '" .. tostring(y) .. "' ... incompatible types")
  end
  return Vector2_metatable:new(x.x - y.x, x.y - y.y)
end

function Vector2_metatable.__mul(x, y)
  if (getmetatable(x) == Vector2_metatable and getmetatable(y) == Vector2_metatable) then
    error("currently does not support CrossProduct")
  elseif (getmetatable(x) == Vector2_metatable and type(y) == "number") then
    return Vector2_metatable:new(x.x * y, x.y * y)
  else
    error("failed to multiply: '" .. tostring(x) .. "' and '" .. tostring(y) .. "' ... incompatible types")
  end
end

function Vector2_metatable.__div(x, y)
  if (getmetatable(x) == Vector2_metatable and type(y) == "number") then
    return Vector2_metatable:new(x.x / y, x.y / y)
  else
    error("failed to divide: '" .. tostring(x) .. "' and '" .. tostring(y) .. "' ... incompatible types")
  end
end
  
--------- ^^^^      math      ^^^^ ---------




local original_type = type  -- saves `type` function
-- monkey patch type function
type = function( obj )
    local otype = original_type( obj )
    if  otype == "table" and getmetatable( obj ) == Vector2_metatable then
        return "Vector2"
    end
    return otype
end

return Vector2_metatable