io.stdout:setvbuf("no")
math.randomseed(love.timer.getTime())
local GE = require("GameEngine")
local Vector2 = GE:Get("Vector2")
local World = GE:Get("World"):GetDefaultWorld()
local Camera = GE:Get("Camera")
local Mouse = GE:Get("Mouse")

function _G.GetCamera()
  return Camera
end






local CurrentScene = nil
local SceneList = {
  ['TitleScreen'] = require("Assets/TitleScreen"),
  ['Game'] = require("Assets/GameScene"),
}

function SetSceneTo(SceneName)
  CurrentScene = SceneList[SceneName]
  CurrentScene.SetSceneTo = SetSceneTo
  return CurrentScene
end


function love.load()
  SetSceneTo("TitleScreen")
end


function love.draw()
  if CurrentScene then
    CurrentScene.Scene:RenderScene()
    CurrentScene.Scene.ManageClicks()
  end
end


local GunDebounce = false
function love.update(dt)
  World:update(dt)
  if CurrentScene == SceneList["Game"] then
    CurrentScene.Update(dt)
  end
  Camera:update(dt)
end