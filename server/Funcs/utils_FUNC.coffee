define("utils_FUNC", [], () ->
    Wait = (time) ->
        Async.runSync((done) ->
            Meteor.setTimeout(() ->
                done(null, 0)
            , time)
        )
    LaunchAsync = (func) ->
        Meteor.setTimeout(func, 1)

    #Seems to be useless??
    # LaunchAndWait = (func) ->
    #     response = Async.runSync((done) ->
    #         res = func()
    #         done(null, res)
    #     )
    #     response.result
    return {
        Wait: Wait
        LaunchAsync: LaunchAsync
        # LaunchAndWait: LaunchAndWait
    }
)