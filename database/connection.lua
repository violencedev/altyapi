local database_connection 

addEventHandler('onResourceStart', resourceRoot, function()
    database_connection = dbConnect('sqlite', ':/global.db')
    if database_connection then 
        outputDebugString('SQLite baglantisi basariyla saglandi.', 3, 0, 255, 0)
    else 
        outputDebugString('SQLite baglantisi saglanirken bir hata meydana geldi!', 1, 255, 0, 0)
    end 
end)

getConnection = function()
    return database_connection
end 