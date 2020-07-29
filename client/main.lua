local PlayerData                = {}
ESX                             = nil

local blip1 = {}
local blips = false
local blipActive = false
local marulAktif = false
local firstspawn = false
local impacts = 0
local timer = 0
local locations = {
    { x = 2094.273, y = 5177.581, z = 53.635},
    { x = 2092.243, y = 5183.563, z = 54.218},
    { x = 2087.770, y = 5183.607, z = 54.080},
    { x = 2087.697, y = 5179.693, z = 53.220},
}

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)  

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function DrawText3D(x,y,z, text)
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
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 0, 0, 0, 100)
end

function Animation()
    Citizen.CreateThread(function()
        while impacts < 5 do
            Citizen.Wait(1)
		local ped = PlayerPedId()	
                RequestAnimDict("amb@prop_human_bum_bin@idle_a")
                Citizen.Wait(100)
                FreezeEntityPosition(ped, true)
                TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
                SetEntityHeading(ped, 270.0)
                Citizen.Wait(2500)
                ClearPedTasks(ped)
                impacts = impacts+1
                if impacts == 5 then
                    FreezeEntityPosition(ped, false)
                    solucanAktif = false
                    impacts = 0
                    TriggerServerEvent("brky:solucantop")
                    break
                end        
        end
    end)
end

local firstspawn = false

Citizen.CreateThread(function()
    local hash = GetHashKey("a_m_m_salton_02")

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Citizen.Wait(100)
    end

    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end

    if firstspawn == false then
        local npc = CreatePed(6, hash, -601.480, -346.890, 34.241, 109.03, false, false)
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        SetPedDiesWhenInjured(npc, false)
        SetPedCanRagdollFromPlayerImpact(npc, false)
        SetPedCanRagdoll(npc, false)
        SetEntityAsMissionEntity(npc, true, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetEntityDynamic(npc, true)
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), -601.480, -346.890, 35.241, true) < 2 then
                DrawText3D(-601.480, -346.890, 36.241, " ~g~[E] ~w~ Big Tony")
                    if IsControlJustReleased(1, 51) then
                        BrkyMarul()                
            end
        end
    end
 end)

 Citizen.CreateThread(function()
	Citizen.Wait(500)
    hamb = AddBlipForCoord(-602.064, -347.123, 35.241)
    SetBlipSprite(hamb, 480)
    SetBlipColour(hamb, 21)
    SetBlipScale(hamb, 0.5)
    SetBlipAsShortRange(hamb, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Big Tony")
    EndTextCommandSetBlipName(hamb)
end)

function BrkyMarul()
    local elements = {
        {label = 'Hamburger Yap',   value = 'hamb'},
        {label = 'Menüyü Kapat',       value = 'kapat'},

    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'brky-ham', {
        title    = 'Hamburger',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'hamb' then
           menu.close()
           veranim()
           exports['sway_taskbar']:taskBar(3000, "Üretim..")
           veranim()
            TriggerServerEvent("brky:hamb")
        elseif data.current.value == 'kapat' then
            menu.close()
        end
    end)
end

function veranim() 
    RequestAnimDict("mp_common")
    while not HasAnimDictLoaded("mp_common")do 
        Citizen.Wait(0)
    end;b=CreateObject(GetHashKey('prop_weed_bottle'),0,0,0,true)
    AttachEntityToEntity(b,PlayerPedId(),
    GetPedBoneIndex(PlayerPedId(),57005),0.13,0.02,0.0,-90.0,0,0,1,1,0,1,0,1)
    AttachEntityToEntity(p,l,GetPedBoneIndex(l,57005),0.13,0.02,0.0,-90.0,0,0,1,1,0,1,0,1)
    TaskPlayAnim(GetPlayerPed(-1),"mp_common","givetake1_a",8.0,-8.0,-1,0,0,false,false,false)
    TaskPlayAnim(l,"mp_common","givetake1_a",8.0,-8.0,-1,0,0,false,false,false)
    Wait(1550)
    DeleteEntity(b)
    ClearPedTasks(pid)
    ClearPedTasks(l)
end

Citizen.CreateThread(function()
	Citizen.Wait(500)
    blip5 = AddBlipForCoord(2088.083, 5183.369, 54.065)
    SetBlipSprite(blip5, 57)
    SetBlipColour(blip5, 2)
    SetBlipScale(blip5, 0.5)
    SetBlipAsShortRange(blip5, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Marul Tarlası")
    EndTextCommandSetBlipName(blip5)
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            for i=1, #locations, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 100 and marulAktif == false then
                DrawMarker(20, locations[i].x, locations[i].y, locations[i].z, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 0, 155, 23, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 1 then
                        ESX.ShowHelpNotification("Marul toplamaya başla ~INPUT_CONTEXT~")
                            if IsControlJustReleased(1, 51) then
                                Animation()
                                marulAktif = true
                            end
                        end
            end
        end
    end
end)


function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   
end

function Animation()
    Citizen.CreateThread(function()
        while impacts < 5 do
            Citizen.Wait(1)
		local ped = PlayerPedId()	
                RequestAnimDict("amb@prop_human_bum_bin@idle_a")
                Citizen.Wait(100)
                FreezeEntityPosition(ped, true)
                TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
                SetEntityHeading(ped, 270.0)
                Citizen.Wait(2500)
                ClearPedTasks(ped)
                impacts = impacts+1
                if impacts == 5 then
                    FreezeEntityPosition(ped, false)
                    marulAktif = false
                    impacts = 0
                    TriggerServerEvent("brky:marulal")
                    break
                end        
        end
    end)
end