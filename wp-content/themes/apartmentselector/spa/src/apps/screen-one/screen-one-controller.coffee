define [ 'extm', 'src/apps/screen-one/screen-one-view' ], ( Extm, ScreenOneView )->

    # Screen one controller
    class ScreenOneController extends Extm.RegionController

        initialize : ->
            console.log "wwwwwwwwwwww"
            @unitTypeCollection = @_getUnitTypeCollection()

            @view = view = @_getUnitTypesView @unitTypeCollection

            if(window.location.href.indexOf('=') > -1)
                console.log "not"
            else
                App.navigate "screen-one" , trigger:true

            @listenTo view, "unit:type:clicked", @_unitTypeClicked

            @show view

        _getUnitTypesView:(unitTypeCollection)->
            new ScreenOneView
                collection :unitTypeCollection


        _unitTypeClicked:=>
            console.log "wwwwwwwwwwww"
            App.navigate "screen-two" , trigger:true






        _getUnitTypeCollection:->
            Model = Backbone.Model.extend({})

            UnitsCollection = Backbone.Collection.extend(
                model: Model
            )
            modelArray = Array()
            collection = new UnitsCollection()
            status = App.currentStore.status.findWhere({'name':'Available'})

            units = App.currentStore.unit.where({'status':status.get('id')})
            priceUnits = App.currentStore.unit
            priceUnits.each ( item)->
                #calculating the price value
                buildingModel = App.currentStore.building.findWhere({'id':item.get 'building'})
                floorRise = buildingModel.get 'floor'
                floorRiseValue = floorRise[item.get 'floor']
                unitTypemodel = App.currentStore.unit_variant.findWhere({'id':item.get 'unitVariant'})
                unitPrice = ( 1000 + parseInt(floorRiseValue)) * parseInt(unitTypemodel.get 'sellablearea')
                item.set({'unitPrice' , unitPrice})
                #calculating the price value




            units = App.currentStore.unit.where({'status':status.get('id')})
            $.each(units , (index,value)->
                unitTypemodel = App.currentStore.unit_type.findWhere({'id':value.get 'unitType'})
                NewUnitCollection = App.currentStore.unit.where({ unitType : unitTypemodel.get( 'id' ) } )
                max_coll = Array()
                $.each(NewUnitCollection , (index,value)->
                    Variant = App.currentStore.unit_variant.findWhere({ 'id' : value.get( 'unitVariant' ) } )
                    max_coll.push Variant.get 'sellablearea'




                )
                max_val = Math.max.apply( Math, max_coll )
                min_val = Math.min.apply( Math, max_coll )
                #set max and min attribute to the unit type model
                unitTypemodel.set( { 'max_value' : max_val, 'min_value' : min_val } )
                modelArray.push unitTypemodel
                #console.log modelArray









            )
            collection.add modelArray
            collection






    msgbus.registerController 'screen:one', ScreenOneController



