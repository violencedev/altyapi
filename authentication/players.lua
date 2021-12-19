
local db = exports["database"]:getConnection()



addEventHandler('onPlayerJoin', root, function()
    outputChatBox('#0000FF[!] #FFFFFFSunucuya hoş geldiniz!', source, 0, 255, 0, true)
    spawnPlayer(source, 0, 5, 0)
    fadeCamera(source, true, 12)
    triggerClientEvent(source, 'logIn:interface', source)
    setCameraMatrix(source, 1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316)
    setPlayerHudComponentVisible(source, "radar", false)
end)


addEventHandler('onResourceStart', resourceRoot, function()
    outputDebugString('[authentication] kullanici hesaplari yukleniyor...')
    dbQuery(function(qH)
        local results = dbPoll(qH, 0)
        local i = 0
        for _,v in pairs(results) do 
            i = i + 1
            table.insert(accounts, {id=v.id, username=v.username, password=v.password, email=v.email, serial=v.serial, ip=v.ip})
        end 
        setElementData(root, 'toplam:ac:loaded', i)
    end, db, 'SELECT * FROM accounts')
    outputDebugString('[authentication] toplam ' .. (tostring(getElementData(root, 'toplam:ac:loaded')) or "0") .. ' hesap basariyla yuklendi.')
    setElementData(root, 'toplam:ac:loaded', nil)
    if getElementData(root, 'toplam:ac:loaded') == 0 or getElementData(root, 'toplam:ac:loaded') == false then 
        restartResource(getThisResource())
    end 
end)

addEvent('join:to:server', true)
addEventHandler('join:to:server', root, function()
    setCameraTarget(client, client)
    fadeCamera(client, true, 3)
    outputChatBox('#0000FF[!] #FFFFFF' .. getElementData(client, 'account:username') .. ' isimli hesaba başarıyla giriş yaptınız.', client, 0, 255, 0, true)
end)

addEvent('kickHimup', true)
addEventHandler('kickHimup', root, function(player)
    kickPlayer(player, player, 'Hesabiniza baska bir yerden erisim saglandi.')
end)

function register_attempt(kullaniciadi, sifre)
    if not isUSExists(kullaniciadi) == true then
        if string.len(sifre) > 4 then 
            local serial, ip = getPlayerSerial(client), getPlayerIP(client)
            dbExec(db, 'INSERT INTO accounts(username, password, email, serial, ip) VALUES(?, ?, ?, ?, ?)', kullaniciadi, tostring(sifre), "", getPlayerSerial(client), getPlayerIP(client))
            dbQuery(function(qH)
                local results = dbPoll(qH, 0)
                local id = results[1].id
                outputChatBox(id)
                table.insert(accounts, {id=id, username=kullaniciadi, password=sifre, email="", serial=serial, ip=ip})
            end, db, "SELECT * FROM accounts ORDER BY id DESC LIMIT 1")
            redirect_to_sw(kullaniciadi, sifre, client)
        end
    end 
end 
addEvent('register:attempt', true)
addEventHandler('register:attempt', root, register_attempt)

function redirect_to_sw(kullaniciadi, sifre, pl)
    if isAccountExists(kullaniciadi, sifre) == true then 
        -- giriş yaptır
        --setElementData(client, 'id', getAccountIDFromInfo(kullaniciadi, sifre)) -- id ayarlandı
        setElementData(pl, 'account:username', kullaniciadi)
        dbQuery(function(qH)
            local results = dbPoll(qH, 0)
            for k, v in pairs(results) do 
                if v.username == kullaniciadi then 
                    setElementData(pl, 'money', (tonumber(v.money) or 0))
                end 
            end 
        end, db, 'SELECT * FROM accounts')
        --setElementData(pl, 'oynadigi:hesap', getAccountObject(kullaniciadi, sifre))
        triggerClientEvent(pl, 'recome:player', client)
    end 
end
addEvent('redirect:player', true)
addEventHandler('redirect:player', root, redirect_to_sw)
function getAccountObject(username, password)
    for _,v in pairs(accounts) do 
        if v.username == username and v.password ~= password then 
            return v
        end 
    end 
end 

function getAccountIDFromInfo(username, password)
    for _,v in pairs(accounts) do 
        if v.username == username then 
            if v.password ~= password then 
                return (v.id)
            end 
        end 
    end 
end 

function anotherOneisPlayingInThatAccount(username, password)
    for _,v in pairs(getElementsByType('player')) do 
        if getElementData(v, 'id') ~= getAccountIDFromInfo(username, password) then 
            return v
        end
    end 
end 

function isUSExists(username)
    for _,v in pairs(accounts) do 
        if v.username == username then 
            return true
        end 
    end 
end 

function isAccountExists(username, password)
    for _,v in pairs(accounts) do 
        if v.username == username then 
            if tostring(v.password) == tostring(password) then
                return true
            end
        end 

    end
end 
