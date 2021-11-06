io.stdout:setvbuf("no")
local GE = require("GameEngine")
local UDim2 = GE:Get("UDim2")
local Color3 = GE:Get("Color3")




local Scene = GE:New("Scene")
local MainFrame = GE:New("Frame", Scene)
MainFrame.Size = UDim2:New(0,50,0,50)
MainFrame.Position = UDim2:New(0.5,-25,0.5,-25)
MainFrame.BorderColor = Color3:New(1,0,0)
MainFrame.BorderSize = 3

function love.keypressed(Key)
  
end

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
  Scene:RenderScene()
end

function love.conf(t)
	t.console = true
end