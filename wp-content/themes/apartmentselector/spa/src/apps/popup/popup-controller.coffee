define [ 'extm', 'src/apps/popup/popup-view' ], ( Extm, PopupView )->

    class PopupController extends Extm.RegionController

        initialize :(opt = {})->

            @Collection = @_getUnitsCountCollection()


            @view = view = @_getPopupView @Collection



            @show view


        _getPopupView:(Collection)->
            console.log Collection
            new PopupView
                templateHelpers:
                    high : Collection[0]
                    medium : Collection[1]
                    low : Collection[2]

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
            $.each(mainunitsTypeArray, (key,item)->
                if (!lunique[item.id])
                    lunitTypeArray = []
                    status = App.currentStore.status.findWhere({'name':'Available'})
                    count = App.currentStore.unit.where({unitType:item.id,'status':status.get('id')})
                    $.each(count, (index,value)->
                        lowUnits = App.currentStore.range.findWhere({name:'low'})
                        if (value.get('floor') >= lowUnits.get('start') &&  value.get('floor') <= lowUnits.get 'end') && item.id == value.get('unitType')
                            lunitTypeArray.push value.get 'id'
                    )
                    lnewarr.push({id:item.id,name:item.name,count:lunitTypeArray.length})
                    lunique[item.id] = item;

            )

            $.each(mainunitsTypeArray, (key,item)->
                if (!munique[item.id])
                    munitTypeArray = []
                    status = App.currentStore.status.findWhere({'name':'Available'})
                    count = App.currentStore.unit.where({unitType:item.id,'status':status.get('id')})
                    $.each(count, (index,value)->

                        mediumUnits = App.currentStore.range.findWhere({name:'medium'})
                        if (value.get('floor') >= mediumUnits.get('start') &&  value.get('floor') <= mediumUnits.get 'end') && item.id == value.get('unitType')
                            munitTypeArray.push value.get 'id'
                    )
                    mnewarr.push({id:item.id,name:item.name,count:munitTypeArray.length})
                    munique[item.id] = item;


            )

            $.each(mainunitsTypeArray, (key,item)->
                if (!hunique[item.id])
                    hunitTypeArray = []
                    status = App.currentStore.status.findWhere({'name':'Available'})
                    count = App.currentStore.unit.where({unitType:item.id,'status':status.get('id')})

                    $.each(count, (index,value)->
                        highUnits = App.currentStore.range.findWhere({name:'high'})
                        if (value.get('floor') >= highUnits.get('start') &&  value.get('floor') <= highUnits.get 'end') && item.id == value.get('unitType')
                            hunitTypeArray.push value.get 'id'
                    )
                    hnewarr.push({id:item.id,name:item.name,count:hunitTypeArray.length})
                    hunique[item.id] = item;


            )




            console.log hnewarr
            [hnewarr,mnewarr,lnewarr]






    msgbus.registerController 'popup', PopupController