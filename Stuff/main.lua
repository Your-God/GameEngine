io.stdout:setvbuf("no")
local Vector2 = require("DataTypes/Vector2")
local UDim2 = require("DataTypes/UDim2")
local CoreClass = require("Classes/CoreClass")
local TransformationClass = require("Classes/Transformation")
local SpriteClass = require("Classes/Sprite")
local FrameClass = require("Classes/Frame")

local MySprite = SpriteClass:New()
local Gauge = love.graphics.newImage("Images/Gauge.png")
MySprite.SpriteAsset = Gauge

local NewPos = UDim2:New(0,200,0,50)
MySprite.Position = NewPos

MySprite:GetActualPosition()

print("Yay!")

function love.draw()
  MySprite:Render()
end

function love.conf(t)
	t.console = true
end
