define("enemy_room_FUNC",
["utils_FUNC", "enemy_base_FUNC", "game_resource_FUNC", "battle_events_FUNC", "keys_FUNC", "synch_collections_FUNC",
"communication_FUNC", "battle_player_FUNC"],
(utils_FUNC, enemy_base_FUNC, game_resource_FUNC, battle_events_FUNC, keys_FUNC, synch_collections_FUNC, 
communication_FUNC, battle_player_FUNC) ->

    CreateAttackAction = (room, attackId) ->
        currentDate = room.GetCurrentDate()
        battle_events_FUNC.ConstructBattleAction(attackId, {
            enemyPower: room.currentEnemy.currentPower
        }, currentDate, currentDate + 19000
        )

    SetupMainPublication = (room) ->
        Meteor.publish(keys_FUNC.GetBattleEventPublicationName(room.enemyData.name), () ->
            console.log("received someone !")
            # setTimeEvent = battle_events_FUNC.ConstructSetTimeEvent(room.GetCurrentDate())
            # battle_events_FUNC.RegisterEvent(room, setTimeEvent)
            collectionHandle = synch_collections_FUNC.GenerateHandlerForSync(
                this, room.events.collection.find(), keys_FUNC.GetBattleEventCollectionName(), false)
            this.ready()
            this.onStop( () ->
                console.log("someone  QUITTED !")
                collectionHandle.stop()
            )
        )
        console.log("subscribed to: #{keys_FUNC.GetBattleEventPublicationName(room.enemyData.name)}")

#    OnPlayerConnection = ()
    SetupOnPlayerConnection = (room) ->
        communication_FUNC.HandleDataRequest(keys_FUNC.GetBattlePlayerSetupKey(room.enemyData.name), (userId) ->
            if not battle_player_FUNC.IsRoomFull(room.players) and not battle_player_FUNC.IsPlayerExisting(room.players, userId)
                player = battle_player_FUNC.ConstructPlayer(userId, battle_player_FUNC.GetPlayerNumber(room.players))
                battle_player_FUNC.AddPlayer(room.players, player)
            room.players[userId] = battle_player_FUNC.ConstructPlayer()
            data = {}
            data.currentDate = room.GetCurrentDate()
            data.enemyData = room.enemyData
            data.currentEnemy = room.currentEnemy
            data.players = room.players
            Cleanup = () ->
                console.log("CLEANUPPP !")
                battle_player_FUNC.RemovePlayer(room.players, userId)
            [data, Cleanup]
        )

    CreateEnemyRoom = (enemyData) ->
        console.log("creating room for #{enemyData.name} !")
        room = {}
        room.enemyData = enemyData
        room.currentEnemy = enemy_base_FUNC.GetInitializedEnemy(enemyData)
        room.battleTimer = game_resource_FUNC.ConstructTimedResource(0, 999999999, 0, 1)
        room.events = battle_events_FUNC.GenerateBattleEvent()
        room.GetCurrentDate = () ->
            game_resource_FUNC.UpdateTimedResource(room.battleTimer)
        room.players = battle_player_FUNC.GetInitializedRoomPlayers()
        SetupOnPlayerConnection(room)
        SetupMainPublication(room)
        Meteor.methods

        utils_FUNC.LaunchAsync(() ->
            while (true)
                utils_FUNC.Wait(utils_FUNC.RandomInt(7000, 8000))
                attackId = utils_FUNC.GetRandomInArray(room.currentEnemy.attackIdList)
                action = CreateAttackAction(room, attackId)
                battle_events_FUNC.RegisterEvent(room, action)
#                room.currentEnemy.currentPower += 1
        )

    return {
        CreateEnemyRoom: CreateEnemyRoom
    }
)