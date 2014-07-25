define [ 'marionette'], ( Marionette )->

    class ApartmentSelector extends Marionette.AppRouter

        appRoutes:
            'screen-three' : 'showUnits'
            'screen-two'  : 'show'
            'screen-one'  : 'showValues'
            'screen-one/:params' : 'showValues'
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
            console.log 'qqqqqqqqqqqqq'
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

        showSelectedUnit:(unit,unittypeid,range,size)->

            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions({unit:unit,unittypeid:unittypeid,range:range,size:size})
            msgbus.showApp 'screen:four'
            .insideRegion  App.mainRegion
                .withOptions({unit:unit,unittypeid:unittypeid,range:range,size:size})










    new ApartmentSelector
        controller : RouterAPI