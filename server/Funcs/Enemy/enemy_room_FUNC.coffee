define("enemy_room_FUNC", ["utils_FUNC", "action_list_FUNC"], (utils_FUNC, action_list_FUNC) ->
    CreateEnemyRoom = (enemyData) ->
        console.log("creating room for #{enemyData.name} !")
        actionList = action_list_FUNC.GenerateEmptyList()
        utils_FUNC.LaunchAsync(() ->
            while (true)
                console.log("#{enemyData.name} running !")
                utils_FUNC.Wait(1000)
        )

    return {
        CreateEnemyRoom: CreateEnemyRoom
    }
)