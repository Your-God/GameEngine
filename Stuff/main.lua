io.stdout:setvbuf("no")
local GE = require("GameEngine")
local World = GE:Get("World"):GetDefaultWorld()


local CurrentScene = nil


function love.load()
  local TitleScreen_Scene, Title_Buttons = unpack(require("Assets/TitleScreen"))
  CurrentScene = TitleScreen_Scene
  
end


function love.draw()
  if CurrentScene then
    CurrentScene:RenderScene()
  end
end

function love.update(dt)
  World:update(dt)
end


--[[

local Scene = GE:New("Scene")

local BoxA = GE:New("Collider", Scene)
BoxA:InitilizeAs("rectangle", Vector2:New(50,10), Vector2:New(60, 20))
BoxA.DebugCollider = false
--BoxA.Body:applyLinearImpulse(600,0)

local Player = GE:New("Frame", BoxA)
Player.Size = UDim2:New(1, 0, 1, 0)
---------------------------------
local BoxB = GE:New("Collider", Scene)
BoxB:InitilizeAs("rectangle", Vector2:New(0,200), Vector2:New(600,20))
BoxB.DebugCollider = true
BoxB.Body:setType('static')

local BoxB_Sprite = GE:New("Frame", BoxB)
BoxB_Sprite.Size = UDim2:New(1, 0, 1, 0)


local World = WorldType:GetDefaultWorld()






function love.update(dt)
  local Speed = 50
  local Velocity = Vector2:New(0,0)
  if love.keyboard.isDown("a") then
    Velocity = Velocity + Vector2:New(-Speed,0)
  end
  if love.keyboard.isDown("d") then
    --player:applyLinearImpulse(10, 0)
    Velocity = Velocity + Vector2:New(Speed,0)
  end
  if love.keyboard.isDown("w") then
    Velocity = Velocity + Vector2:New(0,-Speed)
  end
  if love.keyboard.isDown("s") then
    --player:applyLinearImpulse(10, 0)
    Velocity = Velocity + Vector2:New(0,Speed)
  end


  BoxA.Body:setLinearVelocity(Velocity.x, Velocity.y)

  World:update(dt)
end

function love.draw()
  Scene:RenderScene()
  World:draw()
end


Next need to add rotation
or; if I want to procrastinate; I can simpilfy everything
and turn it into a proof of concept


--]]
--[[
function love.update(dt)
  local Speed = 50
  local Velocity = Vector2:New(0,0)
  if love.keyboard.isDown("a") then
    Velocity = Velocity + Vector2:New(-Speed,0)
  end
  if love.keyboard.isDown("d") then
    --player:applyLinearImpulse(10, 0)
    Velocity = Velocity + Vector2:New(Speed,0)
  end
  if love.keyboard.isDown("w") then
    Velocity = Velocity + Vector2:New(0,-Speed)
  end
  if love.keyboard.isDown("s") then
    --player:applyLinearImpulse(10, 0)
    Velocity = Velocity + Vector2:New(0,Speed)
  end


  player:setLinearVelocity(Velocity.x, Velocity.y)

  world:update(dt)
end

function love.load()

  world = wf.newWorld(0, 0, false )
  
  ground = world:newRectangleCollider(100, 500, 600, 50)
  ground:setType('static')
  platform = world:newRectangleCollider(350, 400, 100, 20)
  platform:setType('static')
  platform:setCollisionClass('Platform')
  player = world:newRectangleCollider(390, 450, 20, 40)
  player.Velocity = Vector2:New(0,0)
  player:setCollisionClass('Player')
  player:setFixedRotation(true)

  test = world:newCircleCollider(0,0,50)
  test:setType('static')
  
end

function love.keypressed(key)
  if key == 'space' then
    player:applyLinearImpulse(0, -700)
  end
end


function love.draw()
  world:draw() -- The world can be drawn for debugging purposes
end





--]]











--[[
local GE = require("GameEngine")
local TitleScreen, MainFrame = unpack(require("Assets/TitleScreen"))




function love.update(dt)
  local KeyPressed = love.keyboard.isDown
  if KeyPressed("a") then
    MainFrame:Offset(-1,0)
  end
  if KeyPressed("d") then
    MainFrame:Offset(1,0)
  end
  if KeyPressed("w") then
    MainFrame:Offset(0,-1)
  end
  if KeyPressed("s") then
    MainFrame:Offset(0,1)
  end
end

function love.keyreleased(Key)

end

-- Need to add a Text Box / Text Property
-- Frame Rounding
-- Keyboard Object? To hook onto Keystrokes

function love.draw()
  TitleScreen:RenderScene()
end

function love.conf(t)
	t.console = true
end



--]]