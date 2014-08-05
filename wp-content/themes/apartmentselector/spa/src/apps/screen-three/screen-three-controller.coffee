define [ 'extm', 'src/apps/screen-three/screen-three-view' ], ( Extm, ScreenThreeView )->

    # Screen three controller
    class ScreenThreeController extends Extm.RegionController

        initialize :()->
            @Collection = @_getUnits()

            @layout = new ScreenThreeView.ScreenThreeLayout(
                countUnits : @Collection[3]
                templateHelpers:
                    selection :@Collection[2]
                    countUnits : @Collection[3]
                    range : @Collection[4]

            )


            @listenTo @layout, "show", @showViews


            @show @layout

        showViews:=>
            @buildingCollection = @Collection[0]
            @unitCollection = @Collection[1]
            @showBuildingRegion @buildingCollection
            @showUnitRegion @unitCollection





        showBuildingRegion:(buildingCollection)->
            itemview1 = @getView buildingCollection
            @layout.buildingRegion.show itemview1



        showUnitRegion:(unitCollection)->
            itemview2 = @getUnitsView unitCollection
            @layout.unitRegion.show itemview2
            @listenTo itemview2, 'childview:childview:childview:unit:item:selected', @_unitItemSelected








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
            $.map(App.defaults, (value, index)->
                if value!='All'
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
                            if value.key == 'unitVariant'
                                key = App.master.unit_variant.findWhere({id:parseInt(element)})
                                templateArr.push key.get 'name'
                            if value.key == 'building'
                                key = App.master.building.findWhere({id:parseInt(element)})
                                templateArr.push key.get 'name'
                            if value.key == 'budget'
                                budget_Val = value+'lakhs'
                                templateArr.push budget_Val
                            if value.key == 'floor'
                                if track == 0
                                    trackArray.push value.value
                                flag = 1
                                track = 1
                    else
                        if value.key == 'unitType'
                            key = App.master.unit_type.findWhere({id:parseInt(value.value)})
                            templateArr.push key.get 'name'
                        if value.key == 'unitVariant'
                            key = App.master.unit_variant.findWhere({id:parseInt(value.value)})
                            templateArr.push key.get 'name'
                        if value.key == 'building'
                            key = App.master.building.findWhere({id:parseInt(value.value)})
                            templateArr.push key.get 'name'
                        if value.key == 'budget'
                            budget_Val = value.value
                            templateArr.push budget_Val
                        if value.key == 'floor'
                            if track == 0
                                trackArray.push value.value
                            flag = 1
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
                    templateArr.push range



                mediumUnits = App.master.range.findWhere({name:'medium'})
                if parseInt(first) >= mediumUnits.get('start') &&  parseInt(first) <= mediumUnits.get 'end'
                    range = 'MIDRISE'
                    templateArr.push range


                highUnits = App.master.range.findWhere({name:'high'})
                if parseInt(first) >= highUnits.get('start') &&  parseInt(first) <= highUnits.get 'end'
                    range = 'HIGHRISE'
                    templateArr.push range
                templateString  = templateArr.join(',')

            else
                templateString  = templateArr.join(',')



            countUnits = 0
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
                        console.log unitPrice = (parseInt( unitVariantmodel.get('persqftprice')) + parseInt(floorRiseValue)) * parseInt(unitVariantmodel.get 'sellablearea')
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
            units.each (item)->
                if buildingArray.indexOf(item.get 'building') ==  -1
                    buildingArray.push item.get 'building'
            $.each(buildingArray, (index,value)->
                buildingid = value
                floorArray = []
                floorCountArray = []
                unitsArray = []
                console.log unitsCollection = units.where({building:value})
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
                $.each(floorArray, (index,value)->

                    floorunits = App.master.unit.where({floor:value,building:buildingid})
                    floorunits.sort( (a,b) ->
                        a.get('id') - b.get('id')
                    )
                    floorCollection = new Backbone.Collection(floorunits)
                    unitsArray.push { floorunits : floorCollection }

                    $.each(floorunits, (index,value)->
                        unitType = App.master.unit_type.findWhere({id:value.get('unitType')})
                        str = unitType.get 'name'
                        str = str.replace(/\s/g, '');

                        value.set 'unitTypeName' , str
                        unitVariant = App.master.unit_variant.findWhere({id:value.get('unitVariant')})
                        value.set 'unitVariantName' , unitVariant.get 'name'




                    )



                )

                buildingModel = App.master.building.findWhere({id:value})
                buildingArrayModel.push buildingModel
                unitCollection = new Backbone.Collection(unitsArray)
                unitArray.push {id:value, buildingid:value, units: unitCollection ,floorcount : floorCountArray }







            )
            building = App.master.building.toArray()
            buildingCollection = App.master.building
            building.sort( (a,b) ->
                a.get('id') - b.get('id')
            )
            modelIdArr = []
            modelArr = []
            ModelActualArr = []
            unitsactual = []
            $.each(building, (index,value)->
                modelIdArr.push(value.get('id'))

            )
            index = _.indexOf(modelIdArr, App.defaults['building'])
            highLength = modelIdArr.length - index
            i = index
            while(i<modelIdArr.length)
                modelArr.push(modelIdArr[i])
                i++
            j= 0
            while(j<index)
                modelArr.push(modelIdArr[j])
                j++


            newunitCollection = new Backbone.Collection(unitArray)
            $.each(modelArr, (index,value)->
                ModelActualArr.push(buildingCollection.get(value))
                unitsactual.push(newunitCollection.get(value))

            )
            buildingCollection = new Backbone.Collection(ModelActualArr)
            newunitCollection = new Backbone.Collection(unitsactual)
            [buildingCollection,newunitCollection,templateString,floorCollunits.length,templateString]






        mainUnitSelected:(childview,childview1,unit,unittypeid,range,size)=>
            App.navigate "#screen-four/unit/#{unit}/unittype/#{unittypeid}/range/#{range}/size/#{size}" ,  trigger : true





    msgbus.registerController 'screen:three', ScreenThreeController