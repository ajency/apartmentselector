define [ 'extm', 'src/apps/header/header-view' ], ( Extm, HeaderView )->

    class HeaderController extends Extm.RegionController

        initialize :(opt = {})->
            @wait()

        onComplete : ->
            @show new HeaderView

    msgbus.registerController 'header', HeaderController