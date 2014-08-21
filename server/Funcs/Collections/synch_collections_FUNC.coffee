define("synch_collections_FUNC", [], () ->
    
    GenerateHandlerForSync = (publisher, cursor, collectionName, observeChange = true) ->
        callbacks = {
            added: (id, fields) ->
                publisher.added(collectionName, id, fields)
            removed: (id) ->
                publisher.removed(collectionName, id)
            changed: (id, fields) ->
                publisher.changed(collectionName, id, fields)
        }
        cursor.observeChanges(callbacks)

#
    return {
        GenerateHandlerForSync: GenerateHandlerForSync
    }
)