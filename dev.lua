-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

function identifyexecutor() return 'DevBuild', 'v0.1.0' end

-- Create the main window for the exploit
local Window = Rayfield:CreateWindow({
    Name = "Rayfield Exploit",
    LoadingTitle = "Initializing Exploit...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "RayfieldExploit",
        FileName = "ExploitConfig"
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = false,
})

-- Add a tab for script execution
local ScriptTab = Window:CreateTab("Script Executor")

-- Script Input
local ScriptInput = ScriptTab:CreateInput({
    Name = "Lua Script",
    PlaceholderText = "Enter script...",
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

-- Anti-Detection
local function doshit()
    --[[local oldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
        if self == game.Players.LocalPlayer and getnamecallmethod() == "Kick" then
            return
        end]]
        return oldNameCall(self, ...)
    end)
end

doshit()
