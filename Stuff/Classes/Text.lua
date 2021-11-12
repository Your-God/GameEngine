local SuperClass = require("Classes/Sprite")
local TextBoxMetaTable = {}



local function Render(self)
  --error("This method hasn't been implemented yet")
  local Pos = self.ActualPosition
  local Size = self.ActualSize
  local Color = self.__InternalObj.Color

  
  love.graphics.setColor(Color.r, Color.g, Color.b)
  if self.__InternalObj.yAlignment == "top" then
    love.graphics.printf( self.Text, Pos.x, Pos.y, Size.x, self.__InternalObj.xAlignment)
  else
    local Font = love.graphics.getFont()
    local TextWidth = Font:getWidth(self.Text)
    local TextHeight = math.ceil(TextWidth / Size.x) * Font:getHeight()
    local yOffset = 0
    if self.__InternalObj.yAlignment == "center" then
      yOffset = (Size.y / 2) - (TextHeight / 2)
    else -- "bottom"
      yOffset = Size.y - TextHeight
    end
    love.graphics.printf( self.Text, Pos.x, Pos.y + yOffset, Size.x, self.__InternalObj.xAlignment)
  end


  love.graphics.setColor(1,1,1)
end


local function SetxAlignment(self, Alignment)
  Alignment = string.lower(tostring(Alignment))
  if Alignment == nil then return end
  if Alignment == "left" or Alignment == "right" or Alignment == "center" then
    self.__InternalObj.xAlignment = Alignment
  else
    error("Invalid Alignment type: " .. Alignment)
  end  
end
local function SetyAlignment(self, Alignment)
  Alignment = string.lower(tostring(Alignment))
  if Alignment == nil then return end
  if Alignment == "top" or Alignment == "bottom" or Alignment == "center" then
    self.__InternalObj.yAlignment = Alignment
  else
    error("Invalid Alignment type: " .. Alignment)
  end 
end



function TextBoxMetaTable.New(self, DefaultParent, DefaultName)
  local SuperObj = SuperClass:New(DefaultParent, DefaultName)
  -- SuperObj is the Class which this class Inherits; Like SuperClass but is an Object
  
  
  local WriteMethods = {
    xAlignment = SetxAlignment,
    yAlignment = SetyAlignment,
  }
  local WriteProtected = {
    --Anything in here can be read but will throw an error if assigned
    __Inherits = SuperClass,
    ClassName = "Text",
    Render = Render,
    xAlignment = "left",
    yAlignment = "top",
  }
  local WriteExposed = {
    -- Can be freely assigned with no problem
    Text = "",
  }
  SuperObj:__Inject(WriteProtected, WriteExposed, WriteMethods) -- Injects the SuperObj with our updated Values
  --------------------------------------------------------------------------------
  -- Anything that should be done after the Object is setup should be done here
  
  
  return SuperObj
end



return TextBoxMetaTable