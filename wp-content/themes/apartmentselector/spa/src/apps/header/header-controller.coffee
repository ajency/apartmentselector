define [ 'extm', 'src/apps/header/header-view' ], ( Extm, HeaderView )->

    class HeaderController extends Extm.RegionController

        initialize :(opt = {})->
            @_promises.push App.store.getHeaderView opt
            @wait()

        onComplete :(model)->
            console.log model
            headerView = new HeaderView
                model : model

            @show headerView

    msgbus.registerController 'header', HeaderController