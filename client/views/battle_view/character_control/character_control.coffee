require(["battle_players_ADPT"], (battle_players_ADPT) ->
    Session.set("selected_elemental_tab_index", 0)
    Session.set("is_ability_hovered", false)
    Session.set("hovered_ability_index", 0)

    ElementalNames = ["Fire", "Earth", "Electric", "Water", "Light", "Dark"]
    @PlayerAbilitiesCollection = new Meteor.Collection(null)
#    @CurrentPlayerResources = new Meteor.Collection(null)
    for i in [0..5]
        PlayerAbilitiesCollection.insert({
            category: "elemental#{i}",
            abilities: (for j in [0..3]
                {
                    name: "#{ElementalNames[i]}_#{j + 1}"
                    cost: 20 + j * 10 + i
                    description: "Attack of type #{ElementalNames[i]} Deals #{10+j*5+i*5} damages"
                    index: j
                }
            )
        })
    #     CurrentPlayerResources.insert({
    #         type: "elemental_mana"
    #         index: i
    #         minValue: 0
    #         maxValue: 10
    #         currentValue: 7
    #     })
    # CurrentPlayerResources.insert({
    #     type: "life"
    #     minValue: 0
    #     maxValue: 10
    #     currentValue: 10
    # })

    GetElementalMana = (index) ->
        battle_players_ADPT.GetPlayerMana(Meteor.userId(), index)
#        CurrentPlayerResources.findOne({type: "elemental_mana", index: index})
    GetLife = () ->
        battle_players_ADPT.GetPlayerLife(Meteor.userId())
#        CurrentPlayerResources.findOne({type: "life"})

    TabIsSelected = (index) ->
            index == Session.get("selected_elemental_tab_index")
    Template.characterControl.helpers({
        TestLifeJauge: () ->
            return {
                currentValue: GetLife().currentValue
                maxValue: GetLife().maxValue
            }

        GetSelectedElementalTabIndex: () ->
            Session.get("selected_elemental_tab_index")
        IsSelected: TabIsSelected
        GetElementalNameFromIndex: (index) ->
            ElementalNames[index]
        ElementIndexes: () ->
            [0, 1, 2, 3, 4, 5]
        GetAbilities: () ->
            PlayerAbilitiesCollection.findOne({category: "elemental#{Session.get('selected_elemental_tab_index')}"}
            ).abilities
        ShowAbilityDescription: () ->
            Session.get("is_ability_hovered")
        GetAbilityDescription: () ->
            PlayerAbilitiesCollection.findOne({category: "elemental#{Session.get('selected_elemental_tab_index')}"}
            ).abilities[Session.get("hovered_ability_index")].description
        GetLifeCurrent: () ->
            GetLife().currentValue
        GetLifeMax: () ->
            GetLife().maxValue


    })
    Template.elementalTab.helpers({
        IsSelected: () ->
            if TabIsSelected(this.index)
                "selected"
            else
                null

        GetElementalName: (index) ->
            ElementalNames[index]
        GetElementalManaCurrent: (index) ->
            GetElementalMana(index).currentValue
        GetElementalManaMax: (index) ->
            GetElementalMana(index).maxValue

    })

    characterControlFunctions = {}
    for i in [0..5]
        do (i) ->
            characterControlFunctions["mousedown .elemental-tab#{i}"] = (event) ->
                Session.set("selected_elemental_tab_index", i)
    for i in [0..3]
        do (i) ->
            characterControlFunctions["mouseenter .ability#{i}"] = (event) ->
                Session.set("is_ability_hovered", true)
                Session.set("hovered_ability_index", i)
            characterControlFunctions["mouseleave .ability#{i}"] = (event) ->
                Session.set("is_ability_hovered", false)

    Template.characterControl.events(
        characterControlFunctions
    )
)