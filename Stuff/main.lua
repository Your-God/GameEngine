io.stdout:setvbuf("no")
local GE = require("GameEngine")
local UDim2 = GE:Get("UDim2")




local Scene = GE:New("Scene")
local MainFrame = GE:New("Frame", Scene)
MainFrame.Size = UDim2:New(0,50,0,50)
MainFrame.Position = UDim2:New(0.5,-25,0.5,-25)



function love.draw()
  Scene:RenderScene()
end

function love.conf(t)
	t.console = true
end