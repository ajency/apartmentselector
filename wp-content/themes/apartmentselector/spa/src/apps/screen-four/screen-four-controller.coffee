define [ 'extm', 'src/apps/screen-four/screen-four-view' ], ( Extm, ScreenFourView )->

    # Screen four controller
    class ScreenFourController extends Extm.RegionController

        initialize :(opt)->
            @unitModel = @_getSelelctedUnit()

            @view = view = @_getSelectedUnitView @unitModel



            @show view

        _getSelelctedUnit:->
            console.log "aaaaaaaaaaa"


        _getSelelctedUnit:(unitModel)->
            new ScreenFourView
                model :unitModel




    msgbus.registerController 'screen:four', ScreenFourController