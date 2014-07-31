define [ 'marionette'], ( Marionette )->

    class ApartmentSelector extends Marionette.AppRouter

        appRoutes:
            'screen-four' : 'showSelectedUnit'
            'screen-three' : 'showUnits'
            'screen-two'  : 'show'
            'screen-one'  : 'showValues'
            ':params' : 'showValues'
            #':params' : 'show'
            'screen-two/:params'  : 'show'

            'screen-three/:params' : 'showUnits'
            'screen-four/:params' : 'showSelectedUnit'








    RouterAPI =
    #Start Sub App
        showValues:(params={})->
            App.filter(params)
            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions()
            msgbus.showApp 'screen:one'
            .insideRegion  App.mainRegion
                .withOptions()




        show :(params={})->
            App.filter(params)
            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions()
            msgbus.showApp 'screen:two'
                .insideRegion  App.mainRegion
                .withOptions()

        showUnits:(params={})->
            App.filter(params={})
            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions()
            msgbus.showApp 'screen:three'
            .insideRegion  App.mainRegion
                .withOptions()

        showSelectedUnit:(params={})->

            App.filter(params={})
            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions()
            msgbus.showApp 'screen:four'
            .insideRegion  App.mainRegion
                .withOptions()


        showpopup:->
            msgbus.showApp 'popup'
            .insideRegion  App.mainRegion
                .withOptions()










    new ApartmentSelector
        controller : RouterAPI