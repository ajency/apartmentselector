define [ 'marionette' ], ( Marionette )->
    cookieArray = []
    class ScreenFourLayout extends Marionette.LayoutView

        template : '<div id="vs-container" class="vs-container flatContainer">
                        <header class="vs-header" id="unitblock-region">
                        </header>

                        <div  id="mainunit-region">
                        </div>


       <input type="button" name="list" id="list" value="Add"  /><label id="errormsg"></label>

       <div id="showList"></div>
       </div></br>                      </div>'




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
                    cookieArray.push(parseInt(App.unit['name']))
                else
                    console.log "Already entered"
                    $('#errormsg' ).text "Already entered"
                console.log cookieArray
                console.log cookieArray = $.merge(cookieArray,cookieOldValue)
                console.log cookieArray = _.uniq(cookieArray)
                $.cookie('key',cookieArray)
                console.log $.cookie("key")
                @showWishList()
            'click .del':(e)->
                console.log cookieArray
                console.log val = $('#'+e.target.id).attr('data-id')
                console.log index = cookieArray.indexOf( parseInt(val) )
                cookieArray.splice( index, 1 )
                $.cookie('key',cookieArray)


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
                    table += '<tr><td>'+model.get('name')+'</td><td>'+unitVariant.get('sellablearea')+' Sq.ft.</td>
                    <td>'+building.get('name')+'</td><td>'+unitType.get('name')+' </td>
                    <td><a href="#" class="del" id="'+element+'" data-id="'+element+'"  >Remove</a></td></tr>'

                table += '</table>'

            $('#showList').html table
















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



