define("battle_events_FUNC",
["utils_FUNC"],
(utils_FUNC) ->

    GenerateBattleEvent = () ->
        events = {}
        events.collection = new Meteor.Collection(null)
        return events

    ScheduleAction = (events, action) ->
        console.log("STARTED: functionId:#{action.functionId}, started:#{action.startDate}, end:#{action.endDate},
         data:#{JSON.stringify(action.data)}")
        Meteor.setTimeout( () ->
            console.log("FINISHED: functionId:#{action.functionId}, data:#{JSON.stringify(action.data)}")
        , action.endDate - action.startDate
        )

    ConstructBattleAction = (actionId, actionData, createdDate, executionDate) ->
        ConstructEvent("battle_action", {
            actionId: actionId
            actionData: actionData
            executionDate: executionDate
        }, createdDate, 1)

    ConstructSetTimeEvent = (currentDate) ->
        ConstructEvent("set_battle_time", {
            currentDate: currentDate
        }, currentDate, 10)

    ConstructEvent = (functionId, data, createdDate, priorityQueue) ->
        {
            functionId: functionId
            data: data
            createdDate: createdDate
            priorityQueue: priorityQueue
        }

    eventFunctions = {
        battle_action: (room, event) ->
            console.log("SCHED ACT: actionId:#{event.data.actionId}, started:#{event.createdDate}, 
                end:#{event.data.executionDate}, data:#{JSON.stringify(event.data.actionData)}")
            utils_FUNC.Wait(event.data.executionDate - room.GetCurrentDate())
            console.log("FINISHED ACT: actionId:#{event.data.actionId},
                data:#{JSON.stringify(event.data.actionData)}")
            room.events.collection.remove({_id: event._id})
        set_battle_time: (_room, event) ->
            console.log("Setting current time: #{event.data.currentDate}")
    }

    RegisterEvent = (room, event) ->
        id = room.events.collection.insert(event)
        event._id = id
        utils_FUNC.LaunchAsync(() ->
            eventFunctions[event.functionId](room, event)
        )
##
    return {
        GenerateBattleEvent: GenerateBattleEvent
        RegisterEvent: RegisterEvent
        ConstructBattleAction: ConstructBattleAction
        ConstructSetTimeEvent: ConstructSetTimeEvent
    }
)