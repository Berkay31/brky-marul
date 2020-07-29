ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("brky:marulal")
AddEventHandler("brky:marulal", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('marul').count < 40 then
                xPlayer.addInventoryItem('marul', math.random(1,5))
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Marul Topladın!' })
            end
        end
    end)

    RegisterNetEvent("brky:hamb")
    AddEventHandler("brky:hamb", function(item, count)
        local _source = source
        local xPlayer  = ESX.GetPlayerFromId(_source)
            if xPlayer ~= nil then
                if xPlayer.getInventoryItem('marul').count > 0 and xPlayer.getInventoryItem('domates').count > 0 and xPlayer.getInventoryItem('ketcap').count > 0 and xPlayer.getInventoryItem('et').count > 0 then
                    xPlayer.removeInventoryItem('marul', 1)
                    xPlayer.removeInventoryItem('domates', 1)
                    xPlayer.removeInventoryItem('ketcap', 1)
                    xPlayer.removeInventoryItem('et', 1)
                    xPlayer.addInventoryItem('hamburger', 1)
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '1 adet Hamburger ürettin!'})
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Üzerinde yeterli malzeme yok!'})
                end
            end
        end)