define [ 'marionette' ], ( Marionette )->
    class ScreenFourLayout extends Marionette.LayoutView

        template : '<div class="page-container row-fluid"><div id="vs-container" class="vs-container flatContainer">
                        <header class="vs-header" id="unitblock-region">
                        </header>

                        <div  id="mainunit-region">
                        </div>

                        <div class="h-align-middle">
                            <a class="btn btn-primary m-t-20 m-b-20 h-align-middle remove" name="list" id="list"><span class="glyphicon glyphicon-star"></span> Add to Wishlist</a>
                            <div class="alert alert-success alert-dismissible hide" role="alert" id="errormsg"></div>
                        </div>

                    </div></div><div class="remodal" data-remodal-id="modal">

        			<div id="invoice" class="paid">
        				<div class="this-is">
        					<h4 class="bold">Estimated Cost</h4>
        				</div><!-- invoice headline -->


        				<header id="header">
        					<div class="invoice-intro">
        						<h2 class="medium m-t-0 m-b-5 text-primary">Skyi</h2>
        						<p class="italic">Tagline comes here</p>
        					</div>

        					<dl class="invoice-meta">
        						<h5 class="invoice-number bold m-t-0">Proposal No.</h5>
        						<dd>6859</dd>
        						<h5 class="invoice-date bold m-t-0">Date</h5>
        						<dd>19/08/2014</dd>
        						<h5 class="invoice-due bold m-t-0">Due Date</h5>
        						<dd>18/09/2014</dd>
        					</dl>
        				</header>
        				<!-- e: invoice header -->


        				<section id="parties">

        					<div class="invoice-to">
        						<h3>Proposal To:</h3>
        						<div id="hcard-Hiram-Roth" class="vcard">
        							<a class="url fn" href="http://memory-alpha.org">Hiram Roth</a>
        							<div class="org">United Federation of Planets</div>
        							<a class="email" href="mailto:president.roth@ufop.uni">president.roth@ufop.uni</a>

        							<div class="adr">
        								<div class="street-address">2269 Elba Lane</div>
        								<span class="locality">Paris</span>
        								<span class="country-name">France</span>
        							</div>

        							<div class="tel">888-555-2311</div>
        						</div><!-- e: vcard -->
        					</div><!-- e invoice-to -->


        					<div class="invoice-from">
        						<h3>Proposal From:</h3>
        						<div id="hcard-Admiral-Valdore" class="vcard">
        							<a class="url fn" href="http://memory-alpha.org">Admiral Valdore</a>
        							<div class="org">Romulan Empire</div>
        							<a class="email" href="mailto:admiral.valdore@theempire.uni">admiral.valdore@theempire.uni</a>

        							<div class="adr">
        								<div class="street-address">5151 Pardek Memorial Way</div>
        								<span class="locality">Krocton Segment</span>
        								<span class="country-name">Romulus</span>
        							</div>

        							<div class="tel">000-555-9988</div>
        						</div><!-- e: vcard -->
        					</div><!-- e invoice-from -->


        					<div class="invoice-status p-t-25">
        						<!-- <h3>Proposal Status</h3> -->
        						<div>Some info</div>
        					</div><!-- e: invoice-status -->

        				</section><!-- e: invoice partis -->


        				<section class="invoice-financials">

        					<div class="invoice-items">
        						<table>
        							<caption>Your Invoice</caption>
        							<thead>
        								<tr>
        									<th>Item &amp; Description</th>
        									<th>Quantity</th>
        									<th>Price (GPL)</th>
        								</tr>
        							</thead>
        							<tbody>
        								<tr>
        									<th>Romulan Warbird</th>
        									<td>1</td>
        									<td>$36,000</td>
        								</tr>
        								<tr>
        									<th>Romulan Troops</th>
        									<td>10</td>
        									<td>$7,650</td>
        								</tr>
        								<tr>
        									<th>Kestrel-class Shuttle</th>
        									<td>1</td>
        									<td>$10,220</td>
        								</tr>
        								<tr>
        									<th>Clocking Device</th>
        									<td>1</td>
        									<td>$50,000</td>
        								</tr>
        							</tbody>
        							<tfoot>
        								<tr>
        									<td colspan="3">Amounts in bars of Gold Pressed Latinum</td>
        								</tr>
        							</tfoot>
        						</table>
        					</div><!-- e: invoice items -->


        					<div class="invoice-totals">
        						<table>
        							<caption>Totals:</caption>
        							<tbody>
        								<tr>
        									<th>Subtotal:</th>
        									<td></td>
        									<td>$103,850</td>
        								</tr>
        								<tr>
        									<th>Tax:</th>
        									<td>5%</td>
        									<td>$5,192</td>
        								</tr>
        								<tr>
        									<th>Total:</th>
        									<td></td>
        									<td>$109,042</td>
        								</tr>
        							</tbody>
        						</table>

        						<div class="invoice-pay">
        							<h5>Pay with...</h5>
        							<ul>
        								<li>
        									<a href="#" class="gcheckout">Checkout with Google</a>
        								</li>
        								<li>
        									<a href="#" class="acheckout">Checkout with Amazon</a>
        								</li>
        							</ul>
        						</div>
        					</div><!-- e: invoice totals -->


        					<div class="invoice-notes">
        						<h6>Notes &amp; Information:</h6>
        						<p>This invoice contains a incomplete list of items destroyed by the Federation ship Enterprise on Startdate 5401.6 in an unprovked attacked on a peaceful &amp; wholly scientific mission to Outpost 775.</p>
        						<p>The Romulan people demand immediate compensation for the loss of their Warbird, Shuttle, Cloaking Device, and to a lesser extent thier troops.</p>
        						<p>Failure to provide adequate compensation for the above losses will result in an immediate increase in Neutral Zone patrols &amp; a formal complaint will be filed in the form of increased aggresion on human populated worlds within the neutral zone.</p>
        					</div><!-- e: invoice-notes -->

        				</section><!-- e: invoice financials -->


        				<footer id="footer">
        					<p>
        						Crafted with Romulan State Required Levels of Attention by <a href="http://sprresponsive.com">sprResponsive</a>.
        					</p>
        				</footer>
        			</div><!-- e: invoice -->
        	</div>'








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
                console.log cookieOldValue.length
                if cookieOldValue.length >= 4
                    $('#errormsg' ).text "Cannot add more than 4 units"
                    return false
                else

                    console.log key = $.inArray(parseInt(App.unit['name']) , cookieOldValue)

                    if parseInt(key) == -1
                        $('#errormsg' ).text ""
                        App.cookieArray.push(parseInt(App.unit['name']))
                        $('#list').addClass "remove"
                    else
                        console.log "Already entered"
                        $('#errormsg' ).text "Already entered"
                        $('#errormsg' ).addClass "inline"
                        $('#list').removeClass "remove"
                        return false
                    console.log App.cookieArray
                    console.log App.cookieArray = $.merge(App.cookieArray,cookieOldValue)
                    console.log App.cookieArray = _.uniq(App.cookieArray)
                    $.cookie('key',App.cookieArray)
                    localStorage.setItem("cookievalue", App.cookieArray)
                    console.log $.cookie("key")
                    $('#errormsg' ).text "The selected flat has been added to your WishList"
                    $('#errormsg' ).addClass "inline"

                cart = $("#showRightPush")
                console.log imgtodrag = $('.remove').find(".glyphicon")
                if imgtodrag
                    imgclone = imgtodrag.clone().offset(
                        top: imgtodrag.offset().top
                        left: imgtodrag.offset().left
                    ).css(
                        opacity: "0.8"
                        position: "absolute"
                        color: "#ff6600"
                        "font-size": "30px"
                        "z-index": "100"
                    ).appendTo($("body")).animate(
                        top: cart.offset().top + 10
                        left: cart.offset().left + 80
                        width: 50
                        height: 50
                    , 1200, "easeInOutCubic")
                    imgclone.animate
                        width: 0
                        height: 0
                    , ->
                        $(this).detach()
                        return
                $('#list').removeClass "remove"


                @showWishList()
            'click .del':(e)->
                console.log App.cookieArray
                console.log val = $('#'+e.target.id).attr('data-id')
                console.log index = App.cookieArray.indexOf( parseInt(val) )
                App.cookieArray.splice( index, 1 )
                $.cookie('key',App.cookieArray)
                localStorage.setItem("cookievalue", App.cookieArray)
                $('#errormsg' ).text ""


                console.log $.cookie('key')

                @showWishList()
            'click a':(e)->
                e.preventDefault()

            'click .selectedunit':(e)->
                menuRight = document.getElementById("cbp-spmenu-s2")
                menuTop = document.getElementById("cbp-spmenu-s3")
                showTop = document.getElementById("showTop")
                showRightPush = document.getElementById("showRightPush")
                body = document.body
                classie.toggle showRightPush, "active"
                classie.toggle body, "cbp-spmenu-push-toleft"
                classie.toggle menuRight, "cbp-spmenu-open"
                App.unit['name'] = $('#'+e.target.id ).attr('data-id')
                App.unit['flag'] = 1
                unitModel = App.master.unit.findWhere({id:parseInt($('#'+e.target.id ).attr('data-id'))})
                App.defaults['unitType'] = unitModel.get 'unitType'
                App.defaults['building'] =  unitModel.get 'building'
                console.log rangeModel = App.master.range
                App.backFilter['screen3'].push("floor")
                App.backFilter['screen2'].push("floor","unitVariant")
                buildingModel = App.master.building.findWhere({id:unitModel.get 'building'})
                floorriserange = buildingModel.get 'floorriserange'
                #floorriserange = [{"name":"low","start":"1","end":"2"},{"name":"medium","start":"3","end":"4"},{"name":"high","start":"5","end":"6"}]
                rangeArrayVal = []
                i = 0
                object = @
                $.each(floorriserange, (index,value)->
                    start = parseInt(value.start)
                    end = parseInt(value.end)
                    while parseInt(start) <= parseInt(end)
                        rangeArrayVal[i] = start
                        start = parseInt(start) + 1
                        i++
                    rangeArrayVal
                    if jQuery.inArray(parseInt(unitModel.get('floor')),rangeArrayVal) >= 0
                        console.log "aaaaaaaaaaa"
                        App.defaults['floor'] = rangeArrayVal.join(',')



                )
                console.log App.defaults

                msgbus.showApp 'header'
                .insideRegion  App.headerRegion
                    .withOptions()
                msgbus.showApp 'screen:four'
                .insideRegion  App.layout.screenFourRegion
                    .withOptions()


        onShow:->
            $('#slider-plans').liquidSlider(
                    slideEaseFunction: "easeInOutQuad",
                    autoSlide: true,
                    includeTitle:false
            )
            $('html, body').animate({
                scrollTop: $('#screen-four-region').offset().top
            }, 'slow')
            console.log cookieOldValue = $.cookie("key")
            console.log typeof cookieOldValue
            if cookieOldValue == undefined || $.cookie("key") == ""
                cookieOldValue = []
            else
                console.log cookieOldValue = $.cookie("key" ).split(',' ).map( (item)->
                    parseInt(item)
                )
            App.cookieArray = cookieOldValue
            @showWishList()

        showWishList:->
            table = ""
            console.log typeof $.cookie("key")
            if $.cookie("key")!= undefined && $.cookie("key") != ""
                console.log selectedUnitsArray = $.cookie("key").split(",")
                table = "<table>"
                for element in selectedUnitsArray
                    model = App.master.unit.findWhere(id:parseInt(element))
                    unitType = App.master.unit_type.findWhere(id:model.get('unitType'))
                    unitVariant = App.master.unit_variant.findWhere(id:model.get('unitVariant'))
                    building = App.master.building.findWhere(id:model.get('building'))
                    table += '<li><a href="#" id="unit'+element+'" data-id="'+element+'"  class="selectedunit">'+model.get('name')+'</a>
                                                            <a href="#" class="del" id="'+element+'" data-id="'+element+'"  ></a></li>
                                                                <div class="clearfix"></div>'

                table += '</table>'
            console.log table
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

       <a data-remodal-target="modal" class="btn btn-primary">Cost Sheet</a>
        </div>'






        tagName  : "section"






        initialize :->
            @$el.prop("id", 'unit'+@model.get("id"))

        onShow:->
            $('#slider-plans').liquidSlider(
                slideEaseFunction: "easeInOutQuad",
                autoSlide: true,
                includeTitle:false,
                minHeight: 500,
                autoSlideInterval: 500,
                forceAutoSlide: true


            )





    class UnitTypeView extends Marionette.CompositeView

        className : "vs-wrapper"


        childView : UnitMainView


    ScreenFourLayout : ScreenFourLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView



