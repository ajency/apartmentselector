define [ 'extm', 'src/apps/popup/popup-view' ], ( Extm, PopupView )->

    class PopupController extends Extm.RegionController

        initialize :(opt = {})->

            @getAjaxData()


            


        _getPopupView:(Collection)->
            console.log Collection
            new PopupView
                collection : Collection



        _getUnitsCountCollection:(modelstring)->
            console.log modelstring
            console.log cookeArray = modelstring
            unitModelArray = []
            console.log cookeArray.length
            if cookeArray.length != 0
                for element in cookeArray
                    console.log unitModel = element
                    console.log buildingModel = App.master.building.findWhere({id:unitModel.get 'building'})
                    exceptionObject = buildingModel.get 'floorexceptionpositions'
                    $.each(exceptionObject, (index,value1)->
                        floorvalue = $.inArray( unitModel.get('floor'),value1.floors)
                        if floorvalue == -1
                            floorLayoutimage = buildingModel.get('floor_layout_detailed').thumbnail_url
                        else
                            floorLayoutimage = value1.floor_layout_detailed.thumbnail_url



                            )


                        
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
                    viewModelArray = []
                    facingModelArray = []
                    unitTypeModel = App.master.unit_type.findWhere({id:unitModel.get 'unitType'})
                    unitTypeModelName = unitTypeModel.get('name' ).split(' ')
                    unitVariantModel = App.master.unit_variant.findWhere({id:unitModel.get 'unitVariant'})
                    unitModel.set "sellablearea" ,unitVariantModel.get 'sellablearea'
                    unitModel.set "carpetarea" ,unitVariantModel.get 'carpetarea'
                    unitModel.set "unitTypeName" ,unitTypeModelName[0]
                    unitModel.set "buidlingName" ,buildingModel.get 'name'
                    unitModel.set 'TwoDimage' , unitVariantModel.get('url2dlayout_image')
                    unitModel.set 'ThreeDimage' , unitVariantModel.get('url3dlayout_image')
                    unitModel.set 'floorLayoutimage' , floorLayoutimage
                    console.log unitModel.get('views_name')
                    if unitModel.get('views_name') != ""
                        viewsArray = unitModel.get('views_name')
                        console.log viewsArray.length
                        for element in viewsArray
                            viewModel = App.master.view.findWhere({id:parseInt(element)})
                            viewModelArray.push(viewModel.get('name'))
                    else
                        viewModelArray.push('-----')
                    unitModel.set 'views',viewModelArray.join(',')
                    facingssArray = unitModel.get('facing_name' )
                    if facingssArray.length != 0
                        for element in facingssArray
                            facingModel = App.master.facings.findWhere({id:parseInt(element)})
                            facingModelArray.push(facingModel.get('name'))

                    else
                        facingModelArray.push('-----')

                    unitModel.set 'facings',facingModelArray.join(',')
                    roomSizesObject = unitVariantModel.get 'roomsizes'
                    roomsizearray = []
                    roomTypeArr = [68,71,72,70,66]
                    roomSizesArray = $.map(roomSizesObject, (index,value1)->
                        console.log index
                        console.log value1
                        [index]




                    )
                    console.log roomSizesArray
                    roomsizearr = []
                    mainArr = []
                    console.log roomsizesCollection = new Backbone.Collection roomSizesArray
                    $.each(roomTypeArr, (ind,val)->
                        roomsizearr = []
                        console.log val
                        console.log roomtype = roomsizesCollection.where({room_type_id:parseInt(val)})
                        $.each(roomtype, (index1,value1)->
                            roomsizearr.push({room_size:value1.get('room_size')})


                            )
                        roomsizearr.sort( (a,b)->
                            b - a

                            )
                        if roomsizearr.length == 0
                            roomsizearr.push({room_size:"----------"})
                        mainArr.push({subarray:roomsizearr})


                        )
                        
                    console.log mainArr
                    unitModel.set 'mainArr',mainArr
                    
                    unitModelArray.push(unitModel)
                console.log unitModelArray
                unitCollection = new Backbone.Collection unitModelArray
                
                @view = view = @_getPopupView unitCollection
                @show view


        getAjaxData:->
            console.log localStorage.getItem("cookievalue" )
            console.log cookeArray = localStorage.getItem("cookievalue" ).split(',')
            unitModelArray = []
            modelArray = []
            i = 0
            if cookeArray.length != 0
                for element in cookeArray
                    console.log unitModel = App.master.unit.findWhere({id:parseInt(element)})
                    object = @
                    $.ajax(
                        method: "POST" ,
                        url : AJAXURL+'?action=get_unit_single_details',
                        data : 'id='+unitModel.get('id'),
                        success :(result)-> 
                            i++
                            console.log unitModel1 = App.master.unit.findWhere({id:parseInt(result.id)})
                            console.log result
                            console.log unitModel1
                            unitModel1.set 'persqftprice' , result.persqftprice
                            unitModel1.set 'views_name' , result.views
                            unitModel1.set 'facing_name' , result.facings
                            console.log unitModel1
                            modelArray.push unitModel1
                            if i == cookeArray.length
                                console.log modelArray
                                object._getUnitsCountCollection(modelArray)
                        error:(result)->

                    )

                console.log i
                console.log cookeArray.length
                







    msgbus.registerController 'popup', PopupController