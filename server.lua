AddEventHandler('playerConnecting', function(name, setKickReason, defferals)
    local source = source
    local identifiers = GetPlayerIdentifiers(source)
    local steamid
    local discord
    local fivem
    local ip
    for k, v in ipairs(identifiers) do
        if string.match(v, 'steam') then
            steamid = v
        elseif string.match(v, 'discord') then
            discord = v
        elseif string.match(v, 'license') then
            license = v
        end
    end

    if not steamid then
        defferals.done('Du musst Steam geöffnet haben um auf Century spielen zu können')
    else
        defferals.done()

        MySQL.Async.fetchScalar('SELECT 1 from user_identifiers WHERE steamid = @steamid', {
            ['@steamid'] = steamid
        }, function(result)
            if not result then
                MySQL.Async.execute('INSERT INTO user_identifiers (steamid, license, discord) VALUES (@steamid, @license, @discord)',
                {['@steamid'] = steamid, ['@license'] = license, ['@discord'] = discord})
                MySQL.Async.execute('INSERT INTO user_information (steamname, steamid) VALUES (@steamname, @steamid)',
                {['@steamname'] = GetPlayerName(source), ['@steamid'] = steamid})
            end
        end)
    end
end)




RegisterServerEvent('century:spawnPlayer')
AddEventHandler('century:spawnPlayer', function()
    local source = source
    local identifiers = GetPlayerIdentifiers(source)
    for k, v in ipairs(identifiers) do
        if string.match(v, 'steam') then
            steamid = v
            break
        end
    end
    MySQL.Async.fetchAll('SELECT * from user_information WHERE steamid = @steamid' , {
        ['@steamid'] = steamid
    }, function (result)
        local SpawnPos = json.decode(result[1].position)
        TriggerClientEvent('century:lastPosition', source, SpawnPos[1], SpawnPos[2], SpawnPos[3])
    end)
end)

RegisterServerEvent('century:saveLastPosition')
AddEventHandler('century:saveLastPosition', function(PosX, PosY, PosZ)
    local source = source
    local identifiers = GetPlayerIdentifiers(source)
    for k, v in ipairs(identifiers) do
        if string.match(v, 'steam') then
            steamid = v
            break
        end
    end
    MySQL.Async.execute('UPDATE user_information SET position = @position WHERE steamid = @steamid', {
        ['@steamid'] = steamid,
        ['@position'] = '{ ' .. PosX .. ', ' .. PosY .. ', ' .. PosZ .. '}'
    })
end)