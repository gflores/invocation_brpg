define("current_player_ADPT", ["battle_events_ADPT"], (battle_events_ADPT) ->

    GetLife = () ->
        battle_events_ADPT.GetCollection().findOne({userId: Meteor.userId()})
#
    return {

    }
)