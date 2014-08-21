require(["battle_timer_DATA", "communication_FUNC", "battle_events_ADPT", "keys_FUNC", "battle_players_ADPT"],
(battle_timer_DATA, communication_FUNC, battle_events_ADPT, keys_FUNC, battle_players_ADPT) ->

    battleIdentifier = "Marone"
    battle_players_ADPT.SetupPlayers()
    Meteor.loginVisitor()
    Deps.autorun( () ->
        if (Meteor.userId() != null)
            console.log("id: #{Meteor.userId()}")
            
            communication_FUNC.RequestData(keys_FUNC.GetBattlePlayerSetupKey(battleIdentifier), (data) ->
                console.log(JSON.stringify(data))
                battle_timer_DATA.SetCurrentDate(data.currentDate)
                for id, player of data.players.list
                    battle_players_ADPT.UpdatePlayer(player)

                battle_events_ADPT.SetupBattleEventsSubscription(battleIdentifier)
            )
    )

)