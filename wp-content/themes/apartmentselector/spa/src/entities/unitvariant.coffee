define ['app' , 'backbone'], (App) ->
    App.module "Entities.UnitVariant", (UnitVariant, App)->

        #define UnitVariant Model
        class UnitVariant extends Backbone.Model

            idAttribute: 'ID'

            defaults:
                name: ''
                carpetarea: ''
                sellablearea: ''







            name: 'unitVariant'


        #define UnitVariant Collection
        class UnitVariantCollection extends Backbone.Collection

            model: UnitVariant






            url: -> #necessary
                AJAXURL


        # declare a UnitVariant collection instance

        unitVariantCollection = new UnitVariantCollection





        # API
        API =
            getUnitVariants: -> #returns a collection of UnitVariants
                jsondata = JSON.parse(UNITVARIANT)
                unitVariantCollection.add jsondata
                unitVariantCollection






        # Handlers
        App.reqres.setHandler "get:unitvariant:collection", ->
            API.getUnitVariants()








