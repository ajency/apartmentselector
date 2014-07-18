define [ 'extm', 'src/apps/screen-two/screen-two-view' ], ( Extm, ScreenTwoView )->

    # Screen two controller
    class ScreenTwoController extends Extm.RegionController

        initialize : ()->

            @layout = new ScreenTwoView.ScreenTwoLayout()



            @unitsCountCollection = @_getUnitsCountCollection()

            @view = view = @_getUnitTypesCountView @unitsCountCollection

            @listenTo @layout , "show", =>

                console.log view.buildingRegion

            @show @view

        _getUnitTypesCountView:(unitsCountCollection)->
            new ScreenTwoView
                collection :unitsCountCollection

        _getUnitsCountCollection:->
            buildingArray = Array()
            unitColl = Array()
            units = App.currentStore.unit.where({status:'Available'})
            $.each(units, (index,value)->
                maxcoll = Array()
                if buildingArray.indexOf(value.get 'building') ==  -1
                    buildingArray.push value.get 'building'
            )
            $.each(buildingArray, (index,value)->
                buildingid = value
                newunits = App.currentStore.unit.where({'building':value})
                console.log newunits
                lowArray = Array()
                mediumArray = Array()
                highArray = Array()
                mainArray = Array()
                $.each(newunits, (index,value)->
                    lowUnits = App.currentStore.range.findWhere({name:'low'})
                    if value.get('floor') >= lowUnits.get('start') &&  value.get('floor') <= lowUnits.get 'end'
                            lowArray.push value.get 'id'



                    mediumUnits = App.currentStore.range.findWhere({name:'medium'})
                    if value.get('floor') >= mediumUnits.get('start') &&  value.get('floor') <= mediumUnits.get 'end'
                        mediumArray.push value.get 'id'


                    highUnits = App.currentStore.range.findWhere({name:'high'})
                    if value.get('floor') >= highUnits.get('start') &&  value.get('floor') <= highUnits.get 'end'
                        highArray.push value.get 'id'

                )
                low_max_val = 0
                low_min_val = 0
                medium_max_val = 0
                medium_min_val = 0
                high_min_val = 0
                high_max_val = 0
                $.each(lowArray , (index,value)->

                    unitmodel = App.currentStore.unit.findWhere({id:value})
                    unittypemodel = App.currentStore.unit_type.findWhere({id :  unitmodel.get( 'unitType' ) })
                    unitCollection = App.currentStore.unit.where({unitType: unittypemodel.get( 'id' ) } )
                    max_coll = Array()
                    $.each(unitCollection, (index,value)->

                        variantmodel = App.currentStore.unit_variant.findWhere({id: value.get( 'unitVariant' )} )
                        max_coll.push variantmodel.get 'sellablearea'


                    )
                    low_max_val = Math.max.apply( Math, max_coll )
                    low_min_val = Math.min.apply( Math, max_coll )
                )
                $.each(mediumArray , (index,value)->

                    unitmodel = App.currentStore.unit.findWhere({id:value})
                    unittypemodel = App.currentStore.unit_type.findWhere({id :  unitmodel.get( 'unitType' ) })
                    unitCollection = App.currentStore.unit.where({unitType: unittypemodel.get( 'id' ) } )
                    max_coll = Array()
                    $.each(unitCollection, (index,value)->

                        variantmodel = App.currentStore.unit_variant.findWhere({id: value.get( 'unitVariant' )} )
                        max_coll.push variantmodel.get 'sellablearea'


                    )
                    medium_max_val = Math.max.apply( Math, max_coll )
                    medium_min_val = Math.min.apply( Math, max_coll )
                )
                $.each(highArray , (index,value)->

                    unitmodel = App.currentStore.unit.findWhere({id:value})
                    unittypemodel = App.currentStore.unit_type.findWhere({id :  unitmodel.get( 'unitType' ) })
                    unitCollection = App.currentStore.unit.where({unitType: unittypemodel.get( 'id' ) } )
                    max_coll = Array()
                    $.each(unitCollection, (index,value)->

                        variantmodel = App.currentStore.unit_variant.findWhere({id: value.get( 'unitVariant' )} )
                        max_coll.push variantmodel.get 'sellablearea'


                    )
                    high_max_val = Math.max.apply( Math, max_coll )
                    high_min_val = Math.min.apply( Math, max_coll )
                )
                mainArray.push({name: lowArray.length,low_max_val: low_max_val,low_min_val:low_min_val,range:'low',buildingid:buildingid})
                mainArray.push({name: mediumArray.length,low_max_val: medium_max_val,low_min_val:medium_min_val,range:'medium',buildingid:buildingid})
                mainArray.push({name:highArray.length,low_max_val: high_max_val,low_min_val:high_min_val,range:'high',buildingid:buildingid})

                itemCollection = new Backbone.Collection(mainArray)
                buildingModel = App.currentStore.building.findWhere({id:value})
                unitColl.push {buildingname: buildingModel.get('name') , units: itemCollection ,buildingid:buildingModel.get('id')}
            )
            units = new Backbone.Collection(unitColl)
            console.log units





    msgbus.registerController 'screen:two', ScreenTwoController