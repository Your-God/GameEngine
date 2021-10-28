local SuperClass = require("Classes/CoreClass")
local TransformationMetaTable = {}
local UDim2Type = require("DataTypes/UDim2")
local Vector2 = require("DataTypes/Vector2")



local function SetRotation(self, Rotation)
  error("This method hasn't been implemented yet")
end

local function SetSize(self, SizeUDim2)
  error("This method hasn't been implemented yet")
end

local function SetPosition(self, PositionUDim2)
  assert(type(PositionUDim2) == "table" and PositionUDim2.__Type == "UDim2", "Invalid DataType, requires type 'UDim2'")
  self.__InternalObj.Position = PositionUDim2
end

local function TransformationPush(self)
  love.graphics.push()
  local _UDim = self.InternalObj.Position
  love.graphics.translate(UDim.x.Offset, UDim.y.Offset)
end

local function TransformationPop(self)
  love.graphics.pop()
end

local function SetPositionMethod(self, a,b,c,d)
  if (type(a)== "table" and a.__Type == "UDim2") then
    self.__InternalObj.Position = a
  elseif (type(a) == "number" and type(b) == "number" and type(c) == "number" and type(d) == "number") then
    -- check if a,b,c,d are numbers
    self.__InternalObj.Position = UDim2Type:New(a,b,c,d)
  else
    error("Invalid DataType, requires type 'UDim2'")
  end
end

local function GetActualPosition(self)
  --error("This method hasn't been implemented yet")
  return Vector2:New(0,0)
end

local function GetActualSize(self)
  error("This method hasn't been implemented yet")
  return Vector2:New(0,0)
end

local function GetDistanceTo(self, Vector2)
  error("This method hasn't been implemented yet")
end

local function GetDistanceToObj(self, Object)
  error("This method hasn't been implemented yet")
end



function TransformationMetaTable.New(self, DefaultParent, DefaultName)
  local SuperObj = SuperClass:New(DefaultParent, DefaultName)
  -- SuperObj is the Class which this class Inherits; Like SuperClass but is an Object
  
  
  local WriteMethods = {
    Rotation = SetRotation,
    Size = SetSize,
    Position = SetPosition,
  }
  local WriteProtected = {
    --Anything in here can be read but will throw an error if assigned
    ClassName = "Transformation",
    SetPosition  = SetPositionMethod,
    Position = UDim2Type:New(), -- UDim2
    Size = UDim2Type:New(),     -- UDim2
    Rotation = 0,   -- Num 0 - 2PI rads
    GetActualPosition = GetActualPosition,
    GetActualSize = GetActualSize,
    GetDistanceTo = GetDistanceTo,
    GetDistanceToObj = GetDistanceToObj,
  }
  local WriteExposed = {
    -- Can be freely assigned with no problem
  }
  SuperObj:__Inject(WriteProtected, WriteExposed, WriteMethods) -- Injects the SuperObj with our updated Values
  --------------------------------------------------------------------------------
  -- Anything that should be done after the Object is setup should be done here
  
  
  return SuperObj
end



return TransformationMetaTable