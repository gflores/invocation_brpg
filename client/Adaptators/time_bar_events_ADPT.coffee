define("time_bar_events_ADPT",
["time_bar_events_DATA", "battlefield_DATA", "battle_timer_DATA"],
(time_bar_events_DATA, battlefield_DATA, battle_timer_DATA) ->

    ConstructEvent = (event) ->
        {
            name: "#{event.data.actionId} | #{event.data.actionData.enemyPower}"
            time: event.data.executionDate - battle_timer_DATA.GetCurrentDate()
        }

    AddEvent = (event) ->
        id = time_bar_events_DATA.collection.insert(ConstructEvent(event))
        intervalId = Meteor.setInterval( () ->
            time_bar_events_DATA.collection.update({_id: id}, {$set:
                {time: event.data.executionDate - battle_timer_DATA.GetCurrentDate()}})
        , 100
        )
        Meteor.setTimeout( () ->
            Meteor.clearInterval(intervalId)
            time_bar_events_DATA.collection.remove({_id: id})
            idBattleFieldAttack = battlefield_DATA.enemyAttackCollection.insert(event)
            Meteor.setTimeout( () ->
                battlefield_DATA.enemyAttackCollection.remove({_id: idBattleFieldAttack})
            , 1000)


    #        BattleFieldEnemyAttackCollection.update({_id: idBattleFieldAttack}, {$set: {position_x: -400}})
        , event.data.executionDate - battle_timer_DATA.GetCurrentDate()
        )


#
    return {
        AddEvent: AddEvent
        GetCollection: () ->
            time_bar_events_DATA.collection
    }
)