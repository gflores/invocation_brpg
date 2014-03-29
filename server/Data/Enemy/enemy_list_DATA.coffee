define("enemy_list_DATA", [], () ->
    BuildBoss = (name, life, power, attackList) ->
        {
            name: name
            life: life
            power: power
            attackList: attackList
        }
    enemyList = []
    enemyList.push(BuildBoss("Marone", 100, 2, [
        "earth1"
        "fire1"
    ]))
    enemyList.push(BuildBoss("Flendore", 70, 5, [
        "fire1"
    ]))
    return {
        enemyList : enemyList
    }
)