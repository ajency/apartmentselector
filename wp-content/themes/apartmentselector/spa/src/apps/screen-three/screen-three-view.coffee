define [ 'marionette' ], ( Marionette )->

    flag_set = 0
    unitVariantArray = ''
    unitVariantIdArray = []
    unitVariantString = ''
    firstElement = ''
    tagsArray = []
    count = 0
    object1 = ""
    unitVariants = []
    cloneunitVariantArrayColl = ""
    rangeunitArray =[]
    globalUnitArrayInt = []
    position = ""
    unitAssigedArray = []
    sudoSlider = ""
    class ScreenThreeLayout extends Marionette.LayoutView

        template : '<div class="text-center subTxt m-b-20 unittype hidden animated pulse">We have <span class="bold text-primary"> {{countUnits }} </span> <strong>{{selection}}</strong> apartments in this floor range of the selected tower.</div>
                    <div class="text-center subTxt m-b-20 budget hidden animated pulse">We have <span class="bold text-primary"> {{countUnits }} </span>  apartments in the budget of <strong>{{selection}}</strong> in this floor range of the selected tower.</div>
                    <div class="text-center subTxt m-b-20 refresh hidden animated pulse">You just refreshed the page. You are now seeing <span class="bold text-primary">All</span> apartments across all the towers.</div>
                    <div class="text-center subTxt m-b-20 All hidden animated pulse">You are seeing <span class="bold text-primary">All</span> apartments in the selected floor range of the tower.</div>
                    <div class="introTxt text-center">These apartments are available in different size variations on different floors of the tower. Click on any available apartment for more details. <!--<br><em>(You can scroll between towers to see other options.)</em>--></div>
                    <div class="text-center light">
                        You are seeing 
                        <div id="tagslist1" class="taglist">
                          <ul></ul>
                        </div>
                        <span class="text-primary variantToggle"></span>variants of your apartment selection
                    </div>

                    <div class="variantBox">
                        <div class="pull-left m-l-15">
                            <input type="checkbox" name="unselectall" id="unselectall" class="checkbox" value="0" checked/>
                            <label for="unselectall">Select/Unselect All</label>
                        </div>
                        <div class="text-right"><span class="variantClose glyphicon glyphicon-remove text-grey"></span></div>
                        <div class="grid-container">

                            {{#unitVariants}}
                            <div class="grid-block-3" >
                                <a class="grid-link selected" href="#" id="gridlink{{id}}" data-id="{{id}}">
                                    {{sellablearea}} Sq.ft.<input type="hidden" name="checklink{{id}}"   id="checklink{{id}}"   value="1" />
                                </a>
                            </div>
                            {{/unitVariants}}

                            <div class="variantAction m-t-5 m-b-20">
                                <a class="btn btn-primary m-r-10 done">DONE</a>
                                <a class="btn btn-default cancel">CANCEL</a>
                            </div>
                        </div>
                    </div>
                    <div class="row m-l-0 m-r-0 m-t-20 bgClass">

                        <div class="col-sm-4">
                            <div id="vs-container" class="vs-container">
                                <header class="vs-header" id="building-region"></header>
                                <div id="floorsvg" class="floorSvg"></div>
                                <div  id="unit-region"></div>
                            </div>

                            <div class="h-align-middle m-t-20 m-b-20">
                                <a href="#screen-three-region" class="btn btn-default btn-lg disabled" id="screen-three-button">Show Unit</a>
                            </div>
                        </div>

                        <div class="col-sm-8 b-grey b-l rightTowerSvg">
                            <div id="positionsvg" class="positionSvg">
                                
                            </div>
                            <div class="radarBox"></div>
                        </div>

                    </div>'




        className : 'page-container row-fluid'





        regions :
            buildingRegion : '#building-region'
            unitRegion : '#unit-region'

        object = @

        events:
            'click .customLink':(e)->
                id = parseInt(e.target.id)
                for element , index in unitAssigedArray
                    if element == parseInt(id)
                        $('#'+element).attr('class','floor-pos position')
                    else
                        $('#'+element).attr('class','floor-pos ')
                $('#'+id).attr('class','floor-pos position')        
                unitAssigedArray.push id
                @loadsvg(id)

            'click .unit-hover':(e)->
                buildingCollection  = Marionette.getOption( @, 'buildingCollection' )
                buildinArray = buildingCollection.toArray()
                building  = _.first(buildinArray)
                buildingModel = App.master.building.findWhere({id:parseInt(building.get('id'))})
                svgdata = buildingModel.get 'svgdata'
                #svgdata = [[svposition:[1],svgfile:"../wp-content/uploads/2014/08/image/floor-pos-1.svg",units:{1:{1:49,2:55,3:61,4:67,5:73,6:80,7:85,8:90,9:98,10:113,11:142,12:152}}]]
                svgposition = ""
                unitvalues = ""
                indexvalue = ""
                $.each(svgdata, (index,value)->
                    if value.svgposition != null
                        $.each(value.svgposition, (index1,val1)->
                                if position == parseInt(val1)
                                    svgposition = value.svgfile
                                    unitsarray = value.units
                                    indexvalue = unitsarray[position]
                                    


                                )
                        



                       



                    )
                flatid = $('#'+e.target.id).attr('data-id')
                $.map(indexvalue, (index,value)->
                                    if App.defaults['floor'] != "All"
                                        floorArr  = App.defaults['floor'].split(',')
                                        $.each(floorArr, (ind,val)->
                                            if parseInt(value) == parseInt(val)
                                                $('#f'+value).attr('class', 'unit-hover range')
                                                $('#t'+value).attr('class', 'unit-hover range')



                                            )
                                    else
                                        $('#f'+value).attr('class', 'unit-hover range')
                                        $('#t'+value).attr('class', 'unit-hover range')


                                        )
                $("#"+e.target.id).attr('class','selected-flat')
                $("#t"+flatid).attr('class','selected-flat')
                unit = indexvalue[parseInt(flatid)]
                unitModel = App.master.unit.findWhere(id:parseInt(unit))
                for element , index in unitAssigedArray
                    if element == parseInt(unitModel.get('unitAssigned'))
                        $('#'+element).attr('class','floor-pos position')
                    else
                        $('#'+element).attr('class','floor-pos ')
                        
                unitAssigedArray.push unitModel.get('unitAssigned')
                $('#'+unitModel.get('unitAssigned')).attr('class','position')
                sudoSlider.goToSlide(unitModel.get('unitAssigned'));
                for element , index in rangeunitArray
                    if element == parseInt(unit)
                        $("#select"+unit).val '1'
                    else
                        $("#select"+element).val '0'
                        $('#check'+element).removeClass 'selected'
                        rangeunitArray = []
                rangeunitArray.push parseInt(unit)
                $('#check'+unit).addClass "selected"

                $("#select"+unit).val "1"
                $("#screen-three-button").removeClass 'disabled btn-default'
                $("#screen-three-button").addClass 'btn-primary'

            'click .unselected-floor':(e)->
                buildingCollection  = Marionette.getOption( @, 'buildingCollection' )
                buildinArray = buildingCollection.toArray()
                building  = _.first(buildinArray)
                buildingModel = App.master.building.findWhere({id:parseInt(building.get('id'))})
                svgdata = buildingModel.get 'svgdata'
                floorriserange = buildingModel.get 'floorriserange'
                #svgdata = [[svposition:[1],svgfile:"../wp-content/uploads/2014/08/image/floor-pos-1.svg",units:{1:{1:49,2:55,3:61,4:67,5:73,6:80,7:85,8:90,9:98,10:113,11:142,12:152}}]]
                svgposition = ""
                unitvalues = ""
                indexvalue = ""
                $.each(svgdata, (index,value)->
                    if value.svgposition != null
                        $.each(value.svgposition, (index1,val1)->
                                if position == parseInt(val1)
                                    svgposition = value.svgfile
                                    unitsarray = value.units
                                    indexvalue = unitsarray[position]
                                    


                                )
                        



                       



                    )
                flatid = $('#'+e.target.id).attr('data-id')
                unit = indexvalue[parseInt(flatid)]
                unitModel = App.master.unit.findWhere(id:parseInt(unit))
                rangeArrayVal = []
                $.each(floorriserange, (index,value)->
                    rangeArrayVal = []
                    i = 0

                    start = parseInt(value.start)
                    end = parseInt(value.end)
                    while parseInt(start) <= parseInt(end)
                        rangeArrayVal[i] = start
                        start = parseInt(start) + 1
                        i++
                    if jQuery.inArray(parseInt(unitModel.get('floor')),rangeArrayVal) >= 0
                        App.defaults['floor'] = rangeArrayVal.join(',')



                )
                $.map(indexvalue, (index,value)->
                    $('#f'+value).attr('class', 'unselected-floor range')
                )
                $.map(indexvalue, (index,value)->
                                    if App.defaults['floor'] != "All"
                                        floorArr  = App.defaults['floor'].split(',')
                                        $.each(floorArr, (ind,val)->
                                            if parseInt(value) == parseInt(val)
                                                $('#f'+value).attr('class', 'unit-hover range')
                                                $('#t'+value).attr('class', 'unit-hover range')



                                            )
                                    else
                                        $('#f'+value).attr('class', 'unselected-floor range')
                                        $('#t'+value).attr('class', 'unselected-floor range')


                                        )
                $("#"+e.target.id).attr('class','selected-flat')
                $("#t"+flatid).attr('class','selected-flat')
                
                
                @trigger "load:range:data", unitModel
                

            'mouseover .disable':(e)->
                buildingCollection  = Marionette.getOption( @, 'buildingCollection' )
                buildinArray = buildingCollection.toArray()
                building  = _.first(buildinArray)
                buildingModel = App.master.building.findWhere({id:parseInt(building.get('id'))})
                svgdata = buildingModel.get 'svgdata'
                #svgdata = [[svposition:[1],svgfile:"../wp-content/uploads/2014/08/image/floor-pos-1.svg",units:{1:{1:49,2:55,3:61,4:67,5:73,6:80,7:85,8:90,9:98,10:113,11:142,12:152}}]]
                svgposition = ""
                unitvalues = ""
                indexvalue = ""
                $.each(svgdata, (index,value)->
                    if value.svgposition != null
                        $.each(value.svgposition, (index1,val1)->
                                if position == parseInt(val1)
                                    svgposition = value.svgfile
                                    unitsarray = value.units
                                    indexvalue = unitsarray[position]
                                    


                                )
                        



                       



                    )
                flatid = $('#'+e.target.id).attr('data-id')
                unit = indexvalue[parseInt(flatid)]

                unitModel = App.master.unit.findWhere(id:parseInt(unit))
                $('#t'+flatid).text unitModel.get('name')

            'mouseover .unit-hover':(e)->
                buildingCollection  = Marionette.getOption( @, 'buildingCollection' )
                buildinArray = buildingCollection.toArray()
                building  = _.first(buildinArray)
                buildingModel = App.master.building.findWhere({id:parseInt(building.get('id'))})
                svgdata = buildingModel.get 'svgdata'
                #svgdata = [[svposition:[1],svgfile:"../wp-content/uploads/2014/08/image/floor-pos-1.svg",units:{1:{1:49,2:55,3:61,4:67,5:73,6:80,7:85,8:90,9:98,10:113,11:142,12:152}}]]
                svgposition = ""
                unitvalues = ""
                indexvalue = ""
                $.each(svgdata, (index,value)->
                    if value.svgposition != null
                        $.each(value.svgposition, (index1,val1)->
                                if position == parseInt(val1)
                                    svgposition = value.svgfile
                                    unitsarray = value.units
                                    indexvalue = unitsarray[position]
                                    


                                )
                        



                       



                    )
                flatid = $('#'+e.target.id).attr('data-id')
                unit = indexvalue[parseInt(flatid)]

                unitModel = App.master.unit.findWhere(id:parseInt(unit))
                $('#t'+flatid).text unitModel.get('name')
                checktrack = @checkSelection(unitModel)
                if checktrack == 1 && parseInt(unitModel.get('status')) == 9
                    $("#"+e.target.id).attr('class','unit-hover range aviable')
                else if checktrack == 1 &&  parseInt(unitModel.get('status')) == 8
                    $("#"+e.target.id).attr('class','sold')
                else
                    $("#"+e.target.id).attr('class','other')

            'mouseover .unselected-floor':(e)->
                buildingCollection  = Marionette.getOption( @, 'buildingCollection' )
                buildinArray = buildingCollection.toArray()
                building  = _.first(buildinArray)
                buildingModel = App.master.building.findWhere({id:parseInt(building.get('id'))})
                svgdata = buildingModel.get 'svgdata'
                #svgdata = [[svposition:[1],svgfile:"../wp-content/uploads/2014/08/image/floor-pos-1.svg",units:{1:{1:49,2:55,3:61,4:67,5:73,6:80,7:85,8:90,9:98,10:113,11:142,12:152}}]]
                svgposition = ""
                unitvalues = ""
                indexvalue = ""
                $.each(svgdata, (index,value)->
                    if value.svgposition != null
                        $.each(value.svgposition, (index1,val1)->
                                if position == parseInt(val1)
                                    svgposition = value.svgfile
                                    unitsarray = value.units
                                    indexvalue = unitsarray[position]
                                    


                                )
                        



                       



                    )
                flatid = $('#'+e.target.id).attr('data-id')
                unit = indexvalue[parseInt(flatid)]

                unitModel = App.master.unit.findWhere(id:parseInt(unit))
                $('#t'+flatid).text unitModel.get('name')
                checktrack = @checkSelection(unitModel)
                if checktrack == 1 && parseInt(unitModel.get('status')) == 9
                    $("#"+e.target.id).attr('class','unselected-floor aviable')
                else if checktrack == 1 &&  parseInt(unitModel.get('status')) == 8
                    $("#"+e.target.id).attr('class','sold')
                else
                    $("#"+e.target.id).attr('class','other')



            'click #screen-three-button':(e)->
                $('#screen-four-region').addClass 'section'
                @trigger 'unit:item:selected'

            'click a':(e)->
                e.preventDefault()

            'click .grid-link':(e)->
                count = unitVariantArray.length
                id = $('#'+e.target.id).attr('data-id')
                track = 0
                if $('#checklink'+id).val() == '1'
                    index = unitVariantArray.indexOf(parseInt(id))
                    if index != -1
                        unitVariantArray.splice( index, 1 )
                        $('#checklink'+id).val '0'
                        track = 0
                        unitVariantIdArray.push(parseInt(id))
                else
                    track = 1
                    unitVariantArray.push(parseInt(id))
                    $('#checklink'+id).val '1'


                if globalUnitArrayInt.length != 0
                    if track == 0
                        unitVariantArray = _.intersection(unitVariantArray,globalUnitArrayInt)
                    else
                        globalUnitArrayInt.push(parseInt(id))
                        unitVariantArray = globalUnitArrayInt

                unitVariantArray = _.uniq(unitVariantArray)
                if unitVariantArray.length == 0
                    unitVariantString = firstElement.toString()

                else



                    if cloneunitVariantArrayColl.length == unitVariantArray.length
                        unitVariantString = 'All'

                    else
                        unitVariantString = unitVariantArray.join(',')
                if unitVariantString == "All"
                    $('#unselectall' ).prop 'checked', true
                else
                    $('#unselectall' ).prop 'checked', false



            'click .done':(e)->
                App.layout.screenFourRegion.el.innerHTML = ""
                App.navigate "screen-three"
                App.currentStore.unit.reset UNITS
                App.currentStore.building.reset BUILDINGS
                App.currentStore.unit_type.reset UNITTYPES
                App.currentStore.unit_variant.reset UNITVARIANTS
                console.log cloneunitVariantArrayColl.length
                console.log unitVariantArray.length
                if unitVariantString == "" || parseInt(cloneunitVariantArrayColl.length) == parseInt(unitVariantArray.length)
                    unitVariantString = "All"
                App.defaults['unitVariant'] = unitVariantString
                App.backFilter['screen2'].push "unitVariant"
                App.filter(params={})
                @trigger 'unit:variants:selected'

            'click .cancel':(e)->
                unitVariantArray = _.union(unitVariantArray,unitVariantIdArray)
                $(".variantBox").slideToggle()
                globalUnitVariants = App.defaults['unitVariant'].split(',')
                globalUnitArrayInt = []
                $.each(globalUnitVariants, (index,value)->
                    globalUnitArrayInt.push(parseInt(value))
                )

                if App.defaults['unitVariant'] != 'All'
                    $.each(unitVariantArray, (index,value)->
                        key = _.contains(globalUnitArrayInt,parseInt(value))
                        if key == true
                            $('#gridlink'+value).addClass 'selected'
                            $('#checklink'+value).val '1'
                        else
                            $('#gridlink'+value).removeClass 'selected'
                            $('#checklink'+value).val '0'
                    )
            'click #unselectall':(e)->
                if $('#'+e.target.id).prop('checked') == true
                    cloneunitVariantArrayColl.each ( index)->
                        $('#gridlink'+index.get('id')).addClass 'selected'
                        $('#checklink'+index.get('id')).val '1'
                        unitVariantArray.push(index.get('id'))
                    unitVariantArray = _.uniq(unitVariantArray)


                    units = cloneunitVariantArrayColl.toArray()
                    units.sort(  (a,b)->
                        a.get('id') - b.get('id')
                    )
                    unitVariantString = 'All'
                else
                    tempArray = []
                    cloneunitVariantArrayColl.each ( value)->
                        tempArray.push(parseInt(value.get('id')))


                    value = _.first(tempArray)
                    remainainArray = _.rest(tempArray)
                    $.each(remainainArray, (index,value)->
                        $('#gridlink'+value).removeClass 'selected'
                        $('#checklink'+value).val '0'
                        index = unitVariantArray.indexOf(parseInt(value))
                        if index != -1
                            unitVariantArray.splice( index, 1 )


                    )
                    unitVariantString = value.toString()

        onShow:->
            unitVariantString = ""
            $('#screen-three-button').on('click',  ()->
                new jBox('Notice', 
                    content: 'Wait 1 Second',
                    autoClose: 2000
                    addClass: 'notifyBox'
                    position:
                        x: 'center'
                        y: 'top'
                    animation:
                        open: 'slide:top'
                        close: 'slide:top'
                    # fade: 1000
                )




            )
            
                
            $('#mainsvg' ).text ""
            
            rangeunitArray= []
            globalUnitArrayInt = []

            @loadbuildingsvg()
            
            $('#sliderplans').liquidSlider(
                slideEaseFunction: "fade",
                autoSlide: true,
                includeTitle:false,
                fadeOutDuration: 1000,
                minHeight: 500,
                forceAutoSlide: true,
                autoSlideInterval: 5000,
                dynamicArrows: false,
                fadeInDuration: 1000
            )
            if App.screenOneFilter['key'] == 'unitType'
                $('.unittype' ).removeClass 'hidden'
            else if App.screenOneFilter['key'] == 'budget'
                $('.budget' ).removeClass 'hidden'
            else if App.defaults['floor'] == 'All'
                $('.refresh' ).removeClass 'hidden'
            else
                $('.All' ).removeClass 'hidden'


            
            $columns_number = $('.unitTable .cd-table-container').find('.cd-block').length

            $('.cd-table-container').on('scroll', ()->
                $this = $(this)
                total_table_width = parseInt($('.cd-table-wrapper').css('width').replace('px', ''))
                table_viewport = parseInt($('.unitTable').css('width').replace('px', ''))
                if( $this.scrollLeft() >= total_table_width - table_viewport - $columns_number)
                    $('.unitTable').addClass('table-end');
                    $('.cd-scroll-right').hide()
                else
                    $('.unitTable').removeClass('table-end')
                    $('.cd-scroll-right').show()
            )
            $('.cd-scroll-right').on('click', ()->
                $this= $(this)
                column_width = $(this).siblings('.cd-table-container').find('.cd-block').eq(0).css('width').replace('px', '')
                new_left_scroll = parseInt($('.cd-table-container').scrollLeft()) + parseInt(column_width)
                $('.cd-table-container').animate( {scrollLeft: new_left_scroll}, 200 )
            )

            $(".variantToggle").click ->
                $(this).toggleClass("open")
                $(".variantBox").slideToggle()
                return

            $(".variantClose").click ->
                $(".variantBox").slideToggle()
                $(".variantToggle").toggleClass("open")
                return

            $(".grid-link").click  (e)->
                $(this).toggleClass("selected")
                return

            unitVariantArray  = Marionette.getOption( @, 'uintVariantId' )
            unitVariantsArray  = Marionette.getOption( @, 'unitVariants' )
            unitVariantArrayColl = new Backbone.Collection unitVariantsArray
            cloneunitVariantArrayColl = unitVariantArrayColl.clone()
            unitVariants  = unitVariantArray
            firstElement = _.first(unitVariantArray)
            globalUnitVariants = App.defaults['unitVariant'].split(',')


            if App.defaults['unitVariant'] != 'All'
                globalUnitVariants = App.defaults['unitVariant'].split(',')
                $.each(globalUnitVariants, (index,value)->
                    globalUnitArrayInt.push(parseInt(value))

                )
            selectedArray = []
            if App.defaults['unitVariant'] != 'All'
                unitVariantArray = _.union(unitVariantArray,unitVariantIdArray)
                $.each(unitVariantArray, (index,value)->
                    key = _.contains(globalUnitArrayInt,parseInt(value))
                    if key == true
                        $('#gridlink'+value).addClass 'selected'
                        $('#checklink'+value).val '1'
                        selectedArray.push value
                    else
                        index = unitVariantArray.indexOf(parseInt(value))
                        $('#gridlink'+value).removeClass 'selected'
                        $('#checklink'+value).val '0'

                )
            else
                unitVariantArray = unitVariantArray
                $.each(unitVariantArray, (index,value)->
                    $('#gridlink'+value).addClass 'selected'
                    $('#checklink'+value).val '1'
                    selectedArray.push value

                )
            App.defaults['unitVariant'] = selectedArray.join(',')
            App.backFilter['screen2'].push "unitVariant"
            console.log selectedArray
            console.log unitVariantArray
            if unitVariantString == "All" || App.defaults['unitVariant'] == "All" || selectedArray.length == unitVariantArray.length
                $('#unselectall' ).prop 'checked', true
            else
                $('#unselectall' ).prop 'checked', false











            $('html, body').delay(600).animate({
                scrollTop: $('#screen-three-region').offset().top
            }, 'slow');

            tagsArray = []
            testtext = App.defaults['unitVariant']
            if parseInt(selectedArray.length) != parseInt(unitVariantArray.length)
                console.log selectedArray
                unitVariantArrayText = selectedArray
                $.each(unitVariantArrayText, (index,value)->
                    unitVariantModel = App.master.unit_variant.findWhere({id:parseInt(value)})
                    tagsArray.push({id:value , area : unitVariantModel.get('sellablearea')+'Sq.ft.'})


                )
            else
                unitVariantArrayText = testtext.split(',')
                tagsArray.push({id:'All' , area : 'All'})

            @doListing()
            object1 = @
            
            
            
            
        $(document).on("click", ".closeButton1",  ()->
                theidtodel = $(this).parent('li').attr('id')
                object1.delItem($('#' + theidtodel).attr('data-itemNum'))
        )
        loadbuildingsvg:->
            console.log buildingCollection  = Marionette.getOption( @, 'buildingCollection' )
            buildinArray = buildingCollection.toArray()
            console.log building  = _.first(buildinArray)
            buildingModel = App.master.building.findWhere({id:parseInt(building.get('id'))})
            svgdata = buildingModel.get 'svgdata'
            floor_layout_Basic = buildingModel.get('floor_layout_basic').image_url
            #svgdata = [[svposition:[1],svgfile:"../wp-content/uploads/2014/08/image/floor-pos-1.svg",units:[1:[1:49,2:55,3:61,4:67,5:73,6:80,7:85,8:90,9:98,10:113,11:142,12:152]]]]
            if floor_layout_Basic != ""
                path = floor_layout_Basic
                $('<div></div>').load(path,  (x)->$('#'+1).attr('class','floor-pos position');unitAssigedArray.push("1")).appendTo("#floorsvg")
            else
                path = ""
            
            @loadsvg()

        loadsvg:(floorid)->
            buildingCollection  = Marionette.getOption( @, 'buildingCollection' )
            buildinArray = buildingCollection.toArray()
            console.log building  = _.first(buildinArray)
            buildingModel = App.master.building.findWhere({id:parseInt(building.get('id'))})
            floorange = buildingModel.get('floorriserange')
            lowrange = floorange[0]
            mediumrange = floorange[1]
            highrange = floorange[2]
            #svgpath = buildingModel.get 'svgfile'
            svgdata = buildingModel.get 'svgdata'
            #svgdata = [[svposition:[1],svgfile:"../wp-content/uploads/2014/08/image/floor-pos-1.svg",units:{1:{1:49,2:55,3:61,4:67,5:73,6:80,7:85,8:90,9:98,10:113,11:142,12:152}}]]
            if floorid == undefined
                floorid = 1
            
                
            
            
            svgposition = ""
            unitvalues = ""
            indexvalue = ""
            $('#positionsvg').text ""
            $.each(svgdata, (index,value)->
                if value.svgposition != null
                    $.each(value.svgposition, (index1,val1)->
                            if floorid == parseInt(val1)
                                svgposition = value.svgfile
                                unitsarray = value.units
                                indexvalue = unitsarray[floorid]
                                if value.svgfile != ""
                                    $('#positionsvg').load(svgposition,  (x)->
                                        $.map(indexvalue, (index,value)->
                                            $('#f'+value).attr('class', 'unselected-floor')
                                        )
                                        $.map(indexvalue, (index1,value1)->
                                            if App.defaults['floor'] != "All"
                                                floorArr  = App.defaults['floor'].split(',')
                                                $.each(floorArr, (ind,val)->
                                                    if parseInt(value1) == parseInt(val)
                                                        $('#f'+value1).attr('class', 'unit-hover range')
                                                        $('#t'+value1).attr('class', 'unit-hover range')



                                                    )
                                            else 
                                                $('#f'+value1).attr('class', 'unit-hover range')
                                                $('#t'+value1).attr('class', 'unit-hover range')

                                            )
                                        rangClass = ['LOWRISE','MIDRISE','HIGHRISE']
                                        i= 0
                                        $.each(floorange, (index,value)->
                                                start = parseInt(value.start)
                                                end = parseInt(value.end)
                                                while parseInt(start) <= parseInt(end)
                                                    $('#c'+start).attr('class',rangClass[i])
                                                    $('#c'+start).text rangClass[i]
                                                    start++
                                                i++
                                        )


                                        )


                            )
                    



                    



                )
            position = floorid

        checkSelection:(model)->
            myArray = []
            $.map(App.defaults, (value, index)->
                if value!='All' && index != 'floor'
                    myArray.push({key:index,value:value})

            )
            flag = 0
            object = @
            track = 0
            $.each(myArray, (index,value)->
                paramKey = {}
                if value.key == 'budget'
                    buildingModel = App.master.building.findWhere({'id':model.get 'building'})
                    floorRise = buildingModel.get 'floorrise'
                    floorRiseValue = floorRise[model.get 'floor']
                    unitVariantmodel = App.master.unit_variant.findWhere({'id':model.get 'unitVariant'})
                    #unitPrice = (parseInt( unitVariantmodel.get('persqftprice')) + parseInt(floorRiseValue)) * parseInt(unitVariantmodel.get 'sellablearea')
                    unitPrice = model.get 'unitPrice'
                    budget_arr = value.value.split(' ')
                    budget_price = budget_arr[0].split('-')
                    budget_price[0] = budget_price[0]+'00000'
                    budget_price[1] = budget_price[1]+'00000'
                    if parseInt(unitPrice) >= parseInt(budget_price[0]) && parseInt(unitPrice) <= parseInt(budget_price[1])
                        flag++
                else if value.key != 'floor'
                    temp = []
                    temp.push value.value
                    tempstring = temp.join(',')
                    initvariant = tempstring.split(',')
                    if initvariant.length > 1
                        for element in initvariant
                           if model.get(value.key) == parseInt(element)
                                flag++ 
                    else
                        if model.get(value.key) == parseInt(value.value)
                            flag++

                   


            )
            if flag == myArray.length
                track =1



            if myArray.length == 0
                track = 1
            track
        
        onShowRangeData:(unitModel,collection)->
            object = @
            unitcoll = collection.toArray()
            $.each(unitcoll, (index,value)->
                units = value.get('units')
                units.each( (item)->
                    object.checkClassSelection(item)


                    )
                

                )
            
            buildingCollection  = Marionette.getOption( @, 'buildingCollection' )
            buildinArray = buildingCollection.toArray()
            building  = _.first(buildinArray)
            buildingModel = App.master.building.findWhere({id:parseInt(building.get('id'))})
            exceptionObject = buildingModel.get 'floorexceptionpositions'
            floorLayoutimage = ""
            #floorLayoutimage = buildingModel.get('floor_layout_basic').image_url

            #if floorLayoutimage != ""
                #pos = unitModel.get('unitAssigned')
                #$('<div></div>').load(floorLayoutimage,  (x)->$('#'+pos).attr('class','floor-pos position');unitAssigedArray.push(pos)).appendTo("#floorsvg")
           

            for element , index in unitAssigedArray
                    if element == parseInt(unitModel.get('unitAssigned'))
                        $('#'+element).attr('class','floor-pos position')
                    else
                        $('#'+element).attr('class','floor-pos ')
                        
            unitAssigedArray.push unitModel.get('unitAssigned')
            $('#'+unitModel.get('unitAssigned')).attr('class','position')
            sudoSlider.goToSlide(unitModel.get('unitAssigned'));
            for element , index in rangeunitArray
                if element == parseInt(unitModel.get('id'))
                    $("#select"+unitModel.get('id')).val '1'
                else
                    $("#select"+element).val '0'
                    $('#check'+element).removeClass 'selected'
                    rangeunitArray = []
            rangeunitArray.push parseInt(unitModel.get('id'))
            $('#check'+unitModel.get('id')).addClass "selected"

            $("#select"+unitModel.get('id')).val "1"
            $("#screen-three-button").removeClass 'disabled btn-default'
            $("#screen-three-button").addClass 'btn-primary'

        checkClassSelection:(model)->
            myArray = []
            $.map(App.defaults, (value, index)->
                if value!='All' && index != 'floor'
                    myArray.push({key:index,value:value})

            )
            flag = 0
            object = @
            track = 0
            $.each(myArray, (index,value)->
                paramKey = {}
                if value.key == 'budget'
                    buildingModel = App.master.building.findWhere({'id':model.get 'building'})
                    floorRise = buildingModel.get 'floorrise'
                    floorRiseValue = floorRise[model.get 'floor']
                    unitVariantmodel = App.master.unit_variant.findWhere({'id':model.get 'unitVariant'})
                    #unitPrice = (parseInt( unitVariantmodel.get('persqftprice')) + parseInt(floorRiseValue)) * parseInt(unitVariantmodel.get 'sellablearea')
                    unitPrice = model.get 'unitPrice'
                    budget_arr = value.value.split(' ')
                    budget_price = budget_arr[0].split('-')
                    budget_price[0] = budget_price[0]+'00000'
                    budget_price[1] = budget_price[1]+'00000'
                    if parseInt(unitPrice) >= parseInt(budget_price[0]) && parseInt(unitPrice) <= parseInt(budget_price[1])
                        flag++
                else if value.key != 'floor'
                    temp = []
                    temp.push value.value
                    tempstring = temp.join(',')
                    initvariant = tempstring.split(',')
                    if initvariant.length > 1
                        for element in initvariant
                           if model.get(value.key) == parseInt(element)
                                flag++ 
                    else
                        if model.get(value.key) == parseInt(value.value)
                            flag++



            )
            if flag == myArray.length
                track =1



            if myArray.length == 0
                track = 1
            
            if track==1 && model.get('status') == 9 && model.get('unitType') != 14
                $('#check'+model.get("id")).addClass 'boxLong filtered'
                $('#flag'+model.get("id")).val '1'
            else if track==1 &&  model.get('status') == 8 && model.get('unitType') != 14
                $('#check'+model.get("id")).addClass 'boxLong sold'
            else
                $('#check'+model.get("id")).addClass 'boxLong other'
                $('#check'+model.get("id")).text model.get 'unitTypeName'



            



        doListing:->
            $('#tagslist1 ul li').remove()
            $.each(tagsArray,  (index, value) ->
                $('#tagslist1 ul').append('<li id="uli-item-' + value.id + '" data-itemNum="' + value.id + '"><span class="itemText">' + value.area + '</span><div class="closeButton1"></div></li>')
            )
            if tagsArray.length == 1
                $('.closeButton1').addClass 'hidden'

        delItem:(delnum)->
            removeItem = delnum
            i =0
            key = ""
            $.each(tagsArray, (index,val)->
                if val.id == delnum
                    key = i
                i++

            )
            index = key
            if (index >= 0)
                tagsArray.splice(index, 1)
                $('#uli-item-' + delnum).remove()
                unitvariantarrayValues = []
                $.each(tagsArray , (index,value)->
                    unitvariantarrayValues.push(value.id)

                )
                App.layout.screenFourRegion.el.innerHTML = ""
                App.navigate "screen-three"
                App.defaults['unitVariant'] = unitvariantarrayValues.join(',')
                App.currentStore.unit.reset UNITS
                App.currentStore.building.reset BUILDINGS
                App.currentStore.unit_type.reset UNITTYPES
                App.currentStore.unit_variant.reset UNITVARIANTS
                App.filter(params={})
                @trigger 'unit:variants:selected'







    class BuildingView extends Marionette.ItemView

        template : '<a class="link" >{{name}}</a>'

        tagName : 'li'

        events :
            'click a':(e)->
                e.preventDefault()
            'click .link' : ( e )->
                $( '#tower'+@model.get 'id' ).removeClass 'hidden'
                App.defaults['building'] = @model.get 'id'
                App.filter(params={})
                msgbus.showApp 'header'
                .insideRegion  App.headerRegion
                    .withOptions()

                @trigger 'building:link:selected'



    class UnitTypeChildView extends Marionette.CompositeView

        tagName : 'ul'


        className : 'vs-nav'



        childView : BuildingView













    class unitChildView extends Marionette.ItemView

        template : '

                                                              <div class="pull-left light">
                                                            <h5 class="rangeName bold m-t-5">Floor {{floor}}</h5>
                                                        </div>
                                                        <div class="pull-right text-center">
                                                            <div class="unitNo">{{name}}</div>
                                                            <div class="small">{{unittypename}} {{sellablearea}} Sq.ft.</div>
                                                        </div><input type="hidden" id="flag{{id}}" name="flag{{id}}" value="0"/>
                 <input type="hidden" id="select{{id}}" name="select{{id}}" value="0"/>
                                                        <div class="clearfix"></div>
                                                    '



        className : 'check'

        initialize :->
            @$el.prop("id", 'check'+@model.get("id"))

        events:

            'click ':(e)->
                screenThreeLayout = new ScreenThreeLayout()
                check = screenThreeLayout.checkSelection(@model)
                if check == 1 && @model.get('status') == 9
                    buildingModel = App.master.building.findWhere({id:parseInt(@model.get('id'))})
                    svgdata = [[svposition:[1],svgfile:"../wp-content/uploads/2014/08/image/floor-pos-1.svg",units:{1:{1:49,2:55,3:61,4:67,5:73,6:80,7:85,8:90,9:98,10:113,11:142,12:152}}]]
                    svgposition = ""
                    unitvalues = ""
                    indexvalue = ""
                    $.each(svgdata, (index,value)->
                        $.each(value, (ind,val)->
                            $.map(val.svposition, (index1,val1)->
                                if position == index1
                                    svgposition = val.svgfile
                                    unitsarray = val.units
                                    indexvalue = unitsarray[position]
                                    


                                )
                            



                            )



                        )
                    $('#screen-four-region').removeClass 'section'
                    App.layout.screenFourRegion.el.innerHTML = ""
                    App.navigate "screen-three"
                    App.currentStore.unit.reset UNITS
                    App.currentStore.building.reset BUILDINGS
                    App.currentStore.unit_type.reset UNITTYPES
                    App.currentStore.unit_variant.reset UNITVARIANTS
                    unitModel = App.master.unit.findWhere(id:@model.get("id"))

                    for element , index in rangeunitArray
                        if element == @model.get('id')
                            $("#select"+@model.get('id')).val '1'
                        else
                            $("#select"+element).val '0'
                            $('#check'+element).removeClass 'selected'
                            if unitModel.get('status') == 9
                                $("#"+element).attr('class','unit-hover aviable ')
                            else if unitModel.get('status') == 8
                                $("#"+element).attr('class','unit-hover sold ')
                            rangeunitArray = []
                    if  parseInt($("#select"+@model.get('id')).val()) == 0
                        rangeunitArray.push @model.get('id')
                        $('#check'+@model.get("id")).addClass "selected"

                        $("#select"+@model.get('id')).val "1"
                        object = @
                        $.map(indexvalue,  (index,value)->
                            if App.defaults['floor'] != 'All'
                                floorArr  = App.defaults['floor'].split(',')
                                $.each(floorArr, (ind,val)->
                                    if parseInt(value) == parseInt(val)
                                        $('#f'+value).attr('class', 'unit-hover')
                                        $('#t'+value).text ""



                                )
                            else
                                $('#f'+value).attr('class', 'unit-hover')
                                $('#t'+value).text ""

                        )
                        $.map(indexvalue,  (index,value)->
                            if parseInt(index) == object.model.get("id")
                                positionassigend = value
                                $("#f"+value).attr('class','selected-flat')
                                $("#t"+value).attr('class','selected-flat')
                                $('#t'+value).text object.model.get('name')


                            )
                        $('#'+@model.get("unitAssigned")).attr('class','floor-pos position')
                        App.unit['name'] = @model.get("id")
                        $("#screen-three-button").removeClass 'disabled btn-default'
                        $("#screen-three-button").addClass 'btn-primary'
                        #@trigger 'unit:item:selected'
                    else
                        rangeunitArray=[]
                        $("#select"+@model.get('id')).val "0"
                        $('#check'+@model.get('id')).removeClass 'selected'
                        if unitModel.get('status') == 9
                            $("#"+@model.get("id")).attr('class','unit-hover aviable ')
                        else if unitModel.get('status') == 8
                            $("#"+@model.get("id")).attr('class','unit-hover sold ')
                    if parseInt($("#select"+@model.get('id')).val()) == 0
                        $("#screen-three-button").addClass 'disabled btn-default'
                        $("#screen-three-button").removeClass 'btn-primary'
                        object = @
                        $.map(indexvalue,  (index,value)->
                            if parseInt(index) == object.model.get("id")
                                positionassigend = value
                                $('#f'+positionassigend).attr('class','unit-hover aviable')


                            )
                        $('#'+@model.get("unitAssigned")).attr('class','floor-pos ')
                        return false


        onShow :->
            myArray = []
            $.map(App.defaults, (value, index)->
                if value!='All' && index != 'floor'
                    myArray.push({key:index,value:value})

            )
            flag = 0
            object = @
            track = 0
            $.each(myArray, (index,value)->
                paramKey = {}
                if value.key == 'budget'
                    buildingModel = App.master.building.findWhere({'id':object.model.get 'building'})
                    floorRise = buildingModel.get 'floorrise'
                    floorRiseValue = floorRise[object.model.get 'floor']
                    unitVariantmodel = App.master.unit_variant.findWhere({'id':object.model.get 'unitVariant'})
                    #unitPrice = (parseInt( unitVariantmodel.get('persqftprice')) + parseInt(floorRiseValue)) * parseInt(unitVariantmodel.get 'sellablearea')
                    unitPrice = object.model.get 'unitPrice'
                    budget_arr = value.value.split(' ')
                    budget_price = budget_arr[0].split('-')
                    budget_price[0] = budget_price[0]+'00000'
                    budget_price[1] = budget_price[1]+'00000'
                    if parseInt(unitPrice) >= parseInt(budget_price[0]) && parseInt(unitPrice) <= parseInt(budget_price[1])
                        flag++
                else if value.key != 'floor'
                    temp = []
                    temp.push value.value
                    tempstring = temp.join(',')
                    initvariant = tempstring.split(',')
                    if initvariant.length > 1
                        for element in initvariant
                           if object.model.get(value.key) == parseInt(element)
                                flag++ 
                    else
                        if object.model.get(value.key) == parseInt(value.value)
                            flag++



            )
            if flag == myArray.length
                track =1



            if myArray.length == 0
                track = 1
            
            if track==1 && @model.get('status') == 9 && @model.get('unitType') != 14
                $('#check'+@model.get("id")).addClass 'boxLong filtered'
                $('#flag'+@model.get("id")).val '1'
            else if track==1 &&  @model.get('status') == 8 && @model.get('unitType') != 14
                $('#check'+@model.get("id")).addClass 'boxLong sold'
            else
                $('#check'+@model.get("id")).addClass 'boxLong other'
                $('#check'+@model.get("id")).text @model.get 'unitTypeName'




















    class UnitView extends Marionette.CompositeView

        template : '<div class="unitContainer"></div>'




        childView : unitChildView

        childViewContainer : '.unitContainer'








        initialize :->
            @collection = @model.get 'units'
            @$el.prop("id", @model.get("id"))








    class UnitTypeView extends Marionette.CompositeView

        template : '<div class="unitTable">
                                <div id="unitsSlider" class="unitSlider">
                                    </div></div>'


        childView : UnitView

        childViewContainer : '.unitSlider'

        onShow:->
            sudoSlider = $("#unitsSlider").sudoSlider(
                customLink: "a"
                prevNext: false
                responsive: true
                speed: 800
                # continuous:true
            )


















    ScreenThreeLayout : ScreenThreeLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView


