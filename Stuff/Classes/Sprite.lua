local SuperClass = require("Classes/Transformation")
local SpriteMetaTable = {}

local BlankImage = love.image.newImageData(1,1) -- creates a tiny empty image
local BlankColor = {r=1,g=1,b=1}

local function SetColor(r, g, b)
  error("This method hasn't been implemented yet")
end


local function OnMouseEnter(self)
  error("This method hasn't been implemented yet")
  -- return an event callback?
end
local function OnMouseHover(self)
  error("This method hasn't been implemented yet")
end
local function OnMouseLeave(self)
  error("This method hasn't been implemented yet")
end
local function OnMouseDown(self)
  error("This method hasn't been implemented yet")
end
local function OnMouseUp(self)
  error("This method hasn't been implemented yet")
end
local function GetActualSize(self)
  error("This method hasn't been implemented yet")
end
local function Render(self)
  love.graphics.draw(self.__InternalObj.SpriteAsset)
end
local function SetSprite(self, NewSprite)
  if NewSprite == nil then
    -- lets the user decide to throw out the image for a blank one
    self.__InternalObj.SpriteAsset = BlankImage
  else
    assert(type(NewSprite) == "userdata" and NewSprite:type() == "Image", "Invalid DataType, requires type 'Image'")
  
    self.__InternalObj.SpriteAsset = NewSprite
  end
end

function SpriteMetaTable.New(self, DefaultParent, DefaultName)
  local SuperObj = SuperClass:New(DefaultParent, DefaultName)
  -- SuperObj is the Class which this class Inherits; Like SuperClass but is an Object
  
  
  local WriteMethods = {
    Color = SetColor,
    SpriteAsset = SetSprite,
  }
  local WriteProtected = {
    --Anything in here can be read but will throw an error if assigned
    ClassName = "Sprite",
    Color = BlankColor,
    OnMouseEnter = OnMouseEnter,
    OnMouseHover = OnMouseHover,
    OnMouseLeave = OnMouseHover,
    OnMouseDown  = OnMouseDown,
    OnMouseUp    = OnMouseUp,
    GetActualSize= GetActualSize,
    Render       = Render, -- Used Internally, please don't use.
    SpriteAsset  = BlankImage -- Values can not be set to nil or it will cause problems
  }
  local WriteExposed = {
    -- Can be freely assigned with no problem
    Transparency = 0,
    Visible = true,
  }
  SuperObj:__Inject(WriteProtected, WriteExposed, WriteMethods) -- Injects the SuperObj with our updated Values
  --------------------------------------------------------------------------------
  -- Anything that should be done after the Object is setup should be done here
  
  
  return SuperObj
end



return SpriteMetaTable