define ['app' , 'backbone'], (App) ->
    App.module "Entities.UnitType", (UnitType, App)->

        #define UnitType Model
        class UnitType extends Backbone.Model

            idAttribute: 'ID'

            defaults:
                name: ''
                nooffloors: ''







            name: 'unitType'


        #define UnitType Collection
        class UnitTypeCollection extends Backbone.Collection

            model: UnitType






            url: -> #necessary
                AJAXURL


        # declare a UnitType collection instance

        unitTypeCollection = new UnitTypeCollection





        # API
        API =
            getUnitTypes: -> #returns a collection of UnitTypes
                jsondata = JSON.parse(UNITTYPE)
                unitTypeCollection.add jsondata
                unitTypeCollection






        # Handlers
        App.reqres.setHandler "get:unittype:collection", ->
            API.getUnitTypes()








