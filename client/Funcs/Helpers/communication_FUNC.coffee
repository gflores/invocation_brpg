define("communication_FUNC", ["keys_FUNC"], (keys_FUNC) ->
    RequestData = (key, DataHandler) ->
        keys = keys_FUNC.GetDataRequestKeys(key)
        collection = new Meteor.Collection(keys.collectionName)
        Meteor.subscribe(keys.publicationName)
        collection.find().observeChanges({
            added: (id, field) ->
                DataHandler(field)
        })
#
    return {
        RequestData: RequestData
    }
)