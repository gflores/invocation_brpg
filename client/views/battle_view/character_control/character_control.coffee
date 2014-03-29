Session.set("selected_elemental_tab_index", 0)
Session.set("is_ability_hovered", false)
Session.set("hovered_ability_index", 0)

ElementalNames = ["Fire", "Earth", "Electric", "Water", "Light", "Dark"]
@PlayerAbilitiesCollection = new Meteor.Collection(null)
@CurrentPlayerResources = new Meteor.Collection(null)
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
    CurrentPlayerResources.insert({
        type: "elemental_mana"
        index: i
        min_value: 0
        max_value: 10
        current_value: 7
    })
CurrentPlayerResources.insert({
    type: "life"
    min_value: 0
    max_value: 10
    current_value: 10
})

GetElementalMana = (index) ->
    CurrentPlayerResources.findOne({type: "elemental_mana", index: index})
GetLife = () ->
    CurrentPlayerResources.findOne({type: "life"})

TabIsSelected = (index) ->
        index == Session.get("selected_elemental_tab_index")
Template.characterControl.helpers({
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
        GetLife().current_value
    GetLifeMax: () ->
        GetLife().max_value


})
Template.elementalTab.helpers({
    IsSelected: () ->
        TabIsSelected(this.index) ? "id='selected'" : ""
    GetElementalName: (index) ->
        ElementalNames[index]
    GetElementalManaCurrent: (index) ->
        GetElementalMana(index).current_value
    GetElementalManaMax: (index) ->
        GetElementalMana(index).max_value

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