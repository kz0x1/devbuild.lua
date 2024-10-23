-- REQUIRED
-- This basically adds a lot of UNC Functions and patches vulns.
-- thanks to raz for this (owner of scorpion)
loadstring(game:HttpGet("https://raw.githubusercontent.com/RazAPI/Scorpion/refs/heads/main/Debug/x64/Model/MainEnvironment.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/RazAPI/Scorpion/refs/heads/main/Debug/x64/Model/ProtectedEnvironment.lua"))()
function getsenv(script_instance)
	local env = getfenv(debug.info(2, 'f'))
	return setmetatable({
		script = script_instance,
	}, {
		__index = function(self, index)
			return env[index] or rawget(self, index)
		end,
		__newindex = function(self, index, value)
			xpcall(function()
				env[index] = value
			end, function()
				rawset(self, index, value)
			end)
		end,
	})
end

function getrunningscripts()
    local scripts = {}
    for _, script in ipairs(game:GetService("Players").LocalPlayer:GetDescendants()) do
        if script:IsA("LocalScript") or script:IsA("ModuleScript") or script:IsA("Script") then
            scripts[#scripts + 1] = script
        end
    end
    return scripts
  end

  function getrunningscript()
    return getrunningscripts
  end

  getconnections = newcclosure(function(Event) -- hi
    assert(typeof(Event) == "RBXScriptSignal", "Argument must be a RBXScriptSignal")

    local Connections = {}

    local Connection = Event:Connect(function() end)
    
    local ConnectionInfo = {
        ["Enabled"] = true,
        ["ForeignState"] = false,
        ["LuaConnection"] = true,
        ["Function"] = function() end,
        ["Thread"] = getrenv()["coroutine"].create(function() end),
        ["Fire"] = function() Connection:Fire() end,
        ["Defer"] = function() task.defer(Connection["Fire"], Connection) end,
        ["Disconnect"] = function() Connection:Disconnect() end,
        ["Disable"] = function() ConnectionInfo["Enabled"] = false end,
        ["Enable"] = function() ConnectionInfo["Enabled"] = true end,
    }

    getrenv()["table"].insert(Connections, ConnectionInfo)

    Connection:Disconnect()
    return Connections
end)

function getconnection()
    return getconnections
end

function get_connections()
    return  getconnections
end

function getconnect()
    return getconnections
end

-- setclipboard("https://discord.gg/VxhjCgcj")

devprint = function(text)
    print(text)
    task.wait(.025)
    local msg = game:GetService("CoreGui").DevConsoleMaster.DevConsoleWindow.DevConsoleUI:WaitForChild("MainView").ClientLog[tostring(#game:GetService("CoreGui").DevConsoleMaster.DevConsoleWindow.DevConsoleUI.MainView.ClientLog:GetChildren())-1].msg
    for i, x in pairs({TextColor3 = Color3.fromRGB(69, 165, 236)}) do
        msg[i] = x
    end
    msg.Parent.image.Image = "rbxasset://textures/DevConsole/Info.png"
end


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
