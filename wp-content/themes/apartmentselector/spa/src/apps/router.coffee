define [ 'marionette'], ( Marionette )->

    class ApartmentSelector extends Marionette.AppRouter

        appRoutes:
            'wishList' :  'showpopup'
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
            .insideRegion  App.layout.screenOneRegion
                .withOptions()




        show :(params={})->
            console.log "router"
            App.filter(params)
            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions()
            flag = 0
            $.map(App.defaults, (value, index)->
                if value!='All'
                    flag = 1

            )
            if flag == 0
                msgbus.showApp 'main:app'
                .insideRegion  App.mainRegion
                    .withOptions()
                msgbus.showApp 'screen:one'
                    .insideRegion  App.layout.screenOneRegion
                    .withOptions()

            msgbus.showApp 'screen:two'
                .insideRegion  App.layout.screenTwoRegion
                .withOptions()

        showUnits:(params={})->
            App.filter(params={})
            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions()
            flag = 0
            $.map(App.defaults, (value, index)->
                if value!='All'
                    flag = 1

            )
            if flag == 0
                msgbus.showApp 'main:app'
                .insideRegion  App.mainRegion
                    .withOptions()
                msgbus.showApp 'screen:one'
                .insideRegion  App.layout.screenOneRegion
                    .withOptions()
                msgbus.showApp 'screen:two'
                .insideRegion  App.layout.screenTwoRegion
                    .withOptions()

            msgbus.showApp 'screen:three'
            .insideRegion  App.layout.screenThreeRegion
                .withOptions()

        showSelectedUnit:(params={})->

            App.filter(params={})
            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions()
            flag = 0
            $.map(App.defaults, (value, index)->
                if value!='All'
                    flag = 1

            )
            console.log flag
            if flag == 0
                msgbus.showApp 'main:app'
                .insideRegion  App.mainRegion
                    .withOptions()
                msgbus.showApp 'screen:one'
                .insideRegion  App.layout.screenOneRegion
                    .withOptions()
                msgbus.showApp 'screen:two'
                .insideRegion  App.layout.screenTwoRegion
                    .withOptions()
                msgbus.showApp 'screen:three'
                .insideRegion  App.layout.screenThreeRegion
                    .withOptions()
            msgbus.showApp 'screen:four'
            .insideRegion  App.layout.screenFourRegion
                .withOptions()


        showpopup:->
            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions()
            msgbus.showApp 'popup'
            .insideRegion  App.mainRegion
                .withOptions()










    new ApartmentSelector
        controller : RouterAPI