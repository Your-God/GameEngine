local SuperClass = require("Classes/Frame")
local TextBoxMetaTable = {}

PUT TEXT HERE

local function Render(self)
  --error("This method hasn't been implemented yet")
  local Pos = self.ActualPosition
  local Size = self.ActualSize
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",Pos.x, Pos.y, Size.x, Size.y)
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill",Pos.x+1, Pos.y+1, Size.x-2, Size.y-2)
  love.graphics.setColor(1,1,1)
end

local function SetStyle(self, StyleAsset)
  error("This method hasn't been implemented yet")
end



function FrameMetaTable.New(self, DefaultParent, DefaultName)
  local SuperObj = SuperClass:New(DefaultParent, DefaultName)
  -- SuperObj is the Class which this class Inherits; Like SuperClass but is an Object
  
  
  local WriteMethods = {
    Style = SetStyle,
  }
  local WriteProtected = {
    --Anything in here can be read but will throw an error if assigned
    __Inherits = SuperClass,
    ClassName = "Frame",
    Style = nil,
    Render = Render,
  }
  local WriteExposed = {
    -- Can be freely assigned with no problem
    UseParentStyle = true,
    CornerRounding = 0,
  }
  SuperObj:__Inject(WriteProtected, WriteExposed, WriteMethods) -- Injects the SuperObj with our updated Values
  --------------------------------------------------------------------------------
  -- Anything that should be done after the Object is setup should be done here
  
  
  return SuperObj
end



return FrameMetaTable