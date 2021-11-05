io.stdout:setvbuf("no")
local Vector2 = require("DataTypes/Vector2")
local UDim2 = require("DataTypes/UDim2")
local CoreClass = require("Classes/CoreClass")
local TransformationClass = require("Classes/Transformation")
local SceneClass = require("Classes/Scene")
local SpriteClass = require("Classes/Sprite")
local FrameClass = require("Classes/Frame")
local Mouse = require("Mouse")

local Scene = SceneClass:New()
print(Scene.ActualSize)
print(Scene.ActualPosition)

local MiddleNode = FrameClass:New(Scene)
MiddleNode.Name = "MiddleNode"
MiddleNode.Position = UDim2:New(0.5,0,0.5,0)
MiddleNode.Size = UDim2:New(0,10,0,50)


local MyFrame = FrameClass:New(MiddleNode)
MyFrame.Name = "MyFrame"
MyFrame.Size = UDim2:New(0,50,1,0)
MyFrame.Position = UDim2:New(0,-25,0,0)

--MyFrame.OnMouseDown:Connect(function(mx, my) print("Mouse Clicked!", mx, my) end)




function love.draw()
  Scene:RenderScene()
end

function love.conf(t)
	t.console = true
end
