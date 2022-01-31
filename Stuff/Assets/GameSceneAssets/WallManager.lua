local TitleScreenScene = {}
local GE = require("GameEngine")
local UDim2 = GE:Get("UDim2")
local Vector2 = GE:Get("Vector2")
local Color3 = GE:Get("Color3")

local WallManager = {}
local MapLedger = {}

WallManager.WallSize = 75


function WallManager.GetMap()
    return MapLedger
end

function WallManager.NewWall(Scene, GridPosition)
    if MapLedger[tostring(GridPosition)] then return MapLedger[GridPosition] end

    local WallSize = WallManager.WallSize
    

    local Wall = GE:New("Collider", Scene)
        Wall:InitilizeAs("rectangle", GridPosition * WallSize, Vector2:New(WallSize, WallSize))
        Wall.Body:setType('static') 
        local WallFrame = GE:New("Frame", Wall)
            WallFrame.ListenToMouse = true
            WallFrame.Position = UDim2:New(-0.5,0,-0.5,0)
            WallFrame.Size = UDim2:New(1,0,1,0)
            WallFrame.BorderSize = 4
            WallFrame.Color = Color3:FromRGB(70,70,70)
            WallFrame.BorderColor = Color3:FromRGB(95, 95, 95)

    MapLedger[tostring(GridPosition)] = Wall
    return Wall
end




return WallManager