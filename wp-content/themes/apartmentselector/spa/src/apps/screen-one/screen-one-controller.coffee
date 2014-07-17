define [ 'extm', 'src/apps/screen-one/screen-one-view' ], ( Extm, ScreenOneView )->

    # Screen one controller
    class ScreenOneController extends Extm.RegionController

        initialize : ->
            @unitTypeCollection = @_getUnitTypeCollection()

            @view = view = @_getUnitTypesView @unitTypeCollection


            @show view

        _getUnitTypesView:(unitTypeCollection)->
            new ScreenOneView
                collection :unitTypeCollection






        _getUnitTypeCollection:->
            Model = Backbone.Model.extend({})

            UnitsCollection = Backbone.Collection.extend(
                model: Model
            )
            modelArray = Array()
            collection = new UnitsCollection()
            units = App.currentStore.unit.where({'status':'Available'})
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



