@EnemyResources = new Meteor.Collection(null)
EnemyResources.insert({
    type: "life"
    min_value: 0
    max_value: 100
    current_value: 100
})
GetLife = () ->
    EnemyResources.findOne({type: "life"})

Template.enemySide.helpers({
    GetLifeCurrent: () ->
        GetLife().current_value
    GetLifeMax: () ->
        GetLife().max_value
})