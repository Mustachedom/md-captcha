
RegisterNetEvent('md-captcha:client:captchaPassed', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'setVisible',
        data = true
    })
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('md-captcha:server:loaded')
end)

RegisterNetEvent('esx:playerLoaded', function (xPlayer, skin)
    TriggerServerEvent('md-captcha:server:loaded')
end)