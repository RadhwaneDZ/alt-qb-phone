QBCore = nil
CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Wait(200)
    end
end)
local drops = {
    [1] =  { ['x'] = 74.5,['y'] = -762.17,['z'] = 31.68,['h'] = 160.98 },
    [2] =  { ['x'] = 100.58,['y'] = -644.11,['z'] = 44.23,['h'] = 69.11 },
    [3] =  { ['x'] = 175.45,['y'] = -445.95,['z'] = 41.1,['h'] = 92.72 },
    [4] =  { ['x'] = 130.3,['y'] = -246.26,['z'] = 51.45,['h'] = 219.63 },
    [5] =  { ['x'] = 198.1,['y'] = -162.11,['z'] = 56.35,['h'] = 340.09 },
    [6] =  { ['x'] = 341.0,['y'] = -184.71,['z'] = 58.07,['h'] = 159.33 },
    [7] =  { ['x'] = -26.96,['y'] = -368.45,['z'] = 39.69,['h'] = 251.12 },
    [8] =  { ['x'] = -155.88,['y'] = -751.76,['z'] = 33.76,['h'] = 251.82 },
    [9] =  { ['x'] = -305.02,['y'] = -226.17,['z'] = 36.29,['h'] = 306.04 },
    [10] =  { ['x'] = -347.19,['y'] = -791.04,['z'] = 33.97,['h'] = 3.06 },
    [11] =  { ['x'] = -703.75,['y'] = -932.93,['z'] = 19.22,['h'] = 87.86 },
    [12] =  { ['x'] = -659.35,['y'] = -256.83,['z'] = 36.23,['h'] = 118.92 },
    [13] =  { ['x'] = -934.18,['y'] = -124.28,['z'] = 37.77,['h'] = 205.79 },
    [14] =  { ['x'] = -1214.3,['y'] = -317.57,['z'] = 37.75,['h'] = 18.39 },
    [15] =  { ['x'] = -822.83,['y'] = -636.97,['z'] = 27.9,['h'] = 160.23 },
    [16] =  { ['x'] = 308.04,['y'] = -1386.09,['z'] = 31.79,['h'] = 47.23 },
}


local messagesCounter, hasActiveSell, activeItem, activePrice = 0, false, nil, -1
local TimeoutCounter, isTimedout = 0, false
local blip, sellerPed, sellerPedCreated = 0, 0, false
local runData = nil

function DeleteBlip()
    if DoesBlipExist(blip) then
        RemoveBlip(blip)
    end
end

function CreateBlip(rnd)
    DeleteBlip()
    blip = AddBlipForCoord(drops[rnd]["x"], drops[rnd]["y"], drops[rnd]["z"])
    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Buyer")
    EndTextCommandSetBlipName(blip)
end

function CreateSellerPed(rnd)
    local hashKey = runData['buyerData'][1]
    local pedType = 5
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Wait(100)
    end

    sellerPed = CreatePed(pedType, hashKey, drops[rnd]["x"], drops[rnd]["y"], drops[rnd]["z"], drops[rnd]["h"], 1, 0)
    ClearPedTasks(sellerPed)
    ClearPedSecondaryTask(sellerPed)
    TaskSetBlockingOfNonTemporaryEvents(sellerPed, true)
    SetPedFleeAttributes(sellerPed, 0, 0)
    SetPedCombatAttributes(sellerPed, 17, 1)

    SetPedSeeingRange(sellerPed, 0.0)
    SetPedHearingRange(sellerPed, 0.0)
    SetPedAlertness(sellerPed, 0)
    SetPedKeepTask(sellerPed, true)
end

function DeleteCreatedPed()
    if DoesEntityExist(sellerPed) then 
        SetPedKeepTask(sellerPed, false)
        TaskSetBlockingOfNonTemporaryEvents(sellerPed, false)
        ClearPedTasks(sellerPed)
        TaskWanderStandard(sellerPed, 10.0, 10)
        SetPedAsNoLongerNeeded(sellerPed)
        sellerPed = nil
    end
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Wait( 5 )
    end
end 

function playerAnim()
    loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

function giveAnim()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "mp_safehouselost@" )
        if ( IsEntityPlayingAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 3 ) ) then 
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        else
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        end     
    end
end

function InteractedSellWithClient()
    everythingOk = true
    Wait(1000)
    playerAnim()
    Wait(800)
    PlayAmbientSpeech1(sellerPed, "Chat_State", "Speech_Params_Force")

    if DoesEntityExist(sellerPed) and not IsEntityDead(sellerPed) then
        local counter = math.random(50,200)
        while counter > 0 do
            local crds = GetEntityCoords(sellerPed)
            counter = counter - 1
            Wait(1)
        end
    
        if everythingOk then
            local counter = math.random(100,300)
            while counter > 0 do
                local crds = GetEntityCoords(sellerPed)
                counter = counter - 1
                Wait(1)
            end
            giveAnim()
        end
    
        local crds = GetEntityCoords(sellerPed)
        local crds2 = GetEntityCoords(PlayerPedId())
    
        if #(crds - crds2) > 3.0 or not DoesEntityExist(sellerPed) or IsEntityDead(sellerPed) then
            everythingOk = false
        end
        
        DeleteBlip()
        DeleteCreatedPed()

        if everythingOk then
            TriggerServerEvent("mg-pawnshop:server:sellEvent", runData)
            return true
        else
            return false
        end
    end
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('mg-pawnshop:client:startDelivery')
AddEventHandler('mg-pawnshop:client:startDelivery', function(data)
    hasActiveSell = true
    runData = data

    local rnd = math.random(1, #drops)
    CreateBlip(rnd)

    local tooLong = data['delivery']
    while hasActiveSell do
        Wait(1)

        local plycoords = GetEntityCoords(PlayerPedId())
        local dstcheck = #(plycoords - vector3(drops[rnd]["x"],drops[rnd]["y"],drops[rnd]["z"])) 
        local veh = GetVehiclePedIsIn(PlayerPedId(),false)

        if dstcheck < 40.0 and not sellerPedCreated then
            sellerPedCreated = true
            DeleteCreatedPed()
            CreateSellerPed(rnd)
        end
        tooLong = tooLong - 1
        if tooLong < 0 then
            hasActiveSell = false
            runData = nil
            TriggerServerEvent('mg-pawnshop:server:banClient', 2)
        end

        if dstcheck < 2.0 and sellerPedCreated then
            local crds = GetEntityCoords(sellerPed)
            DrawText3Ds(crds["x"],crds["y"],crds["z"], "[E]")  

            if not IsPedInAnyVehicle(PlayerPedId()) and IsControlJustReleased(0,38) then
                TaskTurnPedToFaceEntity(sellerPed, PlayerPedId(), 1.0)
                Wait(100)
                PlayAmbientSpeech1(sellerPed, "Generic_Hi", "Speech_Params_Force")
                local sts = InteractedSellWithClient(item, price, count)

                hasActiveSell = false
                runData = createNewListing
            end
        end
    end

    DeleteCreatedPed()
    DeleteBlip()
    hasActiveSell, sellerPed, sellerPedCreated, activeItem, activePrice = false, nil, false, nil, -1
    runData = nil
end)

function hasActiveDelivery()
    return hasActiveSell
end