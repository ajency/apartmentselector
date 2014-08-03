define [ 'extm', 'src/apps/screen-three/screen-three-view' ], ( Extm, ScreenThreeView )->

    # Screen three controller
    class ScreenThreeController extends Extm.RegionController

        initialize :()->
            @Collection = @_getUnits()

            @layout = new ScreenThreeView.ScreenThreeLayout(

                templateHelpers:
                    selection :@Collection[2]

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

            units = App.currentStore.unit
            $.each(App.Cloneddefaults, (index,value)->
                if(value !='All')
                    param[index] = value
                    string_val = _.isString(value)
                    valuearr = ""
                    if string_val == true
                        valuearr = value.split(',')
                    if valuearr.length > 1
                        for element  in valuearr
                            if index == 'unitType'
                                key = App.currentStore.unit_type.findWhere({id:parseInt(element)})
                                templateArr.push key.get 'name'
                            if index == 'unitVariant'
                                key = App.currentStore.unit_variant.findWhere({id:parseInt(element)})
                                templateArr.push key.get 'name'
                            if index == 'building'
                                key = App.currentStore.building.findWhere({id:parseInt(element)})
                                templateArr.push key.get 'name'
                            if index == 'budget'
                                budget_Val = value+'lakhs'
                                templateArr.push budget_Val
                            if index == 'floor'
                                templateArr.push value
                                flag = 1
                    else
                        if index == 'unitType'
                            key = App.currentStore.unit_type.findWhere({id:parseInt(value)})
                            templateArr.push key.get 'name'
                        if index == 'unitVariant'
                            key = App.currentStore.unit_variant.findWhere({id:parseInt(value)})
                            templateArr.push key.get 'name'
                        if index == 'building'
                            key = App.currentStore.building.findWhere({id:parseInt(value)})
                            templateArr.push key.get 'name'
                        if index == 'budget'
                            budget_Val = value
                            templateArr.push budget_Val
                        if index == 'floor'
                            templateArr.push value
                            flag = 1




            )
            if templateArr.length == 0
                templateArr.push 'All'
            if(flag==1)
                first = _.first(templateArr)
                buildingModel = App.currentStore.building.findWhere({id:App.building['name']})
                lowUnits = App.currentStore.range.findWhere({name:'low'})
                if parseInt(first) >= lowUnits.get('start') &&  parseInt(first) <= lowUnits.get 'end'
                    range = 'LOWRISE'+',' +buildingModel.get('name')



                mediumUnits = App.currentStore.range.findWhere({name:'medium'})
                if parseInt(first) >= mediumUnits.get('start') &&  parseInt(first) <= mediumUnits.get 'end'
                    range = 'MIDRISE'+',' +buildingModel.get('name')


                highUnits = App.currentStore.range.findWhere({name:'high'})
                if parseInt(first) >= highUnits.get('start') &&  parseInt(first) <= highUnits.get 'end'
                    range = 'HIGHRISE'+',' +buildingModel.get('name')
                templateString = range
            else
                templateString  = templateArr.join(',')

            units.each (item)->
                if buildingArray.indexOf(item.get 'building') ==  -1
                    buildingArray.push item.get 'building'
            $.each(buildingArray, (index,value)->
                buildingid = value
                floorArray = []
                floorCountArray = []
                unitsArray = []
                unitsCollection = App.currentStore.unit.where({building:value})
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

                    floorunits = App.currentStore.unit.where({floor:value,building:buildingid})
                    floorunits.sort( (a,b) ->
                        console.log a.get('id')
                        a.get('id') - b.get('id')
                    )
                    floorCollection = new Backbone.Collection(floorunits)
                    unitsArray.push { floorunits : floorCollection }

                    $.each(floorunits, (index,value)->
                        unitType = App.currentStore.unit_type.findWhere({id:value.get('unitType')})
                        str = unitType.get 'name'
                        str = str.replace(/\s/g, '');

                        value.set 'unitTypeName' , str
                        unitVariant = App.currentStore.unit_variant.findWhere({id:value.get('unitVariant')})
                        value.set 'unitVariantName' , unitVariant.get 'name'




                    )



                )

                buildingModel = App.currentStore.building.findWhere({id:value})
                buildingArrayModel.push buildingModel
                unitCollection = new Backbone.Collection(unitsArray)
                unitArray.push { buildingid:value, units: unitCollection ,floorcount : floorCountArray }







            )
            temp = []
            temp1 = []
            for element,index in unitArray
                if unitArray[index].buildingid  == App.building['name']
                    temp[0] = unitArray[0]
                    unitArray[0] = unitArray[index]
                    unitArray[index] = temp[0]
                    temp1[0] = buildingArrayModel[0]
                    buildingArrayModel[0] = buildingArrayModel[index]
                    buildingArrayModel[index] = temp1[0]

            buildingCollection = new Backbone.Collection(buildingArrayModel)
            newunitCollection = new Backbone.Collection(unitArray)
            [buildingCollection,newunitCollection,templateString]






        mainUnitSelected:(childview,childview1,unit,unittypeid,range,size)=>
            App.navigate "#screen-four/unit/#{unit}/unittype/#{unittypeid}/range/#{range}/size/#{size}" ,  trigger : true






    msgbus.registerController 'screen:three', ScreenThreeController