define("keys_FUNC", [], () ->
    return {
        GetBattlePlayerSetupKey: (bossName) ->
            "#{bossName}/battle_init"
        GetBattleEventCollectionName: () ->
            "battle_event"
        GetBattleEventPublicationName: (bossName) ->
            "#{bossName}/battle_events"
        GetDataRequestKeys: (key) ->
            {
                collectionName: "#{key}/data_request/collection"
                publicationName: "#{key}/data_request/publication"
            }
    }
)