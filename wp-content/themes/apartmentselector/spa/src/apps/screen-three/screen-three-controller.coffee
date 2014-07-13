define [ 'extm', 'src/apps/screen-three/screen-three-view' ], ( Extm, ScreenThreeView )->

    # Screen three controller
    class ScreenThreeController extends Extm.RegionController

        initialize :(opt)->
            @_promises.push App.store.getAllUnits(opt.buildingid,opt.unittypeid,opt.range)
            @wait()

        onComplete :(unitCollection)->
            console.log "aaaaaaaaaaaaaaaaaaa"
            screenThreeView = new ScreenThreeView
                collection : unitCollection


            @listenTo screenThreeView,'childview:childview:main:unit:clicked' , @mainUnitSelected


            @show screenThreeView


        mainUnitSelected:(childview,childview1,unit,unittypeid,range,size)=>
            console.log "hi"
            App.navigate "#screen-four/unit/#{unit}/unittype/#{unittypeid}/range/#{range}/size/#{size}" ,  trigger : true






    msgbus.registerController 'screen:three', ScreenThreeController