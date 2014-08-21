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
                                flag = 1
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
            console.log unitArray
            building = App.master.building.toArray()
            buildingCollection = App.master.building
            buildingvalue = _.max(unitArray,  (model)->
                model.units.length
            )
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
            if App.defaults['building'] == 'All'
                console.log index = _.indexOf(modelIdArr, buildingvalue.id)
            else
                console.log index = _.indexOf(modelIdArr, App.defaults['building'])
            if index == -1
                index = 0
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
            console.log modelArr
            $.each(modelArr, (index,value)->
                ModelActualArr.push(buildingCollection.get(value))
                unitsactual.push(newunitCollection.get(value))

            )
            buildingArray = Array()
            buildingArrayModel = Array()
            unitColl = Array()
            templateArr = []
            mainunitTypeArray = []
            mainnewarr =  []
            mainunique = {}
            MainCollection = new Backbone.Model()
            status = App.master.status.findWhere({'name':'Available'})
            units = App.master.unit.where({'status':status.get('id')})
            Countunits = App.master.unit.where({'status':status.get('id')})
            param = {}
            paramkey = {}
            flag = 0
            mainunitsTypeArray = []
            lunitTypeArray = []
            lnewarr =  []
            lunique = {}
            munitTypeArray = []
            mnewarr =  []
            munique = {}
            hunitTypeArray = []
            hnewarr =  []
            hunique = {}
            mainunitTypeArray = []



            $.each(units, (index,value)->
                maxcoll = Array()

                if buildingArray.indexOf(value.get 'building') ==  -1
                    buildingArray.push value.get 'building'



                unitType = App.master.unit_type.findWhere({id:value.get 'unitType'})
                mainunitTypeArray.push({id:unitType.get('id'),name: unitType.get('name')})
            )
            console.log range
            if range == 'LOWRISE'
                $.each(mainunitTypeArray, (key,item)->
                    if (!lunique[item.id])
                        lunitTypeArray = []
                        status = App.master.status.findWhere({'name':'Available'})
                        count = App.master.unit.where({unitType:item.id,'status':status.get('id')})
                        $.each(count, (index,value)->
                            lowUnits = App.master.range.findWhere({name:'low'})
                            if (value.get('floor') >= lowUnits.get('start') &&  value.get('floor') <= lowUnits.get 'end') && item.id == value.get('unitType')
                                lunitTypeArray.push value.get 'id'
                        )
                        #mainnewarr.push({id:item.id,name:item.name,count:lunitTypeArray.length,range:'LOWRISE'})
                        lunique[item.id] = item;

                )
                mainnewarr.push({text :'Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.',image:'url',rangetext:"LOWRISE"})

            else if range == 'MIDRISE'
                $.each(mainunitTypeArray, (key,item)->
                    if (!munique[item.id])
                        munitTypeArray = []
                        status = App.master.status.findWhere({'name':'Available'})
                        count = App.master.unit.where({unitType:item.id,'status':status.get('id')})
                        $.each(count, (index,value)->

                            mediumUnits = App.master.range.findWhere({name:'medium'})
                            if (value.get('floor') >= mediumUnits.get('start') &&  value.get('floor') <= mediumUnits.get 'end') && item.id == value.get('unitType')
                                munitTypeArray.push value.get 'id'
                        )
                        #mainnewarr.push({id:item.id,name:item.name,count:munitTypeArray.length,range:'MEDIUMRISE'})
                        munique[item.id] = item;


                )
                mainnewarr.push({text :'Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.',image:'url',rangetext:"MIDRISE"})


            else if range == 'HIGHRISE'

                $.each(mainunitTypeArray, (key,item)->
                    if (!hunique[item.id])
                        hunitTypeArray = []
                        status = App.master.status.findWhere({'name':'Available'})
                        count = App.master.unit.where({unitType:item.id,'status':status.get('id')})

                        $.each(count, (index,value)->
                            highUnits = App.master.range.findWhere({name:'high'})
                            if (value.get('floor') >= highUnits.get('start') &&  value.get('floor') <= highUnits.get 'end') && item.id == value.get('unitType')
                                hunitTypeArray.push value.get 'id'
                        )
                        #mainnewarr.push({id:item.id,name:item.name,count:hunitTypeArray.length,range:"HIGHRISE"})
                        hunique[item.id] = item;


                )
                mainnewarr.push({text :'Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.',image:'url',rangetext:"HIGHRISE"})

            else
                range = "ALL"
                $.each(mainunitTypeArray, (key,item)->
                    if (!hunique[item.id])
                        hunitTypeArray = []
                        status = App.master.status.findWhere({'name':'Available'})
                        count = App.master.unit.where({unitType:item.id,'status':status.get('id')})

                        $.each(count, (index,value)->
                            hunitTypeArray.push value.get 'id'
                        )
                        #mainnewarr.push({id:item.id,name:item.name,count:hunitTypeArray.length,range:"HIGHRISE"})
                        hunique[item.id] = item;


                )
                mainnewarr.push({text :'Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.',image:'url',rangetext:"HIGHRISE"})
                mainnewarr.push({text :'Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.',image:'url',rangetext:"MIDRISE"})
                mainnewarr.push({text :'Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.',image:'url',rangetext:"LOWRISE"})





            console.log mainnewarr
            if App.defaults['building'] == "All"
                unitArray.sort( (a,b)->
                    b.units.length - a.units.length

                )
                buildingsactual = []
                unitsactual = []
                buildingCollection = App.master.building
                units = new Backbone.Collection(unitArray)
                $.each(unitArray , (index,value)->
                    value = value.id
                    buildingsactual.push(buildingCollection.get(value))
                    unitsactual.push(units.get(value))
                )
                console.log  buildingCollection = new Backbone.Collection(buildingsactual)
                newunitCollection = new Backbone.Collection(unitsactual)
            else
                buildingCollection = new Backbone.Collection(ModelActualArr)
                console.log newunitCollection = new Backbone.Collection(unitsactual)
            [buildingCollection,newunitCollection,templateString,Countunits.length,templateString,mainnewarr,range,unitVariantModels,unitVariantID]






        mainUnitSelected:(childview,childview1,unit,unittypeid,range,size)=>
            App.navigate "#screen-four/unit/#{unit}/unittype/#{unittypeid}/range/#{range}/size/#{size}" ,  trigger : true





    msgbus.registerController 'screen:three', ScreenThreeController