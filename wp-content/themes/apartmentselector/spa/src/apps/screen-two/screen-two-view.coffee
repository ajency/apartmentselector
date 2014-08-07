define [ 'extm', 'marionette' ], ( Extm, Marionette )->
    m = ""
    unitVariantArray = ''
    class ScreenTwoLayout extends Marionette.LayoutView

        template : '<div class="text-center subTxt m-b-20">We have <span class="bold text-primary"> {{unitsCount }} </span> <strong>{{selection}}</strong> apartments</div>
        		<div class="text-center introTxt m-b-10">These apartments are spread over different towers. Each tower has three floor blocks. The number in the boxes indicate the number of apartments of your selection. Select one for more details.</div>

                <div class="introTxt text-center">You are seeing <span class="text-primary variantToggle"> All <span class="glyphicon glyphicon-chevron-down"></span> </span> variants of your apartment selection</div>
                <div class="variantBox">
                    <div class="text-right"><span class="variantClose glyphicon glyphicon-remove text-grey"></span></div> 
                    <div class="grid-container">
                        {{#unitVariants}}
                        <div class="grid-block-3" >
                            <a class="grid-link selected" href="#" id="grid{{id}}" data-id="{{id}}">
                                {{name}}<input type="hidden" name="check{{id}}"   id="check{{id}}"   value="1" />
                            </a>
                        </div>
                        {{/unitVariants}}
                    </div>
                </div>

        		<div class="legend text-center m-b-20">

       {{#unittypes}}
<span class={{classname}}>.</span>{{name}}
        {{/unittypes}}
        		</div>
                <div>
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
                if $('#check'+id).val() == '1'
                    console.log id
                    console.log index = unitVariantArray.indexOf(parseInt(id))
                    if index != -1
                        unitVariantArray.splice( index, 1 )
                        $('#check'+id).val '0'
                else
                    console.log "aaaaaaaaaa"
                    unitVariantArray.push(parseInt(id))
                    $('#check'+id).val '1'


                console.log unitVariantArray
                unitVariantString = unitVariantArray.join(',')
                App.defaults['unitVariant'] = unitVariantString
                App.filter(params={})
                @trigger 'unit:variants:selected'









        onShow:->
            console.log unitVariantArray  = Marionette.getOption( @, 'uintVariantId' )
            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/main2.js'

            document.body.appendChild(scr)

            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/jquery.remodal.js'
            document.body.appendChild(scr)

            $(".variantToggle").click ->
                $(".variantBox").slideToggle()
                return

            $(".variantClose").click ->
                $(".variantBox").slideToggle()
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
                    'id': 4,
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
                                        {{#unittypes}}
                                        <div class="col-xs-4">
                                           <h3 class="m-t-0 m-b-0">Total Apartments</h3>
                                           <h1 class="semi-bold m-t-5">{{count}}</h1>
                                        </div>
                                        {{/unittypes}}
                                        <div class="col-xs-4">
                                           <h3 class="m-t-0 m-b-0">Available Apartments</h3>
                                           <h1 class="semi-bold m-t-5">10</h1>
                                        </div>
                                        <div class="col-xs-4">
                                           <h3 class="m-t-0 m-b-0">Number of Floors</h3>
                                           <h1 class="semi-bold m-t-5">10</h1>
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
                                            <h4 class="m-t-0 text-primary">What can I<div class="bold">SEE?</div> </h4>
                                        </div> 
                                        <div class="col-xs-4"> 
                                            Garden view<br> Pond View
                                        </div>
                                        <div class="col-xs-4"> 
                                            Manas Lake<br> Eco pond 
                                        </div>
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


















