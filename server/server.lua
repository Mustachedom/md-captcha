local fuckTheseDudes = {
    -- 'license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', -- Example Identifier
}

local function contains(tbl, val)
    for i=1, #tbl do
        if tbl[i] == val then
            return true
        end
    end
    return false
end

RegisterNetEvent('md-captcha:server:loaded', function()
    local src = source
    local id = GetPlayerIdentifierByType(source, 'license')

    if contains(fuckTheseDudes, id) then
        TriggerClientEvent('md-captcha:client:captchaPassed', src)
        return
    end
end)

RegisterCommand('EnableCaptcha', function(source, args, rawCommand)
    local src = source
    if not IsPlayerAceAllowed(src, 'command') then
        TriggerClientEvent('md-captcha:client:captchaPassed', src)
        return
    end
    if args and not args[1] then
        TriggerClientEvent('md-captcha:client:captchaPassed', src)
    end
    local ID = tonumber(args[1])
    if ID then
        TriggerClientEvent('md-captcha:client:captchaPassed', ID)
    end
end, false)