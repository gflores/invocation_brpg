require(["battle_players_ADPT"], (battle_players_ADPT) ->

    IsPlayerExisting = (index) ->
        battle_players_ADPT.GetCollection().findOne({index: index}).isExisting
    GetCurrentPlayer = (index) ->
        battle_players_ADPT.GetCollection().findOne({index: index})


    Template.playersSide.helpers({
        
    })
    Template.battlefieldPlayer.helpers({
        IsPlayerExisting: () ->
            IsPlayerExisting(this.index)
        GetCurrentPlayer: () ->
            GetCurrentPlayer(this.index)

    })
)