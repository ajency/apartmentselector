define ['app' , 'backbone'], (App) ->
    App.module "Entities.Building", (Building, App)->

        #define Building Model
        class Building extends Backbone.Model

            idAttribute: 'ID'

            defaults:
                name: ''
                phase: ''







            name: 'building'


        #define Building Collection
        class BuildingCollection extends Backbone.Collection

            model: Building






            url: -> #ajax call to return a list of all the users from the databse
                AJAXURL


        # declare a building collection instance

        buildingCollection = new BuildingCollection





        # API
        API =
            getBuildings: -> #returns a collection of buildings
                jsondata = JSON.parse(BUILDING)
                buildingCollection.add jsondata
                buildingCollection






        # Handlers
        App.reqres.setHandler "get:building:collection", ->
            console.log "building"
            API.getBuildings()








