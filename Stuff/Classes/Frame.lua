local SuperClass = require("Classes/Sprite")
local Color3Type = require("DataTypes/Color3")
local FrameMetaTable = {}

local function Render(self)
  --error("This method hasn't been implemented yet")
  local Pos = self.ActualPosition
  local Size = self.ActualSize
  local Color = self.__InternalObj.Color

  if self.BorderSize ~= 0 then
    local BC = self.__InternalObj.BorderColor
    local BS = self.BorderSize
    love.graphics.setColor(BC.r, BC.g, BC.b)
    love.graphics.rectangle("fill",Pos.x - BS, Pos.y - BS, Size.x + BS + BS, Size.y + BS + BS)
  end
  love.graphics.setColor(Color.r, Color.g, Color.b)
  love.graphics.rectangle("fill",Pos.x, Pos.y, Size.x, Size.y)
  love.graphics.setColor(1,1,1)
end

local function SetStyle(self, StyleAsset)
  error("This method hasn't been implemented yet")
end

local function SetBorderColor3(self, NewColor3)
  assert(type(NewColor3) == "table" and NewColor3.__Type == "Color3", "Invalid DataType, requires type 'Color3'")
  self.__InternalObj.BorderColor = NewColor3
end



function FrameMetaTable.New(self, DefaultParent, DefaultName)
  local SuperObj = SuperClass:New(DefaultParent, DefaultName)
  -- SuperObj is the Class which this class Inherits; Like SuperClass but is an Object
  
  
  local WriteMethods = {
    Style = SetStyle,
    BorderColor = SetBorderColor3,
  }
  local WriteProtected = {
    --Anything in here can be read but will throw an error if assigned
    __Inherits = SuperClass,
    ClassName = "Frame",
    Style = nil,
    Render = Render,
    BorderColor = Color3Type:New(0,0,0),
  }
  local WriteExposed = {
    -- Can be freely assigned with no problem
    UseParentStyle = true,
    CornerRounding = 0,
    BorderSize = 1,
  }
  SuperObj:__Inject(WriteProtected, WriteExposed, WriteMethods) -- Injects the SuperObj with our updated Values
  --------------------------------------------------------------------------------
  -- Anything that should be done after the Object is setup should be done here
  
  
  return SuperObj
end



return FrameMetaTable