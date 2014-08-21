require(["time_bar_events_ADPT", "battlefield_ADPT"], (time_bar_events_ADPT, battlefield_ADPT) ->

    GetMaxTimeSeconds = () ->
        20
    TimePercent = (sec) ->
        (sec / GetMaxTimeSeconds()) * 100
    TimePercentMillisecond = (sec) ->
        (sec / GetMaxTimeSeconds()) * 100 / 1000

    # @ActionEventCollection = new Meteor.Collection(null)
    # @BattleFieldEnemyAttackCollection = new Meteor.Collection(null)
    
    # CreateAndLaunchEvent = (event) ->
    #     id = ActionEventCollection.insert(event)
    #     intervalId = Meteor.setInterval( () ->
    #         ActionEventCollection.update({_id: id}, {$inc: {time: -0.1}})
    #     , 100
    #     )
    #     Meteor.setTimeout( () ->
    #         Meteor.clearInterval(intervalId)
    #         ActionEventCollection.remove({_id: id})
    #         idBattleFieldAttack = BattleFieldEnemyAttackCollection.insert(event)
    #         Meteor.setTimeout( () ->
    #             BattleFieldEnemyAttackCollection.remove({_id: idBattleFieldAttack})
    #         , 1000)


    # #        BattleFieldEnemyAttackCollection.update({_id: idBattleFieldAttack}, {$set: {position_x: -400}})
    #     , event.time * 1000
    #     )
        

    # CreateAndLaunchEvent({time: 8, name: "attack_C"})
    # CreateAndLaunchEvent({time: 6, name: "attack_B"})
    # CreateAndLaunchEvent({time: 3, name: "attack_A"})

    @TestCollection = new Meteor.Collection(null)
    TestCollection.insert({
        type: "life"
        minValue: 0
        maxValue: 10
        currentValue: 10
    })

    Template.timeBar.helpers({
        GetEvents: () ->
            time_bar_events_ADPT.GetCollection().find().fetch()
        GetEnemyAttacks: () ->
            battlefield_ADPT.GetEnemyAttackCollection.find().fetch()
    })

    Template.timeBarMajorGraduation.helpers({
        MaxTimeSeconds: GetMaxTimeSeconds
        TimePercent: TimePercent
    })
    Template.timeBarEvent.helpers({
        TimePercent: TimePercent
        TimePercentMillisecond: TimePercentMillisecond
    })
    Template.battlefieldEnemyAttack.rendered = () ->
        console.log("RENDERED!!!");
        $this = $(this.firstNode)
        $this.css("transition", "all 1s");
        Meteor.setTimeout( () ->
            $this.css("left", "-800%");
        , 1)
)