define [ 'extm', 'src/apps/screen-four/screen-four-view' ], ( Extm, ScreenFourView )->

    # Screen four controller
    class ScreenFourController extends Extm.RegionController

        initialize :(opt)->
            @wait()

        onComplete :->
            console.log "aaaaaaaaaaaaaaaaaaa"
            screenFourView = new ScreenFourView


            @show screenFourView




    msgbus.registerController 'screen:four', ScreenFourController