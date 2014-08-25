define [ 'extm', 'src/apps/popup/popup-view' ], ( Extm, PopupView )->

    class PopupController extends Extm.RegionController

        initialize :(opt = {})->

            @Collection = @_getUnitsCountCollection()


            @view = view = @_getPopupView @Collection



            @show view


        _getPopupView:(Collection)->
            console.log Collection
            new PopupView
                collection : Collection


        _getUnitsCountCollection:->
            console.log cookeArray = localStorage.getItem("cookievalue" ).split(',')
            unitModelArray = []
            if cookeArray.length != 0
                for element in cookeArray
                    unitModel = App.master.unit.findWhere({id:parseInt(element)})
                    console.log buildingModel = App.master.building.findWhere({id:unitModel.get 'building'})
                    floorriserange = buildingModel.get 'floorriserange'
                    #floorriserange = [{"name":"low","start":"1","end":"2"},{"name":"medium","start":"3","end":"4"},{"name":"high","start":"5","end":"6"}]
                    rangeArrayVal = []
                    i = 0
                    $.each(floorriserange, (index,value)->
                        rangeArrayVal = []
                        i = 0
                        start = parseInt(value.start)
                        end = parseInt(value.end)
                        while parseInt(start) <= parseInt(end)
                            rangeArrayVal[i] = start
                            start = parseInt(start) + 1
                            i++
                        console.log rangeArrayVal
                        rangename = ""
                        if jQuery.inArray(parseInt(unitModel.get('floor')),rangeArrayVal) >= 0
                            if value.name == "medium"
                                rangename = "mid"
                            else
                                rangename = value.name
                            console.log rangename
                            rangename = _.str.capitalize rangename
                            unitModel.set "flooRange" ,rangename+'rise'



                    )
                    #viewModelArray = []
                    #facingModelArray = []
                    unitTypeModel = App.master.unit_type.findWhere({id:unitModel.get 'unitType'})
                    unitTypeModelName = unitTypeModel.get('name' ).split(' ')
                    unitVariantModel = App.master.unit_variant.findWhere({id:unitModel.get 'unitVariant'})
                    unitModel.set "sellablearea" ,unitVariantModel.get 'sellablearea'
                    unitModel.set "carpetarea" ,unitVariantModel.get 'carpetarea'
                    unitModel.set "unitTypeName" ,unitTypeModelName[0]
                    #viewsArray = unitModel.get('views' ).split(',')
                    #for element in viewsArray
                    #viewModel = App.master.view.findWhere({id:parseInt(element)})
                    #viewModelArray.push(viewModel.get('name'))
                    #unitModel.set 'views',viewModelArray.join(',')
                    #facingssArray = unitModel.get('facing' ).split(',')
                    #for element in facingssArray
                    #facingModel = App.master.facings.findWhere({id:parseInt(element)})
                    #facingModelArray.push(facingModel.get('name'))
                    #unitModel.set 'facings',facingModelArray.join(',')
                    unitModelArray.push(unitModel)
                unitCollection = new Backbone.Collection unitModelArray
                unitCollection







    msgbus.registerController 'popup', PopupController