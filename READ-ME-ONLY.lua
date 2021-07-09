--==## Fines-for-phone ##==--

-- Add this to [police/client/interactions.lua]

RegisterNetEvent('police:client:checkFines')
AddEventHandler('police:client:checkFines', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:checkFines", playerId)
    else
        QBCore.Functions.Notify("No one around!", "error")
    end
end)

------------------------------------------------------------------------------------------

-- Add this to [police/server/main.lua]

QBCore.Commands.Add('checkfines', 'Check player fines (Emergency Only).', {{name = 'id', help = 'Player ID'}}, true, function(source, args)
    local src = source
    local id = tonumber(args[1])
    if id then
        local xPlayer = QBCore.Functions.GetPlayer(id)
        local xO = QBCore.Functions.GetPlayer(src)
        
        if xPlayer and xO and xO.PlayerData.job.name == 'police' then
            local distance = 3.0 or 10.0
            if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(id))) < distance then
                QBCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '" .. xPlayer.PlayerData.citizenid .. "'", function(result)
                    if result[1] ~= nil then
                        TriggerClientEvent('QBCore:Notify', src, "This person has " .. #result .. " unpaid fines.", "success")
                    else
                        TriggerClientEvent('QBCore:Notify', src, "This person has no unpaid fines.", "success")
                    end
                end)
            else
                TriggerClientEvent('QBCore:Notify', src, "You are too far away.", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "This command is for officers only!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Wrong ID.", "error")
    end
end)

RegisterServerEvent('police:server:checkFines')
AddEventHandler('police:server:checkFines', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        QBCore.Functions.ExecuteSql(false, "SELECT * FROM phone_invoices WHERE `citizenid` = '"..SearchedPlayer.PlayerData.citizenid.."' AND `society`='police'", function(invoices)
            if #invoices == 0 then
                TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player have no unpaid fines.")
            else
                local str = ""
                for i=1,#invoices do
                    local invoice = invoices[i]
                    str = str .. '<br>'
                    str = str .. i .. '. ' .. invoice.title .. ' - $' .. invoice.amount
                end
                
                TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player Unpaid Fines: ".. str)
            end
        end)
    end
end)

QBCore.Commands.Add("fine", "Bill Player", {{name="id", help="Player ID"}, {name="amount", help="Fine Amount"}, {name="title", help="Fine Title"}}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local price = tonumber(args[2])
    local title = args[3] ~= nil and args[3] or "None"
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == 'ambulance' or Player.PlayerData.job.name == 'mechanic' or Player.PlayerData.job.name == 'cardealer' then
        if OtherPlayer ~= nil then
            if price and price > 0 then
                QBCore.Functions.ExecuteSql(false, "INSERT INTO `phone_invoices` (`citizenid`, `amount`, `society`, `title`) VALUES ('" .. OtherPlayer.PlayerData.citizenid .. "', " .. price .. ", '" .. Player.PlayerData.job.name .. "', '" .. title .. "')", function()
                    TriggerClientEvent('QBCore:Notify', source, OtherPlayer.PlayerData.source, "You received a fine for a total of $" .. price, "error")
                    TriggerClientEvent("qb-phone:RefreshPhone", OtherPlayer.PlayerData.source)

                    TriggerClientEvent('chat:addMessage', src, {
                        template = '<div class="chat-message"><b>BILL:</b> {0}</div>',
                        args = { "You wrote a bill for " .. price .. " dollar(s)" }
                    })
                end)
            else
                TriggerClientEvent('chat:addMessage', src, {
                    template = '<div class="chat-message server"><b>SYSTEM:</b> {0}</div>',
                    args = { "Invaild Amount" }
                })
            end
        else
            TriggerClientEvent('chat:addMessage', src, {
                template = '<div class="chat-message server"><b>SYSTEM:</b> {0}</div>',
                args = { "Invaild Player ID" }
            })
        end
    end
end)

------------------------------------------------------------------------------------------

-- Add this to [phone/client/main.lua]

RegisterNetEvent('qb-phone:RefreshPhone')
AddEventHandler('qb-phone:RefreshPhone', function()
    TriggerEvent("debug", 'Phone: Refresh', 'success')

    LoadPhone()
    SetTimeout(250, function()
        SendNUIMessage({
            action = "RefreshAlerts",
            AppData = Config.PhoneApplications,
        })
    end)
end)

-------------------------------------------------------------------------------------------
-- Drop old phone_invoices table and add

CREATE TABLE `phone_invoices` (
  `invoiceid` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` varchar(50) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
