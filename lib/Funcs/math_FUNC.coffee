define("math_FUNC", [], ()->
    Clamp = (min, max, value) ->
        Math.max(min, Math.min(max, value))

    return {
        Clamp: Clamp
    }
)