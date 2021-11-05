local SuperClass = require("Classes/Transformation")
local EventClass = require("DataTypes/EventManager")
local SpriteMetaTable = {}
local InteractionLedger = {}
  setmetatable(InteractionLedger, {__mode = "k"}) -- Creates a weak table

function SpriteMetaTable.__GetInteractionLedger()
  return InteractionLedger
end

local BlankImage = love.image.newImageData(1,1) -- creates a tiny empty image
BlankImage = love.graphics.newImage(BlankImage)

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

local function Render(self)
  local Pos = self.ActualPosition
  love.graphics.draw(self.__InternalObj.SpriteAsset, Pos.x, Pos.y)
  -- Currently Doesn't Scale sprites
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

local function __MarkRenderLayer(self, ID)
  -- When obj gets rendered it will call this function tagging it with the passed ID
  -- This is so we know what gets rendered over what
  -- Perfect for mouse detection
  InteractionLedger[self] = ID
end

local function __GetRenderLayer(self)
  return InteractionLedger[self]
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
    OnMouseDown  = EventClass:New(),
    OnMouseUp    = OnMouseUp,
    Render       = Render, -- Used Internally, please don't use.
    SpriteAsset  = BlankImage, -- Values can not be set to nil or it will cause problems
    __RenderLayer=-1,  -- The layer that the object gets rendered at
    __MarkRenderLayer = __MarkRenderLayer,
    __GetRenderLayer  = __GetRenderLayer,
  }
  local WriteExposed = {
    -- Can be freely assigned with no problem
    Transparency = 0,
    Visible = true,
  }
  SuperObj:__Inject(WriteProtected, WriteExposed, WriteMethods) -- Injects the SuperObj with our updated Values
  --------------------------------------------------------------------------------
  -- Anything that should be done after the Object is setup should be done here
  InteractionLedger[SuperObj] = WriteProtected.__RenderLayer -- The Render Layer; -1 means it hasn't been defined yet
  
  return SuperObj
end



return SpriteMetaTable