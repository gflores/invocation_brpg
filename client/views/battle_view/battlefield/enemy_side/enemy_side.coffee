@EnemyResources = new Meteor.Collection(null)
EnemyResources.insert({
    type: "life"
    minValue: 0
    maxValue: 100
    currentValue: 100
})
GetLife = () ->
    EnemyResources.findOne({type: "life"})

Template.enemySide.helpers({
    GetLifeCurrent: () ->
        GetLife().currentValue
    GetLifeMax: () ->
        GetLife().maxValue
})