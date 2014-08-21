define("battle_timer_DATA", ["game_resource_FUNC"], (game_resource_FUNC) ->
    battleTimer = game_resource_FUNC.ConstructTimedResource(0, 999999999, 0, 1)

    GetCurrentDate = () ->
        game_resource_FUNC.UpdateTimedResource(battleTimer)

    SetCurrentDate = (currentDate) ->
        battleTimer.currentValue = currentDate
        battleTimer.lastTime = (new Date).getTime()
        
    return {
        GetCurrentDate: GetCurrentDate
        SetCurrentDate: SetCurrentDate
    }
)