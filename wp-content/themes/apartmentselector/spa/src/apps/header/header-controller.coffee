define [ 'extm', 'src/apps/header/header-view' ], ( Extm, HeaderView )->

    class HeaderController extends Extm.RegionController

        initialize :(opt = {})->
            @wait()

        onComplete :(model)->
            console.log model
            headerView = new HeaderView
                model : model

            @show headerView

    msgbus.registerController 'header', HeaderController