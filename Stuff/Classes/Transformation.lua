local SuperClass = require("Classes/CoreClass")
local TransformationMetaTable = {}
local UDim2Type = require("DataTypes/UDim2")
local Vector2 = require("DataTypes/Vector2")



local function SetRotation(self, Rotation)
  assert(type(Rotation) == "number", "Invalid DataType, requires type 'number'")
  self.__InternalObj.Rotation = Rotation
end

local function SetSize(self, SizeUDim2)

  assert(type(SizeUDim2) == "table" and SizeUDim2.__Type == "UDim2", "Invalid DataType, requires type 'UDim2'")
  self.__InternalObj.Size = SizeUDim2
  if self.Parent and self.Parent.UpdateSize then
    self.Parent:UpdateSize()
    self.Parent:UpdatePosition() -- We have to update Position because it's dependent on size
  end
end

local function SetPosition(self, PositionUDim2)
  assert(type(PositionUDim2) == "table" and PositionUDim2.__Type == "UDim2", "Invalid DataType, requires type 'UDim2'")
  self.__InternalObj.Position = PositionUDim2
  if (self.Parent) then
    self.Parent:UpdatePosition()
  else
    print("Err; no parent; default ActualPosition")
    self.__InternalObj.ActualPosition = Vector2:New() -- IDK
  end
end

local function UpdatePosition(self)
  local AP = self.__InternalObj.ActualPosition
  local AS = self.__InternalObj.ActualSize
  for _, Child in pairs(self:GetChildren()) do
    if (Child.UpdatePosition) then
      Child.__InternalObj.ActualPosition = AP + Vector2:New(
        AS.x * Child.Position.x.Scale + Child.Position.x.Offset, -- x
        AS.y * Child.Position.y.Scale + Child.Position.y.Offset  -- y
      )
      Child:UpdatePosition()
    end
  end
end

local function UpdateSize(self)
  local AS = self.__InternalObj.ActualSize
  for _, Child in pairs(self:GetChildren()) do
    if (Child.UpdateSize) then
      Child.__InternalObj.ActualSize = Vector2:New(
        AS.x * Child.Size.x.Scale + Child.Size.x.Offset, -- x
        AS.y * Child.Size.y.Scale + Child.Size.y.Offset  -- y
      )
      Child:UpdateSize()
    end
  end
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
  
  if (self.Parent) then
    self:UpdatePosition()
    -- Refreshes the position of all children so to be accurate
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
    Size = UDim2Type:New(0,2,0,3),     -- UDim2
    Rotation = 0,   -- Num 0 - 2PI rads
    ActualPosition = Vector2:New(), --Vector2
    ActualSize = Vector2:New(),     --Vector2
    UpdatePosition = UpdatePosition,
    UpdateSize = UpdateSize,
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