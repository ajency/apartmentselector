define [ 'marionette' ], ( Marionette )->

    class ScreenFourLayout extends Marionette.LayoutView

        template : '<div id="vs-container" class="vs-container flatContainer">

                    <header class="vs-header" id="unitblock-region">

        			</header>

                    <div  id="mainunit-region">




                    </div>
                    </div>'




        className : 'page-container row-fluid'




        regions :
            unitRegion : '#unitblock-region'
            mainRegion : '#mainunit-region'

        onShow:->
            $('#slider-plans').liquidSlider(
                    slideEaseFunction: "easeInOutQuad",
                    autoSlide: true,
                    includeTitle:false
            )









    class UnitsView extends Marionette.ItemView

        template : '<a class="link" href="unit{{id}}">Flat No {{name}}</a>'

        tagName : 'li'




    class UnitTypeChildView extends Marionette.CompositeView

        tagName : 'ul'


        className : 'vs-nav'



        childView : UnitsView


    class UnitMainView extends Marionette.CompositeView

        template : '<div class="vs-content">
        						<div class="row">
        							<div class="col-sm-7 p-b-10">
        								<div class="liquid-slider center-block" id="slider-plans">
        									<div>
        										<h2 class="title">2D</h2>
        										<img src="{{TwoDimage}}" class="img-responsive">
        									</div>
        									<div>
        										<h2 class="title">3D</h2>
        										<img src="{{ThreeDimage}}" class="img-responsive">
        									</div>
        									<div>
        										<h2 class="title">Slide 3</h2>
        										<img src="assets/img/flat1.jpg" class="img-responsive">
        									</div>
        									<div>
        										<h2 class="title">Slide 4</h2>
        										<img src="assets/img/flat1.jpg" class="img-responsive">
        									</div>
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

        onShow:->
            $('#slider-plans').liquidSlider(
                slideEaseFunction: "easeInOutQuad",
                autoSlide: true,
                includeTitle:false
            )





    class UnitTypeView extends Marionette.CompositeView

        className : "vs-wrapper"


        childView : UnitMainView


    ScreenFourLayout : ScreenFourLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView



