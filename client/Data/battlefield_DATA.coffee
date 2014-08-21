define("battlefield_DATA", [], () ->
    enemyAttackCollection = new Meteor.Collection(null)

#
    return {
        enemyAttackCollection: enemyAttackCollection
    }
)