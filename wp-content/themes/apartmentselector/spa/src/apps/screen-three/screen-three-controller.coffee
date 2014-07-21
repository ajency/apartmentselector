define [ 'extm', 'src/apps/screen-three/screen-three-view' ], ( Extm, ScreenThreeView )->

    # Screen three controller
    class ScreenThreeController extends Extm.RegionController

        initialize :()->
            @unitsCollection = @_getUnits()

            @view = view = @_getUnitsView @unitsCollection



            @show view

        _getUnitsView:(unitsCollection)->
            new ScreenThreeView
                collection :unitsCollection

        _getUnits:->
            unitCollection = App.currentStore.unit
            floorCollection = App.currentStore.unit.pluck('floor')
            uniqueFloors = _.uniq(floorCollection)

            floorArray = Array()
            $.each(uniqueFloors, (index,value)->
                unitArray = Array()
                unitCollection.each (item)->
                    if parseInt(value) == parseInt(item.get('floor'))
                        variantModel = App.currentStore.unit_variant.findWhere({id:item.get('unitVariant')} )
                        item.set 'variantModel',variantModel.get 'sellablearea'
                        viewModel = App.currentStore.view.findWhere({id:item.get('view')} )
                        item.set 'view_name',viewModel.get 'name'
                        unitArray.push(item)




                collection = new Backbone.Collection(unitArray)
                floorArray.push({floorid:value,units:collection})




            )
            unitcollection = new Backbone.Collection(floorArray)
            unitcollection





        mainUnitSelected:(childview,childview1,unit,unittypeid,range,size)=>
            console.log "hi"
            App.navigate "#screen-four/unit/#{unit}/unittype/#{unittypeid}/range/#{range}/size/#{size}" ,  trigger : true






    msgbus.registerController 'screen:three', ScreenThreeController