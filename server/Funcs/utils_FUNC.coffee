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
    RandomInt = (lower, upper=0) ->
        start = Math.random()
        if not lower?
            [lower, upper] = [0, lower]
        if lower > upper
            [lower, upper] = [upper, lower]
        return Math.floor(start * (upper - lower + 1) + lower)

    GetRandomInArray = (array) ->
        array[Math.floor(Math.random() * array.length)]

    GetRandomInHash = (hash) ->
        key = GetRandomInArray(Object.keys(hash))
        [key, hash[key]]

    return {
        Wait: Wait
        LaunchAsync: LaunchAsync
        RandomInt: RandomInt
        GetRandomInArray: GetRandomInArray
        GetRandomInHash: GetRandomInHash
    }
)