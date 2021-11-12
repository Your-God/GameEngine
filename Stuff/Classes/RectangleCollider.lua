local SuperClass = require("Classes/CoreClass")
local ColliderMetaTable = {}
local UDim2Type = require("DataTypes/UDim2")
local Vector2 = require("DataTypes/Vector2")
local WorldType = require("DataTypes/World")

local function SetWorld(self, NewValue)
  assert(type(NewValue) == "table" and NewValue.__Type == "World", "Invalid DataType, requires type 'World' got:" .. tostring(NewValue))
  self.__InternalObj.World = NewValue
  error("Currently doesn't support multiple Worlds")
end


--How to connect windfield to my Object system?




function ColliderMetaTable.New(self, Type, DefaultParent, DefaultName)
  local SuperObj = SuperClass:New(DefaultParent, DefaultName)
  -- SuperObj is the Class which this class Inherits; Like SuperClass but is an Object
  
  
  local WriteMethods = {
    Rotation = SetRotation,
    Size = SetSize,
    Position = SetPosition,
    World = SetWorld,
  }
  local WriteProtected = {
    --Anything in here can be read but will throw an error if assigned
    ClassName = "Collider",
    
    Position = Vector2:New(), -- UDim2
    Size = Vector2:New(),     -- UDim2
    Rotation = 0,   -- Num 0 - 2PI rads
    --
    World = WorldType:GetDefaultWorld()
  }
  local WriteExposed = {
    -- Can be freely assigned with no problem
  }
  SuperObj:__Inject(WriteProtected, WriteExposed, WriteMethods) -- Injects the SuperObj with our updated Values
  --------------------------------------------------------------------------------
  -- Anything that should be done after the Object is setup should be done here
  
  
  return SuperObj
end



return ColliderMetaTable