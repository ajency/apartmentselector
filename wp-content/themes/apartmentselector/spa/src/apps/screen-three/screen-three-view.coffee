define [ 'marionette' ], ( Marionette )->

    class ScreenThreeLayout extends Marionette.LayoutView

        template : '<h3 class="text-center introTxt m-b-30">We have <span class="bold text-primary">25 options</span> for 1BHK <br><small>Select your flat to get started</small></h3>
                    <div id="vs-container" class="vs-container">
                    <header class="vs-header" id="building-region">

        			</header>

                    <div class="vs-wrapper" id="unit-region">
                    </div>
                    </div>'




        className : 'page-container row-fluid'




        regions :
            buildingRegion : '#building-region'
            unitRegion : '#unit-region'

        onShow:->
            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/spa/src/bower_components/preload/main.js'
            document.body.appendChild(scr)




    class BuildingView extends Marionette.ItemView

        template : '<a class="link" href="tower{{id}}">{{name}}</a>'

        tagName : 'li'

        events :
            'click .link' : ( e )->
                console.log @model.get 'id'
                $( '#tower'+@model.get 'id' ).removeClass 'hidden'


    class UnitTypeChildView extends Marionette.CompositeView

        tagName : 'ul'


        className : 'vs-nav'



        childView : BuildingView



        onShow : ->
            console.log "aaaaaaaaaaaaa"

    class childViewUnit extends Marionette.ItemView

        template : '
        													{{name}}
        													<div class="small">{{unitTypeName}}  {{unitVariantName}}</div>
        												'



        className : 'box filtered'


    class unitChildView extends Marionette.CompositeView



        className : 'cd-table-column'



        childView : childViewUnit






        initialize :->
            console.log @model
            @collection = @model.get 'floorunits'






    class UnitView extends Marionette.CompositeView

        template : '<div class="vs-content"><div  class="unitTable">
                            <header class="cd-table-column">
                								<ul>

                    {{#floorcount}}         									<li>
                										Floor {{id}}
                										<small>95 per sqft</small>
                									</li>
                    {{/floorcount}}
                								</ul>
                							</header>
                			<div class="cd-table-container"><div class="cd-table-wrapper">
                            </div></div></div></div>'




        childView : unitChildView


        tagName  : "section"

        childViewContainer : '.cd-table-wrapper'





        initialize :->
            console.log @model.get 'floorcount'
            @collection = @model.get 'units'
            @$el.prop("id", 'tower'+@model.get("buildingid"))




    class UnitTypeView extends Marionette.CompositeView




        childView : UnitView






    ScreenThreeLayout : ScreenThreeLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView














