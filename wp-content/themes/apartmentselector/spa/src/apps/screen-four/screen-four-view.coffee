define [ 'marionette' ], ( Marionette )->
    class ScreenFourLayout extends Marionette.LayoutView

        template : '<div id="vs-container" class="vs-container flatContainer">
                        <header class="vs-header" id="unitblock-region">
                        </header>

                        <div  id="mainunit-region">
                        </div>

                        <div class="h-align-middle">
                            <a class="btn btn-primary m-t-20 m-b-20 h-align-middle" name="list" id="list"><span class="glyphicon glyphicon-star"></span> Add to Wishlist</a>
                            <div class="alert alert-success alert-dismissible hide" role="alert" id="errormsg"></div>
                        </div>

                    </div>'




        className : 'page-container row-fluid'




        regions :
            unitRegion : '#unitblock-region'
            mainRegion : '#mainunit-region'

        events:->
            'click #list':(e)->
                console.log App.unit['name']

                console.log cookieOldValue = $.cookie("key")
                console.log typeof cookieOldValue
                if cookieOldValue == undefined || $.cookie("key") == ""
                        cookieOldValue = ""
                else
                    console.log cookieOldValue = $.cookie("key" ).split(',' ).map( (item)->
                            parseInt(item)
                    )
                console.log key = $.inArray(App.unit['name'] , cookieOldValue)

                if parseInt(key) == -1
                    $('#errormsg' ).text ""
                    App.cookieArray.push(parseInt(App.unit['name']))
                else
                    console.log "Already entered"
                    $('#errormsg' ).text "Already entered"
                    $('#errormsg' ).addClass "inline"
                    return false
                console.log App.cookieArray
                console.log App.cookieArray = $.merge(App.cookieArray,cookieOldValue)
                console.log App.cookieArray = _.uniq(App.cookieArray)
                $.cookie('key',App.cookieArray)
                console.log $.cookie("key")
                $('#errormsg' ).text "The selected flat has been added to your WishList"
                $('#errormsg' ).addClass "inline"
                @showWishList()
            'click .del':(e)->
                console.log App.cookieArray
                console.log val = $('#'+e.target.id).attr('data-id')
                console.log index = App.cookieArray.indexOf( parseInt(val) )
                App.cookieArray.splice( index, 1 )
                $.cookie('key',App.cookieArray)


                console.log $.cookie('key')

                @showWishList()
            'click a':(e)->
                e.preventDefault()


        onShow:->
            $('#slider-plans').liquidSlider(
                    slideEaseFunction: "easeInOutQuad",
                    autoSlide: true,
                    includeTitle:false
            )
            $('html, body').animate({
                scrollTop: $('#screen-four-region').offset().top
            }, 'slow')
            @showWishList()

        showWishList:->
            table = ""
            console.log typeof $.cookie("key")
            if $.cookie("key")!= undefined && $.cookie("key") != ""
                selectedUnitsArray = $.cookie("key").split(",")
                table = "<table>"
                for element in selectedUnitsArray
                    model = App.master.unit.findWhere(id:parseInt(element))
                    unitType = App.master.unit_type.findWhere(id:model.get('unitType'))
                    unitVariant = App.master.unit_variant.findWhere(id:model.get('unitVariant'))
                    building = App.master.building.findWhere(id:model.get('building'))
                    table += '<li><a href="#">'+model.get('name')+'</a>
                    <a href="#" class="del" id="'+element+'" data-id="'+element+'"  >Remove</a></li>'

                table += '</table>'

            $('#showWishlist').html table
















    class UnitsView extends Marionette.ItemView

        template : '<a class="link" href="unit{{id}}">Flat No {{name}}</a>'

        tagName : 'li'

        className : 'vs-nav-current'






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
										<h2 class="title">2D Layout</h2>
										<img src="{{TwoDimage}}" class="img-responsive">
									</div>
									<div>
										<h2 class="title">3D Layout</h2>
										<img src="{{ThreeDimage}}" class="img-responsive">
									</div>
									<div>
										<h2 class="title">Floor Layout</h2>
										<img src="{{floorLayoutimage}}" class="img-responsive">
									</div>
									<div>
										<h2 class="title">Building Position</h2>
										<img src="{{BuildingPositionimage}}" class="img-responsive">
									</div>
								</div>
							</div>
							<div class="col-sm-5">
								<h4 class="bold">FLAT SUMMARY</h4>
								<div class="summary">
                                    <div class="row">
										<div class="col-xs-6">CARPET AREA</div>
										<div class="col-xs-6 text-right text-primary">{{carpetarea}} sqft</div>
									</div>
									<div class="row">
										<div class="col-xs-6">TERRACE AREA</div>
										<div class="col-xs-6 text-right text-primary">{{terracearea}} sqft</div>
									</div>
									<div class="row">
										<div class="col-xs-6">CHARGEABLE AREA</div>
										<div class="col-xs-6 text-right text-primary">{{sellablearea}} sqft</div>
									</div>
									<div class="row">
										<div class="col-xs-6">PRICE per SQ.FT - starts from</div>
										<div class="col-xs-6 text-right text-primary">-</div>
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

       {{#toiletArray}}                                             <h3 class="text-primary">{{size}}</h3>

       {{/toiletArray}} 										</div>
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



