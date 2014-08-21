define [ 'extm', 'src/apps/screen-three/screen-three-view' ], ( Extm, ScreenThreeView )->

    # Screen three controller
    class ScreenThreeController extends Extm.RegionController

        initialize :()->
            @Collection = @_getUnits()

            @layout = new ScreenThreeView.ScreenThreeLayout(
                countUnits : @Collection[3]
                uintVariantId : @Collection[8]
                uintVariantIdArray : @Collection[8]
                unitVariants:@Collection[7]
                templateHelpers:
                    selection :@Collection[2]
                    countUnits : @Collection[3]
                    range : @Collection[4]
                    high : @Collection[5]
                    rangetext : @Collection[6]
                    unitVariants:@Collection[7]


            )


            @listenTo @layout, "show", @showViews

            @listenTo @layout, 'unit:variants:selected', @_showBuildings

            @listenTo @layout, 'unit:item:selected', @_unitItemSelected



            @show @layout

        showViews:=>
            @buildingCollection = @Collection[0]
            @unitCollection = @Collection[1]
            @showBuildingRegion @buildingCollection
            @showUnitRegion @unitCollection




        _showBuildings:->
                @Collection = @_getUnits()


                @layout = new ScreenThreeView.ScreenThreeLayout(
                        countUnits : @Collection[3]
                        uintVariantId : @Collection[8]
                        uintVariantIdArray : @Collection[8]
                        unitVariants:@Collection[7]
                        templateHelpers:
                                selection :@Collection[2]
                                countUnits : @Collection[3]
                                range : @Collection[4]
                                high : @Collection[5]
                                rangetext : @Collection[6]
                                unitVariants:@Collection[7]


                )


                @listenTo @layout, "show", @showViews

                @listenTo @layout, 'unit:variants:selected', @_showBuildings

                @listenTo @layout, 'unit:item:selected', @_unitItemSelected



                @show @layout


                #@layout.unitRegion.show(new ScreenThreeView.UnitTypeView
                                    #collection : @Collection[1])








        showBuildingRegion:(buildingCollection)->
            itemview1 = @getView buildingCollection
            @layout.buildingRegion.show itemview1
            @listenTo itemview1, 'childview:building:link:selected', @_showBuildings



        showUnitRegion:(unitCollection)->
            itemview2 = @getUnitsView unitCollection
            @layout.unitRegion.show itemview2
            #@listenTo itemview2, 'childview:childview:childview:unit:item:selected', @_unitItemSelected








        getView:(buildingCollection)->
            new ScreenThreeView.UnitTypeChildView
                collection : buildingCollection

        getUnitsView:(unitCollection)->
            new ScreenThreeView.UnitTypeView
                collection : unitCollection

        _unitItemSelected:(childview,childview1,childview2)=>
            console.log "hi"
            App.navigate "screen-four" , trigger:true






        _getUnits:->
            console.log App.defaults

            buildingArray = []
            unitArray = []
            unitsArray = []
            buildingArrayModel = []
            templateArr = []
            param = {}
            paramkey = {}
            flag = 0
            track = 0
            trackArray = []
            floorUnitsArray = []
            myArray = []
            units = App.master.unit
            status = App.currentStore.status.findWhere({'name':'Available'})
            Countunits = App.currentStore.unit.where({'status':status.get('id')})
            $.map(App.defaults, (value, index)->
                if value!='All'
                    if  index != 'unitVariant'
                        myArray.push({key:index,value:value})

            )
            $.each(myArray, (index,value)->
                if(value.value !='All')
                    console.log value.key
                    param[value.key] = value.value
                    string_val = _.isString(value.value)
                    valuearr = ""
                    if string_val == true
                        valuearr = value.value.split(',')
                    if valuearr.length > 1
                        for element  in valuearr
                            if value.key == 'unitType'
                                key = App.master.unit_type.findWhere({id:parseInt(element)})
                                templateArr.push key.get 'name'
                            #if value.key == 'building'
                                #key = App.master.building.findWhere({id:parseInt(element)})
                            #templateArr.push key.get 'name'
                            if value.key == 'budget'
                                budget_Val = value+'lakhs'
                                templateArr.push budget_Val
                            if value.key == 'floor'
                                if track == 0
                                    trackArray.push value.value
                                #flag = 1
                                track = 1
                    else
                        if value.key == 'unitType'
                            key = App.master.unit_type.findWhere({id:parseInt(value.value)})
                            templateArr.push key.get 'name'
                        #if value.key == 'building'
                            #key = App.master.building.findWhere({id:parseInt(value.value)})
                            #templateArr.push key.get 'name'
                        if value.key == 'budget'
                            budget_Val = value.value
                            templateArr.push budget_Val
                        if value.key == 'floor'
                            if track == 0
                                trackArray.push value.value
                            #flag = 1
                            track = 1




            )
            console.log templateArr
            if templateArr.length == 0
                templateArr.push 'All'
            if(flag==1)
                first = _.first(trackArray)
                lowUnits = App.master.range.findWhere({name:'low'})
                if parseInt(first) >= lowUnits.get('start') &&  parseInt(first) <= lowUnits.get 'end'
                    range = 'LOWRISE'
                    #templateArr.push range



                mediumUnits = App.master.range.findWhere({name:'medium'})
                if parseInt(first) >= mediumUnits.get('start') &&  parseInt(first) <= mediumUnits.get 'end'
                    range = 'MIDRISE'
                    #templateArr.push range


                highUnits = App.master.range.findWhere({name:'high'})
                if parseInt(first) >= highUnits.get('start') &&  parseInt(first) <= highUnits.get 'end'
                    range = 'HIGHRISE'
                    #templateArr.push range
                #templateString  = templateArr.join(',')

            else
                templateString  = templateArr.join(',')



            flag  = 0
            console.log templateArr

            console.log templateString

            console.log myArray
            status = App.master.status.findWhere({'name':'Available'})
            console.log unitslen = App.master.unit.where({'status':status.get('id')})


            $.each(unitslen, (index,value1)->

                if App.defaults['floor'] !='All'
                    floorstring = App.defaults['floor']
                    floorArray  = floorstring.split(',')
                    $.each(floorArray, (index,value)->
                        if value1.get('floor') == parseInt(value)
                            floorUnitsArray.push(value1)




                    )


            )
            if App.defaults['floor'] == "All"
                floorUnitsArray = unitslen

            console.log floorUnitsArray.length
            floorCollunits = []
            $.each(floorUnitsArray, (index,value1)->
                flag = 0
                $.each(myArray, (index,value)->
                    paramKey = {}
                    paramKey[value.key] = value.value
                    if value.key == 'budget'
                        buildingModel = App.master.building.findWhere({'id':value1.get 'building'})
                        floorRise = buildingModel.get 'floorrise'
                        floorRiseValue = floorRise[value1.get 'floor']
                        unitVariantmodel = App.master.unit_variant.findWhere({'id':value1.get 'unitVariant'})
                        #unitPrice = (parseInt( unitVariantmodel.get('persqftprice')) + parseInt(floorRiseValue)) * parseInt(unitVariantmodel.get 'sellablearea')
                        unitPrice = value1.get 'unitPrice'
                        budget_arr = value.value.split(' ')
                        budget_price = budget_arr[0].split('-')
                        console.log budget_price[0] = budget_price[0]+'00000'
                        console.log budget_price[1] = budget_price[1]+'00000'
                        if parseInt(unitPrice) >= parseInt(budget_price[0]) && parseInt(unitPrice) <= parseInt(budget_price[1])
                            flag++
                    else if value.key != 'floor'
                        console.log value.key
                        console.log value1.get(value.key) + '== ' + parseInt(value.value)
                        if value1.get(value.key) == parseInt(value.value)

                            flag++


                )
                console.log flag
                if flag == myArray.length - 1
                    floorCollunits.push(value1)





            )
            console.log floorCollunits
            if App.defaults['floor'] == "All"
                floorCollunits = unitslen
            console.log floorCollunits.length
            units = new Backbone.Collection floorCollunits
            buildings = units.pluck("building")
            console.log uniqBuildings = _.uniq(buildings)

            unitvariant = units.pluck("unitVariant")
            console.log uniqUnitvariant = _.uniq(unitvariant)
            unitVariantModels = []
            unitVariantID = []

            $.each(uniqUnitvariant, (index,value)->
                unitVarinatModel = App.master.unit_variant.findWhere({id:value})
                unitVariantModels.push({id:unitVarinatModel.get('id'),name:unitVarinatModel.get('name'),sellablearea:unitVarinatModel.get('sellablearea')})
                unitVariantID.push(parseInt(unitVarinatModel.get('id')))

            )
            unitVariantModels.sort( (a,b)->
                a.id - b.id

            )
            unitVariantID.sort( (a,b)->
                a - b

            )
            console.log unitVariantModels


            floorArray = []
            floorCountArray = []
            unitsArray = []
            buildingvalue = App.defaults['building']
            if App.defaults['building'] == "All"
                buildings = App.currentStore.building
                buildings.each ( item)->
                    unitsColl = App.master.unit.where({building:item.get('id')})
                    unitsArray.push({id:item.get('id'),count:unitsColl.length})
                buildingvalue = _.max(unitsArray,  (model)->
                    model.count
                )
                console.log buildingvalue = buildingvalue.id
            console.log unitsCollection = units.where({building:parseInt(buildingvalue)})
            $.each(unitsCollection, (index,value)->
                    if floorArray.indexOf(value.get 'floor') ==  -1
                        floorArray.push value.get 'floor'
                        floorCountArray.push {id:value.get 'floor'}



            )
            floorArray = floorArray.sort()
            floorArray.sort( (a,b) ->
                    b - a
            )

            floorCountArray.sort( (a,b) ->
                    b.id - a.id
            )
            unitArray= []
            unitColl = new Backbone.Collection unitsCollection
            unitAssigned = unitColl.pluck("unitAssigned")
            console.log uniqunitAssigned = _.uniq(unitAssigned)
            $.each(uniqunitAssigned, (index,value)->
                console.log unitAssgendModels = unitColl.where({unitAssigned:value})
                $.each(unitAssgendModels, (index,value)->
                    unitType = App.master.unit_type.findWhere({id:value.get('unitType')})
                    value.set "unittypename" , unitType.get "name"
                    unitVariant = App.master.unit_variant.findWhere({id:value.get('unitVariant')})
                    value.set "sellablearea" , unitVariant.get "sellablearea"

                )
                console.log unitAssgendModels = _.uniq(unitAssgendModels)
                unitAssgendModels.sort( (a,b)->
                    b.get('floor') - a.get('floor')

                )
                unitAssgendModelsColl = new Backbone.Collection unitAssgendModels
                unitArray.push({id:value,units:unitAssgendModelsColl})



            )
            unitArray.sort( (a,b)->
                a.id - b.id

            )
            console.log unitArray
            console.log newunitCollection = new Backbone.Collection unitArray
            buildingModel = App.currentStore.building.where(id:parseInt(buildingvalue))
            console.log buildingCollection = new Backbone.Collection buildingModel
            mainnewarr = ""
            [buildingCollection,newunitCollection,templateString,Countunits.length,templateString,mainnewarr,range,unitVariantModels,unitVariantID]






        mainUnitSelected:(childview,childview1,unit,unittypeid,range,size)=>
            App.navigate "#screen-four/unit/#{unit}/unittype/#{unittypeid}/range/#{range}/size/#{size}" ,  trigger : true





    msgbus.registerController 'screen:three', ScreenThreeController