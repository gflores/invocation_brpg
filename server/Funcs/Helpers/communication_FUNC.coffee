define("communication_FUNC", ["keys_FUNC"], (keys_FUNC) ->
    HandleDataRequest = (key, RequestHandler) ->
        keys = keys_FUNC.GetDataRequestKeys(key)
        Meteor.publish(keys.publicationName, () ->
            [dataToSend, CleanupFunction] = RequestHandler(this.userId)
            this.added(keys.collectionName, "uniq", dataToSend)
            this.ready()
            this.onStop(CleanupFunction)
        )
#
    return {
        HandleDataRequest: HandleDataRequest
    }
)