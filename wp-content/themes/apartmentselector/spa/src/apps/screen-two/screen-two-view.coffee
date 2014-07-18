define [ 'extm','marionette' ], (Extm, Marionette )->
    class UnitTypeView extends Marionette.ItemView

        template : '<section id="tower1">
        							<div class="vs-content">
        								<div class="text-center">
        										<div class="flatNos">05</div>
        								</div>
        								<div class="text-center">
        										<div class="flatNos">05</div>
        								</div>
        								<div class="text-center">
        										<div class="flatNos">05</div>
        								</div>
        							</div>
        						</section>'

        events :
            'click '   : 'typeOfUnitSelected'

        typeOfUnitSelected :(evt)->
            evt.preventDefault()

            @trigger 'type:unit:clicked', @model.get('buildingid') , @model.get('unitType'),@model.get('range')


    class UnitTypeChildView extends Marionette.CompositeView

        template : '<a href="#tower1">{{buildingname}}</a>'

        tagName : 'ul'

        clasName : 'vs-nav'

        initialize:->
            console.log @model.get 'units'
            @collection = @model.get 'units'















    class ScreenTwoLayout extends Marionette.LayoutView

        template : '<h3 class="text-center introTxt">We have <span class="bold">100 options</span> for 1BHK <br><small>Just select your floors to get started</small></h3>
        <div class="towerTable"><div class="tableHeader">
        				<ul>
        					<li><a href="#modal"><span class="bold">HIGHRISE</span><br>15-11 Floors</a></li>
        					<li><a href="#modal"><span class="bold">MIDRISE</span><br>15-11 Floors</a></li>
        					<li><a href="#modal"><span class="bold">LOWRISE</span><br>15-11 Floors</a></li>
        				</ul>
        			</div><div class="tableBody">
        				<div id="vs-container2" class="vs-container">
        					<header class="vs-header"></header>
        						<ul class="vs-nav" id="building-region"></ul><div id="unit-region" class="vs-wrapper"></div></div></div>'




        className : 'page-container row-fluid'

        regions :
            buildingRegion : '#building-region'
            unitRegion : '#unit-region'




















