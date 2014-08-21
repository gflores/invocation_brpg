define("battle_player_FUNC", ["game_resource_FUNC"], (game_resource_FUNC) ->

    GetInitializedRoomPlayers = (maxPlayerNumber) ->
        {
            list: {}
            currentPlayerNumber: 0
            maxPlayerNumber: maxPlayerNumber
        }

    AddPlayer = (players, player) ->
        players.list[player.userId] = player
        players.currentPlayerNumber += 1

    RemovePlayer = (players, userId) ->
        delete players.list[userId]
        players.currentPlayerNumber -= 1

    IsRoomFull = (players) ->
        players.currentPlayerNumber >= players.maxPlayerNumber
    IsPlayerExisting = (players, id) ->
        players.list.hasOwnProperty(id)

    ConstructPlayer = (userId, index) ->
        initLife = 10
        initMana = 10
        elementalMana = {}
        for i in [0..5]
            elementalMana["#{i}"] = game_resource_FUNC.ConstructResource(0, initMana, initMana)
        {
            userId: userId
            index: index
            life: game_resource_FUNC.ConstructResource(0, initLife, initLife)
            elementalMana: elementalMana
            isExisting: true
        }
    GetPlayerNumber = (players) ->
        players.currentPlayerNumber
#
    return {
        GetInitializedRoomPlayers: GetInitializedRoomPlayers
        AddPlayer: AddPlayer
        RemovePlayer: RemovePlayer
        IsRoomFull: IsRoomFull
        ConstructPlayer: ConstructPlayer
        GetPlayerNumber: GetPlayerNumber
        IsPlayerExisting: IsPlayerExisting
    }
)