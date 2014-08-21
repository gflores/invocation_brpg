define("battle_events_ADPT",
["time_bar_events_ADPT", "battle_events_DATA", "keys_FUNC", "battle_timer_DATA"],
(time_bar_events_ADPT, battle_events_DATA, keys_FUNC, battle_timer_DATA) ->


    actionFunctions = {

    }

    eventFunctions = {
        battle_action: (event) ->
            time_bar_events_ADPT.AddEvent(event)
            # console.log("SCHED ACT: actionId:#{event.data.actionId}, started:#{event.createdDate}, 
            #     end:#{event.data.executionDate}, data:#{JSON.stringify(event.data.actionData)}")
            # utils_FUNC.Wait(event.data.executionDate - room.GetCurrentDate())
            # console.log("FINISHED ACT: actionId:#{event.data.actionId},
            #     data:#{JSON.stringify(event.data.actionData)}")
            # room.events.collection.remove({_id: event._id})
        set_battle_time: (event) ->
            console.log("Setting current time: #{event.data.currentDate}")
            battle_timer_DATA.SetCurrentDate(event.data.currentDate)
    }

    SetupBattleEventsSubscription = (battleIdentifier) ->
        Meteor.subscribe(keys_FUNC.GetBattleEventPublicationName(battleIdentifier))
        battle_events_DATA.collection.find().observeChanges({
            added: (id, field) ->
                eventFunctions[field.functionId](field)
        })
        console.log("subscribed to: #{keys_FUNC.GetBattleEventPublicationName(battleIdentifier)}")


    return {
        SetupBattleEventsSubscription: SetupBattleEventsSubscription
    }
)