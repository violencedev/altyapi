accounts = {}
guncellemeyazisi = "11.12.2021 - violence colab. \n\nSunucu ve paketin temelleri atılmaya başlandı, authentication sistemi sıfırdan eksiksizce yazıldı."
sunucu_hakkinda_yazisi = "| violence development |\n\nSunucumuz, xxx tarihinde açılarak MTA piyasasına ilk adımını atmıştır..... \n\nPara Kazanma Yolları : \n\n- İş Yapma\n-Adam Öldürme \n\nSistemler Hakkında :\n\nSistemlerimiz tamamen sıfırdan yazılmaktadır.\n\nSunucu Discord : discord.gg/xxxroleplay\nSunucu FB :\nSunucu IG :"

local sx, sy = guiGetScreenSize()

panel = guiCreateWindow(sx * (845 / 1920), sy * (431 / 1080), sx * (230 / 1920), sy * (203 / 1080), "Giriş Arayüzü", false) 
-- 
guiWindowSetSizable(panel, false)
guiWindowSetMovable(panel, false)
username = guiCreateEdit(sx * (51 / 1920), sy * (40 / 1080), sx * (128 / 1920), sy * (34 / 1080), "Kullanıcı adınız", false, panel)
password = guiCreateEdit(sx * (51 / 1920), sy * (84 / 1080), sx * (128 / 1920), sy * (34 / 1080), "Şifreniz", false, panel)
logIn = guiCreateButton(sx * (9 / 1920), sy * (124 / 1080), sx * (210 / 1920), sy * (32 / 1080), "Giriş Yap!", false, panel)
signUp = guiCreateButton(sx * (9 / 1920), sy * (161 / 1080), sx * (104 / 1920), sy * (32 / 1080), "Kayıt Ol!", false, panel)
guiEditSetMasked(password, true)
forgotPassword = guiCreateButton(sx * (115 / 1920), sy * (161 / 1080), sx * (104 / 1920), sy * (32 / 1080), "Şifremi Unuttum!", false, panel)
warningLabel = guiCreateLabel(sx * (3 / 1920), sy * (23 / 1080), sx * (222 / 1920), sy * (17 / 1080), "", false, panel)
guiLabelSetHorizontalAlign(warningLabel, "center", true)    
guiSetInputMode('no_binds_when_editing')
guncellemeler = guiCreateWindow(sx * (517 / 1920), sy * (312 / 1080), sx * (326 / 1920), sy * (455 / 1080), "Güncellemeler & Haberler", false)
-- 1920 - 326
guiWindowSetSizable(guncellemeler, false)

yazi = guiCreateMemo(sx * (9 / 1920), sy * (26 / 1080), sx * (307/1920), sy*(419/1080), "", false, guncellemeler)
guiMemoSetReadOnly(yazi, true)


muzikkontrol = guiCreateWindow(sx*(845 / 1920), sy*(638 / 1080), sx*(230 / 1920), sy*(128/1080), "Müzik Kontrol Paneli", false)
guiWindowSetSizable(muzikkontrol, false)
guiWindowSetMovable(muzikkontrol, false)
guiWindowSetMovable(guncellemeler, false)

myazi = guiCreateLabel(sx * (9 / 1920), sy * (28 / 1080), sx * (206 / 1920), sy * (40/1080), "Şu an çalan müzik : Juice WRLD - Lean Wit Me", false, muzikkontrol)
guiLabelSetHorizontalAlign(myazi, 'left', true)
mchange = guiCreateButton(sx * (9 / 1920), sy * (69 / 1080), sx * (120 / 1920), sy * (35 / 1080), "Müziği Değiştir", false, muzikkontrol)
mlevel = guiCreateEdit(sx * (138 / 1920), sy * (69 / 1080), sx * (82 / 1920), sy * (35 / 1080), "100", false, muzikkontrol)

logo = guiCreateStaticImage(sx * (796 / 1920) , sy * (183/1080), sx * (320/1920), sy *(342/1080), ":authentication/violence.png", false)   

