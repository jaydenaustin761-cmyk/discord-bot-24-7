-- Product Purchase Faker
-- Made by jay credits to vaehz

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Product Fucker",
    LoadingTitle = "Product Purchase Faker",
    LoadingSubtitle = "by jay credits to vaehz",
    ConfigurationSaving = { Enabled = false },
})

local ActionTab = Window:CreateTab("Action", 4483362458)
local ListenerTab = Window:CreateTab("Listener", 4483362458)

-- ==================== ACTION TAB ====================
local ActionSection = ActionTab:CreateSection("Signal Fake Purchases")

local ProductIDValue = ""  -- We'll store the ID here manually

local ProductIDInput = ActionTab:CreateInput({
    Name = "Product ID",
    PlaceholderText = "Enter Product ID here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        ProductIDValue = Text  -- Update our stored value every time user types
    end,
})

ActionTab:CreateButton({
    Name = "Signal Product",
    Callback = function()
        local id = tonumber(ProductIDValue)
        if not id or id <= 0 then
            Rayfield:Notify({Title = "Error", Content = "Invalid Product ID", Duration = 3})
            return
        end

        print("Falsely signaling Product Purchase:", id)
        game:GetService("MarketplaceService"):SignalPromptProductPurchaseFinished(
            game.Players.LocalPlayer.UserId, id, true
        )

        Rayfield:Notify({Title = "Signaled", Content = "Product Purchase ID: "..id, Duration = 4})
    end,
})

ActionTab:CreateButton({
    Name = "Signal Gamepass",
    Callback = function()
        local id = tonumber(ProductIDValue)
        if not id or id <= 0 then
            Rayfield:Notify({Title = "Error", Content = "Invalid Product ID", Duration = 3})
            return
        end

        print("Falsely signaling Gamepass Purchase:", id)
        game:GetService("MarketplaceService"):SignalPromptGamePassPurchaseFinished(
            game.Players.LocalPlayer, id, true
        )

        Rayfield:Notify({Title = "Signaled", Content = "Gamepass Purchase ID: "..id, Duration = 4})
    end,
})

ActionTab:CreateButton({
    Name = "Signal Bulk",
    Callback = function()
        local id = tonumber(ProductIDValue)
        if not id or id <= 0 then
            Rayfield:Notify({Title = "Error", Content = "Invalid Product ID", Duration = 3})
            return
        end

        print("Falsely signaling Bulk Purchase:", id)
        game:GetService("MarketplaceService"):SignalPromptBulkPurchaseFinished(
            game.Players.LocalPlayer.UserId, id, true
        )

        Rayfield:Notify({Title = "Signaled", Content = "Bulk Purchase ID: "..id, Duration = 4})
    end,
})

ActionTab:CreateButton({
    Name = "Signal Purchase",   -- This one was broken for you
    Callback = function()
        local id = tonumber(ProductIDValue)
        if not id or id <= 0 then
            Rayfield:Notify({Title = "Error", Content = "Invalid Product ID\nMake sure you typed a number", Duration = 4})
            return
        end

        print("Falsely signaling Purchase:", id)
        game:GetService("MarketplaceService"):SignalPromptPurchaseFinished(
            game.Players.LocalPlayer.UserId, id, true
        )

        Rayfield:Notify({Title = "Signaled", Content = "Purchase ID: "..id, Duration = 4})
    end,
})

ActionTab:CreateParagraph({
    Title = "Warning",
    Content = "These only fake the signals.\nType a real-looking number in the box above."
})

-- ==================== LISTENER TAB ====================
local ListenerSection = ListenerTab:CreateSection("Purchase Listener")

local LogLabel = ListenerTab:CreateParagraph({
    Title = "Latest Log",
    Content = "No purchases detected yet.\nClick any Signal button to test.",
})

local logCount = 0

local function addLog(productId, wasPurchased)
    logCount = logCount + 1
    local status = wasPurchased and "✅ SUCCESS" or "❌ Failed"
    
    LogLabel:Set({
        Title = "Purchase Log #" .. logCount,
        Content = "Product ID: " .. tostring(productId) .. "\nStatus: " .. status .. "\nTime: " .. os.date("%X")
    })

    Rayfield:Notify({
        Title = "Purchase Detected",
        Content = "ID: " .. tostring(productId) .. "\n" .. status,
        Duration = 5,
    })

    print("=== Listener Triggered === ID:", productId, "| Success:", wasPurchased)
end

-- ==================== HOOKS ====================
local MS = game:GetService("MarketplaceService")

MS.PromptProductPurchaseFinished:Connect(function(_, productId, wasPurchased)
    addLog(productId, wasPurchased)
end)

MS.PromptGamePassPurchaseFinished:Connect(function(_, productId, wasPurchased)
    addLog(productId, wasPurchased)
end)

MS.PromptPurchaseFinished:Connect(function(_, productId, wasPurchased)
    addLog(productId, wasPurchased)
end)

MS.PromptBulkPurchaseFinished:Connect(function(_, productId, wasPurchased)
    addLog(productId, wasPurchased)
end)

Rayfield:Notify({
    Title = "Loaded",
    Content = "Product Fucker by jay\nType ID first, then click Signal Purchase",
    Duration = 6,
})