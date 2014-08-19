define [ 'marionette' ], ( Marionette )->

    flag_set = 0
    unitVariantArray = ''
    unitVariantIdArray = []
    unitVariantString = ''
    firstElement =''
    tagsArray = []
    count = 0
    object = ""



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

                    <div id="vs-container" class="vs-container">
                        <header class="vs-header" id="building-region"></header>
                        <div  id="unit-region"></div>
                    </div>

                    <div class="h-align-middle m-t-20 m-b-20">
                        <a href="#screen-three-region" class="btn btn-default btn-lg disabled" id="screen-three-button">Show Unit</a>
                    </div>

                    

                    </div>
                <div class="col-sm-8">
                    {{#high}}
                    <div class="towerRange">
                        <h3 class="text-primary text-center semi-bold m-t-0"><u>{{rangetext}}</u></h3>
                        <div class="row m-l-0 m-r-0 m-b-20">
                            <div class="col-sm-4 col-xs-12">
                                <img src="../HTML/assets/img/floor-rise.jpg" class="img-responsive center-block">
                            </div>

                            <div class="col-sm-8 col-xs-12 m-t-30">
                                <p>{{text}}</p>
                            </div>
                        </div>
                    </div>
                    {{/high}}
                    </div>
                    </div>'




        className : 'page-container row-fluid'





        regions :
            buildingRegion : '#building-region'
            unitRegion : '#unit-region'

        events:
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
                globalUnitArrayInt = []

                if App.defaults['unitVariant'] != 'All'
                    globalUnitVariants = App.defaults['unitVariant'].split(',')
                    $.each(globalUnitVariants, (index,value)->
                        globalUnitArrayInt.push(parseInt(value))

                    )
                console.log globalUnitArrayInt
                if globalUnitArrayInt.length != 0
                    if track == 0
                        console.log track
                        unitVariantArray = _.intersection(unitVariantArray,globalUnitArrayInt)
                    else
                        globalUnitArrayInt.push(parseInt(id))
                        unitVariantArray = globalUnitArrayInt

                console.log firstElement
                if unitVariantArray.length == 0
                    unitVariantString = firstElement.toString()

                else



                    if count == unitVariantArray.length
                        unitVariantString = 'All'

                    else
                        unitVariantString = unitVariantArray.join(',')



            'click .done':(e)->
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
                    if unitVariantIdArray.length == 0
                        units = unitVariantArray
                    else
                        units = unitVariantIdArray
                    $.each(units, (index,value)->
                        $('#gridlink'+value).addClass 'selected'
                        $('#checklink'+value).val '1'


                    )
                    units.sort(  (a,b)->
                        a - b
                    )
                    console.log unitVariantArray = units
                    unitVariantString = 'All'
                else
                    console.log value = _.first(unitVariantArray)
                    remainainArray = _.rest(unitVariantArray)
                    $.each(remainainArray, (index,value)->
                        $('#gridlink'+value).removeClass 'selected'
                        $('#checklink'+value).val '0'


                    )
                    unitVariantString = value.toString()

        onShow:->
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
            console.log firstElement = _.first(unitVariantArray)
            console.log globalUnitVariants = App.defaults['unitVariant'].split(',')
            globalUnitArrayInt = []
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
        $(document).on("click", ".closeButton",  ()->
                theidtodel = $(this).parent('li').attr('id')
                object.delItem($('#' + theidtodel).attr('data-itemNum'))
        )

        doListing:->
            $('#tagslist1 ul li').remove()
            $.each(tagsArray,  (index, value) ->
                $('#tagslist1 ul').append('<li id="li-item-' + value.id + '" data-itemNum="' + value.id + '"><span class="itemText">' + value.area + '</span><div class="closeButton"></div></li>')
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
                $('#li-item-' + delnum).remove()
                unitvariantarrayValues = []
                $.each(tagsArray , (index,value)->
                    unitvariantarrayValues.push(value.id)

                )
                App.defaults['unitVariant'] = unitvariantarrayValues.join(',')
                console.log App.defaults['unitVariant']
                App.currentStore.unit.reset UNITS
                App.currentStore.building.reset BUILDINGS
                App.currentStore.unit_type.reset UNITTYPES
                App.currentStore.unit_variant.reset UNITVARIANTS
                App.filter(params={})
                @trigger 'unit:variants:selected'







    class BuildingView extends Marionette.ItemView

        template : '<a class="link" href="tower{{id}}">{{name}}</a>'

        tagName : 'li'

        events :
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





    class childViewUnit extends Marionette.ItemView

        template : '<div id="check{{id}}" class="check" >
                        <input type="hidden" id="flag{{id}}" name="flag{{id}}" value="0"/>     												{{name}}
        				<div class="small">{{unitTypeName}} {{unitVariantName}} Sqft</div>
        			</div>'




        className : 'cd-block'

        initialize :->
            @$el.prop("id", 'unit'+@model.get("id"))

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
            if track==1 && @model.get('status') == 9
                $('#check'+@model.get("id")).addClass 'box filtered'
                $('#flag'+@model.get("id")).val '1'
            else if track==1 &&  @model.get('status') == 8
                $('#check'+@model.get("id")).addClass 'box sold'

            else
                $('#check'+@model.get("id")).addClass 'box other'
                $('#check'+@model.get("id")).text @model.get 'unitTypeName'


        events:
            'click .check':(e)->
                console.log $('#flag'+@model.get("id"))
                App.unit['name'] = @model.get("id")
                App.backFilter['screen3'].push 'floor'
                if parseInt($('#flag'+@model.get("id")).val()) == 1
                    console.log $("#screen-three-button")
                    $("#screen-three-button").removeClass 'disabled btn-default'
                    $("#screen-three-button").addClass 'btn-primary'
                    #@trigger 'unit:item:selected'





    class unitChildView extends Marionette.CompositeView

        template : '<div class="clearfix"></div>'



        className : 'cd-table-row'



        childView : childViewUnit






        initialize :->
            @collection = @model.get 'floorunits'

    class emptyChildView extends Marionette.CompositeView

        template : 'No units available for the current selection'

        className : 'noUnits'


    class UnitView extends Marionette.CompositeView

        template : '<div class="vs-content">
                        <div  class="unitTable">
                            <header class="cd-table-column">
                    			<ul>
                                    {{#floorcount}}
                                    <li>
                                        Floor {{id}}
                                    </li>
                                    {{/floorcount}}
                    			</ul>
                    		</header>
                    		<div class="cd-table-container">
                                <div class="cd-table-wrapper">
                                </div>
                            </div>
                            <em class="cd-scroll-right"></em>
                        </div>
                    </div>'




        childView : unitChildView

        emptyView : emptyChildView


        tagName  : "section"

        childViewContainer : '.cd-table-wrapper'


        collectionEvents :
            'reset'  : 'dataUpdated'


        dataUpdated:->
            console.log "aaaaaaaaaaaaa"






        initialize :->
            @collection = @model.get 'units'
            @$el.prop("id", 'tower'+@model.get("buildingid"))







    class UnitTypeView extends Marionette.CompositeView

        className : "vs-wrapper"


        childView : UnitView


















    ScreenThreeLayout : ScreenThreeLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView














