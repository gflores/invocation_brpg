define("game_resource_FUNC", ["math_FUNC"], (math_FUNC) ->

    ConstructResource = (minValue, maxValue, currentValue) ->
        {
            minValue: minValue
            maxValue: maxValue
            currentValue: currentValue
        }
#
    ConstructTimedResource = (minValue, maxValue, currentValue, timeScale) ->
        {
            minValue: minValue
            maxValue: maxValue
            currentValue: currentValue
            lastTime: (new Date).getTime()
            timeScale: timeScale
        }
    UpdateTimedResource = (timedResource) ->
        timeNow = (new Date).getTime()
        deltaTime = timeNow - timedResource.lastTime
        timedResource.lastTime = timeNow
        timedResource.currentValue = math_FUNC.Clamp(
            timedResource.minValue,
            timedResource.maxValue,
            timedResource.currentValue + (timedResource.timeScale * deltaTime)
        )

    GetInCollection = (collection, request, resourceField) ->
        bracketAccessor = resourceField.split(".").map((x) -> "['#{x}']").join("")
        str = "collection.findOne(request, {fields: {'#{resourceField}': 1}})#{bracketAccessor}"
#        console.log(str)
        eval(str)

    SetInCollection = (collection, request, resourceField, val) ->
        collection.update(request, $set: {resourceField: val})

    UpdateTimedInCollection = (collection, request, resourceField) ->
        resource = GetInCollection(collection, request, resourceField)
        currValue = UpdateTimedResource(resource)
        SetInCollection(collection, request, resourceField, resource)
        currValue

    return {
        ConstructResource: ConstructResource
        ConstructTimedResource: ConstructTimedResource
        UpdateTimedResource: UpdateTimedResource
        GetInCollection: GetInCollection
        SetInCollection: SetInCollection
        UpdateTimedInCollection: UpdateTimedInCollection
    }
)