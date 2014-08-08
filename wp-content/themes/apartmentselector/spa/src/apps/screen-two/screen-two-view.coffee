define [ 'extm', 'marionette' ], ( Extm, Marionette )->
    m = ""
    unitVariantArray = ''
    unitVariantIdArray = []
    unitVariantString = ''
    class ScreenTwoLayout extends Marionette.LayoutView

        template : '<div class="text-center subTxt m-b-20 unittype hidden animated fadeIn">We have <span class="bold text-primary"> {{unitsCount }} </span> <strong>{{selection}}</strong> apartments</div>
                    <div class="text-center subTxt m-b-20 budget hidden animated fadeIn">We have <span class="bold text-primary"> {{unitsCount }} </span>  apartments in the budget of <strong>{{selection}}</strong></div>
                    <div class="text-center subTxt m-b-20 refresh hidden animated fadeIn">You are now seeing all apartments across all the towers.</div>

                            <div class="text-center introTxt m-b-10">These apartments are spread over different towers. Each tower has three floor blocks. The number in the boxes indicate the number of apartments of your selection. Select one for more details.</div>

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

            		<div class="legend text-center m-b-20">
                        {{#unittypes}}
                        <span class={{classname}}>.</span>{{name}}
                        {{/unittypes}}
        		    </div>

                    <div class="towerTable">
                        <div class="tableHeader">
            				<ul>
            					<li><a href="#modal" class="remodalcheck"><span class="bold">HIGHRISE</span><br>15-11 Floors</a></li>
            					<li><a href="#modal" class="remodalcheck"><span class="bold">MIDRISE</span><br>10-6 Floors</a></li>
            					<li><a href="#modal" class="remodalcheck"><span class="bold">LOWRISE</span><br>5-1 Floors</a></li>
            				</ul>
            		    </div>
                        <div class="tableBody">
            				<div id="vs-container2" class="vs-container">
            				    <header class="vs-header" id="building-region"></header>
            				    <div id="unit-region"></div>
                            </div>
                        </div>
                    </div>

                    <div class="m-t-40 p-l-15 p-r-15 text-center">
        				<h4 class="bold m-t-0">Where is this tower located in the project?</h4>
        				<p>This is a map of the entire project that shows the location of the tower selected (on the left).</p>
                        <div id="mapplic1" class="towersMap center-block"></div>
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
                @trigger 'show:updated:building' , $('#'+e.target.id ).attr('data-id')

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
                        globalUnitArrayInt.push(id)
                        unitVariantArray = globalUnitArrayInt


                if globalUnitArrayInt.length == unitVariantArray.length
                    unitVariantString = 'All'
                else
                    unitVariantString = unitVariantArray.join(',')



            'click .done':(e)->


                App.defaults['unitVariant'] = unitVariantString
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
            else if App.screenOneFilter['key'] == ""
                $('.refresh' ).removeClass 'hidden'


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


            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/main2.js'

            document.body.appendChild(scr)

            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/jquery.remodal.js'
            document.body.appendChild(scr)

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

        template : '<div class="box psuedoBox {{classname}} pull-left">{{count}}</div>
                    <div class="box {{classname}}">{{count}}</div>
                            </div>'

        className : 'text-center'


        events:
            'click .box':(e)->
                param = {}
                param['name'] = @model.get 'range'
                rangeModel = App.currentStore.range.findWhere(param)
                rangeArray = []
                i = 0
                start = rangeModel.get('start')
                end = rangeModel.get('end')
                while parseInt(start) <= parseInt(end)
                    rangeArray[i] = start
                    start = parseInt(start) + 1
                    i++
                rangeArray
                rangeString = rangeArray.join(',')


                App.defaults['floor'] = rangeString
                App.backFilter['screen2'].push 'floor'
                App.defaults['building'] = parseInt(@model.get 'buildingid')
                App.backFilter['screen2'].push 'building'
                @trigger 'unit:count:selected'






    class UnitView extends Marionette.CompositeView

        template : '<div class="vs-content">
                        <div class="row">
                            <div class="col-sm-6 towerUnits">
                                <div class="subHeader">
                                    <div class="row">
                                        <div class="col-xs-5">
                                            FLOOR<br>RANGE
                                        </div>
                                        <div class="col-xs-7 text-right">
                                            NO. OF UNITS OF<br>YOUR SELECTION
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 b-grey b-l">
                                <div class="towerUnits psuedoUnits"></div>
                                <div class="towerDetails">
                                    <div class="row">
                                        <div class="col-xs-4">
                                           <h3 class="m-t-0 m-b-0">Total Apartments</h3>
                                           <h2 class="semi-bold m-t-5">{{totalunits}}</h2>
                                        </div>

                                        <div class="col-xs-4">
                                           <h3 class="m-t-0 m-b-0">Available Apartments</h3>
                                           <h2 class="semi-bold m-t-5">{{availableunits}}</h2>
                                        </div>
                                        <div class="col-xs-4">
                                           <h3 class="m-t-0 m-b-0">Number of Floors</h3>
                                           <h2 class="semi-bold m-t-5">{{totalfloors}}</h2>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12 m-t-10">
                                            <div class="col">
                                                <p>Climb leg make muffins or sweet beast play time and hate dog or chew foot. Stretch climb leg. Play time give attitude for all of a sudden go crazy chase imaginary bugs lick butt. Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs. Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything.</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row m-l-0 m-r-0 m-b-20">
                                        <div class="col-xs-4">
                                            <h4 class="m-t-0 text-primary"><div class="bold">VIEWS</div>for this tower</h4>
                                        </div>

       {{#views}}                                         <div class="col-xs-4">

                                  {{#data}}          <span class="glyphicon glyphicon-asterisk small text-grey"></span>{{name}}<br>{{/data}}
                                        </div>
{{/views}}
                                    </div>
                                </div>
                            </div>
                        </div>
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


















