define [ 'extm', 'src/apps/screen-two/screen-two-view' ], ( Extm, ScreenTwoView )->

    # Screen two controller
    class ScreenTwoController extends Extm.RegionController

        initialize : ()->

            @Collection = @_getUnitsCountCollection()

            @unitTypecoll = @Collection[2]

            @layout = new ScreenTwoView.ScreenTwoLayout({templateHelpers:
                                                            unitType : @unitTypecoll,
                                                            selection :@Collection[3]
                                                            unitsCount:@Collection[4] })


            @listenTo @layout, "show", @showViews


            @show @layout


        showViews:=>
            @buildingCollection = @Collection[0]
            @unitCollection = @Collection[1]
            itemview1 = @getView @buildingCollection
            console.log itemview1
            @layout.buildingRegion.show itemview1
            itemview2 = @getUnitsView @unitCollection
            @layout.unitRegion.show itemview2





        getView:(buildingCollection)->
            console.log "hi"
            new ScreenTwoView.UnitTypeChildView
                collection : buildingCollection

        getUnitsView:(unitCollection)->
            new ScreenTwoView.UnitTypeView
                collection : unitCollection



        _getUnitsCountCollection:->
            buildingArray = Array()
            buildingArrayModel = Array()
            unitColl = Array()
            unitTypeArray = Array()
            newarr =  []
            unique = {}
            templateArr = []
            MainCollection = new Backbone.Model()
            status = App.currentStore.status.findWhere({'name':'Available'})
            units = App.currentStore.unit.where({'status':status.get('id')})
            Countunits = App.currentStore.unit.where({'status':status.get('id')})
            param = {}
            paramkey = {}
            $.each(App.defaults, (index,value)->
                if(value !='All')
                    param[index] = value
                    console.log index
                    string_val = _.isString(value)
                    if string_val == true
                        valuearr = value.split(',')
                    if valuearr.length > 1
                        for element  in valuearr
                            console.log element
                            if index == 'unitType'
                                key = App.currentStore.unit_type.findWhere({id:parseInt(element)})
                                console.log key
                                templateArr.push key.get 'name'
                            if index == 'unitVariant'
                                key = App.currentStore.unit_variant.findWhere({id:parseInt(element)})
                                console.log key
                                templateArr.push key.get 'name'
                            if index == 'building'
                                key = App.currentStore.building.findWhere({id:parseInt(element)})
                                console.log key
                                templateArr.push key.get 'name'
                            if index == 'budget'
                                budget_Val = value+'lakhs'
                                templateArr.push budget_Val
                            if index == 'floor'
                                templateArr.push value
                    else
                        if index == 'unitType'
                            key = App.currentStore.unit_type.findWhere({id:parseInt(value)})
                            console.log key
                            templateArr.push key.get 'name'
                        if index == 'unitVariant'
                            key = App.currentStore.unit_variant.findWhere({id:parseInt(value)})
                            console.log key
                            templateArr.push key.get 'name'
                        if index == 'building'
                            key = App.currentStore.building.findWhere({id:parseInt(value)})
                            console.log key
                            templateArr.push key.get 'name'
                        if index == 'budget'
                            budget_Val = value+'lakhs'
                            templateArr.push budget_Val
                        if index == 'floor'
                            templateArr.push value




            )
            console.log templateArr
            templateString  = templateArr.join(',')
            $.each(units, (index,value)->
                maxcoll = Array()
                unitType = App.currentStore.unit_type.findWhere({id:value.get 'unitType'})
                unitTypeArray.push({id:unitType.get('id'),name: unitType.get('name')})
                if buildingArray.indexOf(value.get 'building') ==  -1
                    buildingArray.push value.get 'building'
            )
            $.each(unitTypeArray, (key,item)->
                if (!unique[item.id])
                    console.log count = App.currentStore.unit.where({unitType:item.id})
                    newarr.push({id:item.id,name:item.name,count:count.length})
                    unique[item.id] = item;


            )
            console.log newarr
            $.each(buildingArray, (index,value)->
                buildingid = value
                newunits = App.currentStore.unit.where({'building':value})
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
                buildingArrayModel.push(buildingModel)

            )
            buildingCollection = new Backbone.Collection(buildingArrayModel)
            units = new Backbone.Collection(unitColl)
            [buildingCollection ,units,newarr,templateString,Countunits.length]





    msgbus.registerController 'screen:two', ScreenTwoController