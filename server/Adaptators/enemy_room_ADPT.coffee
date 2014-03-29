define("enemy_room_ADPT", ["enemy_list_DATA", "enemy_room_FUNC"],  (enemy_list_DATA, enemy_room_FUNC) ->
    CreateRooms = () ->
        for enemyData in enemy_list_DATA.enemyList
            enemy_room_FUNC.CreateEnemyRoom(enemyData)
    return {
        CreateRooms: CreateRooms
    }
)