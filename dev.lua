-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

function identifyexecutor() return 'DevBuild', 'v0.1.0' end

-- Key System
local key = "devbuildbeta"
local userInputKey = ""

local function verifyKey()
    return userInputKey == key
end

local function requestKey()
    Rayfield:Notify({
        Title = "Key Required",
        Content = "Please enter the key to continue.",
        Duration = 5,
    })

    userInputKey = Rayfield:Prompt({
        Title = "Enter Key",
        PlaceholderText = "Key here...",
        Callback = function(value)
            userInputKey = value
        end,
    })
end

requestKey()

if verifyKey() then
    -- Create the main window for the exploit
    local Window = Rayfield:CreateWindow({
        Name = "DevBuild by kz0x1",
        LoadingTitle = "Initializing...",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "devbuild-0.1.0",
            FileName = "configs"
        },
        Discord = {
            Enabled = false,
        },
        KeySystem = true,
    })

    -- Add a tab for script execution
    local ScriptTab = Window:CreateTab("Script Executor")

    -- Script Input
    local ScriptInput = ScriptTab:CreateInput({
        Name = "Script Executor",
        PlaceholderText = "Script here...",
        RemoveTextAfterFocus = true,
        Callback = function(value)
            scriptToExecute = value
        end,
    })

    -- Execute Button
    ScriptTab:CreateButton({
        Name = "Execute",
        Callback = function()
            local success, err = pcall(function()
                loadstring(scriptToExecute)()
            end)

            if not success then
                Rayfield:Notify({
                    Title = "Error",
                    Content = err,
                    Duration = 5,
                })
            else
                Rayfield:Notify({
                    Title = "Executed",
                    Content = "Script executed successfully!",
                    Duration = 5,
                })
            end
        end,
    })

    -- Add LocalPlayer tab for quick access
    local LocalPlayerTab = Window:CreateTab("LocalPlayer")

    -- Add buttons for LocalPlayer functions
    LocalPlayerTab:CreateButton({
        Name = "WalkSpeed 100",
        Callback = function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
        end,
    })

    LocalPlayerTab:CreateButton({
        Name = "JumpPower 100 (2x normal jumppower)",
        Callback = function()
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
        end,
    })

else
    Rayfield:Notify({
        Title = "Invalid Key",
        Content = "The key you entered is incorrect.",
        Duration = 5,
    })
end
