define [ 'extm', 'marionette' ], ( Extm, Marionette )->
    m = ""
    unitVariantArray = ''
    unitVariantIdArray = []
    unitVariantString = ''
    globalArrayLength = []
    firstElement = ''
    rangeArray =[]
    class ScreenTwoLayout extends Marionette.LayoutView

        template : '<div class="row m-l-0 m-r-0">
                        <div class="col-sm-4">
                            <div class="text-center subTxt m-b-20 unittype hidden animated pulse">We have <span class="bold text-primary"> {{unitsCount }} </span> <strong>{{selection}}</strong> apartments</div>
                    <div class="text-center subTxt m-b-20 budget hidden animated pulse">We have <span class="bold text-primary"> {{unitsCount }} </span>  apartments in the budget of <strong>{{selection}}</strong></div>
                    <div class="text-center subTxt m-b-20 refresh hidden animated pulse">You are now seeing <span class="bold text-primary">All</span> apartments across all the towers.</div>

                    <div class="text-center introTxt m-b-10">These apartments are spread over different towers. Each tower has three floor blocks. The number in the boxes indicate the number of apartments of your selection. Select one for more details.</div>

                    <div class="introTxt text-center">You are seeing <span class="text-primary variantToggle1"> All  </span> variants of your apartment selection</div>
                    <div class="variantBox1">

                        <div class="pull-left m-l-15">
                            <input type="checkbox" name="selectall" id="selectall" class="checkbox" value="0" checked/>
                            <label for="selectall">Select/Unselect All</label>
                        </div>
                        <div class="text-right m-b-20">
                            <span class="variantClose1 glyphicon glyphicon-remove text-grey"></span>
                        </div>

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

            		<div class="legend text-center m-b-20">
                        {{#unittypes}}
                        <span class={{classname}}>.</span>{{name}}
                        {{/unittypes}}
        		    </div>

                    <div class="towerTable">
                        <div class="tableBody">
            				<div id="vs-container2" class="vs-container">
            				    <header class="vs-header" id="building-region"></header>
            				    <div id="unit-region"></div>
                            </div>
                        </div>
                    </div>
                    <div class="h-align-middle m-t-20 m-b-20">
                        <a href="#screen-three-region" class="btn btn-default btn-lg disabled" id="screen-three-button">Select</a>
                    </div>

                </div>
                <div class="col-sm-8">
                    <div class="m-t-10 text-center">
                        <h4 class="bold m-t-0">Where is this tower located in the project?</h4>
                        <p class="light">This is a map of the entire project that shows the location of the tower selected (on the left).</p>
                        <div id="mapplic1" class="towersMap center-block"></div>
                    </div>
                </div>
                    </div>'




        className : 'page-container row-fluid'




        regions :
            buildingRegion : '#building-region'
            unitRegion : '#unit-region'

        events:
            'mouseover a':(e)->
                id  = $('#'+e.target.id ).attr('data-id')
                #locationData = m.getLocationData(id);
                #m.showTooltip(locationData);


            'click a':(e)->
                e.preventDefault()



            'click .remodalcheck':(e)->
                console.log @
                #App.navigate "modal"
                e.preventDefault()


            'click .scroll':(e)->
                console.log $('#'+e.target.id ).attr('data-id')
                $('html, body').animate({ scrollTop : 0 }, 'slow')
                @trigger 'show:updated:building' , $('#'+e.target.id ).attr('data-7')

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
                        globalArrayLength.push(parseInt(value))

                    )
                console.log globalUnitArrayInt
                if globalUnitArrayInt.length != 0
                    if track == 0
                        console.log track
                        unitVariantArray = _.intersection(unitVariantArray,globalUnitArrayInt)
                    else
                        globalUnitArrayInt.push(id)
                        globalArrayLength.push(id)
                        unitVariantArray = globalUnitArrayInt

                console.log unitVariantArray
                console.log firstElement
                if unitVariantArray.length == 0
                    unitVariantString = firstElement.toString()

                else



                    if globalUnitArrayInt.length == unitVariantArray.length
                        unitVariantString = 'All'

                    else
                        unitVariantString = unitVariantArray.join(',')




            'click .done':(e)->
                App.currentStore.unit.reset UNITS
                App.currentStore.building.reset BUILDINGS
                App.currentStore.unit_type.reset UNITTYPES
                App.currentStore.unit_variant.reset UNITVARIANTS
                App.filter(params={})
                if globalArrayLength.length == unitVariantArray.length
                    @$el.find('.variantToggle1').text 'All'
                else
                    @$el.find('.variantToggle1').text ''

                App.defaults['unitVariant'] = unitVariantString
                console.log App.defaults
                App.filter(params={})
                @trigger 'unit:variants:selected'

            'click .cancel':(e)->
                console.log unitVariantIdArray
                unitVariantArray = _.union(unitVariantArray,unitVariantIdArray)
                $(".variantBox1").slideToggle()
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

            'click #selectall':(e)->
                console.log unitVariantArray
                if $('#'+e.target.id).prop('checked') == true
                    $.each(unitVariantArray, (index,value)->
                        $('#grid'+value).addClass 'selected'
                        $('#check'+value).val '1'


                    )
                    unitVariantString = 'All'
                else
                    console.log value = _.first(unitVariantArray)
                    remainainArray = _.rest(unitVariantArray)
                    $.each(remainainArray, (index,value)->
                        $('#grid'+value).removeClass 'selected'
                        $('#check'+value).val '0'


                    )
                    unitVariantString = value.toString()

            'click #screen-three-button':(e)->
                console.log "aaaaaaaaaaaaa"
                @trigger 'unit:count:selected'


















        onShow:->
            if App.screenOneFilter['key'] == 'unitType'
                $('.unittype' ).removeClass 'hidden'
            else if App.screenOneFilter['key'] == 'budget'
                $('.budget' ).removeClass 'hidden'
            else if App.screenOneFilter['key'] == ""
                $('.refresh' ).removeClass 'hidden'


            console.log unitVariantArray  = Marionette.getOption( @, 'uintVariantId' )
            console.log firstElement = _.first(unitVariantArray)
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


            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/main2.js'

            document.body.appendChild(scr)

            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/jquery.remodal.js'
            document.body.appendChild(scr)

            $(".variantToggle1").click ->
                $(this).toggleClass("open")
                $(".variantBox1").slideToggle()
                return

            $(".variantClose1").click ->
                $(".variantBox1").slideToggle()
                $(".variantToggle1").toggleClass("open")
                return

            $(".grid-link").click  (e)->
                $(this).toggleClass("selected")
                return




            i = 1
            while (window['mapplic' + i] != undefined)
                params = window['mapplic' + i]
                selector = '#mapplic' + i
                ajaxurl = AJAXURL
                $(selector).mapplic(
                    'id': 5,
                    'width': params.width,
                    'height': params.height


                )



                i++;

            m  = $('#mapplic1').data('mapplic')

            $('html, body').animate({
                scrollTop: $('#screen-two-region').offset().top
            }, 'slow');

















    class BuildingView extends Marionette.ItemView

        template : '<a  class="link" href="tower{{id}}">{{name}}</a>'

        tagName : 'li'

        events:
            'click .link':->
                #m = mapplic()
                #m  = $('#mapplic1').data('mapplic')
                id = 'tower'+@model.get('id')
                i =1
                params = window['mapplic' + i]
                selector = '#mapplic' + i

                #m.initial($(selector),params)
                m.showLocation(id, 800)
                locationData = m.getLocationData(id);
                m.showTooltip(locationData);
                #App.navigate "tower"+@model.get('id') , trigger:true







    class UnitTypeChildView extends Marionette.CompositeView

        tagName : 'ul'


        className : 'vs-nav'



        childView : BuildingView

        onShow:->
            model = @collection.at(0)

            id = 'tower'+model.get('id')
            #m.showLocation(id, 800)

            #App.navigate "tower"+model.get('id') , trigger:true






    class UnitViewChildView extends Marionette.ItemView

        template : '<!--<div class="box psuedoBox {{classname}} pull-left">{{count}}</div>-->
                    <div class="pull-left light">
                        <h5 class="rangeName bold">{{rangetext}}</h5>
                        <div class="small">{{rangeNo}}</div>
                    </div>
                    <div class="pull-right box {{classname}}">{{count}}</div>
                    <div class="clearfix"></div>

                    <input type="hidden" name="checkrange{{range}}"   id="checkrange{{range}}"       value="0" />                             </div>'

        className : 'text-center towerSelect'

        initialize :->
            @$el.prop("id", 'range'+@model.get("range"))


        events:
            'click ':(e)->
                console.log rangeArray
                for element , index in rangeArray
                    if element == @model.get('range')
                        $("#checkrange"+@model.get 'range').val '1'
                    else
                        $("#checkrange"+element).val '0'
                        $('#range'+element).removeClass 'selected'
                        rangeArray = []
                console.log $("#checkrange"+@model.get 'range').val()

                if  parseInt($("#checkrange"+@model.get 'range').val()) == 0
                    rangeArray.push @model.get 'range'
                    $('#range'+@model.get 'range').addClass 'selected'

                    $("#checkrange"+@model.get 'range').val "1"
                    param = {}
                    param['name'] = @model.get 'range'
                    console.log param
                    rangeModel = App.currentStore.range.findWhere(param)
                    rangeArrayVal = []
                    i = 0
                    start = rangeModel.get('start')
                    end = rangeModel.get('end')
                    while parseInt(start) <= parseInt(end)
                        rangeArrayVal[i] = start
                        start = parseInt(start) + 1
                        i++
                    rangeArrayVal
                    rangeString = rangeArrayVal.join(',')


                    App.defaults['floor'] = rangeString
                    App.backFilter['screen2'].push 'floor'
                    App.defaults['building'] = parseInt(@model.get 'buildingid')
                    App.backFilter['screen2'].push 'building'
                    console.log $('#screen-three-button')
                    $('#screen-three-button').removeClass 'disabled btn-default'
                    $("#screen-three-button").addClass 'btn-primary'
                    #@trigger 'unit:count:selected'
                else
                    rangeArray=[]
                    $("#checkrange"+@model.get 'range').val "0"
                    $('#range'+@model.get 'range').removeClass 'selected'
                if parseInt($("#checkrange"+@model.get 'range').val()) == 0
                    $("#screen-three-button").addClass 'disabled btn-default'
                    $("#screen-three-button").removeClass 'btn-primary'
                    return false







    class UnitView extends Marionette.CompositeView

        template : '<div class="vs-content">
                            <div class="towerUnits">
                                <div class="subHeader ">
                                    <div class="row small light">
                                        <div class="col-xs-5">
                                            FLOOR<br>RANGE
                                        </div>
                                        <div class="col-xs-7 text-right">
                                            NO. OF UNITS OF<br>YOUR SELECTION
                                        </div>
                                    </div>
                                </div>
                            </div>
                                <!--<div class="towerDetails m-t-10">
                                    <div class="row">
                                        <div class="col-xs-4">
                                           <h4 class="m-t-0 m-b-0 bold">Total Apartments</h4>
                                           <h3 class="light m-t-0">{{totalunits}}</h3>
                                        </div>

                                        <div class="col-xs-4">
                                           <h4 class="m-t-0 m-b-0 bold">Available Apartments</h4>
                                           <h3 class="light m-t-0">{{availableunits}}</h3>
                                        </div>
                                        <div class="col-xs-4">
                                           <h4 class="m-t-0 m-b-0 bold">Number of Floors</h4>
                                           <h3 class="light m-t-0">{{totalfloors}}</h3>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12 m-t-10">
                                            <div class="col">
                                                <p>Climb leg make muffins or sweet beast play time and hate dog or chew foot. Stretch climb leg. Play time give attitude for all of a sudden go crazy chase imaginary bugs lick butt. Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs. Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <h4 class="m-t-0 m-b-5 text-primary"><span class="bold">VIEWS</span> for this tower</h4>
                                    <div class="row m-b-20">
                                        {{#views}}
                                        <div class="col-sm-6">
                                            {{#data}}<span class="glyphicon glyphicon-asterisk small text-grey"></span> {{name}}<br>{{/data}}
                                        </div>
                                        {{/views}}
                                    </div>
                                </div>-->
                    </div>'



        tagName : 'section'



        childView : UnitViewChildView


        childViewContainer : '.towerUnits'





        initialize :->
            @collection = @model.get 'units'
            @$el.prop("id", 'tower'+@model.get("buildingid"))

        onShow :->
            $("#unit-region section").addClass "vs-current" if $("#unit-region section").length < 2
            return






    class UnitTypeView extends Marionette.CompositeView




        childView : UnitView

        className : "vs-wrapper"




    ScreenTwoLayout : ScreenTwoLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView


















