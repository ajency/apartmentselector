define [ 'extm', 'src/apps/screen-two/screen-two-view' ], ( Extm, ScreenTwoView )->

    # Screen two controller
    class ScreenTwoController extends Extm.RegionController

        initialize : ()->

            @Collection = @_getUnitsCountCollection()


            @layout = new ScreenTwoView.ScreenTwoLayout(
                collection:@Collection[1]
                templateHelpers:
                    selection :@Collection[2]
                    unitsCount:@Collection[3]
                    unittypes:  @Collection[4]
                    high : @Collection[5]
                    medium : @Collection[6]
                    low : @Collection[7]
                    AJAXURL : AJAXURL)


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

            @listenTo itemview2, 'childview:childview:unit:count:selected', @_unitCountSelected







        getView:(buildingCollection)->
            new ScreenTwoView.UnitTypeChildView
                collection : buildingCollection

        getUnitsView:(unitCollection)->
            new ScreenTwoView.UnitTypeView
                collection : unitCollection


        _unitCountSelected:(childview,childview1)=>
            App.navigate "screen-three" , trigger:true









        _getUnitsCountCollection:->
            buildingArray = Array()
            buildingArrayModel = Array()
            unitColl = Array()
            templateArr = []
            mainunitTypeArray = []
            mainnewarr =  []
            mainunique = {}
            MainCollection = new Backbone.Model()
            status = App.currentStore.status.findWhere({'name':'Available'})
            units = App.currentStore.unit.where({'status':status.get('id')})
            Countunits = App.currentStore.unit.where({'status':status.get('id')})
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
            lcount = []
            mcount = []
            hcount = []
            lclassname = ""
            mclassname = ""
            hclassname = ""
            $.each(App.defaults, (index,value)->
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


            $.each(units, (index,value)->
                maxcoll = Array()

                if buildingArray.indexOf(value.get 'building') ==  -1
                    buildingArray.push value.get 'building'


                lowUnits = App.currentStore.range.findWhere({name:'low'})
                if value.get('floor') >= lowUnits.get('start') &&  value.get('floor') <= lowUnits.get 'end'
                    unittypemodel = App.currentStore.unit_type.findWhere({id :  value.get( 'unitType' ) })

                    mainunitsTypeArray.push({id:unittypemodel.get('id'),name: unittypemodel.get('name')})


                unitType = App.currentStore.unit_type.findWhere({id:value.get 'unitType'})
                mainunitTypeArray.push({id:unitType.get('id'),name: unitType.get('name')})
            )
            flag = 0
            flag1 = 0
            $.each(mainunitsTypeArray, (key,item)->
                if (!lunique[item.id])
                    lunitTypeArray = []
                    status = App.currentStore.status.findWhere({'name':'Available'})
                    count = App.currentStore.unit.where({unitType:item.id,'status':status.get('id')})
                    $.each(count, (index,value)->
                        if value.get('unitType') == 9
                            flag = 1
                        if value.get('unitType') == 10
                            flag1 = 1
                        lowUnits = App.currentStore.range.findWhere({name:'low'})
                        if (value.get('floor') >= lowUnits.get('start') &&  value.get('floor') <= lowUnits.get 'end') && item.id == value.get('unitType')
                            lunitTypeArray.push value.get 'id'
                    )
                    if parseInt(flag) == 1
                        lclassname = 'twoBHK'
                    if parseInt(flag1) == 1
                        lclassname = 'threeBHK'
                    if parseInt(flag) == 1 && parseInt(flag1) == 1
                        lclassname = 'multiBHK'





                    lnewarr.push({id:item.id,name:item.name,count:lunitTypeArray.length,classname:lclassname})
                    lunique[item.id] = item;

            )
            flag = 0
            flag1 = 0

            $.each(mainunitsTypeArray, (key,item)->
                if (!munique[item.id])
                    munitTypeArray = []
                    status = App.currentStore.status.findWhere({'name':'Available'})
                    count = App.currentStore.unit.where({unitType:item.id,'status':status.get('id')})
                    $.each(count, (index,value)->
                        if value.get('unitType') == 9
                            flag = 1
                        if value.get('unitType') == 10
                            flag1 = 1
                        mediumUnits = App.currentStore.range.findWhere({name:'medium'})
                        if (value.get('floor') >= mediumUnits.get('start') &&  value.get('floor') <= mediumUnits.get 'end') && item.id == value.get('unitType')
                            munitTypeArray.push value.get 'id'
                    )
                    if parseInt(flag) == 1
                        mclassname = 'twoBHK'
                    if parseInt(flag1) == 1
                        mclassname = 'threeBHK'
                    if parseInt(flag) == 1 && parseInt(flag1) == 1
                        mclassname = 'multiBHK'


                    mnewarr.push({id:item.id,name:item.name,count:munitTypeArray.length,classname:mclassname})
                    munique[item.id] = item;


            )
            flag = 0
            flag1 = 0
            $.each(mainunitsTypeArray, (key,item)->

                if (!hunique[item.id])
                    hunitTypeArray = []
                    status = App.currentStore.status.findWhere({'name':'Available'})
                    count = App.currentStore.unit.where({unitType:item.id,'status':status.get('id')})

                    $.each(count, (index,value)->
                        if value.get('unitType') == 9
                            flag = 1
                        if value.get('unitType') == 10
                            flag1 = 1
                        highUnits = App.currentStore.range.findWhere({name:'high'})
                        if (value.get('floor') >= highUnits.get('start') &&  value.get('floor') <= highUnits.get 'end') && item.id == value.get('unitType')
                            hunitTypeArray.push value.get 'id'
                    )
                    console.log flag
                    console.log flag1
                    if parseInt(flag) == 1
                        hclassname = 'twoBHK'
                    if parseInt(flag1) == 1
                        hclassname = 'threeBHK'
                    if parseInt(flag) == 1 && parseInt(flag1) == 1
                        hclassname = 'multiBHK'

                    console.log hclassname
                    hnewarr.push({id:item.id,name:item.name,count:hunitTypeArray.length,classname:hclassname})
                    hunique[item.id] = item;


            )

            $.each(mainunitTypeArray, (key,item)->
                if (!mainunique[item.id])
                    status = App.currentStore.status.findWhere({'name':'Available'})

                    count = App.currentStore.unit.where({unitType:item.id,'status':status.get('id')})

                    if parseInt(item.id) == 9
                        classname = 'twoBHK'
                    else
                        classname = 'threeBHK'

                    mainnewarr.push({id:item.id,name:item.name,classname:classname,count:count})
                    mainunique[item.id] = item;


            )


            buildingUnits = []
            $.each(buildingArray, (index,value)->
                buildingid = value
                unitTypeArray = Array()
                newarr =  []
                unique = {}

                status = App.currentStore.status.findWhere({'name':'Available'})

                newunits = App.currentStore.unit.where({'building':value,'status':status.get('id')})
                buildingUnits.push({id:buildingid,count:newunits.length})
                lowArray = Array()
                mediumArray = Array()
                highArray = Array()
                mainArray = Array()
                unitTypeArray = []
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

                    unitType = App.currentStore.unit_type.findWhere({id:value.get 'unitType'})
                    unitTypeArray.push({id:unitType.get('id'),name: unitType.get('name')})

                )
                $.each(unitTypeArray, (key,item)->
                    if (!unique[item.id])
                        status = App.currentStore.status.findWhere({'name':'Available'})
                        count = App.currentStore.unit.where({unitType:item.id,'status':status.get('id'),'building':buildingid})
                        console.log item.id
                        if parseInt(item.id) == 9
                            classname = 'twoBHK m-l-20'
                        else
                            classname = 'oneBHK'
                        newarr.push({id:item.id,name:item.name,count:count.length,classname:classname})
                        unique[item.id] = item;


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
                    munitTypeArray.push({id:unittypemodel.get('id'),name: unittypemodel.get('name')})

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
                    hunitTypeArray.push({id:unittypemodel.get('id'),name: unittypemodel.get('name')})

                    unitCollection = App.currentStore.unit.where({unitType: unittypemodel.get( 'id' ) } )
                    max_coll = Array()
                    $.each(unitCollection, (index,value)->

                        variantmodel = App.currentStore.unit_variant.findWhere({id: value.get( 'unitVariant' )} )
                        max_coll.push variantmodel.get 'sellablearea'


                    )
                    high_max_val = Math.max.apply( Math, max_coll )
                    high_min_val = Math.min.apply( Math, max_coll )
                )

                mainArray.push({count:highArray.length,low_max_val: high_max_val,low_min_val:high_min_val,range:'high',buildingid:buildingid,unittypes:hnewarr,classname:hclassname})
                mainArray.push({count: mediumArray.length,low_max_val: medium_max_val,low_min_val:medium_min_val,range:'medium',buildingid:buildingid,unittypes:mnewarr,classname:mclassname})
                mainArray.push({count: lowArray.length,low_max_val: low_max_val,low_min_val:low_min_val,range:'low',buildingid:buildingid,unittypes:lnewarr,classname:lclassname})

                itemCollection = new Backbone.Collection(mainArray)
                buildingModel = App.currentStore.building.findWhere({id:value})
                unitColl.push {id:buildingModel.get('id'),buildingname: buildingModel.get('name') , units: itemCollection ,buildingid:buildingModel.get('id'),unittypes:newarr}
                buildingArrayModel.push(buildingModel)

            )
            buildingUnits.sort( (a,b)->
                b.count - a.count

            )
            buildingsactual = []
            unitsactual = []
            buildingCollection = new Backbone.Collection(buildingArrayModel)
            units = new Backbone.Collection(unitColl)
            $.each(buildingUnits , (index,value)->
                value = value.id
                buildingsactual.push(buildingCollection.get(value))
                unitsactual.push(units.get(value))
            )
            buildingCollection = new Backbone.Collection(buildingsactual)
            units = new Backbone.Collection(unitsactual)

            if App.defaults['unitType'] != 'All'
                mainnewarr = []
            [buildingCollection ,units,templateString,Countunits.length,mainnewarr,hnewarr,mnewarr,lnewarr]





    msgbus.registerController 'screen:two', ScreenTwoController