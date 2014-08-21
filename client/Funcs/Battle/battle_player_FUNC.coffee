define("battle_player_FUNC", [], () ->

    ConstructDisconectedPlayer = (index) ->
        {
            index: index
            isExisting: false
        }
#
    return {
        ConstructDisconectedPlayer: ConstructDisconectedPlayer
    }
)