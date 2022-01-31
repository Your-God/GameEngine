local SuperClass = require("Classes/Transformation")
local Mouse = require("bin/Mouse")
local SceneMetaTable = {}
local Vector2 = require("DataTypes/Vector2")
local CurrentRenderLayer = 0 -- Which layer is currently being rendered; increments per obj
-- ViewPorts control the rendering of objects below it
-- They control Rendering and game logic
-- Objects outside of an active scene don't render
-- Scripts outside of an active scene don't update?






local function WithinBounds(Obj, mX, mY)
  local AP  =  Obj.ActualPosition
  local AS  =  Obj.ActualSize

  return 
      ( AP.x <= mX ) and
      ( AP.y <= mY ) and
      ( AP.x + AS.x >= mX ) and
      ( AP.y + AS.y >= mY )
end

local ObjectClicked = {Obj = nil, x = 0, y = 0, Button = -1}
local function CheckForClicks(Obj, SceneOffset)
  if Mouse.Down and not Mouse.HeldDown then
    -- Only check if mouse is down; ignore if it's been held down
    local x = love.mouse.getX() - SceneOffset.x
    local y = love.mouse.getY() - SceneOffset.y
    if Obj.ListenToMouse and WithinBounds(Obj, x, y) then
      ObjectClicked.Obj = Obj
      ObjectClicked.x = x
      ObjectClicked.y = y
      ObjectClicked.Button = Mouse.Button
    end
  end
end

local function RenderChildren(Parent, SceneOffset)
  for _,Child in pairs(Parent.__InternalObj.Children) do
    if (Child.Render) then
      CurrentRenderLayer = CurrentRenderLayer + 1
      Child:__MarkRenderLayer(CurrentRenderLayer)
      Child:Push(Parent) -- Push(Child, Parent)
      Child:Render()
      CheckForClicks(Child, SceneOffset)
      RenderChildren(Child, SceneOffset) -- RenderChild(Parent)
      Child:Pop()
    end
  end
end

local function Render(self)
  love.graphics.push()
  love.graphics.translate(self.__InternalObj.ActualPosition.x, self.__InternalObj.ActualPosition.y)
  love.graphics.points(0,0)
  love.graphics.rotate(self.Rotation)
  CurrentRenderLayer = 0
  RenderChildren(self, self.ActualPosition)
  
  --World:draw()
  love.graphics.pop()
end



local function ManageClicks()
  --[[
    MD  &  HD -- Nothing
    nMD &  HD -- Call MouseUp   Func
    MD  & nHD -- Call MouseDown Func
    nMD & nHD -- Nothing
  ]]
  if Mouse.Down and not Mouse.HeldDown then
    if ObjectClicked.Obj ~= nil then
      ObjectClicked.Obj.OnMouseDown:Fire( Mouse.x, Mouse.y , Mouse.Button)
    end
    Mouse.HeldDown = true
  elseif not Mouse.Down and Mouse.HeldDown then
    -- Mouse Up
    if ObjectClicked.Obj ~= nil then
      ObjectClicked.Obj.OnMouseUp:Fire()
    end
    ObjectClicked.Obj = nil
    Mouse.HeldDown = false
  end
end

local function SetActualPosition(self, Position)
  self.__InternalObj.ActualPosition = Position
end

local function GetActualPosition()
  -- returns top left
  return self.__InternalObj.ActualPosition
end

local function GetActualSize()
  -- returns screen size
  return Vector2:New(love.graphics.getDimensions())
end

function SceneMetaTable.New(self, DefaultParent, DefaultName)
  local SuperObj = SuperClass:New(DefaultParent, DefaultName)
  -- SuperObj is the Class which this class Inherits; Like SuperClass but is an Object
  
  
  local WriteMethods = {
    Color = SetColor,
  }
  local WriteProtected = {
    --Anything in here can be read but will throw an error if assigned
    __Camera = nil;
    ClassName = "Scene",
    RenderScene       = Render, -- Used Internally, please don't use.
    GetActualPosition = GetActualPosition,
    GetActualSize = GetActualSize,
    SetActualPosition = SetActualPosition,
    ActualSize = Vector2:New(love.graphics.getDimensions()),     --Vector2
    ManageClicks = ManageClicks,
  }
  local WriteExposed = {
    -- Can be freely assigned with no problem
    Enabled = true,
  }
  SuperObj:__Inject(WriteProtected, WriteExposed, WriteMethods) -- Injects the SuperObj with our updated Values
  --------------------------------------------------------------------------------
  -- Anything that should be done after the Object is setup should be done here
  
  
  return SuperObj
end



return SceneMetaTable