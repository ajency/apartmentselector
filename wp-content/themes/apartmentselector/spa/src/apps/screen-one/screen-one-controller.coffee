define [ 'extm', 'src/apps/screen-one/screen-one-view' ], ( Extm, ScreenOneView )->

   # Screen one controller
   class ScreenOneController extends Extm.RegionController

      initialize : ->
         @_promises.push App.store.getUnitTypes()
         @wait()

      onComplete : ( unitTypesCollection )->
         screenOneView = new ScreenOneView
                  collection : unitTypesCollection

         @listenTo screenOneView, 'childview:unit:type:clicked', @unitTypeClicked

         @show screenOneView

      unitTypeClicked : ( childView, unitTypeId )=>
         App.navigate "#/screen-two/unittype:#{unitTypeId}"

   msgbus.registerController 'screen:one', ScreenOneController