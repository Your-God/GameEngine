local SuperClass = require("Classes/CoreClass")
local TransformationMetaTable = {}
local UDim2Type = require("DataTypes/UDim2")
local Vector2 = require("DataTypes/Vector2")
local WorldType = require("DataTypes/World")

------------------------------[[NOTES]]------------------------------
--
--
--
--
--
--
------------------------------[[NOTES]]------------------------------



local function SetRotation(self, Rotation)
  assert(type(Rotation) == "number", "Invalid DataType, requires type 'number'")
  self.__InternalObj.Rotation = Rotation
end

local function SetSize(self, SizeUDim2)

  assert(type(SizeUDim2) == "table" and SizeUDim2.__Type == "UDim2", "Invalid DataType, requires type 'UDim2'")
  self.__InternalObj.Size = SizeUDim2
end

local function SetPosition(self, PositionUDim2)
  assert(type(PositionUDim2) == "table" and PositionUDim2.__Type == "UDim2", "Invalid DataType, requires type 'UDim2'")
  self.__InternalObj.Position = PositionUDim2
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
  return self.__InternalObj.ActualPosition
end

local function GetActualSize(self) 
  return self.__InternalObj.ActualSize
end

local function GetDistanceTo(self, Vector2)
  error("This method hasn't been implemented yet")
end

local function GetDistanceToObj(self, Object)
  error("This method hasn't been implemented yet")
end



local __Offset = Vector2:New()
local function Push(self, Parent)
  local SPos = self.Position
  local SSize = self.Size
  love.graphics.push()
  __Offset.x = SPos.x.Offset + SPos.x.Scale * Parent.ActualSize.x
  __Offset.y = SPos.y.Offset + SPos.y.Scale * Parent.ActualSize.y
  
  self.__InternalObj.ActualSize.x = SSize.x.Offset + SSize.x.Scale * Parent.ActualSize.x
  self.__InternalObj.ActualSize.y = SSize.y.Offset + SSize.y.Scale * Parent.ActualSize.y

  
  self.__InternalObj.ActualPosition = self.Parent.ActualPosition + __Offset


  -- Rotates around the center point

  if self.Rotation ~= 0 then
    __Offset = __Offset + self.__InternalObj.ActualSize / 2 --Offset by half the size so that it rotates around the center
    love.graphics.translate(
      __Offset.x,
      __Offset.y
    )
    love.graphics.rotate(self.Rotation) 
    __Offset = self.__InternalObj.ActualSize / -2 -- go back by half the size
  end
  love.graphics.translate(
    __Offset.x,
    __Offset.y
  )
end

local function Pop(self)
  love.graphics.pop()
end





local function GetRelativeMousePos(self)
  local mPos = Vector2:New(love.mouse.getPosition())
  print(ActualPosition)
  return mPos 
end



function TransformationMetaTable.New(self, DefaultParent, DefaultName)
  local SuperObj = SuperClass:New(DefaultParent, DefaultName)
  -- SuperObj is the Class which this class Inherits; Like SuperClass but is an Object
  
  
  local WriteMethods = {
    Rotation = SetRotation,
    Size = SetSize,
    Position = SetPosition,
    Rotation = SetRotation,
  }
  local WriteProtected = {
    --Anything in here can be read but will throw an error if assigned
    Offset = Offset,
    ClassName = "Transformation",
    SetPosition  = SetPositionMethod,
    Position = UDim2Type:New(), -- UDim2
    Size = UDim2Type:New(0,100,0,50),     -- UDim2
    Rotation = 0,   -- Num 0 - 2PI rads
    ActualPosition = Vector2:New(), --Vector2
    Offset = Vector2:New(), --Vector2
    ActualSize = Vector2:New(100, 50),     --Vector2
    ActualRotation = 0,
    Push = Push,
    Pop = Pop,
    GetDistanceTo = GetDistanceTo,
    GetDistanceToObj = GetDistanceToObj,
    World = WorldType:GetDefaultWorld(),
    GetRelativeMousePos = GetRelativeMousePos,
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