-- sunucu tanıtımı
aboutserver = guiCreateWindow(sx * (1077 / 1920) , sy * (312 / 1080), sx * (326 / 1920), sy * (455 / 1080), "Sunucu Hakkında", false)
guiWindowSetMovable(aboutserver, false)
guiWindowSetSizable(aboutserver,false)

text = guiCreateMemo(sx* (9 / 1920), sy * (26 / 1080), sx * (307 / 1920), sx * (419 / 1080), "", false, aboutserver)
guiMemoSetReadOnly(text, true)

guiSetVisible(panel, false)
guiSetVisible(logo, false)
guiSetVisible(muzikkontrol, false)
guiSetVisible(guncellemeler, false)
guiSetVisible(aboutserver, false)

function girisArayuzu()
        local kaynak = "1"
        local sound = playSound('1.mp3', true)
        guiSetText(text, sunucu_hakkinda_yazisi)
        setSoundVolume(sound, 1)
        setElementData(getLocalPlayer(), 'sound', sound)
        showCursor(true)
        showChat(false)
        guiSetVisible(panel, true)
        guiSetVisible(logo, true)
        guiSetVisible(muzikkontrol, true)
        guiSetVisible(aboutserver, true)
        guiSetVisible(guncellemeler, true)
        guiSetText(yazi, guncellemeyazisi)
        addEventHandler('onClientGUIClick', getRootElement(), function(state)    
                if source == logIn then 
                    -- giriş denetlemesi
                    local kullaniciadi, sifre = guiGetText(username), guiGetText(password)
                    triggerServerEvent('redirect:player', getLocalPlayer(), kullaniciadi, sifre, getLocalPlayer())
                elseif source == signUp then 
                    local kullaniciadi, sifre = guiGetText(username), guiGetText(password)
                    triggerServerEvent('register:attempt', getLocalPlayer(), kullaniciadi, sifre)
                elseif source == mchange then 
                    stopSound(sound)
                    if tonumber(kaynak) == 1 then 
                        sound = playSound("2.mp3", true)
                        guiSetText(myazi, 'Şu an çalan müzik : The Kid LAROI - Not Sober')
                        kaynak = 2
                    elseif tonumber(kaynak) == 2 then 
                        sound = playSound("3.mp3", true)
                        guiSetText(myazi, 'Şu an çalan müzik : XXXTENTACION - Look At Me')
                        kaynak = 3
                    else 
                        sound = playSound("1.mp3", true)
                        guiSetText(myazi, 'Şu an çalan müzik : Juice WRLD - Lean Wit Me')
                        kaynak = 1
                    end 
                    setSoundVolume(sound, 1)
                    setElementData(getLocalPlayer(), 'sound', sound)
                end 
            
        end)
        addEventHandler('onClientGUIChanged', mlevel, function()
            if not tonumber(guiGetText(mlevel)) then 
                guiSetText(mlevel, "100")
                setSoundVolume(sound, 1)
            return end
            if tonumber(guiGetText(mlevel)) > 100 or tonumber(guiGetText(mlevel)) < 0 then 
                guiSetText(mlevel, "100")
                setSoundVolume(sound, 1)
            return end 
            setSoundVolume(sound, tonumber(guiGetText(mlevel)) / 100)
        end)
        
end 
addEvent('logIn:interface', true)
addEventHandler('logIn:interface', root, girisArayuzu)



addEvent('recome:player', true)
addEventHandler('recome:player', root, function()
    guiSetVisible(panel, false)
    guiSetVisible(logo, false)
    guiSetVisible(muzikkontrol, false)
    guiSetVisible(guncellemeler, false)
    guiSetVisible(aboutserver, false)
    showCursor(false)
    showChat(true)
    stopSound(getElementData(getLocalPlayer(), 'sound'))
    guiSetInputMode('allow_binds')
    triggerServerEvent('join:to:server', getLocalPlayer())
end)

