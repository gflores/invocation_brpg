define("enemy_base_FUNC", ["game_resource_FUNC"], (game_resource_FUNC) ->
    GetInitializedEnemy = (enemyData) ->
        {
            life: game_resource_FUNC.ConstructResource(0, enemyData.life, enemyData.life)
            attackIdList: enemyData.attackIdList
            currentPower: enemyData.basePower
        }
#
    return {
        GetInitializedEnemy: GetInitializedEnemy
    }
)