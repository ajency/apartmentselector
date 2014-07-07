define ['app' , 'backbone'], (App) ->
    App.module "Entities.View", (View, App)->

        #define View Model
        class View extends Backbone.Model

            idAttribute: 'ID'

            defaults:
                name: ''








            name: 'view'


        #define View Collection
        class ViewCollection extends Backbone.Collection

            model: View






            url: -> #necessary
                AJAXURL


        # declare a View collection instance

        viewCollection = new ViewCollection





        # API
        API =
            getViews: -> #returns a collection of Views
                jsondata = JSON.parse(VIEW)
                viewCollection.add jsondata
                viewCollection






        # Handlers
        App.reqres.setHandler "get:view:collection", ->
            API.getViews()








