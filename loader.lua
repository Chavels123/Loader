local Key = isfile("PulseHub/key.save") and readfile("PulseHub/key.save") or ""

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local SCRIPTS = {
    [6348640020] = "fa4e49b11535d5a034b51e9bfd716abf",
    [6137321701] = "fa4e49b11535d5a034b51e9bfd716abf",
    [8260276694] = "963cec62def32b2419a935d99b45f1cc",
    [4623386862] = "6e17bb33ce19a54874ef18805c1c4dad",
    [1962086868] = "9abaceaa22f3631d6dd3a9c9420cf349",
}

if not SCRIPTS[game.PlaceId] then
    LocalPlayer:Kick("Hello, " .. LocalPlayer.Name .. "! currently, this game is not supported by Pulse Hub")
    return
end

local function loadScript()
    script_key = Key
    local scriptURL = "https://api.luarmor.net/files/v3/loaders/" .. SCRIPTS[game.PlaceId] .. ".lua"
    loadstring(game:HttpGet(scriptURL))()
    Fluent:Destroy()
    script:Destroy()
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Pulse Hub",
    SubTitle = "Authentication",
    Theme = "Dark",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
})

local Tabs = {
    KeySystem = Window:AddTab({ Title = "Key System", Icon = "key" }),
    Discord = Window:AddTab({ Title = "Discord", Icon = "link" }),
    Information = Window:AddTab({ Title = "Information", Icon = "info" })
}

do
    local KeySection = Tabs.KeySystem:AddSection("Authentication")
    
    Tabs.KeySystem:AddInput("Key", {
        Title = "Enter Key",
        Default = Key,
        Placeholder = "Paste your key here...",
        Callback = function(value)
            Key = value
            script_key = value
            Fluent:Notify({
                Title = "Key System",
                Content = "Key has been entered",
                Duration = 3
            })
        end
    })

    local function saveAndLoadScript()
        if not isfolder("PulseHub") then
            makefolder("PulseHub")
        end
        writefile("PulseHub/key.save", Key)
        loadScript()
    end

    Tabs.KeySystem:AddButton({
        Title = "Get Key (Linkvertise)",
        Description = "Click to get a new key",
        Callback = function()
            setclipboard("https://ads.luarmor.net/get_key?for=Pulse_Hub_Checkpoint-EZwqJKYLjCoC")
            Fluent:Notify({
                Title = "Link Copied!",
                Content = "Open the link in your browser to get your key",
                Duration = 5,
                Image = "check"
            })
        end
    })

    Tabs.KeySystem:AddButton({
        Title = "Login",
        Description = "Authenticate with your key",
        Callback = function()
            if Key and Key ~= "" then
                Window:Dialog({
                    Title = "Key Authentication",
                    Content = "Your key has been detected! Would you like to save this key for automatic login next time?",
                    Buttons = {
                        {
                            Title = "Yes, Save Key",
                            Callback = saveAndLoadScript
                        },
                        {
                            Title = "No, Just Login",
                            Callback = loadScript
                        }
                    }
                })
            else
                Fluent:Notify({
                    Title = "Authentication Failed",
                    Content = "Please enter a valid key before attempting to login",
                    Duration = 5
                })
            end
        end
    })
end

do
    local DiscordSection = Tabs.Discord:AddSection("Community")
    
    Tabs.Discord:AddButton({
        Title = "Join Discord",
        Description = "Click to copy Discord invite link",
        Callback = function()
            setclipboard("https://discord.gg/5UPBtm7KW6")
            Fluent:Notify({
                Title = "Discord Link Copied!",
                Content = "Join our community for support and updates",
                Duration = 5,
                Image = "check"
            })
        end
    })
end

do
    local InfoSection = Tabs.Information:AddSection("Script Information")
    
    Tabs.Information:AddParagraph({
        Title = "Current Version",
        Content = "v1.0.0"
    })

    Tabs.Information:AddParagraph({
        Title = "Last Updated",
        Content = "Jan 2025"
    })

    Tabs.Information:AddParagraph({
        Title = "Supported Games",
        Content = [[
• Blair
• BABFT
• And more!]]
    })
end

if Key ~= "" then
    Fluent:Notify({
        Title = "Automatic Login",
        Content = "A saved key has been detected! You can now login or get a new key.",
        Duration = 5
    })
else
    Fluent:Notify({
        Title = "Welcome to Pulse Hub",
        Content = "Please obtain and enter your key to access the script",
        Duration = 5
    })
end
