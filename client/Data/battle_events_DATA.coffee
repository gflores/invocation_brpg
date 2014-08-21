define("battle_events_DATA", ["keys_FUNC"], (keys_FUNC) ->
    collection = new Meteor.Collection(keys_FUNC.GetBattleEventCollectionName())
#
    return {
        collection: collection
    }
)