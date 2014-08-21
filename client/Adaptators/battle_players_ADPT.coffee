define("battle_players_ADPT",
["battle_players_DATA", "battle_player_FUNC", "game_resource_FUNC"],
(battle_players_DATA, battle_player_FUNC, game_resource_FUNC) ->

    SetupPlayers = () ->
        for i in [0..3]
            battle_players_DATA.collection.insert(battle_player_FUNC.ConstructDisconectedPlayer(i))

    UpdatePlayer = (player) ->
        console.log("updating player #{player.index}")
        battle_players_DATA.collection.update({index: player.index}, {$set: player})

    GetPlayerLife = (playerId) ->
        try
            game_resource_FUNC.GetInCollection(battle_players_DATA.collection, {userId: playerId}, "life")
        catch err
            -42
         
    GetPlayerMana = (playerId, manaIndex) ->
        try
            game_resource_FUNC.GetInCollection(battle_players_DATA.collection, {userId: playerId},
                "elementalMana.#{manaIndex}")
        catch err
            -42

    return {
        GetCollection: () ->
            battle_players_DATA.collection
        SetupPlayers: SetupPlayers
        UpdatePlayer: UpdatePlayer
        GetPlayerLife: GetPlayerLife
        GetPlayerMana: GetPlayerMana
    }
)