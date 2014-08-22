define [ 'marionette' ], ( Marionette )->

    flag_set = 0
    unitVariantArray = ''
    unitVariantIdArray = []
    unitVariantString = ''
    firstElement = ''
    tagsArray = []
    count = 0
    object = ""
    unitVariants = []
    cloneunitVariantArrayColl = ""
    rangeunitArray =[]
    globalUnitArrayInt = []

    class ScreenThreeLayout extends Marionette.LayoutView

        template : '<div class="row m-l-0 m-r-0">
                        <div class="col-sm-4">
                    <div class="text-center subTxt m-b-20 unittype hidden animated pulse">We have <span class="bold text-primary"> {{countUnits }} </span> <strong>{{selection}}</strong> apartments in this floor range of the selected tower.</div>
                    <div class="text-center subTxt m-b-20 budget hidden animated pulse">We have <span class="bold text-primary"> {{countUnits }} </span>  apartments in the budget of <strong>{{selection}}</strong> in this floor range of the selected tower.</div>
                    <div class="text-center subTxt m-b-20 refresh hidden animated pulse">You just refreshed the page. You are now seeing <span class="bold text-primary">All</span> apartments across all the towers.</div>
                    <div class="text-center subTxt m-b-20 All hidden animated pulse">You are seeing <span class="bold text-primary">All</span> apartments in the selected floor range of the tower.</div>
                    <div class="introTxt text-center">These apartments are available in different size variations on different floors of the tower. Click on any available apartment for more details. <br><em>(You can scroll between towers to see other options.)</em></div>
                    <div class="introTxt text-center">You are seeing 
                        <div id="tagslist1" class="taglist">
                          <ul></ul>
                        </div><span class="text-primary variantToggle"></span>variants of your apartment selection</div>

                    

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
        <div id="floorsvg">
                                    </div>
                    <div id="vs-container" class="vs-container">
                        <header class="vs-header" id="building-region"></header>
                        <div  id="unit-region"></div>
                    </div>




                    <div class="h-align-middle m-t-20 m-b-20">
                        <a href="#screen-three-region" class="btn btn-default btn-lg disabled" id="screen-three-button">Show Unit</a>
                    </div>

                    

                    </div>
                <div class="col-sm-8">
                    <div class="liquid-slider center-block sliderPlans" id="sliderplans">


                    <div id="svg1">
                    </div>

                    <div id="svg2">
                    </div>

                    <div id="svg3">
                    </div>
                    <div id="svg4">
                    </div>
                    </div>
                    </div>
                    </div>'




        className : 'page-container row-fluid'





        regions :
            buildingRegion : '#building-region'
            unitRegion : '#unit-region'

        events:
            'click .unit-hover':(e)->
                console.log(e.target.id)
                unitModel = App.master.unit.findWhere(id:parseInt(e.target.id))
                for element , index in rangeunitArray
                    if element == e.target.id
                        $("#select"+e.target.id).val '1'
                    else
                        $("#select"+element).val '0'
                        $('#check'+element).removeClass 'selected'
                        if unitModel.get('status') == 9
                            $("#"+element).attr('class','unit-hover aviable ')
                        else if unitModel.get('status') == 8
                            $("#"+element).attr('class','unit-hover sold ')
                        rangeunitArray = []
                rangeunitArray.push parseInt(e.target.id)
                $('#check'+e.target.id).addClass "selected"

                $("#select"+e.target.id).val "1"
                $("#screen-three-button").removeClass 'disabled btn-default'
                $("#screen-three-button").addClass 'btn-primary'

            'mouseover .unit-hover':(e)->
                console.log(e.target.id)

                unitModel = App.master.unit.findWhere(id:parseInt(e.target.id))
                if unitModel.get('status') == 9
                    $("#"+e.target.id).attr('class','unit-hover aviable')
                else if unitModel.get('status') == 8
                    $("#"+e.target.id).attr('class','unit-hover sold')


            'click #screen-three-button':(e)->
                @trigger 'unit:item:selected'

            'click a':(e)->
                e.preventDefault()

            'click .grid-link':(e)->
                console.log unitVariantArray
                count = unitVariantArray.length
                id = $('#'+e.target.id).attr('data-id')
                track = 0
                if $('#checklink'+id).val() == '1'
                    console.log id
                    console.log index = unitVariantArray.indexOf(parseInt(id))
                    if index != -1
                        unitVariantArray.splice( index, 1 )
                        $('#checklink'+id).val '0'
                        track = 0
                        unitVariantIdArray.push(parseInt(id))
                else
                    console.log "aaaaaaaaaa"
                    track = 1
                    unitVariantArray.push(parseInt(id))
                    $('#checklink'+id).val '1'


                console.log unitVariantArray

                console.log globalUnitArrayInt
                if globalUnitArrayInt.length != 0
                    if track == 0
                        console.log track
                        unitVariantArray = _.intersection(unitVariantArray,globalUnitArrayInt)
                    else
                        globalUnitArrayInt.push(parseInt(id))
                        unitVariantArray = globalUnitArrayInt

                unitVariantArray = _.uniq(unitVariantArray)
                console.log firstElement
                if unitVariantArray.length == 0
                    unitVariantString = firstElement.toString()

                else



                    if cloneunitVariantArrayColl.length == unitVariantArray.length
                        unitVariantString = 'All'

                    else
                        unitVariantString = unitVariantArray.join(',')
                console.log unitVariantString
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
                App.defaults['unitVariant'] = unitVariantString
                App.backFilter['screen2'].push "unitVariant"
                App.filter(params={})
                @trigger 'unit:variants:selected'

            'click .cancel':(e)->
                console.log unitVariantIdArray
                unitVariantArray = _.union(unitVariantArray,unitVariantIdArray)
                $(".variantBox").slideToggle()
                console.log globalUnitVariants = App.defaults['unitVariant'].split(',')
                globalUnitArrayInt = []
                $.each(globalUnitVariants, (index,value)->
                    globalUnitArrayInt.push(parseInt(value))
                )

                if App.defaults['unitVariant'] != 'All'
                    $.each(unitVariantArray, (index,value)->
                        console.log value
                        key = _.contains(globalUnitArrayInt,parseInt(value))
                        console.log key
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


                    console.log value = _.first(tempArray)
                    remainainArray = _.rest(tempArray)
                    $.each(remainainArray, (index,value)->
                        $('#gridlink'+value).removeClass 'selected'
                        $('#checklink'+value).val '0'
                        index = unitVariantArray.indexOf(parseInt(value))
                        if index != -1
                            unitVariantArray.splice( index, 1 )


                    )
                    console.log unitVariantArray
                    unitVariantString = value.toString()

        onShow:->
            if unitVariantString == "All" || App.defaults['unitVariant'] == "All"
                $('#unselectall' ).prop 'checked', true
            else
                $('#unselectall' ).prop 'checked', false

            rangeunitArray=[]
            source = "../wp-content/uploads/2014/08/image/1.svg"
            source1 = "../wp-content/uploads/2014/08/image/2.svg"
            source2 = "../wp-content/uploads/2014/08/image/3.svg"
            source3 = "../wp-content/uploads/2014/08/image/4.svg"
            floorsvg = "../wp-content/uploads/2014/08/image/floor.svg"
            $('<div></div>').load(source).appendTo("#svg1")
            $('<div></div>').load(source1).appendTo("#svg2")
            $('<div></div>').load(source2).appendTo("#svg3")
            $('<div></div>').load(source3).appendTo("#svg4")
            $('<div></div>').load(floorsvg).appendTo("#floorsvg")

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


            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/main.js'
            document.body.appendChild(scr)

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

            console.log unitVariantArray  = Marionette.getOption( @, 'uintVariantId' )
            unitVariantsArray  = Marionette.getOption( @, 'unitVariants' )
            unitVariantArrayColl = new Backbone.Collection unitVariantsArray
            cloneunitVariantArrayColl = unitVariantArrayColl.clone()
            console.log unitVariants  = unitVariantArray
            console.log firstElement = _.first(unitVariantArray)
            console.log globalUnitVariants = App.defaults['unitVariant'].split(',')


            if App.defaults['unitVariant'] != 'All'
                globalUnitVariants = App.defaults['unitVariant'].split(',')
                $.each(globalUnitVariants, (index,value)->
                    globalUnitArrayInt.push(parseInt(value))

                )

            if App.defaults['unitVariant'] != 'All'
                console.log unitVariantArray = _.union(unitVariantArray,unitVariantIdArray)
                $.each(unitVariantArray, (index,value)->
                    console.log value
                    key = _.contains(globalUnitArrayInt,parseInt(value))
                    console.log key
                    if key == true
                        $('#gridlink'+value).addClass 'selected'
                        $('#checklink'+value).val '1'
                    else
                        console.log index = unitVariantArray.indexOf(parseInt(value))
                        $('#gridlink'+value).removeClass 'selected'
                        $('#checklink'+value).val '0'

                )
            else
                unitVariantArray = unitVariantArray
                $.each(unitVariantArray, (index,value)->
                    $('#gridlink'+value).addClass 'selected'
                    $('#checklink'+value).val '1'

                )










            $('html, body').animate({
                scrollTop: $('#screen-three-region').offset().top
            }, 'slow');

            tagsArray = []
            console.log testtext = App.defaults['unitVariant']
            if testtext != 'All'
                unitVariantArrayText = testtext.split(',')
                $.each(unitVariantArrayText, (index,value)->
                    console.log value
                    console.log unitVariantModel = App.master.unit_variant.findWhere({id:parseInt(value)})
                    tagsArray.push({id:value , area : unitVariantModel.get('sellablearea')+'Sq.ft.'})


                )
            else
                unitVariantArrayText = testtext.split(',')
                tagsArray.push({id:'All' , area : 'All'})

            @doListing()
            object = @
        $(document).on("click", ".closeButton1",  ()->
                theidtodel = $(this).parent('li').attr('id')
                object.delItem($('#' + theidtodel).attr('data-itemNum'))
        )
        call:->
            console.log "aaaaaaaaaaaaaaaaaaa"


        doListing:->
            $('#tagslist1 ul li').remove()
            $.each(tagsArray,  (index, value) ->
                $('#tagslist1 ul').append('<li id="uli-item-' + value.id + '" data-itemNum="' + value.id + '"><span class="itemText">' + value.area + '</span><div class="closeButton1"></div></li>')
            )
            if tagsArray.length == 1
                $('.closeButton').addClass 'hidden'

        delItem:(delnum)->
            removeItem = delnum
            i =0
            key = ""
            $.each(tagsArray, (index,val)->
                if val.id == delnum
                    key = i
                i++

            )
            console.log index = key
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
                console.log App.defaults['unitVariant']
                App.currentStore.unit.reset UNITS
                App.currentStore.building.reset BUILDINGS
                App.currentStore.unit_type.reset UNITTYPES
                App.currentStore.unit_variant.reset UNITVARIANTS
                App.filter(params={})
                #@trigger 'unit:variants:selected'







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

                App.layout.screenFourRegion.el.innerHTML = ""
                App.navigate "screen-three"
                App.currentStore.unit.reset UNITS
                App.currentStore.building.reset BUILDINGS
                App.currentStore.unit_type.reset UNITTYPES
                App.currentStore.unit_variant.reset UNITVARIANTS
                unitModel = App.master.unit.findWhere(id:@model.get("id"))

                console.log rangeunitArray
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

                    if unitModel.get('status') == 9
                        $("#"+@model.get("id")).attr('class','unit-hover aviable selected')
                    else if unitModel.get('status') == 8
                        $("#"+@model.get("id")).attr('class','unit-hover sold selected')
                    console.log $('#select'+@model.get("id"))
                    App.unit['name'] = @model.get("id")
                    App.backFilter['screen3'].push 'floor'
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
                    return false


        onShow :->
            myArray = []
            $.map(App.defaults, (value, index)->
                if value!='All' && index != 'floor'
                    myArray.push({key:index,value:value})

            )
            console.log myArray
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
                    console.log budget_price[0] = budget_price[0]+'00000'
                    console.log budget_price[1] = budget_price[1]+'00000'
                    if parseInt(unitPrice) >= parseInt(budget_price[0]) && parseInt(unitPrice) <= parseInt(budget_price[1])
                        flag++
                else if value.key != 'floor'

                    console.log value.key
                    console.log value.value
                    if object.model.get(value.key) == parseInt(value.value)
                        console.log  flag++


            )
            if flag == myArray.length
                track =1



            console.log flag
            if myArray.length == 0
                track = 1
            console.log @model.get('unitType')
            console.log @model.get('name')

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
                customLink: "a.customLink"
                prevNext: false
                responsive: true
                speed: 800
                # continuous:true
            )


















    ScreenThreeLayout : ScreenThreeLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView














