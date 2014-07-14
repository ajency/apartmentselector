define [ 'extm', 'src/apps/screen-two/screen-two-view' ], ( Extm, ScreenTwoView )->

    # Screen two controller
    class ScreenTwoController extends Extm.RegionController

        initialize : (opt)->
            console.log opt.unittypeid
            @_promises.push App.store.getUnits opt.unittypeid
            @wait()

        onComplete :(unitCollection)->
            screenTwoView = new ScreenTwoView
                collection : unitCollection


            @listenTo screenTwoView, 'childview:childview:type:unit:clicked', @typeUnitSelected


            @show screenTwoView

        typeUnitSelected:( childView, childview,buildingId, unitType,range )=>
            App.navigate "#screen-three/unittype/#{unitType}/range/#{range}/building/#{buildingId}" ,  trigger :true



    msgbus.registerController 'screen:two', ScreenTwoController