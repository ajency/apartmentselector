define [ 'marionette' ], ( Marionette )->

    class ScreenFourLayout extends Marionette.LayoutView

        template : '<div id="vs-container" class="vs-container flatContainer">

                    <header class="vs-header" id="unit-region">

        			</header>

                    <div  id="main-region">




                    </div>
                    </div>'




        className : 'page-container row-fluid'




        regions :
            unitRegion : '#unit-region'
            mainRegion : '#main-region'

        onShow:->
            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/main.js'
            document.body.appendChild(scr)


    class UnitsView extends Marionette.ItemView

        template : '<a class="link" href="unit{{id}}">{{name}}</a>'

        tagName : 'li'




    class UnitTypeChildView extends Marionette.CompositeView

        tagName : 'ul'


        className : 'vs-nav'



        childView : UnitsView


    class UnitMainView extends Marionette.CompositeView

        template : '<div class="vs-content">
        						<div class="row">
        							<div class="col-sm-7 p-b-10">
        								<div class="floorplan">
        									</div>
        							</div>
        							<div class="col-sm-5">
        								<h4 class="bold">FLAT SUMMARY</h4>
        								<div class="summary">
        									<div class="row">
        										<div class="col-xs-6">FLOOR {{floor}}</div>
        										<div class="col-xs-6 text-right text-primary">{{unittypename}}</div>
        									</div>
        									<div class="row">
        										<div class="col-xs-6">CARPET AREA</div>
        										<div class="col-xs-6 text-right text-primary">{{carpetarea}} sqft</div>
        									</div>
        									<div class="row">
        										<div class="col-xs-6">TERRACE AREA</div>
        										<div class="col-xs-6 text-right text-primary">{{terracearea}} sqft</div>
        									</div>
        									<div class="row">
        										<div class="col-xs-6">SELLABLEAREA AREA</div>
        										<div class="col-xs-6 text-right text-primary">{{sellablearea}} sqft</div>
        									</div>
        									<div class="row">
        										<div class="col-xs-6">APARTMENT FACING</div>
        										<div class="col-xs-6 text-right text-primary">HILLSIDE</div>
        									</div>
        									<div class="row ">
        										<div class="col-xs-12 m-t-20 m-b-50">Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs.</div>
        									</div>
        								</div>
        							</div>
        						</div>
        						<div class="row m-t-20 p-t-20 b-grey b-t">
        							<div class="col-md-6 p-b-10">
        								<h4 class="bold">ROOM DIMENSIONS</h4>
        								<div class="summary">
        									<div class="row p-b-10">
        										<div class="col-sm-6">
        											TERRACE
        											<h3 class="text-primary"</h3>
										</div>
<div class="col-sm-6">
TOILET
<h3 class="text-primary"></h3>
										</div>
</div>
									<div class="row m-t-20">
										<div class="col-sm-6">
											LIVING ROOM
											<h3 class="text-primary"></h3>
</div>
										<div class="col-sm-6">
											KITCHEN
											<h3 class="text-primary"></h3>
</div>
									</div>
</div>
							</div>
<div class="col-md-6">
<h4 class="bold">ROOM DIMENSIONS</h4>
								<div class="summary facilities">
									<div class="row">

									</div>
<div class="row m-t-20">


									</div>
</div>
							</div>
</div>
					</div>'






        tagName  : "section"






        initialize :->
            @$el.prop("id", 'unit'+@model.get("id"))



    class UnitTypeView extends Marionette.CompositeView

        className : "vs-wrapper"


        childView : UnitMainView


    ScreenFourLayout : ScreenFourLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView



