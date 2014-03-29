GetMaxTimeSeconds = () ->
    20
TimePercent = (sec) ->
    (sec / GetMaxTimeSeconds()) * 100

@ActionEventCollection = new Meteor.Collection(null)
@BattleFieldEnemyAttackCollection = new Meteor.Collection(null)
CreateAndLaunchEvent = (event) ->
    id = ActionEventCollection.insert(event)
    intervalId = Meteor.setInterval( () ->
        ActionEventCollection.update({_id: id}, {$inc: {time: -0.1}})
    , 100
    )
    Meteor.setTimeout( () ->
        Meteor.clearInterval(intervalId)
        ActionEventCollection.remove({_id: id})
        idBattleFieldAttack = BattleFieldEnemyAttackCollection.insert(event)
        Meteor.setTimeout( () ->
            BattleFieldEnemyAttackCollection.remove({_id: idBattleFieldAttack})
        , 1000)


#        BattleFieldEnemyAttackCollection.update({_id: idBattleFieldAttack}, {$set: {position_x: -400}})
    , event.time * 1000
    )
    

CreateAndLaunchEvent({time: 8, name: "attack_C"})
CreateAndLaunchEvent({time: 6, name: "attack_B"})
CreateAndLaunchEvent({time: 3, name: "attack_A"})

@TestCollection = new Meteor.Collection(null)
TestCollection.insert({
    type: "life"
    min_value: 0
    max_value: 10
    current_value: 10
})

Template.timeBar.helpers({
    GetEvents: () ->
        ActionEventCollection.find().fetch()
    GetEnemyAttacks: () ->
        BattleFieldEnemyAttackCollection.find().fetch()
})

Template.timeBarMajorGraduation.helpers({
    MaxTimeSeconds: GetMaxTimeSeconds
    TimePercent: TimePercent
})
Template.timeBarEvent.helpers({
    TimePercent: TimePercent
})
Template.battlefieldEnemyAttack.rendered = () ->
    console.log("RENDERED!!!");
    $this = $(this.firstNode)
    $this.css("transition", "all 1s");
    Meteor.setTimeout( () ->
        $this.css("left", "-800%");
    , 1)