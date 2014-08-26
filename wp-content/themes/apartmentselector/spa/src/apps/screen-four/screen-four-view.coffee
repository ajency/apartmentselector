define [ 'marionette' ], ( Marionette )->

    perFlag = 0
    object =""
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

       <div>Payment Plans<select id="paymentplans">

       {{#paymentplans}}

       <option value="{{id}}">{{name}}</option>{{/paymentplans}}
        </select>
        </br>Discount :
                                            Value<input type="radio" class="radioClass" id="radio1"  checked name="discountradio" value="1"/>

                                            Percentage<input type="radio" class="radioClass" name="discountradio" value="2"/>

                                            <input type="text" id="discountvalue" value=""/>


                                            <input type="text" id="discountper" value="" class="hidden" /><br/>
                                            Actual Payment : <input type="text" id="payment" value=""/></div>

        				</header>
        				<!-- e: invoice header -->





        				<section class="invoice-financials">

                            <div class="invoice-items">
        						<table id="costSheetTable">
        							<caption>Your Invoice</caption>
        							<thead>
        								<tr>
        									<th>Item &amp; Description</th>
        									<th>Quantity</th>
        									<th>Price (GPL)</th>
        								</tr>
        							</thead>
        							<tbody>

        							</tbody>

        						</table>
        					</div>




       <div class="invoice-items">
                						<table id="paymentTable">
                							<caption>Schedule of Payments</caption>
                							<thead>
                								<tr>
                									<th>Item &amp; Description</th>
                									<th>Quantity</th>
                									<th>Price (GPL)</th>
                								</tr>
                							</thead>
                							<tbody>

                							</tbody>

                						</table>
                					</div>
<!-- e: invoice items -->


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

            $(document).on('open', '.remodal',  () ->
                $('.radioClass').on('click' , ()->
                    console.log $('input[name=discountradio]:checked').val()
                    if parseInt($('input[name=discountradio]:checked').val()) == 1
                        $('#discountvalue').removeClass "hidden"
                        $('#discountper').addClass "hidden"
                        perFlag = 1
                    else
                        $('#discountvalue').addClass "hidden"
                        $('#discountper').removeClass "hidden"
                        perFlag = 2

                )
                $('#discountvalue').on('change' , ()->
                    perFlag = 1
                    object.generateCostSheet()


                )
                $('#discountper').on('change' , ()->
                    perFlag = 2
                    object.generateCostSheet()


                )
                $('#payment').on('change' , ()->
                    object.generateCostSheet()


                )
                $('#paymentplans').on('change' , ()->
                    id = $('#'+this.id ).val()
                    object.generatePaymentSchedule(id)
                    object.getMilestones(id)


                )
            )
            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/jquery.remodal.js'
            document.body.appendChild(scr)
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
            object = @
            @generateCostSheet()

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


        generateCostSheet:->
            $('table#costSheetTable tr' ).remove()
            costSheetArray = []
            console.log App.unit['name']
            console.log unitModel = App.master.unit.findWhere({id:parseInt(App.unit['name'])})
            uniVariantModel = App.master.unit_variant.findWhere({id:unitModel.get('unitVariant')})
            costSheetArray.push(uniVariantModel.get('sellablearea'))
            costSheetArray.push(uniVariantModel.get('persqftprice'))
            discount = 0
            console.log perFlag
            if perFlag== 1
                console.log parseFloat(uniVariantModel.get('sellablearea'))
                console.log parseFloat(uniVariantModel.get('persqftprice'))
                discount = ((parseFloat(uniVariantModel.get('sellablearea')) * parseFloat(uniVariantModel.get('persqftprice'))) - parseFloat($('#discountvalue').val()))/parseFloat(uniVariantModel.get('sellablearea'))
            else if perFlag == 2
                pervalue = parseFloat($('#discountper').val())/100
                discount = (parseFloat(uniVariantModel.get('persqftprice')) * parseFloat(pervalue))
            discount = Math.ceil(discount.toFixed(2));

            revisedrate = parseFloat(uniVariantModel.get('persqftprice')) - (parseFloat(uniVariantModel.get('persqftprice'))*parseFloat(discount))
            costSheetArray.push(revisedrate)
            basicCost = parseFloat(uniVariantModel.get('persqftprice')) * parseFloat(revisedrate)
            costSheetArray.push(basicCost)
            costSheetArray.push(discount)
            table = ""
            buildingModel = App.master.building.findWhere({id:unitModel.get('building')})
            console.log planselectedValue = buildingModel.get('payment_plan')
            console.log milestoneselectedValue = buildingModel.get('milestone')
            $("#paymentplans option[value="+planselectedValue+"]").prop('selected', true)
            $("#milestones option[value="+milestoneselectedValue+"]").prop('selected', true)
            id1=$('#paymentplans').val()

            maintenance = parseFloat(uniVariantModel.get('sellablearea')) * 100
            agreement = parseFloat(basicCost) + 0
            table += '<tr><td>Chargeable Area</td><td>'+costSheetArray[0]+'</td></tr>
                       <tr><td>Rate Per Sq. Ft. Rs.</td><td>'+costSheetArray[1]+'</td></tr>
                        <tr><td>Revised Rate</td><td>'+costSheetArray[2]+'</td></tr>
                        <tr><td>Basic Cost Rs.</td><td>'+costSheetArray[3]+'</td></tr>

                        <tr><td>Infrastructure and Developement Charges.</td><td></td></tr>

                        <tr><td>Agreement Amount Rs.</td><td>'+agreement+'</td></tr>

           <tr><td>Stamp Duty Rs.</td><td></td></tr>
            <tr><td>Registration Amount Rs.</td><td></td></tr>
            <tr><td>VAT  Rs.</td><td></td></tr>
            <tr><td>Service Tax Rs.</td><td></td></tr>

           <tr><td>Total Cost Rs.</td><td></td></tr>
            <tr><td>Maintenance Deposit.</td><td>'+maintenance+'</td></tr>
            <tr><td>Club membership + Service Tax.</td><td></td></tr>                                                  <tr><td>Discount</td><td>'+costSheetArray[4]+'</td></tr>
                        <tr><td>Actual Payment</td><td>'+$('#payment').val()+'</td></tr>
                        <tr><td>Milestone Completed Till Date</td><td><select id="milestones"></select></td></tr>'
            console.log $('table#costSheetTable tbody' )
            $('table#costSheetTable tbody' ).append table
            id = $('#paymentplans' ).val()
            object.generatePaymentSchedule(id)
            object.getMilestones(id1)

        generatePaymentSchedule:(id)->
            console.log id
            $('table#paymentTable tr' ).remove()
            paymentColl = new Backbone.Collection PAYMENTPLANS
            milestones = paymentColl.get(parseInt(id))
            milestonesArray = milestones.get('milestones')
            milestonesArray = milestonesArray.sort( (a,b)->
                parseInt( a.sort_index) - parseInt( b.sort_index)
            )
            console.log milestonesArray
            table = ""
            milestoneColl = new Backbone.Collection MILESTONES
            for element in milestonesArray
                console.log milestoneModel = milestoneColl.get(element.milestone)
                table += '<tr><td>'+milestoneModel.get('name')+'</td><td>'+element.payment_percentage+'</td></tr> '
            $('table#paymentTable tbody' ).append table


        getMilestones:(id)->
            milesstones = ''
            $('#milestones option' ).remove()
            paymentColl = new Backbone.Collection PAYMENTPLANS
            milestones = paymentColl.get(parseInt(id))
            milestonesArray = milestones.get('milestones')
            milestonesArray = milestonesArray.sort( (a,b)->
                parseInt( a.sort_index) - parseInt( b.sort_index)
            )
            console.log milestonesArray
            milestoneColl = new Backbone.Collection MILESTONES
            for element in milestonesArray
                console.log milestoneModel = milestoneColl.get(element.milestone)
                milesstones += '<option value="'+element.milestone+'">'+milestoneModel.get('name')+'</option>'
            $('#milestones' ).append milesstones





















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



