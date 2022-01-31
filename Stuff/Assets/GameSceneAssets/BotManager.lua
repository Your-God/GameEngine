local TitleScreenScene = {}
local GE = require("GameEngine")
local UDim2 = GE:Get("UDim2")
local Vector2 = GE:Get("Vector2")
local Color3 = GE:Get("Color3")




local function RenderBot(self)
    local Size = self.ActualSize
    local Color = self.__InternalObj.Color


    
    love.graphics.setColor(Color.r, Color.g, Color.b, self.Opacity)
    
    love.graphics.circle("fill", 0, 0, Size.x)
    love.graphics.setColor(1,0.2,0.2)
    love.graphics.rectangle("fill", -10, Size.x-5, Size.x * 2, 5)
    love.graphics.setColor(1,1,1)
end

function NewBot(Position)
    local Bot = GE:New("Collider")
        Bot:InitilizeAs("circle", Position or Vector2:New(0,0), Vector2:New(25,25))
        Bot.Body:setLinearDamping(20)
        Bot.Body:setAngularDamping(20)
        Bot.Body:setType("kineomatic")
        local BotFrame = GE:New("Frame", Bot)
            --BotFrame.Position = UDim2:New(-0.5,0,-0.5,0)
            BotFrame.Size = UDim2:New(0, 25, 0, 25)
            BotFrame.BorderSize = 4
            BotFrame.Color = Color3:FromRGB(112, 112, 112)
            BotFrame.BorderColor = Color3:FromRGB(95, 95, 95)
            BotFrame.__InternalObj.Render = RenderBot
    return Bot
end




return NewBot