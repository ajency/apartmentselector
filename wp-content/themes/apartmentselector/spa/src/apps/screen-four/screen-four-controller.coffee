define [ 'extm', 'src/apps/screen-four/screen-four-view' ], ( Extm, ScreenFourView )->

    # Screen four controller
    class ScreenFourController extends Extm.RegionController

        initialize :(opt)->
            @Collection = @_getSelelctedUnit()

            @layout = new ScreenFourView.ScreenFourLayout()


            @listenTo @layout, "show", @showViews


            @show @layout

        showViews:=>
            @unitCollection = @Collection
            @mainCollection = @Collection
            @showUnitRegion @unitCollection
            @showMainRegion @mainCollection





        showUnitRegion:(unitCollection)->
            itemview1 = @getView unitCollection
            @layout.unitRegion.show itemview1



        showMainRegion:(mainCollection)->
            itemview2 = @getUnitsView mainCollection
            @layout.mainRegion.show itemview2








        getView:(unitCollection)->
            new ScreenFourView.UnitTypeChildView
                collection : unitCollection

        getUnitsView:(mainCollection)->
            new ScreenFourView.UnitTypeView
                collection : mainCollection

        _getSelelctedUnit:->
            units = App.currentStore.unit
            unitsArray = App.currentStore.unit.toArray()
            units.each (item)->

                unitVariantModel = App.currentStore.unit_variant.findWhere({id:item.get('unitVariant')})
                unitTypeModel = App.currentStore.unit_type.findWhere({id:item.get('unitType')})
                item.set 'terracearea' , unitVariantModel.get('terracearea')
                item.set 'sellablearea' , unitVariantModel.get('sellablearea')
                item.set 'carpetarea' , unitVariantModel.get('carpetarea')
                item.set 'unittypename' , unitTypeModel.get('name')






            units









    msgbus.registerController 'screen:four', ScreenFourController