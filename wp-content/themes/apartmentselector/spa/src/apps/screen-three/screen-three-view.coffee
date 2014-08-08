define [ 'marionette' ], ( Marionette )->

    flag_set = 0
    unitVariantArray = ''
    unitVariantIdArray = []
    unitVariantString = ''


    class ScreenThreeLayout extends Marionette.LayoutView

        template : '
       <div class="text-center subTxt m-b-20 unittype hidden animated fadeIn">We have <span class="bold text-primary"> {{countUnits }} </span> <strong>{{selection}}</strong> apartments in this floor range of the selected tower.</div>
                            <div class="text-center subTxt m-b-20 budget hidden animated fadeIn">We have <span class="bold text-primary"> {{countUnits }} </span>  apartments in the budget of <strong>{{selection}}</strong> in this floor range of the selected tower.</div>
                             <div class="text-center subTxt m-b-20 refresh hidden animated fadeIn">You just refreshed the page. You are now seeing all apartments across all the towers.</div>
                            <div class="text-center subTxt m-b-20 All hidden animated fadeIn">You are seeing all apartments in the selected floor range of the tower.</div>
              <div class="introTxt text-center">These apartments are available in different size variations on different floors of the tower. Click on any available apartment for more details. <br>(You can scroll between towers to see other options.)</div>
                    <div class="introTxt text-center">You are seeing <span class="text-primary variantToggle"> All  </span> variants of your apartment selection</div>
                            <div class="variantBox">
                                <div class="text-right"><span class="variantClose glyphicon glyphicon-remove text-grey"></span></div>
                                <div class="grid-container">

                                    {{#unitVariants}}
                                    <div class="grid-block-3" >
                                        <a class="grid-link selected" href="#" id="grid{{id}}" data-id="{{id}}">
                                            {{sellablearea}} Sq.ft.<input type="hidden" name="check{{id}}"   id="check{{id}}"   value="1" />
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

                    <div class="towerRange">
                        <h3 class="text-primary text-center semi-bold m-t-40"><u>{{rangetext}}</u></h3>
                        <div class="row m-l-0 m-r-0 m-b-20">
                            <div class="col-sm-4 col-xs-12">
                                <img src="../HTML/assets/img/floor-rise.jpg" class="img-responsive center-block">
                            </div>
                            <!--<div class="col-sm-8 col-xs-3">
                                <div class="row">
                                    {{#high}}
                                     <div class="col-sm-4 p-l-0 p-r-0">
                                        <h1><small>Total {{name}}</small><br>{{count}}</h1>
                                    </div>
                                    {{/high}}
                            </div>-->

                            <div class="col-sm-8 col-xs-12 m-t-30">
                                <p>Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.</p>
                            </div>

                            <!--<div class="row">
                                <div class="col-sm-4">
                                </div>
                                <div class="col-sm-4">
                                </div>
                                <div class="col-sm-4">
                                </div>
                            </div>-->
                        </div>

                       <!-- <div class="viewsNo m-t-20">
                            <div class="row m-l-0 m-r-0">
                                <div class="col-xs-4">
                                    <h4>
                                        NO OF <span class="text-primary bold">VIEWS</span>
                                    </H4>
                                </div>
                                <div class="col-xs-4">
                                    Garden view<br>
                                    Pond View<br>
                                    Manas Lake<br>
                                    Eco pond
                                </div>
                                <div class="col-xs-4">
                                    Garden view<br>
                                    Pond View<br>
                                    Manas Lake<br>
                                    Eco pond
                                </div>
                            </div>
                        </div>-->

                    </div>
                    '




        className : 'page-container row-fluid'





        regions :
            buildingRegion : '#building-region'
            unitRegion : '#unit-region'

        events:
            'click a':(e)->
                e.preventDefault()

            'click .grid-link':(e)->
                console.log unitVariantArray
                id = $('#'+e.target.id).attr('data-id')
                track = 0
                if $('#check'+id).val() == '1'
                    console.log id
                    console.log index = unitVariantArray.indexOf(parseInt(id))
                    if index != -1
                        unitVariantArray.splice( index, 1 )
                        $('#check'+id).val '0'
                        track = 0
                        unitVariantIdArray.push(parseInt(id))
                else
                    console.log "aaaaaaaaaa"
                    track = 1
                    unitVariantArray.push(parseInt(id))
                    $('#check'+id).val '1'


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

                if globalUnitArrayInt.length == unitVariantArray.length
                    unitVariantString = 'All'
                else
                    unitVariantString = unitVariantArray.join(',')



            'click .done':(e)->
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
                            $('#grid'+value).addClass 'selected'
                            $('#check'+value).val '1'
                        else
                            $('#grid'+value).removeClass 'selected'
                            $('#check'+value).val '0'








                    )

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
            console.log globalUnitVariants = App.defaults['unitVariant'].split(',')
            globalUnitArrayInt = []
            $.each(globalUnitVariants, (index,value)->
                globalUnitArrayInt.push(parseInt(value))

            )

            if App.defaults['unitVariant'] != 'All'
                unitVariantArray = _.union(unitVariantArray,unitVariantIdArray)
                $.each(unitVariantArray, (index,value)->
                    console.log value
                    key = _.contains(globalUnitArrayInt,parseInt(value))
                    console.log key
                    if key == true
                        $('#grid'+value).addClass 'selected'
                    else
                        console.log index = unitVariantArray.indexOf(parseInt(value))
                        $('#grid'+value).removeClass 'selected'
                        $('#check'+value).val '0'









                )







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
        				<div class="small">{{unitTypeName}} {{unitVariantName}} SQF</div>
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
                    @trigger 'unit:item:selected'





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














