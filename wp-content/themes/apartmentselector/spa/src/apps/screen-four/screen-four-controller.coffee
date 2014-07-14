define [ 'extm', 'src/apps/screen-four/screen-four-view' ], ( Extm, ScreenFourView )->

    # Screen four controller
    class ScreenFourController extends Extm.RegionController

        initialize :(opt)->
            console.log opt
            @_promises.push App.store.getSingleUnit opt.unit
            @wait()

        onComplete :(model)->
            screenFourView = new ScreenFourView
                model : model


            @show screenFourView




    msgbus.registerController 'screen:four', ScreenFourController