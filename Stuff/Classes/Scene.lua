local SuperClass = require("Classes/Transformation")
local SceneMetaTable = {}
local Vector2 = require("DataTypes/Vector2")
local CurrentRenderLayer = 0 -- Which layer is currently being rendered; increments per obj
-- ViewPorts control the rendering of objects below it
-- They control Rendering and game logic
-- Objects outside of an active scene don't render
-- Scripts outside of an active scene don't update?




local function RenderChildren(self)
  for _,Child in pairs(self.__InternalObj.Children) do
    if (Child.Render) then
      CurrentRenderLayer = CurrentRenderLayer + 1
      Child:__MarkRenderLayer(CurrentRenderLayer)
      Child:Render()
      RenderChildren(Child)
    end
  end
end

local function Render(self)
  CurrentRenderLayer = 0
  RenderChildren(self)
end


local function GetActualPosition()
  -- returns top left
  return Vector2:New(0,0)
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
    ClassName = "Scene",
    RenderScene       = Render, -- Used Internally, please don't use.
    GetActualPosition = GetActualPosition,
    GetActualSize = GetActualSize,
    ActualPosition = Vector2:New(), --Vector2
    ActualSize = Vector2:New(love.graphics.getDimensions()),     --Vector2
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