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

local function InitilizeAs(self, Type, Position, Size)
  assert(self.__InternalObj.ColliderType == nil, "Can only Initilize the collider once")
  assert(type(Position) == "table" and Position.__Type == "Vector2", "Invalid DataType, requires type 'Vector2'")
  assert(type(Size) == "table" and Size.__Type == "Vector2", "Invalid DataType, requires type 'Vector2'")
  


  self.__InternalObj.ActualPosition = Position 
  self.__InternalObj.ActualSize = Size
  if Type == "rectangle" then
    self.__InternalObj.ColliderType = Type
    self.__InternalObj.Body = self.__InternalObj.World:newRectangleCollider(Position.x, Position.y, Size.x, Size.y)
    self.__InternalObj.Body:setFixedRotation(true) -- We add this due to frame rotation not currently supported
  elseif false then

  else
    error("unknown ColliderType")
  end
end

local function GetPosition(self)
  return Vector2:New(self.__InternalObj.Body:getPosition())
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

local function UpdatePosition(self)
  local AP = self.__InternalObj.ActualPosition
  local AS = self.__InternalObj.ActualSize
  for _, Child in pairs(self:GetChildren()) do
    if (Child.UpdatePosition) then
      Child.__InternalObj.ActualPosition = AP + Vector2:New(
        AS.x * Child.Position.x.Scale + Child.Position.x.Offset, -- x
        AS.y * Child.Position.y.Scale + Child.Position.y.Offset  -- y
      ) 
      - AS/2 -- We step back by half the size as the ancore point is in the center
      Child:UpdatePosition()
    end
  end
end

local function Render(self)
  local Pos = self:GetPosition()
  local Size = self.__InternalObj.ActualSize 
  self.__InternalObj.ActualPosition = Pos
  
  self:UpdatePosition()
  -- It updates the frame's location every time it renders
  -- Just the work around I had to do :\

  if self.DebugCollider then
    local Offset = Size / 2
    love.graphics.setColor(1,0,0,0.3)
    love.graphics.rectangle("fill",Pos.x, Pos.y, Size.x - Offset.x, Size.y - Offset.y)
    love.graphics.setColor(1,1,1)
  end
end


function ColliderMetaTable.New(self, DefaultParent, DefaultName)
  local SuperObj = SuperClass:New(DefaultParent, DefaultName)
  -- SuperObj is the Class which this class Inherits; Like SuperClass but is an Object
  
  
  local WriteMethods = {
    Rotation = SetRotation,
    --Size = SetSize, --Curren't can't set size due to Box2D limitation
    Position = SetPosition,
    World = SetWorld,
  }
  local WriteProtected = {
    --Anything in here can be read but will throw an error if assigned
    ClassName = "Collider",
    
    ActualPosition = Vector2:New(0,0),
    ActualSize = Vector2:New(0,0),
    UpdatePosition = UpdatePosition,
    UpdateSize = UpdateSize,
    Render = Render,
    InitilizeAs = InitilizeAs,
    GetPosition = GetPosition, -- UDim2
    Rotation = 0,   -- Num 0 - 2PI rads
    __MarkRenderLayer = function() end, -- Does nothing, just there for others to call it without error
    Body = nil,
    
    --
    World = WorldType:GetDefaultWorld()
  }
  local WriteExposed = {
    -- Can be freely assigned with no problem
    DebugCollider = false,
  }
  SuperObj:__Inject(WriteProtected, WriteExposed, WriteMethods) -- Injects the SuperObj with our updated Values
  --------------------------------------------------------------------------------
  -- Anything that should be done after the Object is setup should be done here
  
  return SuperObj
end



return ColliderMetaTable