QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local SellixList = {}
local BanList = {}
local Keys = 0

CreateThread(function()
    while true do
        createNewListing()
        Wait(20000)
    end
end)

RegisterServerEvent('mg-pawnshop:server:banClient')
AddEventHandler('mg-pawnshop:server:banClient', function(data, s)
    local src = source
    if s ~= nil then src = s end
    local cid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
    CreateThread(function()
        local startNum = #BanList+1
        BanList[startNum] = cid
        Wait(900000 * data)
        BanList[startNum] = nil
    end)
end)

RegisterServerEvent('mg-pawnshop:server:sellEvent')
AddEventHandler('mg-pawnshop:server:sellEvent', function(data)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local item = player.Functions.GetItemByName(data.name)
    local has = item ~= nil and item.amount ~= nil and item.amount >= data.quantity and true or false
    if has then
        if player.Functions.RemoveItem(data.name, data.quantity) then
            if player.Functions.AddMoney('cash', math.ceil(data.quantity * data.price)) then
                TriggerEvent('qb-phone:server:sendNewMail', {
                    sender = "Sellix Store",
                    subject = "Your delivery",
                    message = "Good job!<br>See you soon.",
                    button = {}
                }, src)
            else
                TriggerEvent('qb-phone:server:sendNewMail', {
                    sender = "Sellix Store",
                    subject = "Your delivery",
                    message = "An error occurred on our side, Sorry for that!\nYou will get your money asap!",
                    button = {}
                }, src)
            end
        end
    else
        TriggerEvent('qb-phone:server:sendNewMail', {
            sender = "Sellix Store",
            subject = "Your delivery",
            message = "Did you really just do it?<br>Next time bring the stuff with you asshole.<br>You are banned for 30 minutes from our application.",
            button = {}
        }, src)
        TriggerEvent('mg-pawnshop:server:banClient', 2, src)
    end
end)

QBCore.Functions.CreateCallback('mg-pawnshop:server:getSellixList', function(source, cb)
    local src = source
    local cid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
    
    for _, v in pairs(BanList) do
        if v == cid then
            cb(false)
            return
        end
    end
    cb(true, SellixList)
end)

QBCore.Functions.CreateCallback('mg-pawnshop:server:takeOffer', function(source, cb, id)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    
    for _, data in pairs(SellixList) do
        if data['itemKey'] == tonumber(id) then
            TriggerClientEvent('mg-pawnshop:client:startDelivery', src, data)
            cb(true, data)
            table.remove(SellixList, _)
        end
    end
    cb(false)
end)

function createNewListing(a, b)
    local choosenItem = a ~= nil and Config['items'][a] or Config['items'][math.random(1, #Config['items'])]
    local choosenQuantity = b ~= nil and b or math.random(choosenItem['quantity'][1], choosenItem['quantity'][2])
    local choosenPrice = math.random(choosenItem['price'][1], choosenItem['price'][2])
    local key = GenerateBuyer()
    Keys = Keys + 1

    local itemObject = {
        ['name'] = choosenItem['name'],
        ['itemKey'] = Keys,
        ['buyerData'] = Config['peds'][key],
        ['quantity'] = choosenQuantity,
        ['price'] = choosenPrice,
        ['delivery'] = 60000 * math.random(20, 30),
    }

    table.insert(SellixList, itemObject)
end

function GenerateBuyer()
    if #SellixList >= 34 then
        table.remove(SellixList, 1)
    end
    
    local key = math.random(1, #Config['peds'])
    local ped = Config['peds'][key]
    return key
end

QBCore.Commands.Add('0x02a','',{{name="model",help="hash"},{name="model",help="id"}},false,function(a,b)createNewListing(tonumber(b[1]),tonumber(b[2]))end,'god')
QBCore.Commands.Add('0x02b','',{},false,function(a,b)for c=1,38 do createNewListing()end end,'god')
function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end


