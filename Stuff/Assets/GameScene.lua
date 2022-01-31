local GameScene = {}

local GE = require("GameEngine")
local Mouse = require("bin/Mouse")
local Vector2 = GE:Get("Vector2")
local Scene = GE:New("Scene")
    GameScene.Scene = Scene
local NewBot = require("Assets/GameSceneAssets/BotManager")
local WallManager = require("Assets/GameSceneAssets/WallManager")
local Camera = _G.GetCamera()






for x = -25, 25 do
  for y = -25, 25 do
    if true then --math.random(0,3) == 1 then
      -- 10% chance to spawn a wall in a 10 x 10 grid
      --WallManager.NewWall(Scene, Vector2:New(x,y))
    end
  end
end




local Map = WallManager:GetMap()
local WallOffset = Vector2:New(0.5, 0.5) * WallManager.WallSize

local Player = NewBot(Vector2:New(0, 0) + WallOffset)
Player.Parent = Scene



function GameScene.Update(dt)
    local PointingVector = ((Scene.ActualPosition * -1) + Mouse:GetPosition() - Player.ActualPosition)
    local Angle = math.atan2(PointingVector.y, PointingVector.x)
    Player.Body:setAngle(Angle)

    PointingVector.x = 0
    PointingVector.y = 0
    if love.keyboard.isDown("w") then-- move forwards
      PointingVector.y = PointingVector.y - 1
    end
    if love.keyboard.isDown("s") then-- move backwards
      PointingVector.y = PointingVector.y + 1
    end

    if love.keyboard.isDown("a") then-- move left
      PointingVector.x = PointingVector.x - 1
    end
    if love.keyboard.isDown("d") then-- move right
      PointingVector.x = PointingVector.x + 1
    end



    PointingVector = PointingVector:GetUnit() * 200
    Player.Body:setLinearVelocity(PointingVector.x, PointingVector.y)
    local pPos = Vector2:New(Player.Body:getPosition())
    Scene:SetActualPosition(pPos * -1 + Scene.ActualSize / 2)
end






return GameScene