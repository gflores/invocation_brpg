define("action_list_FUNC", [], () ->
    GenerateEmptyList = () ->
        {
            list: []
        }
    AddAction = (actionList, action) ->
        Meteor.setTimeout( () ->
            console.log("functionId: #{action.functionId}")
        , action.endDate - action.startDate
        )

##
    return {
        GenerateEmptyList: GenerateEmptyList
        AddAction: AddAction
    }
)