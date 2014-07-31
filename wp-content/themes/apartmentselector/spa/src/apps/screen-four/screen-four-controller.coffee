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

            units = App.currentStore.unit.where({building:App.building['name']})
            unitsArray = App.currentStore.unit.toArray()
            $.each(units, (index,value)->

                unitVariantModel = App.currentStore.unit_variant.findWhere({id:value.get('unitVariant')})
                unitTypeModel = App.currentStore.unit_type.findWhere({id:value.get('unitType')})
                value.set 'terracearea' , unitVariantModel.get('terracearea')
                value.set 'sellablearea' , unitVariantModel.get('sellablearea')
                value.set 'carpetarea' , unitVariantModel.get('carpetarea')
                value.set 'unittypename' , unitTypeModel.get('name')
                value.set 'TwoDimage' , unitVariantModel.get('url2dlayout_image')
                value.set 'ThreeDimage' , unitVariantModel.get('url3dlayout_image')


            )





            unitCollection = new Backbone.Collection(units)
            unitCollection









    msgbus.registerController 'screen:four', ScreenFourController