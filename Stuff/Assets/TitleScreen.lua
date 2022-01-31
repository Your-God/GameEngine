local TitleScreenScene = {}
local GE = require("GameEngine")
local UDim2 = GE:Get("UDim2")
local Color3 = GE:Get("Color3")



local Scene = GE:New("Scene")
  TitleScreenScene.Scene = Scene
local MainMenu = GE:New("Frame", Scene)
  MainMenu.Size = UDim2:New(0, 150, 0, 275)
  MainMenu.Position = UDim2:New(0.5,-75,0.5,-100)
  MainMenu.BorderSize = 4
  MainMenu.Color = Color3:FromRGB(112, 112, 112)
  MainMenu.BorderColor = Color3:FromRGB(95, 95, 95)

  local Title = GE:New("Text", MainMenu)
    Title.Position = UDim2:New(0,0,0,0)
    Title.Size = UDim2:New(1,0,0,80)
    Title.Text = "My Game!"
    Title.Color = Color3:FromRGB(181, 168, 87)
    Title.xAlignment = "center"
    Title.yAlignment = "center"

local PlayButton = GE:New("Frame", MainMenu)
  PlayButton.ListenToMouse = true
  PlayButton.Size = UDim2:New(0,80,0,40)
  PlayButton.Position = UDim2:New(0.5, -40, 0, 80)
  PlayButton.Color = Color3:FromRGB(181, 168, 87)
  PlayButton.BorderSize = 0
  PlayButton.Rotation = math.rad(15)
  local PlayTextLabel = GE:New("Text", PlayButton)
    PlayTextLabel.xAlignment = "center"
    PlayTextLabel.yAlignment = "center"
    PlayTextLabel.Size = UDim2:New(1,0,1,0)
    PlayTextLabel.Color = Color3:New(0,0,0)
    PlayTextLabel.Text = "Play"

local SettingsButton = GE:New("Frame", MainMenu)
  --SettingsButton.ListenToMouse = true
  SettingsButton.Size = UDim2:New(0,80,0,40)
  SettingsButton.Position = UDim2:New(0.5, -40, 0, 125)
  SettingsButton.Color = Color3:FromRGB(181, 168, 87)
  SettingsButton.BorderSize = 0
  local SettingsTextLabel = GE:New("Text", SettingsButton)
    SettingsTextLabel.xAlignment = "center"
    SettingsTextLabel.yAlignment = "center"
    SettingsTextLabel.Size = UDim2:New(1,0,1,0)
    SettingsTextLabel.Color = Color3:New(0,0,0)
    SettingsTextLabel.Text = "Settings"


local CreditsButton = GE:New("Frame", MainMenu)
  --CreditsButton.ListenToMouse = true
  CreditsButton.Size = UDim2:New(0,80,0,40)
  CreditsButton.Position = UDim2:New(0.5, -40, 0, 170)
  CreditsButton.Color = Color3:FromRGB(181, 168, 87)
  CreditsButton.BorderSize = 0
  local CreditsTextLabel = GE:New("Text", CreditsButton)
    CreditsTextLabel.xAlignment = "center"
    CreditsTextLabel.yAlignment = "center"
    CreditsTextLabel.Size = UDim2:New(1,0,1,0)
    CreditsTextLabel.Color = Color3:New(0,0,0)
    CreditsTextLabel.Text = "Credits"

local QuitButton = GE:New("Frame", MainMenu)
  QuitButton.ListenToMouse = true
  QuitButton.Size = UDim2:New(0,80,0,40)
  QuitButton.Position = UDim2:New(0.5, -40, 0, 215)
  QuitButton.Color = Color3:FromRGB(181, 168, 87)
  QuitButton.BorderSize = 0
  local QuitTextLabel = GE:New("Text", QuitButton)
    QuitTextLabel.xAlignment = "center"
    QuitTextLabel.yAlignment = "center"
    QuitTextLabel.Size = UDim2:New(1,0,1,0)
    QuitTextLabel.Color = Color3:New(0,0,0)
    QuitTextLabel.Text = "Quit"












------------------------------------------------------------------------------



QuitButton.OnMouseDown:Connect(
  function(mx,my,button)
    if button == 1 then 
      print("Quitting")
      --love.event.quit()
    else
      print("Close")
    end
  end)

PlayButton.OnMouseDown:Connect(
  function(mx,my,button)
    if button == 1 then 
      print(".")
      TitleScreenScene.SetSceneTo("Game")
    end
  end
)








return TitleScreenScene