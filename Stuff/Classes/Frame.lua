local SuperClass = require("Classes/Sprite")
local FrameMetaTable = {}

local function Render(self)
  error("This method hasn't been implemented yet")
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