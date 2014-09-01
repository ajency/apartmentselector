define [ 'marionette' ], ( Marionette )->

    perFlag = 0
    object = ""
    agreementValue = ""
    agreementValue1 = ""
    infraid = ""
    class ScreenFourLayout extends Marionette.LayoutView

        template : '<div class="page-container row-fluid">
                        <div id="vs-container" class="vs-container flatContainer">

                            <header class="vs-header" id="unitblock-region">
                            </header>

                            <div  id="mainunit-region">
                            </div>

                            <div class="h-align-middle">
                                <!--<a class="btn btn-primary m-t-20 m-b-20 h-align-middle remove" ><span class="glyphicon glyphicon-heart"></span> Add to Wishlist</a>-->
                                <div class="alert alert-success alert-dismissible hide" role="alert" id="errormsg"></div>
                            </div>

                            <div class="step4Actions">
                                <div class="grid-container">
                                    <div class="grid-block-4">
                                        <a class="grid-link remove" name="list" id="list">
                                            <h3 class="m-t-0 m-b-0"><span class="skyicon sky-heart"></span></h3>
                                            <h4 class="m-t-0 m-b-0">Add to Wishlist</h4>
                                        </a>
                                    </div>
                                    <div class="grid-block-4">
                                        <a class="grid-link">
                                            <h3 class="m-t-0 m-b-0"><span class="sky-printer"></span></h3>
                                            <h4 class="m-t-0 m-b-0">Print</h4>
                                        </a>
                                    </div>
                                    <div class="grid-block-4">
                                        <a class="grid-link">
                                            <h3 class="m-t-0 m-b-0"><span class="sky-mail"></span></h3>
                                            <h4 class="m-t-0 m-b-0">Email</h4>
                                        </a>
                                    </div>
                                    <div class="grid-block-4 costsheetbutton" >
                                        <a class="grid-link" data-remodal-target="modal">
                                            <h3 class="m-t-0 m-b-0"><span class="sky-coin"></span></h3>
                                            <h4 class="m-t-0 m-b-0">Cost Sheet</h4>
                                        </a>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="remodal" data-remodal-id="modal">

            			<div id="invoice" class="paid">

            				<div class="this-is">
            					<h3 class="light">Estimated Cost for Flat No. <span class="text-primary flatno"></span> in <span class="text-primary building"></span></h3>
            				</div><!-- invoice headline -->

            				<header id="header">
            					<div class="invoice-intro">
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <h5>Prepared for:</h5>
                                            <input type="text" id="" value="" class="form-control" placeholder="Customer Name"/>
                                        </div>
                                        <div class="col-sm-5">
                                            <h5>Prepared by:</h5>
                                            <h4 class="preparedby"></h4>
                                        </div>
                                        <div class="col-sm-2">
                                            <h5>Prepared on:</h5>
                                            <h4 class="preparedon"></h4>
                                        </div>
                                    </div>
            						<!--<h2 class="medium m-t-0 m-b-5 text-primary">Skyi</h2>
            						<p class="italic">Tagline comes here</p>-->
            					</div>

                                <div class="paymentDetails">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <h5 >Total Cost:</h5> <h4>Rs. <span class="totalcost"></span></h4>
                                        </div>
                                        <div class="col-sm-6">
                                            <h5 >Amount Receivable as on Date:</h5> <h4>Rs. <span class="rec"></span></h4>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <h5>Current Milestone:</h5> <h4> <span class="currentmile"></span></h4>
                                        </div>
                                        <div class="col-sm-6 form-inline">
                                            <h5>Actual Payment:</h5> 
                                            <input type="text" class="form-control" id="payment" value="0"/> <span class="glyphicon glyphicon-plus discountToggle"></span>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 form-inline">
                                            <h5>Payment Plan: </h5>
                                            <select id="paymentplans" class="form-control">
                                            {{#paymentplans}}
                                            <option value="{{id}}">{{name}}</option>
                                            {{/paymentplans}}
                                            </select>
                                        </div>
                                        <div class="col-sm-6 form-inline">
                                            <div class="discountBox">
                                                <h5>Discount Type:</h5>
                                                <label class="checkbox-inline">
                                                    <input type="radio" class="radioClass" id="radio1"  checked name="discountradio" value="1"/> Value
                                                </label>

                                                <label class="checkbox-inline">
                                                    <input type="radio" class="radioClass" name="discountradio" value="2"/> Percentage
                                                </label>
                                                <br>
                                                <h5>Discount Amount:</h5>
                                                <input type="text" id="discountvalue" value="" class="numeric form-control" />
                                                <input type="text" id="discountper" value="" class="numeric hidden form-control" />
                                                <br>
                                                <h5>Add On Payment: </h5><h4> Rs. <span class="addonpay"></span></h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                        


                                        
            				</header><!-- e: invoice header -->

            				<section class="invoice-financials">

                                <div class="invoice-items">
            						<div id="costSheetTable">
                                    </div>
                                    <!--<table id="costSheetTable">
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

            						</table>-->
            					</div>

                                <div class="invoice-items">
                                    <h4 class="text-primary">Payment Schedule</h4>
            						<ul id="paymentTable">

            						</ul>
            					</div><!-- e: invoice items -->

            				</section><!-- e: invoice financials -->

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
                console.log imgtodrag = $('.remove').find(".skyicon")
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

            $(".discountToggle").click ->
                $(".discountBox").slideToggle()
                return

            usermodel = new Backbone.Model USER
            capability = usermodel.get('all_caps')
            if usermodel.get('id') != "0" && $.inArray('see_cost_sheet',capability) >= 0
                @trigger "get:perSqft:price"
            else
                $('.costsheetbutton').hide()
                

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
                    #object.getMilestones(id)



                )
                $('#infra').on('change' , ()->
                    console.log "qqqqqqqqqqqqq"
                    console.log infraid = $('#infra' ).val()
                    object.updated()



                )
                $('#infra1').on('change' , ()->
                    console.log "qqqqqqqqqqqqq"
                    console.log infraid = $('#infra' ).val()
                    object.updated()


                )
                $('.numeric').on('keypress', (e)->
                    keyCode = e.keyCode
                    ret = ((keyCode >= 48 && keyCode <= 57) ||keyCode == 46 )
                    return ret



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
            #@generateCostSheet()
            perFlag = ""
            costSheetArray = []
            flag = 0
            count = 0

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

        onShowCostSheet:->
            @generateCostSheet()


        generateCostSheet:->
            $('#costSheetTable' ).text ""
            costSheetArray = []
            console.log App.unit['name']
            $('.flatno').text App.unit['name']
            usermodel = new Backbone.Model USER
            $('.preparedby').text usermodel.get 'display_name'
            date = new Date()
            $('.preparedon').text date.getDate()+'/'+(parseInt(date.getMonth()) + 1)+'/'+date.getFullYear()
            console.log unitModel = App.master.unit.findWhere({id:parseInt(App.unit['name'])})
            uniVariantModel = App.master.unit_variant.findWhere({id:unitModel.get('unitVariant')})
            costSheetArray.push(uniVariantModel.get('sellablearea'))
            costSheetArray.push(unitModel.get('persqftprice'))
            discount = 0
            console.log perFlag
            if perFlag== 1
                console.log parseFloat(uniVariantModel.get('sellablearea'))
                console.log parseFloat(unitModel.get('persqftprice'))
                discount = ((parseFloat(uniVariantModel.get('sellablearea')) * parseFloat(unitModel.get('persqftprice'))) - parseFloat($('#discountvalue').val()))/parseFloat(uniVariantModel.get('sellablearea'))
            else if perFlag == 2
                pervalue = parseFloat($('#discountper').val())/100
                discount = (parseFloat(unitModel.get('persqftprice')) * parseFloat(pervalue))
            discount = Math.ceil(discount.toFixed(2));

            revisedrate = parseFloat(unitModel.get('persqftprice')) - (parseFloat(discount))
            costSheetArray.push(revisedrate)
            basicCost = parseFloat(uniVariantModel.get('sellablearea')) * parseFloat(revisedrate)
            costSheetArray.push(basicCost)
            costSheetArray.push(discount)
            table = ""
            buildingModel = App.master.building.findWhere({id:unitModel.get('building')})
            $('.building').text buildingModel.get 'name'
            console.log planselectedValue = buildingModel.get('payment_plan')
            console.log milestoneselectedValue = buildingModel.get('milestone')
            $("#paymentplans option[value="+planselectedValue+"]").prop('selected', true)
            #$("#milestones option[value="+milestoneselectedValue+"]").prop('selected', true)
            id1=$('#paymentplans').val()

            maintenance = parseFloat(uniVariantModel.get('sellablearea')) * 100
            SettingModel = new Backbone.Model SETTINGS
            stamp_duty = (basicCost * (parseFloat(SettingModel.get('stamp_duty'))/100)) + 110
            reg_amt = parseFloat(SettingModel.get('registration_amount'))
            vat = (basicCost * (parseFloat(SettingModel.get('vat'))/100))
            sales_tax = (basicCost * (parseFloat(SettingModel.get('sales_tax'))/100))
            infraArray = SettingModel.get('infrastructure_charges' )
            membership_fees = SettingModel.get('membership_fees' )
            console.log membership_feesColl = new Backbone.Collection membership_fees
            console.log parseInt(unitModel.get('unitType'))
            console.log parseInt(unitModel.get('unitVariant'))
            console.log unitTypeMemeber = membership_feesColl.findWhere({unit_type:parseInt(unitModel.get('unitType'))})
            if unitTypeMemeber.get('membership_fees') == 0
                console.log unitVariantMemeber = unitTypeMemeber.get('unit_variant')
                unitVariantMemeberColl = new Backbone.Collection unitVariantMemeber
                univariantmem = unitVariantMemeberColl.findWhere({unit_variant:parseInt(unitModel.get('unitVariant'))})
                membershipfees = univariantmem.get('membership_fees')
            else
                membershipfees = unitTypeMemeber.get('membership_fees')
            infratxt = ''

            for element,index in infraArray
                selected = ""
                if parseInt(element) == infraid
                    selected = "selected"
                else
                    selected = ""
                infratxt += '<option value="'+element+'" '+selected+'>'+element+'</option>'
            console.log infratxt



            table += '  
                        <div class="costsRow totals title">
                            <div class="costCell costName">Cost Type</div>
                            <div class="costCell discCol showDisc">Base Rate <span class="cost-uniE600"></span></div>
                            <div class="costCell">Discounted Rate <span class="cost-uniE600"></span></div>
                        </div>
                        
                        <h5 class="headers"><span class="cost-office"></span> Skyi Costs</h5>

                        <div class="costsRow">
                            <div class="costCell costName">Chargeable Area (Sq.Ft.)</div>
                            <div class="costCell discCol showDisc">'+costSheetArray[0]+'</div>
                            <div class="costCell">'+costSheetArray[0]+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Rate per Sq.Ft.</div>
                            <div class="costCell discCol showDisc">'+costSheetArray[1]+'</div>
                            <div class="costCell">'+costSheetArray[1]+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Revised Rate</div>
                            <div class="costCell discCol showDisc">--</div>
                            <div class="costCell">'+costSheetArray[2]+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Basic Cost</div>
                            <div class="costCell discCol showDisc">'+(costSheetArray[0] * costSheetArray[1])+'</div>
                            <div class="costCell">'+costSheetArray[3]+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Infrastructure and Developement Charges</div>
                            <div class="costCell discCol showDisc"><select id="infra1"></select></div>
                            <div class="costCell"><select id="infra"></select></div>
                        </div>
                        <!--<tr>
                            <td>Chargeable Area</td>
                            <td>'+costSheetArray[0]+'</td>
                            <td>'+costSheetArray[0]+'</td>
                        </tr>
                        <tr>
                            <td>Rate Per Sq. Ft. Rs.</td>
                            <td>'+costSheetArray[1]+'</td>
                            <td>'+costSheetArray[1]+'</td>
                        </tr>
                        <tr>
                            <td>Revised Rate</td>
                            <td>--</td>
                            <td>'+costSheetArray[2]+'</td>
                        </tr>
                        <tr>
                            <td>Basic Cost Rs.</td>
                            <td>'+(costSheetArray[0] * costSheetArray[1])+'</td>
                            <td>'+costSheetArray[3]+'</td>
                        </tr>
                        <tr>
                            <td>Infrastructure and Developement Charges.</td>
                            <td><select id="infra1"></select></td>
                            <td><select id="infra"></select></td>
                        </tr>-->'
            $('#costSheetTable' ).append table
            $('#infra' ).append infratxt
            $('#infra1' ).append infratxt
            console.log infraid


            table = ""
            console.log $('#infra').val()
            basicCost1 = (costSheetArray[0] * costSheetArray[1])
            agreement1 = parseFloat(basicCost1) + parseFloat($('#infra').val())
            agreementValue1 = agreement1
            agreement = parseFloat(basicCost) + parseFloat($('#infra').val())
            agreementValue = agreement
            stamp_duty1 = (basicCost1 * (parseFloat(SettingModel.get('stamp_duty'))/100)) + 110
            reg_amt1 = parseFloat(SettingModel.get('registration_amount'))
            vat1 = (basicCost1 * (parseFloat(SettingModel.get('vat'))/100))
            sales_tax1 = (basicCost1 * (parseFloat(SettingModel.get('sales_tax'))/100))
            totalcost1 = parseFloat(agreement1) + parseFloat(stamp_duty1) + parseFloat( reg_amt1) + parseFloat(vat1) + parseFloat(sales_tax1)
            finalcost1 = parseFloat(totalcost1) + parseFloat(maintenance)


            paymentColl = new Backbone.Collection PAYMENTPLANS
            milestones = paymentColl.get(parseInt($('#paymentplans').val()))
            milestonesArray = milestones.get('milestones')
            console.log milestonesArrayColl = new Backbone.Collection milestonesArray
            console.log milestoneselectedValue
            console.log milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(buildingModel.get('milestone'))})
            milestonesArray = milestonesArray.sort( (a,b)->
                parseInt( a.sort_index) - parseInt( b.sort_index)
            )
            console.log milestoneCollection = new Backbone.Collection MILESTONES
            if milestonemodel == undefined
                console.log milesotneVal = _.first(milestonesArray)
                console.log milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(milesotneVal.milestone)})
                console.log milestonename = milestoneCollection.get(parseInt(milestonemodel.get('milestone')))
                $('.currentmile').text milestonename.get 'name'
                
            else
                console.log milstoneModelName = milestoneCollection.get(milestonemodel.get('milestone'))
                $('.currentmile').text milstoneModelName.get 'name'
            

            console.log milestonesArray
            milestoneColl = new Backbone.Collection MILESTONES
            count = 0
            for element in milestonesArray
                if element.sort_index <= milestonemodel.get('sort_index')
                    percentageValue = (agreement * ((parseFloat(element.payment_percentage))/100))
                    count = count + percentageValue
            if  $('#payment').val() == 0
                addon = 0
            else

                addon = parseFloat($('#payment').val()) - parseFloat(count)

            totalcost = parseFloat(agreement) + parseFloat(stamp_duty) + parseFloat( reg_amt) + parseFloat(vat) + parseFloat(sales_tax)
            finalcost = parseFloat(totalcost) + parseFloat(maintenance)
            console.log table
            $('.totalcost').text totalcost
            $('.rec').text count
            table += '  <div class="costsRow totals">
                            <div class="costCell costName">Agreement Amount</div>
                            <div class="costCell discCol showDisc"><span id="agreement1">'+$('#infra').val()+(costSheetArray[0] * costSheetArray[1])+'</span></div>
                            <div class="costCell"><span id="agreement">'+agreement+'</span></div>
                        </div>

                        <h5 class="headers"><span class="cost-library"></span> Government Charges</h5>
                        <div class="costsRow">
                            <div class="costCell costName">Stamp Duty</div>
                            <div class="costCell discCol showDisc">'+stamp_duty1+'</div>
                            <div class="costCell">'+stamp_duty+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Registration Amount</div>
                            <div class="costCell discCol showDisc">'+reg_amt1+'</div>
                            <div class="costCell">'+reg_amt+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">VAT</div>
                            <div class="costCell discCol showDisc">'+vat1+'</div>
                            <div class="costCell">'+vat+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Service Tax</div>
                            <div class="costCell discCol showDisc">'+sales_tax1+'</div>
                            <div class="costCell">'+sales_tax+'</div>
                        </div>
                        <div class="costsRow totals">
                            <div class="costCell costName">Total Cost</div>
                            <div class="costCell discCol showDisc">'+totalcost1+'</div>
                            <div class="costCell">'+totalcost+'</div>
                        </div>

                        <h5 class="headers"><span class="cost-paint-format"></span> Other Costs</h5>
                        <div class="costsRow">
                            <div class="costCell costName">Maintenance Deposit</div>
                            <div class="costCell discCol showDisc">'+maintenance+'</div>
                            <div class="costCell">'+maintenance+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Club membership + Service Tax</div>
                            <div class="costCell discCol showDisc">'+membershipfees+'</div>
                            <div class="costCell">'+membershipfees+'</div>
                        </div>
                        <div class="costsRow totals">
                            <div class="costCell costName">Final Cost</div>
                            <div class="costCell discCol showDisc"><span id="finalcost1">'+finalcost1+'</span></div>
                            <div class="costCell"><span id="finalcost">'+finalcost+'</span></div>
                        </div>

                        <!--<tr>
                            <td>Agreement Amount Rs.</td>
                            <td><span id="agreement1">'+$('#infra').val()+(costSheetArray[0] * costSheetArray[1])+'</span></td>
                            <td><span id="agreement">'+agreement+'</span></td>
                        </tr>

                        <tr>
                            <td>Stamp Duty Rs.</td>
                            <td>'+stamp_duty1+'</td>
                            <td>'+stamp_duty+'</td>
                        </tr>
                        <tr>
                            <td>Registration Amount Rs.</td>
                            <td>'+reg_amt1+'</td>
                            <td>'+reg_amt+'</td>
                        </tr>
                        <tr>
                            <td>VAT  Rs.</td>
                            <td>'+vat1+'</td>
                            <td>'+vat+'</td>
                        </tr>
                        <tr>
                            <td>Service Tax Rs.</td>
                            <td>'+sales_tax1+'</td>
                            <td>'+sales_tax+'</td>
                        </tr>
                        <tr>
                            <td>Total Cost Rs.</td>
                            <td><span id="totalcost1">'+totalcost1+'</span></td>
                            <td><span id="totalcost">'+totalcost+'</span></td>
                        </tr>

                        <tr>
                            <td>Maintenance Deposit.</td>
                            <td>'+maintenance+'</td>
                            <td>'+maintenance+'</td>
                        </tr>
                        <tr>
                            <td>Club membership + Service Tax.</td>
                            <td>'+membershipfees+'</td>
                            <td>'+membershipfees+'</td>
                        </tr>

                        <tr>
                            <td>Discount</td>
                            <td></td>
                            <td>'+costSheetArray[4]+'</td>
                        </tr>
                        <tr>
                            <td>Actual Payment</td>
                            <td></td>
                            <td>'+$('#payment').val()+'</td>
                        </tr>
                        <tr>
                            <td>Milestone Completed Till Date</td>
                            <td></td>
                            <td><select id="milestones"></select></td>
                        </tr>
                        <tr>
                            <td>Actual Receivable As On Date</td>
                            <td></td>
                            <td><span id="rec">'+count+'</span></td>
                        </tr>
                        <tr>
                            <td>Add On Payment</td>
                            <td></td>
                            <td><span id="addonpay">'+addon+'</span></td>
                        </tr>

                        <tr>
                            <td>Final Cost</td>
                            <td><span id="finalcost1">'+finalcost1+'</span></td>
                            <td><span id="finalcost">'+finalcost+'</span></td>
                        </tr>-->'
            # console.log $('table#costSheetTable tbody' )
            $('#costSheetTable' ).append table

            id = $('#paymentplans' ).val()
            object.generatePaymentSchedule(id)
            #object.getMilestones(id1)
            $('#infra').on('change' , ()->
                console.log "qqqqqqqqqqqqq"
                console.log infraid = $('#infra' ).val()
                object.updated()


            )
            $('#infra1').on('change' , ()->
                console.log "qqqqqqqqqqqqq"
                console.log infraid = $('#infra' ).val()
                object.updated()


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
                #object.getMilestones(id)


            )

        generatePaymentSchedule:(id)->
            flag = 0
            #get_apratment_selector_settings()
            console.log id
            unitModel = App.master.unit.findWhere({id:parseInt(App.unit['name'])})
            buildingModel = App.master.building.findWhere({id:unitModel.get('building')})
            #milestonecompletion = buildingModel.get 'milestonecompletion'
            $('#paymentTable' ).text ""
            paymentColl = new Backbone.Collection PAYMENTPLANS
            milestones = paymentColl.get(parseInt(id))
            milestonesArray = milestones.get('milestones')
            console.log milestonesArrayColl = new Backbone.Collection milestonesArray
            console.log milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(buildingModel.get('milestone'))})
            milestonesArray = milestonesArray.sort( (a,b)->
                parseInt( a.sort_index) - parseInt( b.sort_index)
            )
            milestoneCollection = new Backbone.Collection MILESTONES
            

            if milestonemodel == undefined
                flag = 1
                console.log "unnnn"
                console.log milesotneVal = _.first(milestonesArray)
                console.log milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(milesotneVal.milestone)})
                console.log milestonename = milestoneCollection.get(parseInt(milestonemodel.get('milestone')))
                $('.currentmile').text milestonename.get 'name'
            else
                milstoneModelName = milestoneCollection.get(milestonemodel.get('milestone'))
                $('.currentmile').text milstoneModelName.get 'name'


            console.log milestonesArray
            table = ""
            count = 0
            milestoneColl = new Backbone.Collection MILESTONES
            milestonecompletion = {48:'26/08/2014', 52:'30/08/2014'}
            for element in milestonesArray
                percentageValue = (agreementValue * ((parseFloat(element.payment_percentage))/100))
                percentageValue1 = (agreementValue1 * ((parseFloat(element.payment_percentage))/100))
                console.log proposed_date = $.map(milestonecompletion, (index,value)->
                    console.log element.milestone
                    console.log value
                    if parseInt(element.milestone) == parseInt(value)
                        return index

                    )
                if proposed_date.length == 0
                    proposed_date = ''
                if element.sort_index <= milestonemodel.get('sort_index')
                    trClass = "milestoneReached"
                    percentageValue = (agreementValue * ((parseFloat(element.payment_percentage))/100))
                    count = count + percentageValue
                else
                    trClass = ""
                if flag == 1
                    trClass = ""

                console.log milestoneModel = milestoneColl.get(element.milestone)
                table += '  <span class="msPercent">'+element.payment_percentage+'%</span>
                            <li class="milestoneList '+trClass+'">
                                <div class="msName">'+milestoneModel.get('name')+' <span class="completionDate">(Estimated date: 15-12-2014)</span></div>
                                <div class="msVal">'+percentageValue1+'</div>
                                <div class="msVal">'+percentageValue+'</div>
                                <span class="barBg" style="width:'+element.payment_percentage+'%"></span>
                            </li>
                            <div class="clearfix"></div>
                            <!--<tr class="'+trClass+'"><td>'+milestoneModel.get('name')+'</td><td>'+element.payment_percentage+'</td>
                                            <td>'+percentageValue1+'</td><td>'+percentageValue+'</td></tr>--> '
            $('#rec' ).text count
            $('.rec' ).text count
            console.log $('#payment' ).val()
            if $('#payment' ).val() == 0
                addon = 0

            else
                addon = $('#payment' ).val() - count
            $('.addonpay' ).text addon

            $('#paymentTable' ).append table


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

        updated:->

            costSheetArray = []
            console.log App.unit['name']
            console.log unitModel = App.master.unit.findWhere({id:parseInt(App.unit['name'])})
            uniVariantModel = App.master.unit_variant.findWhere({id:unitModel.get('unitVariant')})
            costSheetArray.push(uniVariantModel.get('sellablearea'))
            costSheetArray.push(unitModel.get('persqftprice'))
            discount = 0
            console.log perFlag
            if perFlag== 1
                console.log parseFloat(uniVariantModel.get('sellablearea'))
                console.log parseFloat(unitModel.get('persqftprice'))
                discount = ((parseFloat(uniVariantModel.get('sellablearea')) * parseFloat(unitModel.get('persqftprice'))) - parseFloat($('#discountvalue').val()))/parseFloat(uniVariantModel.get('sellablearea'))
            else if perFlag == 2
                pervalue = parseFloat($('#discountper').val())/100
                discount = (parseFloat(unitModel.get('persqftprice')) * parseFloat(pervalue))
            discount = Math.ceil(discount.toFixed(2));

            revisedrate = parseFloat(unitModel.get('persqftprice')) - (parseFloat(discount))
            costSheetArray.push(revisedrate)
            basicCost = parseFloat(uniVariantModel.get('sellablearea')) * parseFloat(revisedrate)
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
            SettingModel = new Backbone.Model SETTINGS
            stamp_duty = (basicCost * (parseFloat(SettingModel.get('stamp_duty'))/100)) + 110
            reg_amt = parseFloat(SettingModel.get('registration_amount'))
            vat = (basicCost * (parseFloat(SettingModel.get('vat'))/100))
            sales_tax = (basicCost * (parseFloat(SettingModel.get('sales_tax'))/100))
            infraArray = SettingModel.get('infrastructure_charges' )
            membership_fees = SettingModel.get('membership_fees' )
            console.log membership_feesColl = new Backbone.Collection membership_fees
            console.log parseInt(unitModel.get('unitType'))
            console.log parseInt(unitModel.get('unitVariant'))
            console.log unitTypeMemeber = membership_feesColl.findWhere({unit_type:parseInt(unitModel.get('unitType'))})
            if unitTypeMemeber.get('membership_fees') == 0
                console.log unitVariantMemeber = unitTypeMemeber.get('unit_variant')
                unitVariantMemeberColl = new Backbone.Collection unitVariantMemeber
                univariantmem = unitVariantMemeberColl.findWhere({unit_variant:parseInt(unitModel.get('unitVariant'))})
                membershipfees = univariantmem.get('membership_fees')
            else
                membershipfees = unitTypeMemeber.get('membership_fees')








            table = ""
            console.log $('#infra').val()
            basicCost1 = (costSheetArray[0] * costSheetArray[1])
            agreement1 = parseFloat(basicCost1) + parseFloat($('#infra').val())
            agreementValue1 = agreement1
            agreement = parseFloat(basicCost) + parseFloat($('#infra').val())
            agreementValue = agreement
            $('#agreement' ).text agreement
            $('#agreement1' ).text agreement1
            stamp_duty1 = (basicCost1 * (parseFloat(SettingModel.get('stamp_duty'))/100)) + 110
            reg_amt1 = parseFloat(SettingModel.get('registration_amount'))
            vat1 = (basicCost1 * (parseFloat(SettingModel.get('vat'))/100))
            sales_tax1 = (basicCost1 * (parseFloat(SettingModel.get('sales_tax'))/100))
            totalcost1 = parseFloat(agreement1) + parseFloat(stamp_duty1) + parseFloat( reg_amt1) + parseFloat(vat1) + parseFloat(sales_tax1)
            finalcost1 = parseFloat(totalcost1) + parseFloat(maintenance)
            $('#totalcost1' ).text totalcost1
            $('#finalcost1' ).text totalcost1


            paymentColl = new Backbone.Collection PAYMENTPLANS
            milestones = paymentColl.get(parseInt($('#paymentplans').val()))
            milestonesArray = milestones.get('milestones')
            console.log milestonesArrayColl = new Backbone.Collection milestonesArray
            console.log milestoneselectedValue
            console.log milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(buildingModel.get('milestone'))})
            milestonesArray = milestonesArray.sort( (a,b)->
                parseInt( a.sort_index) - parseInt( b.sort_index)
            )
            if milestonemodel == undefined
                console.log milesotneVal = _.first(milestonesArray)
                milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(milesotneVal.milestone)})

            console.log milestonesArray
            milestoneColl = new Backbone.Collection MILESTONES
            count = 0
            for element in milestonesArray
                if element.sort_index <= milestonemodel.get('sort_index')
                    percentageValue = (agreement * ((parseFloat(element.payment_percentage))/100))
                    count = count + percentageValue
            addon = parseFloat($('#payment').val()) - parseFloat(count)

            totalcost = parseFloat(agreement) + parseFloat(stamp_duty) + parseFloat( reg_amt) + parseFloat(vat) + parseFloat(sales_tax)
            finalcost = parseFloat(totalcost) + parseFloat(maintenance)
            $('#totalcost' ).text totalcost
            $('#finalcost' ).text totalcost























    class UnitsView extends Marionette.ItemView

        # template : '<a class="link" href="unit{{id}}">Flat No {{name}}</a>'

        tagName : 'li'

        className : 'vs-nav-current'






    class UnitTypeChildView extends Marionette.CompositeView

        tagName : 'ul'


        className : 'vs-nav'



        childView : UnitsView


    class UnitMainView extends Marionette.CompositeView

        template : '<div class="row m-l-0 m-r-0">
						<div class="col-sm-4 p-b-10">
                            <div class="unitDetails">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="unitBox unitNmbr">
                                            <h3>{{name}}</h3>
                                            <h4 class="titles"><span class="sky-flag"></span> Flat No.</h4>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="unitBox chargeArea">
                                            <h3>{{sellablearea}} <span class="light">Sq.Ft.</span></h3>
                                            <h4 class="titles"><span class="sky-banknote"></span> Chargeable Area</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="unitBox">

                                            {{#roomsizearray}}
                                             <div class="rooms">{{type}}<h4 class="size">{{size}} Sq.Ft.</h4></div>


                                    {{/roomsizearray}}
                                    <h4 class="titles"><span class="sky-maximize"></span> Room Sizes</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="unitBox facing">
                                            <h4 class="view">{{terraceoptions}}</h4>
                                            <h4 class="titles"><span class="sky-content-left"></span> Terrace</h4>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="unitBox facing">
                                            <h4 class="view">{{facings}}</h4>
                                            <h4 class="titles"><span class="sky-location"></span> Facing</h4>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="unitBox facing">
                                            <h4 class="view">{{views}}</h4>
                                            <h4 class="titles"><span class="sky-map"></span> Views</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
						</div>

						<!--<div class="col-sm-8">
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
						</div>-->

                        <div class="col-sm-8 b-grey b-l">
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
					</div>
					
                    <!--<div class="row m-l-0 m-r-0 m-t-20 p-t-20 b-grey b-t">
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
                                        {{#toiletArray}}
                                        <h3 class="text-primary">{{size}}</h3>
                                        {{/toiletArray}}
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
                    </div>-->
                    <!--<a  class="btn btn-primary">Cost Sheet</a>-->
                    '






        tagName  : "section"






        initialize :->
            @$el.prop("id", 'unit'+@model.get("id"))

        onShow:->
            console.log @model.get("unitVariant")
            $('#slider-plans').liquidSlider(
                slideEaseFunction: "easeInOutQuad",
                autoSlide: true,
                includeTitle:false,
                minHeight: 300,
                autoSlideInterval: 4000,
                forceAutoSlide: true,
                mobileNavigation: false,
                hideArrowsWhenMobile: false,
                dynamicTabsAlign: "center"


            )





    class UnitTypeView extends Marionette.CompositeView

        className : "vs-wrapper"


        childView : UnitMainView


    ScreenFourLayout : ScreenFourLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView



