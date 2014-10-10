define [ 'marionette' ], ( Marionette )->

    perFlag = 0
    object = ""
    agreementValue = ""
    agreementValue1 = ""
    infraid = ""
    discountClass = ""
    class ScreenFourLayout extends Marionette.LayoutView

        template : '<div class="page-container row-fluid">
                        <div id="vs-container" class="vs-container flatContainer">

                            <header class="vs-header" id="unitblock-region">
                            </header>

                            <div  id="mainunit-region">
                            </div>

                            <div class="h-align-middle">
                                <!--<a class="btn btn-primary m-t-20 m-b-20 h-align-middle remove" ><span class="glyphicon glyphicon-heart"></span> Add to Wishlist</a>-->
                                <!--<div class="alert alert-success alert-dismissible hide" role="alert" id="errormsg"></div>-->
                            </div>

                            <div class="step4Actions">
                                <div class="grid-container">
                                    <div class="grid-block-4 addtowishlist ">
                                        <a class="grid-link remove" name="list" id="list">
                                            <h3 class="m-t-0 m-b-0"><span class="skyicon sky-heart"></span></h3>
                                            <h4 class="m-t-0 m-b-0 ">Add to Wishlist</h4>
                                        </a>
                                    </div>
                                    <div class="grid-block-4">
                                        <a class="grid-link print-preview">
                                            <h3 class="m-t-0 m-b-0"><span class="sky-printer"></span></h3>
                                            <h4 class="m-t-0 m-b-0">Print</h4>
                                        </a>
                                    </div>
                                    <div class="grid-block-4">
                                        <a class="grid-link" id="emailBtn"  >
                                            <h3 class="m-t-0 m-b-0"><span class="sky-mail"></span></h3>
                                            <h4 class="m-t-0 m-b-0">Email</h4>
                                        </a>
                                    </div>
                                    <div class="grid-block-4 costsheetbutton " >
                                        <a class="grid-link" >
                                            <h3 class="m-t-0 m-b-0"><span class="sky-coin"></span></h3>
                                            <h4 class="m-t-0 m-b-0 ">Cost Sheet</h4>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </div>


                    <div class="costsheetclass" style="display:none" >

            			<div id="invoice" class="paid">

            				<div class="this-is">
            					<h3 class="light">Estimated Cost for Flat No. <span class="text-primary flatno"></span> in <span class="text-primary building"></span></h3>
            				</div><!-- invoice headline -->

            				<header id="header">
            					<div class="invoice-intro">
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <h5>Prepared for:</h5>
                                            <input type="text" id="customer_name" value="" class="form-control" placeholder="Customer Name"/>
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
                                            <h5 >Total Cost:</h5> <h4><span class="actualcost" data-a-sign="Rs. " data-d-group="2"></span></h4>
                                        <input type="hidden" id="actualcostvalue" data-a-sign="Rs. " data-d-group="2" value="" /></div>
                                        <div class="col-sm-6">
                                            <h5 >Amount Receivable as on Date:</h5> <h4><span class="rec" data-a-sign="Rs. " data-d-group="2"></span></h4>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <h5>Current Milestone:</h5> <h4> <span class="currentmile"></span></h4>
                                        </div>
                                        <div class="col-sm-6 form-inline">
                                            <h5>Actual Payment:</h5> 
                                            <input type="text" class="form-control"  id="payment" value="0"/> <span class="glyphicon glyphicon-plus discountToggle"></span>
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
                                                <h5>Add On Payment: </h5><h4><span class="addonpay" data-v-min="-9999999999999999.99"data-a-sign="Rs. " data-d-group="2"></span></h4>
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
                	</div>

                    <div class="formPopup" style="display:none">
                        <div class="formIntro">I\'m interested in <br>Flat <span id="emailflatno"></span> in <span id="emailtower"></span></div>
                        <div class="formFields"></div>                        
                    </div><div class="inframamout hidden" data-a-sign="Rs. " data-d-group="2"></div>'






        regions :
            unitRegion : '#unitblock-region'
            mainRegion : '#mainunit-region'

        events:->
            'click .costsheetbutton':(e)->
                $('.costsheetclass').bPopup onClose: ->
                    $('body').css
                            overflowY: 'auto'
                            height: 'auto'
                    return

                $('body').css
                    overflowY: 'hidden'
                    height: '100%'

            # 'click .print-preview':(e)->
            #     @loadPrint()
            'click #emailBtn':(e)->
                e.preventDefault()
                
                
                $('.formIntro').html ""
                unit = App.master.unit.findWhere({id:parseInt(App.unit['name'])})
                building = App.master.building.findWhere({id:parseInt(unit.get('building'))})
                $(".formFields").html(EMAILFORM)
                $('.formIntro').html  'I\'m interested in <br>Flat <span id="emailflatno">'+unit.get('name')+'</span> in <span id="emailtower">'+building.get('name')+'</span></div>'
                $(".formPopup").bPopup()
                # inst = $.remodal.lookup[$("[data-remodal-id=emailpop]").data("remodal")]
                # inst.open()
                $('#field_emailunit').val unit.get('name')
                $('#field_emailtower').val building.get('name')
                $('#field_unitid').val unit.get('id')
                $('#field_towerid').val building.get('id')
                $('#field_wishlist').val localStorage.getItem("cookievalue" )
                
                
                return


            
            'click #list':(e)->
                myModal = new jBox('Notice', 
                    content: '',
                    autoClose: 2000
                    addClass: 'notifyBox'
                    position:
                        x: 'center'
                        y: 'top'
                    animation:
                        open: 'slide:top'
                        close: 'slide:top'
                    # fade: 1000
                )

                $("#showRightPush").removeClass "hidden"

                cookieOldValue = $.cookie("key")
                if cookieOldValue == undefined || $.cookie("key") == ""
                    cookieOldValue = ""
                else
                    cookieOldValue = $.cookie("key" ).split(',' ).map( (item)->
                        parseInt(item)
                    )
                if cookieOldValue.length >= 4
                    myModal.setContent("Cannot add more than 4 units")
                    return false
                else

                    key = $.inArray(parseInt(App.unit['name']) , cookieOldValue)

                    if parseInt(key) == -1
                        App.cookieArray.push(parseInt(App.unit['name']))
                        $('#list').addClass "remove"
                    else
                        myModal.setContent("Already entered")
                        $('#list').removeClass "remove"
                        return false
                    App.cookieArray = $.merge(App.cookieArray,cookieOldValue)
                    App.cookieArray = _.uniq(App.cookieArray)
                    $.cookie('key',App.cookieArray)
                    localStorage.setItem("cookievalue", App.cookieArray)
                    myModal.setContent("The selected flat has been added to your WishList")
                    
                cart = $("#showRightPush")
                imgtodrag = $('.remove').find(".skyicon")
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
                val = $('#'+e.target.id).attr('data-id')
                index = App.cookieArray.indexOf( parseInt(val) )
                App.cookieArray.splice( index, 1 )
                if App.cookieArray.length <= 1
                    $('#compare').hide()
                $.cookie('key',App.cookieArray)
                localStorage.setItem("cookievalue", App.cookieArray)
                if App.cookieArray.length < 1
                    $("#showRightPush").addClass "hidden"
                    menuRight = document.getElementById("cbp-spmenu-s2")
                    menuTop = document.getElementById("cbp-spmenu-s3")
                    showTop = document.getElementById("showTop")
                    showRightPush = document.getElementById("showRightPush")
                    body = document.body
                    classie.toggle showRightPush, "active"
                    classie.toggle body, "cbp-spmenu-push-toleft"
                    classie.toggle menuRight, "cbp-spmenu-open"
                    
                     
                

                

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
                rangeModel = App.master.range
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
                        App.defaults['floor'] = rangeArrayVal.join(',')



                )
                

                msgbus.showApp 'header'
                .insideRegion  App.headerRegion
                    .withOptions()
                msgbus.showApp 'screen:four'
                .insideRegion  App.layout.screenFourRegion
                    .withOptions()

            #'click .print-preview':(e)->
        jQuery(document).bind("keyup keydown", (e)->
            if(e.ctrlKey && e.keyCode == 80)
                @loadPrint()

        )

        loadPrint:->
                # $('.prntLoader').removeClass "hidden"
                $("#flatno").text ""
                $("#towerno").text ""
                $("#unittypename").text ""
                $("#area").text ""
                $("#floorrise").text ""
                $('.room').html ""
                $('#terrace').text ""
                $('#printfacing').text ""
                $('#printview').text ""
                $("#twoDimage").attr('src' , "")
                $("#zoomedinimage").attr('src' , "")
                $("#floorlayoutbasic").text ""
                $('#printmapplic1').text ""
                $('#towerview').text ""
                units = App.master.unit.findWhere({id:parseInt(App.unit['name'])})
                $("#flatno").text units.get 'name'
                $("#towerno").text units.get 'buildingname'
                $("#unittypename").text units.get 'unittypename'
                $("#area").text units.get 'sellablearea'
                $("#floorrise").text units.get 'flooRange'
                roomsizearray = units.get 'roomsizearray'
                roomtext = ""
                $.each(roomsizearray, (index,value)->

                    roomtext += '<div class="rooms">
                                    <span>'+value.type+'</span>: '+value.size+' sq ft
                                </div>'


                    )
                $('.room').html roomtext
                $('#terrace').text units.get 'terraceoptions'
                $('#printfacing').text units.get 'facings_name'
                $('#printview').text units.get 'views_name'
                image = document.getElementById('twoDimage')
                $("#twoDimage").attr('src' , units.get 'TwoDimage')
                $("#zoomedinimage").attr('src' , units.get 'zoomedinimage')
                $("#threeDimage").attr('src' , units.get 'ThreeDimage')
                object = @
                $("#floorlayoutbasic").load(units.get('floor_layout_basic'), (x)->
                        $('#'+units.get('unitAssigned')).attr('class','floor-pos position')
                )
                $('#printmapplic1').load(SITEURL+'/wp-content/uploads/2014/08/first-map.svg', (x)->
                        $('#hglighttower'+units.get('building')).attr('class','overlay highlight')

                )
                building = App.master.building.findWhere({id:units.get('building')})
                svgdata = building.get 'svgdata'
                indexvalue = ""
                indexvalue1 = ""
                temp = ['ff','f']
                temp1 = ['tt','t']
                temp2 = ['cc','cc']
                
                if  parseInt(building.get('id')) == 11
                        temp = ['f','ff']
                        temp1 = ['t','tt']
                        temp2 = ['c','cc']
                
                $.each(svgdata, (index,value)->
                    
                    if $.inArray(units.get('unitAssigned'),value.svgposition ) >= 0 && value.svgposition != null
                        ii = 0
                        if value.svgfile != ""
                            svgposition = value.svgfile
                            unitsarray = value.units
                            $('#towerview').load(svgposition,  (x)->
                                value.svgposition.sort( (a,b)->
                                    b - a

                                )
                                $.each(value.svgposition, (index1,val1)->
                                            
                                            indexvalue = unitsarray[units.get('unitAssigned')]
                                            indexvalue1 = unitsarray[val1]
                                            $.map(indexvalue1, (index,value)->
                                                $('#'+temp[ii]+value).attr('class', 'unselected-floor')
                                                $('#'+temp[ii]+value).attr('data-value', index)
                                                $('#'+temp[ii]+value).attr('data-idvalue', temp[ii])
                                            
                                                
                                            )
                                            ii++

                                        
                                            


                                )
                                idvalue = ""

                               
                                position = ""
                                $.each(indexvalue, (index,value)->
                                    if parseInt($('#f'+index).attr('data-value'))  == units.get('id')
                                       idvalue = $('#f'+index).attr('data-idvalue')
                                       position = index 
                                    else if parseInt($('#ff'+index).attr('data-value'))  == units.get('id')
                                       idvalue = $('#ff'+index).attr('data-idvalue')
                                       position = index 

                                    )
                                textid = ""
                                $('#'+idvalue+position).attr('class', 'selected-flat')
                                if idvalue == 'f'
                                    textid = 't'
                                else
                                    textid = 'tt'
                                $("#"+textid+position).attr('class','selected-flat')
                                unittpe = App.master.unit_type.findWhere({id:units.get('unitType')})
                                text = units.get('name')+' | '+unittpe.get('name')
                                $('#'+textid+position).html text
                                $('#'+textid+position).attr('x','-30')
                                

                            )
                        


                )

        onShow:->
            #@trigger "get:perSqft:price"

             
            $(".discountToggle").click ->
                $(".discountBox").slideToggle()
                return

            usermodel = new Backbone.Model USER
            capability = usermodel.get('all_caps')
            if usermodel.get('id') != "0" && $.inArray('see_cost_sheet',capability) >= 0
                true
            else
                $('.costsheetbutton').hide()
                $('.addtowishlist').hide()
                $('.special').hide()
                #@trigger "get:perSqft:price"
                

            
            $('#customer_name').on('change', ()->
                    $('#customerlabel').text this.value

            )
            $('.radioClass').on('click' , ()->
                    if parseInt($('input[name=discountradio]:checked').val()) == 1
                        $('#discountvalue').removeClass "hidden"
                        $('#discountper').addClass "hidden"
                        $('#discountper').val ""
                        perFlag = 0
                        $('.discCol').removeClass 'showDisc'
                        $('.revised').hide()
                        $('.actualcost').text $('#actualcostvalue').val()
                    else
                        $('#discountvalue').addClass "hidden"
                        $('#discountvalue').val ""
                        $('#discountper').removeClass "hidden"
                        perFlag = 0
                        $('.discCol').removeClass 'showDisc'
                        $('.revised').hide()
                        $('.actualcost').text $('#actualcostvalue').val()

            )
            $('#discountvalue').on('change' , ()->
                    perFlag = 1
                    
                    if parseInt(this.value.length) == 0
                        perFlag = 0
                        $('.discCol').removeClass 'showDisc'
                    object.generateCostSheet()


            )
            $('#discountper').on('change' , ()->
                    perFlag = 2
                    
                    if parseInt(this.value.length) == 0
                        perFlag = 0
                        $('.discCol').removeClass 'showDisc'
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
                    infraid = $('#infra' ).val()
                    object.updated()



            )
            $('#infra1').on('change' , ()->
                    infraid = $('#infra1' ).val()
                    object.updated1()


            )
            $('.numeric').on('keypress', (e)->
                    keyCode = e.keyCode
                    ret = ((keyCode >= 48 && keyCode <= 57) ||keyCode == 46 )
                    return ret



            )

           

            # scr = document.createElement('script')
            # scr.src = '../wp-content/themes/apartmentselector/js/src/preload/jquery.remodal.js'
            # document.body.appendChild(scr)
            
            $('html, body').delay(600).animate({
                scrollTop: $('#screen-four-region').offset().top
            }, 'slow')
            cookieOldValue = $.cookie("key")
            if cookieOldValue == undefined || $.cookie("key") == ""
                cookieOldValue = []
            else
                cookieOldValue = $.cookie("key" ).split(',' ).map( (item)->
                    parseInt(item)
                )
            App.cookieArray = cookieOldValue
            @showWishList()
            object = @
            @generateCostSheet()
            perFlag = ""
            costSheetArray = []
            flag = 0
            count = 0
            discountClass = ""
            $('a.print-preview').printPreview();
            @loadPrint()

        showWishList:->
            table = ""
            if $.cookie("key")!= undefined && $.cookie("key") != ""
                selectedUnitsArray = $.cookie("key").split(",")
                if selectedUnitsArray.length > 1
                    $('#compare').show()
                table = ""
                for element in selectedUnitsArray
                    model = App.master.unit.findWhere(id:parseInt(element))
                    unitType = App.master.unit_type.findWhere(id:model.get('unitType'))
                    unitVariant = App.master.unit_variant.findWhere(id:model.get('unitVariant'))
                    building = App.master.building.findWhere(id:model.get('building'))
                    table +='<li>
                                <a href="#" id="unit'+element+'" data-id="'+element+'"  class="selectedunit">'+model.get('name')+' - '+building.get('name')+'</a>
                                <a href="#" class="del" id="'+element+'" data-id="'+element+'"  ></a>
                                <div class="clearfix"></div>
                            </li>'

                # table += '</table>'
            $('#showWishlist').html table

        onShowCostSheet:(value)->
            units = App.master.unit.findWhere({id:parseInt(App.unit['name'])})
            # @generateCostSheet()
            viewModelArray = []
            facingModelArray = []
            units.set 'views_name' , value.views
            if value.views.length != 0
                viewsArray = value.views
                for element in viewsArray
                    viewModel = App.master.view.findWhere({id:parseInt(element)})
                    viewModelArray.push(viewModel.get('name'))
            else
                viewModelArray.push('-----')
            $('.viewclass').text viewModelArray.join(', ')
            facingssArray = value.facings
            units.set 'facing_name' , value.facings
            if facingssArray.length != 0
                for element in facingssArray
                    facingModel = App.master.facings.findWhere({id:parseInt(element)})
                    facingModelArray.push(facingModel.get('name'))

            else
                facingModelArray.push('-----')
            units = App.master.unit.findWhere({id:parseInt(App.unit['name'])})
            $('.facingclass').text facingModelArray.join(', ')




        generateCostSheet:->
            $('#costSheetTable' ).text ""
            $('#costSheetTableprint' ).text ""
            costSheetArray = []
            usermodel = new Backbone.Model USER
            $('.preparedby').text usermodel.get 'display_name'
            date = new Date()
            $('.preparedon').text date.getDate()+'/'+(parseInt(date.getMonth()) + 1)+'/'+date.getFullYear()
            unitModel = App.master.unit.findWhere({id:parseInt(App.unit['name'])})
            $('.flatno').text unitModel.get 'name'
            
            uniVariantModel = App.master.unit_variant.findWhere({id:unitModel.get('unitVariant')})
            costSheetArray.push(uniVariantModel.get('sellablearea'))
            costSheetArray.push(unitModel.get('persqftprice'))
            revisedhidden = 'hidden'
            discount = 0
            buildingModel = App.master.building.findWhere({id:unitModel.get('building')})
            floorRise = buildingModel.get 'floorrise'
            floorRiseValue = floorRise[unitModel.get 'floor']
            discountClass = ''
            ratePerSqFtPrice = (parseFloat(costSheetArray[1]) + parseFloat(floorRiseValue))
            if perFlag== 1
                revisedhidden = ""
                discount = parseFloat($('#discountvalue').val())
                discountClass = 'showDisc'
                # discount = ((parseFloat(uniVariantModel.get('sellablearea')) * parseFloat(unitModel.get('persqftprice'))) - parseFloat($('#discountvalue').val()))/parseFloat(uniVariantModel.get('sellablearea'))
            else if perFlag == 2
                revisedhidden = ""
                pervalue = parseFloat($('#discountper').val())/100
                discount = (parseFloat(ratePerSqFtPrice) * parseFloat(pervalue))
                discountClass = 'showDisc'
            # discount = Math.ceil(discount.toFixed(2));

            
           
            if parseInt($('#discountper').val().length) == 0 && parseInt($('#discountvalue').val().length) == 0
                discountClass = ''
            
            revisedrate = parseFloat(ratePerSqFtPrice) - (parseFloat(discount))
            costSheetArray.push(revisedrate)
            basicCost = parseFloat(uniVariantModel.get('sellablearea')) * parseFloat(revisedrate)
            costSheetArray.push(basicCost)
            costSheetArray.push(discount)
            table = ""
            table1 = ""
            $('.building').text buildingModel.get 'name'
            planselectedValue = buildingModel.get('payment_plan')
            milestoneselectedValue = buildingModel.get('milestone')
            $("#paymentplans option[value="+planselectedValue+"]").prop('selected', true)
            #$("#milestones option[value="+milestoneselectedValue+"]").prop('selected', true)
            id1 = $('#paymentplans').val()
            paymentColl = new Backbone.Collection PAYMENTPLANS
            milestones = paymentColl.get(parseInt($('#paymentplans').val()))
            $('.paymentplan').text milestones.get('name')
            maintenance = parseFloat(uniVariantModel.get('sellablearea')) * 100
            SettingModel = new Backbone.Model SETTINGS
            stamp_duty = (basicCost * (parseFloat(SettingModel.get('stamp_duty'))/100)) + 110
            reg_amt = parseFloat(SettingModel.get('registration_amount'))
            vat = (basicCost * (parseFloat(SettingModel.get('vat'))/100))
            sales_tax = (basicCost * (parseFloat(SettingModel.get('sales_tax'))/100))
            infraArray = SettingModel.get('infrastructure_charges' )
            membership_fees = SettingModel.get('membership_fees' )
            membership_feesColl = new Backbone.Collection membership_fees
            unitTypeMemeber = membership_feesColl.findWhere({unit_type:parseInt(unitModel.get('unitType'))})
            if unitTypeMemeber.get('membership_fees') == 0
                unitVariantMemeber = unitTypeMemeber.get('unit_variant')
                unitVariantMemeberColl = new Backbone.Collection unitVariantMemeber
                univariantmem = unitVariantMemeberColl.findWhere({unit_variant:parseInt(unitModel.get('unitVariant'))})
                membershipfees = univariantmem.get('membership_fees')
            else
                membershipfees = unitTypeMemeber.get('membership_fees')
            infratxt = ''
            
            for element,index in infraArray
                $('.inframamout').autoNumeric('init');
                $('.inframamout').autoNumeric('set', element);
                selected = ""
                if parseInt(element) == infraid
                    selected = "selected"
                else
                    selected = ""
                infratxt += '<option  value="'+element+'" '+selected+'>'+$('.inframamout').text()+'</option>'
            

            basicCost1 = (parseFloat(costSheetArray[0]) * parseFloat(costSheetArray[1]))
            $('#rec' ).text ""
            $('.rec' ).text ""


            ratepersqftfloorval = (parseFloat(costSheetArray[1]) + parseFloat(floorRiseValue))
            table += '  
                        <div class="costsRow totals title">
                            <div class="costCell costName">Cost Type</div>
                            <div class="costCell discCol '+discountClass+'">Discounted Rate</div>
                            <div class="costCell">Base Rate</div>
                        </div>
                        
                        <h5 class="headers skyiCost"><span class="cost-office"></span> Skyi Costs</h5>
                        <div class="skyiCostDtls costDtls">
                            <div class="panel-body">
                                Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunc. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably ccusamus labore sustainable VHS.
                            </div>
                        </div>

                        <div class="costsRow">
                            <div class="costCell costName">Chargeable Area (Sq.Ft.)</div>
                            <div class="costCell discCol '+discountClass+'">'+costSheetArray[0]+'</div>
                            <div class="costCell">'+costSheetArray[0]+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Floorrise</div>
                            <div class="costCell discCol '+discountClass+' floorrise" data-a-sign="Rs. " data-d-group="2">'+floorRiseValue+'</div>
                            <div class="costCell floorrise" data-a-sign="Rs. " data-d-group="2">'+floorRiseValue+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Rate per Sq.Ft.</div>
                            <div class="costCell discCol '+discountClass+' ratepersqft" data-a-sign="Rs. " data-d-group="2">'+costSheetArray[1]+'</div>
                            <div class="costCell ratepersqft" data-a-sign="Rs. " data-d-group="2">'+costSheetArray[1]+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Rate per Sq.Ft. with Floorrise</div>
                            <div class="costCell discCol '+discountClass+' ratepersqftfloor" data-a-sign="Rs. " data-d-group="2">'+ratepersqftfloorval+'</div>
                            <div class="costCell ratepersqftfloor" data-a-sign="Rs. " data-d-group="2">'+ratepersqftfloorval+'</div>
                        </div>
                        <div class="costsRow revised '+revisedhidden+' ">
                            <div class="costCell costName">Revised Rate</div>
                            <div class="costCell discCol '+discountClass+' revisedrate" data-a-sign="Rs. " data-d-group="2">'+costSheetArray[2]+'</div>
                            <div class="costCell ">--</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Basic Cost</div>
                            <div class="costCell discCol '+discountClass+' basicCost" data-a-sign="Rs. " data-d-group="2">'+basicCost+'</div>
                            <div class="costCell basicCost1" data-a-sign="Rs. " data-d-group="2">'+basicCost1+'</div>
                        </div>
                       <div class="costsRow">
                            <div class="costCell costName">Infrastructure and Development Charges</div>
                            <div class="costCell discCol '+discountClass+'"><select id="infra"></select></div>
                            <div class="costCell"><select id="infra1"></select></div>
                        </div>'

            table1 += '  
                        <div class="costsRow totals title">
                            <div class="costCell costName">Cost Type</div>
                            <div class="costCell discCol '+discountClass+' ">Discounted Rate <span class="cost-uniE600"></span></div>
                            <div class="costCell">Base Rate <span class="cost-uniE600"></span></div>
                        </div>
                        
                        <h5 class="headers"><span class="cost-office"></span> Skyi Costs</h5>

                        <div class="costsRow">
                            <div class="costCell costName">Chargeable Area (Sq.Ft.)</div>
                            <div class="costCell discCol '+discountClass+' ">'+costSheetArray[0]+'</div>
                            <div class="costCell">'+costSheetArray[0]+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName" >Floorrise</div>
                            <div class="costCell discCol '+discountClass+' floorrise" data-a-sign="Rs. " data-d-group="2">'+floorRiseValue+'</div>
                            <div class="costCell floorrise" data-a-sign="Rs. " data-d-group="2">'+floorRiseValue+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Rate per Sq.Ft.</div>
                            <div class="costCell discCol '+discountClass+' ratepersqft" data-a-sign="Rs. " data-d-group="2">'+costSheetArray[1]+'</div>
                            <div class="costCell ratepersqft" data-a-sign="Rs. " data-d-group="2">'+costSheetArray[1]+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Rate per Sq.Ft. with Floorrise</div>
                            <div class="costCell discCol '+discountClass+' ratepersqftfloor" data-a-sign="Rs. " data-d-group="2">'+ratepersqftfloorval+'</div>
                            <div class="costCell ratepersqftfloor" data-a-sign="Rs. " data-d-group="2">'+ratepersqftfloorval+'</div>
                        </div>
                        <div class="costsRow revised '+revisedhidden+'">
                            <div class="costCell costName">Revised Rate</div>
                            <div class="costCell discCol '+discountClass+' revisedrate" data-a-sign="Rs. " data-d-group="2">'+costSheetArray[2]+'</div>
                            <div class="costCell ">--</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Basic Cost</div>
                            <div class="costCell discCol '+discountClass+' basicCost" data-a-sign="Rs. " data-d-group="2">'+basicCost+'</div>
                            <div class="costCell basicCost1" data-a-sign="Rs. " data-d-group="2">'+basicCost1+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Infrastructure and Developement Charges</div>
                            <div class="costCell discCol '+discountClass+' infra" data-a-sign="Rs. " data-d-group="2">'+infraid+'</div>
                            <div class="costCell infra1" data-a-sign="Rs. " data-d-group="2">'+infraid+'</div>
                        </div>'
                        
            $('#costSheetTable' ).append table
            $('#costSheetTableprint' ).append table1
            $('#infra' ).append infratxt
            $('#infra1' ).append infratxt
            $('.ratepersqft').autoNumeric('init')
            $('.ratepersqft').autoNumeric('set', costSheetArray[1]);
            $('.revisedrate').autoNumeric('init')
            $('.revisedrate').autoNumeric('set', costSheetArray[2]);
            $('.basicCost1').autoNumeric('init')
            $('.basicCost1').autoNumeric('set', basicCost1);
            $('.basicCost').autoNumeric('init')
            $('.basicCost').autoNumeric('set', basicCost);
            $('.addonpay').autoNumeric('init')
            
            $('.floorrise').autoNumeric('init')
            $('.floorrise').autoNumeric('set', floorRiseValue);
            $('.ratepersqftfloor').autoNumeric('init')
            $('.ratepersqftfloor').autoNumeric('set', ratepersqftfloorval);


            table = ""
            agreement1 = parseFloat(basicCost1) + parseFloat($('#infra1').val())
            agreementValue1 = agreement1
            agreement = parseFloat(basicCost) + parseFloat($('#infra').val())
            agreementValue = agreement
            stamp_duty1 = (basicCost1 * (parseFloat(SettingModel.get('stamp_duty'))/100)) + 110
            reg_amt1 = parseFloat(SettingModel.get('registration_amount'))
            vat1 = (basicCost1 * (parseFloat(SettingModel.get('vat'))/100))
            sales_tax1 = (basicCost1 * (parseFloat(SettingModel.get('sales_tax'))/100))
            totalcost1 =  parseFloat(stamp_duty1) + parseFloat( reg_amt1) + parseFloat(vat1) + parseFloat(sales_tax1)
            finalcost1 =  parseFloat(maintenance) + parseFloat(membershipfees)


            paymentColl = new Backbone.Collection PAYMENTPLANS
            milestones = paymentColl.get(parseInt($('#paymentplans').val()))
            milestonesArray = milestones.get('milestones')
            milestonesArrayColl = new Backbone.Collection milestonesArray
            milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(buildingModel.get('milestone'))})
            milestonesArray = milestonesArray.sort( (a,b)->
                parseInt( a.sort_index) - parseInt( b.sort_index)
            )
            milestoneCollection = new Backbone.Collection MILESTONES
            if milestonemodel == undefined
                milesotneVal = _.first(milestonesArray)
                milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(milesotneVal.milestone)})
                milestonename = milestoneCollection.get(parseInt(milestonemodel.get('milestone')))
                $('.currentmile').text milestonename.get 'name'
                
            else
                milstoneModelName = milestoneCollection.get(milestonemodel.get('milestone'))
                $('.currentmile').text milstoneModelName.get 'name'
            

            milestoneColl = new Backbone.Collection MILESTONES
            count = 0
            for element in milestonesArray
                if element.sort_index <= milestonemodel.get('sort_index')
                    percentageValue = (agreement * ((parseFloat(element.payment_percentage))/100))
                    count = count + percentageValue
            if  parseInt($('#payment').val()) == 0
                addon = 0
            else

                addon = parseFloat($('#payment').val()) - parseFloat(count)

            totalcost = parseFloat(stamp_duty) + parseFloat( reg_amt) + parseFloat(vat) + parseFloat(sales_tax)
            finalcost = parseFloat(maintenance) + parseFloat(membershipfees)
            $('.totalcost').text totalcost
            finalvalue = parseFloat(totalcost) + parseFloat(finalcost) + parseFloat(agreement)
            finalvalue1 = parseFloat(totalcost1) + parseFloat(finalcost1) + parseFloat(agreement1)
            # $('.rec').autoNumeric('init')
            # recount = $('.rec').autoNumeric('set', count)
            # reccount = recount.text()
            # $('.rec').text reccount
            if discountClass == ""
                actualcost = finalvalue1
                $('#actualcostvalue').autoNumeric('init')
                $('#actualcostvalue').autoNumeric('set', finalvalue1);
                
            else
                actualcost = finalvalue
            table += '  <div class="costsRow totals">
                            <div class="costCell costName">Agreement Amount</div>
                            <div class="costCell discCol '+discountClass+' agreement"  data-a-sign="Rs. " data-d-group="2">'+agreement+'</div>
                            <div class="costCell agreement1"  data-a-sign="Rs. " data-d-group="2">'+agreement1+'</div>
                        </div>

                        <h5 class="headers govChrg"><span class="cost-library"></span> Government Charges</h5>
                        <div class="govChrgDtls costDtls">
                            <div class="panel-body">
                                Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunc. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably ccusamus labore sustainable VHS.
                            </div>
                        </div>

                        <div class="costsRow">
                            <div class="costCell costName">Stamp Duty</div>
                            <div class="costCell discCol '+discountClass+' stamp_duty" data-a-sign="Rs. " data-d-group="2">'+stamp_duty+'</div>
                            <div class="costCell stamp_duty1" data-a-sign="Rs. " data-d-group="2">'+stamp_duty1+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Registration Amount</div>
                            <div class="costCell discCol '+discountClass+' reg_amt" data-a-sign="Rs. " data-d-group="2">'+reg_amt+'</div>
                            <div class="costCell reg_amt1" data-a-sign="Rs. " data-d-group="2">'+reg_amt1+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">VAT</div>
                            <div class="costCell vat1" data-a-sign="Rs. " data-d-group="2">'+vat1+'</div>
                            <div class="costCell discCol vat '+discountClass+'" data-a-sign="Rs. " data-d-group="2">'+vat+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Service Tax</div>
                            <div class="costCell discCol '+discountClass+' sales_tax" data-a-sign="Rs. " data-d-group="2">'+sales_tax+'</div>
                            <div class="costCell sales_tax1" data-a-sign="Rs. " data-d-group="2">'+sales_tax1+'</div>
                        </div>
                        <div class="costsRow totals">
                            <div class="costCell costName">Total Goverment Charges</div>
                            <div class="costCell discCol '+discountClass+' totalcost" data-a-sign="Rs. " data-d-group="2">'+totalcost+'</div>
                            <div class="costCell totalcost1" data-a-sign="Rs. " data-d-group="2">'+totalcost1+'</div>
                        </div>

                        <h5 class="headers othrCost"><span class="cost-paint-format"></span> Other Costs</h5>
                        <div class="othrCostDtls costDtls">
                            <div class="panel-body">
                                Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunc. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably ccusamus labore sustainable VHS.
                            </div>
                        </div>

                        <div class="costsRow">
                            <div class="costCell costName">Maintenance Deposit</div>
                            <div class="costCell discCol '+discountClass+' maintenance" data-a-sign="Rs. " data-d-group="2">'+maintenance+'</div>
                            <div class="costCell maintenance" data-a-sign="Rs. " data-d-group="2">'+maintenance+'</div>
                        </div>
                        <div class="costsRow">
                            <div class="costCell costName">Club membership + Service Tax</div>
                            <div class="costCell discCol '+discountClass+' membershipfees" data-a-sign="Rs. " data-d-group="2">'+membershipfees+'</div>
                            <div class="costCell membershipfees" data-a-sign="Rs. " data-d-group="2">'+membershipfees+'</div>
                        </div>
                        <div class="costsRow totals">
                            <div class="costCell costName">Total Maintenance Cost</div>
                            <div class="costCell discCol '+discountClass+' finalcost" data-a-sign="Rs. " data-d-group="2">'+finalcost+'</div>
                            <div class="costCell finalcost1" data-a-sign="Rs. " data-d-group="2">'+finalcost1+'</div>
                        </div>
                        <div class="costsRow totals">
                            <div class="costCell costName">Final Cost</div>
                            <div class="costCell discCol '+discountClass+' finalvalue" data-a-sign="Rs. " data-d-group="2">'+finalvalue+'</div>
                            <div class="costCell finalvalue1" data-a-sign="Rs. " data-d-group="2">'+finalvalue1+'</div>
                        </div>

                        '
            # console.log $('table#costSheetTable tbody' )
            $('#costSheetTable' ).append table
            $('#costSheetTableprint' ).append table
            $('.agreement1').autoNumeric('init')
            $('.agreement1').autoNumeric('set', agreement1);
            $('.agreement').autoNumeric('init')
            $('.agreement').autoNumeric('set', agreement);
            $('.stamp_duty1').autoNumeric('init')
            $('.stamp_duty1').autoNumeric('set', stamp_duty1);
            $('.stamp_duty').autoNumeric('init')
            $('.stamp_duty').autoNumeric('set', stamp_duty);
            $('.reg_amt').autoNumeric('init')
            $('.reg_amt').autoNumeric('set', reg_amt);
            $('.reg_amt1').autoNumeric('init')
            $('.reg_amt1').autoNumeric('set', reg_amt1);
            $('.vat').autoNumeric('init')
            $('.vat').autoNumeric('set', vat);
            $('.vat1').autoNumeric('init')
            $('.vat1').autoNumeric('set', vat1);
            $('.vat').autoNumeric('init')
            $('.vat').autoNumeric('set', vat);
            $('.sales_tax1').autoNumeric('init')
            $('.sales_tax1').autoNumeric('set', sales_tax1);
            $('.sales_tax').autoNumeric('init')
            $('.sales_tax').autoNumeric('set', sales_tax);
            $('.totalcost1').autoNumeric('init')
            $('.totalcost1').autoNumeric('set', totalcost1);
            $('.totalcost').autoNumeric('init')
            $('.totalcost').autoNumeric('set', totalcost);
            $('.maintenance').autoNumeric('init')
            $('.maintenance').autoNumeric('set', maintenance);
            $('.membershipfees').autoNumeric('init')
            $('.membershipfees').autoNumeric('set', membershipfees);
            $('.finalcost').autoNumeric('init')
            $('.finalcost').autoNumeric('set', finalcost);
            $('.finalcost1').autoNumeric('init')
            $('.finalcost1').autoNumeric('set', finalcost1);
            $('.infra1').autoNumeric('init')
            $('.infra1').autoNumeric('set', $('#infra1' ).val());
            $('.infra').autoNumeric('init')
            $('.infra').autoNumeric('set', $('#infra' ).val());
            $('.finalvalue1').autoNumeric('init')
            $('.finalvalue1').autoNumeric('set', finalvalue1);
            $('.finalvalue').autoNumeric('init')
            $('.finalvalue').autoNumeric('set', finalvalue);
            $('.actualcost').autoNumeric('init')
            $('.actualcost').autoNumeric('set', actualcost);
            id = $('#paymentplans' ).val()
            object.generatePaymentSchedule(id)
            #object.getMilestones(id1)
            $('#infra').on('change' , ()->
                infraid = $('#infra' ).val()
                object.updated()


            )
            $('#infra1').on('change' , ()->
                infraid = $('#infra1' ).val()
                object.updated1()


            )
            $('#discountvalue').on('change' , ()->
                    perFlag = 1
                    
                    if parseInt(this.value.length) == 0
                         perFlag = 0
                    object.generateCostSheet()


            )
            $('#discountper').on('change' , ()->
                    perFlag = 2
                    
                    if parseInt(this.value.length) == 0
                         perFlag = 0
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

            $(".skyiCost").click ->
                $(".skyiCostDtls").slideToggle()
                return

            $(".govChrg").click ->
                $(".govChrgDtls").slideToggle()
                return

            $(".othrCost").click ->
                $(".othrCostDtls").slideToggle()
                return

        generatePaymentSchedule:(id)->
            flag = 0
            $('#rec' ).text ""
            $('.rec' ).text ""
            
            #get_apratment_selector_settings()
            unitModel = App.master.unit.findWhere({id:parseInt(App.unit['name'])})
            buildingModel = App.master.building.findWhere({id:unitModel.get('building')})
            milestonecompletion = buildingModel.get 'milestonecompletion'
            $('#paymentTable' ).text ""
            
            paymentColl = new Backbone.Collection PAYMENTPLANS
            milestones = paymentColl.get(parseInt(id))
            milestonesArray = milestones.get('milestones')
            $('.paymentplan').text milestones.get('name')
            milestonesArrayColl = new Backbone.Collection milestonesArray
            milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(buildingModel.get('milestone'))})
            milestonesArray = milestonesArray.sort( (a,b)->
                parseInt( a.sort_index) - parseInt( b.sort_index)
            )
            milestoneCollection = new Backbone.Collection MILESTONES
            

            if milestonemodel == undefined
                flag = 1
                milesotneVal = _.first(milestonesArray)
                milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(milesotneVal.milestone)})
                milestonename = milestoneCollection.get(parseInt(milestonemodel.get('milestone')))
                $('.currentmile').text milestonename.get 'name'
            else
                milstoneModelName = milestoneCollection.get(milestonemodel.get('milestone'))
                $('.currentmile').text milstoneModelName.get 'name'


            table = ""
            count = 0
            milestoneColl = new Backbone.Collection MILESTONES
            #milestonecompletion = {48:'26/08/2014', 52:'30/08/2014'}
            for element,index in milestonesArray
                percentageValue = (agreementValue * ((parseFloat(element.payment_percentage))/100))
                percentageValue1 = (agreementValue1 * ((parseFloat(element.payment_percentage))/100))
                proposed_date = $.map(milestonecompletion, (index,value)->
                    if parseInt(element.milestone) == parseInt(value)
                        return index

                    )
                if proposed_date.length == 0
                    proposed_date = ''
                if element.sort_index <= milestonemodel.get('sort_index')
                    trClass = "milestoneReached"
                    percentageValue = (parseFloat(agreementValue) * ((parseFloat(element.payment_percentage))/100))
                    count = count + percentageValue
                else
                    trClass = ""
                if flag == 1
                    trClass = ""
                $('.percentageValue1').autoNumeric('init')
                $('.percentageValue').autoNumeric('init')
                milestoneModel = milestoneColl.get(element.milestone)
                
                table += '  <span class="msPercent">'+element.payment_percentage+'%</span>
                            <li class="milestoneList '+trClass+'">
                                <div class="msName">'+milestoneModel.get('name')+' <span class="completionDate">(Estimated date: '+proposed_date+')</span></div>
                                <div class="msVal discCol '+discountClass+' percentageValue'+index+'" data-a-sign="Rs. " data-d-group="2"></div>
                                <div class="msVal percentageValue1'+index+'" data-a-sign="Rs. " data-d-group="2"></div>
                                <span class="barBg" style="width:'+element.payment_percentage+'%"></span>
                            </li>
                            <div class="clearfix"></div>
                            '

            $('.rec').autoNumeric('init')
            
            recount = $('.rec').autoNumeric('set', count)
            reccount = recount.text()
            # $('#rec' ).text reccount
            # $('.rec' ).text reccount
            if parseInt($('#payment' ).val()) == 0
                addon = 0

            else
                addon = $('#payment' ).val() - count
            $('.actpayment').autoNumeric('init')
            $('.actpayment').autoNumeric('set', $('#payment' ).val())
            $('.addonpay').autoNumeric('init')
            $('.addonpay').autoNumeric('set', addon)
            
            

            $('#paymentTable' ).append table
            
            for element,index in milestonesArray
                percentageValue = (parseFloat(agreementValue) * ((parseFloat(element.payment_percentage))/100))
                percentageValue1 = (parseFloat(agreementValue1) * ((parseFloat(element.payment_percentage))/100))
                $('.percentageValue'+index).autoNumeric('init')
                $('.percentageValue'+index).autoNumeric('set', percentageValue)
                $('.percentageValue1'+index).autoNumeric('init')
                $('.percentageValue1'+index).autoNumeric('set', percentageValue1)
           
            


        getMilestones:(id)->
            milesstones = ''
            $('#milestones option' ).remove()
            paymentColl = new Backbone.Collection PAYMENTPLANS
            milestones = paymentColl.get(parseInt(id))
            $('.paymentplan').text milestones.get('name')
            milestonesArray = milestones.get('milestones')
            milestonesArray = milestonesArray.sort( (a,b)->
                parseInt( a.sort_index) - parseInt( b.sort_index)
            )
            milestoneColl = new Backbone.Collection MILESTONES
            for element in milestonesArray
                milestoneModel = milestoneColl.get(element.milestone)
                milesstones += '<option value="'+element.milestone+'">'+milestoneModel.get('name')+'</option>'
            $('#milestones' ).append milesstones

        updated:->
            $('.infra1').autoNumeric('init')
            $('.infra1').autoNumeric('set', $('#infra1' ).val());
            $('.infra').autoNumeric('init')
            $('.infra').autoNumeric('set', $('#infra' ).val());
            costSheetArray = []
            unitModel = App.master.unit.findWhere({id:parseInt(App.unit['name'])})
            uniVariantModel = App.master.unit_variant.findWhere({id:unitModel.get('unitVariant')})
            costSheetArray.push(uniVariantModel.get('sellablearea'))
            costSheetArray.push(unitModel.get('persqftprice'))
            buildingModel = App.master.building.findWhere({id:unitModel.get('building')})
            floorRise = buildingModel.get 'floorrise'
            floorRiseValue = floorRise[unitModel.get 'floor']
            discount = 0
            ratePerSqFtPrice = (parseFloat(costSheetArray[1]) + parseFloat(floorRiseValue))
            if perFlag== 1
                revisedhidden = ""
                discount = parseFloat($('#discountvalue').val())
                # discount = ((parseFloat(uniVariantModel.get('sellablearea')) * parseFloat(unitModel.get('persqftprice'))) - parseFloat($('#discountvalue').val()))/parseFloat(uniVariantModel.get('sellablearea'))
            else if perFlag == 2
                revisedhidden = ""
                pervalue = parseFloat($('#discountper').val())/100
                discount = (parseFloat(ratePerSqFtPrice) * parseFloat(pervalue))
            # discount = Math.ceil(discount.toFixed(2));
            
            
            revisedrate = parseFloat(ratePerSqFtPrice) - (parseFloat(discount))
            costSheetArray.push(revisedrate)
            basicCost = parseFloat(uniVariantModel.get('sellablearea')) * parseFloat(revisedrate)
            costSheetArray.push(basicCost)
            costSheetArray.push(discount)
            table = ""
            buildingModel = App.master.building.findWhere({id:unitModel.get('building')})
            planselectedValue = buildingModel.get('payment_plan')
            milestoneselectedValue = buildingModel.get('milestone')
            $("#paymentplans option[value="+planselectedValue+"]").prop('selected', true)
            $("#milestones option[value="+milestoneselectedValue+"]").prop('selected', true)
            id1= $('#paymentplans').val()

            maintenance = parseFloat(uniVariantModel.get('sellablearea')) * 100
            SettingModel = new Backbone.Model SETTINGS
            stamp_duty = (basicCost * (parseFloat(SettingModel.get('stamp_duty'))/100)) + 110
            reg_amt = parseFloat(SettingModel.get('registration_amount'))
            vat = (basicCost * (parseFloat(SettingModel.get('vat'))/100))
            sales_tax = (basicCost * (parseFloat(SettingModel.get('sales_tax'))/100))
            infraArray = SettingModel.get('infrastructure_charges' )
            membership_fees = SettingModel.get('membership_fees' )
            membership_feesColl = new Backbone.Collection membership_fees
            unitTypeMemeber = membership_feesColl.findWhere({unit_type:parseInt(unitModel.get('unitType'))})
            if unitTypeMemeber.get('membership_fees') == 0
                unitVariantMemeber = unitTypeMemeber.get('unit_variant')
                unitVariantMemeberColl = new Backbone.Collection unitVariantMemeber
                univariantmem = unitVariantMemeberColl.findWhere({unit_variant:parseInt(unitModel.get('unitVariant'))})
                membershipfees = univariantmem.get('membership_fees')
            else
                membershipfees = unitTypeMemeber.get('membership_fees')








            table = ""
            basicCost1 = (costSheetArray[0] * costSheetArray[1])
            agreement1 = parseFloat(basicCost1) + parseFloat($('#infra').val())
            agreementValue1 = agreement1
            agreement = parseFloat(basicCost) + parseFloat($('#infra').val())
            agreementValue = agreement
            $('.agreement').autoNumeric('init')
            # $('.agreement1').autoNumeric('init')
            $('.agreement').autoNumeric('set', agreement)
            # $('.agreement1').autoNumeric('set', agreement1)
            stamp_duty1 = (basicCost1 * (parseFloat(SettingModel.get('stamp_duty'))/100)) + 110
            reg_amt1 = parseFloat(SettingModel.get('registration_amount'))
            vat1 = (basicCost1 * (parseFloat(SettingModel.get('vat'))/100))
            sales_tax1 = (basicCost1 * (parseFloat(SettingModel.get('sales_tax'))/100))
            totalcost1 = parseFloat(stamp_duty1) + parseFloat( reg_amt1) + parseFloat(vat1) + parseFloat(sales_tax1)
            finalcost1 = parseFloat(maintenance) + parseFloat(membershipfees)
            # $('#totalcost1').autoNumeric('init')
            # $('#finalcost1').autoNumeric('init')
            # $('#totalcost1' ).text $('#totalcost1').autoNumeric('set', totalcost1).text()
            # $('#finalcost1' ).text $('#finalcost1').autoNumeric('set', finalcost1).text()


            paymentColl = new Backbone.Collection PAYMENTPLANS
            milestones = paymentColl.get(parseInt($('#paymentplans').val()))
            milestonesArray = milestones.get('milestones')
            milestonesArrayColl = new Backbone.Collection milestonesArray
            milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(buildingModel.get('milestone'))})
            milestonesArray = milestonesArray.sort( (a,b)->
                parseInt( a.sort_index) - parseInt( b.sort_index)
            )
            if milestonemodel == undefined
                milesotneVal = _.first(milestonesArray)
                milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(milesotneVal.milestone)})

            milestoneColl = new Backbone.Collection MILESTONES
            count = 0
            for element in milestonesArray
                if element.sort_index <= milestonemodel.get('sort_index')
                    percentageValue = (agreement * ((parseFloat(element.payment_percentage))/100))
                    count = count + percentageValue
            addon = parseFloat($('#payment').val()) - parseFloat(count)

            totalcost = parseFloat(stamp_duty) + parseFloat( reg_amt) + parseFloat(vat) + parseFloat(sales_tax)
            finalcost = parseFloat(maintenance) + parseFloat(membershipfees)
            finalvalue = parseFloat(totalcost) + parseFloat(finalcost) + parseFloat(agreement)
            
            $('.totalcost').autoNumeric('init')
            $('.finalcost').autoNumeric('init')
            $('.totalcost').autoNumeric('set', totalcost)
            $('.finalcost').autoNumeric('set', finalcost)
            $('.finalvalue').autoNumeric('init')
            $('.finalvalue').autoNumeric('set', finalvalue)

        updated1:->
            $('.infra1').autoNumeric('init')
            $('.infra1').autoNumeric('set', $('#infra1' ).val());
            $('.infra').autoNumeric('init')
            $('.infra').autoNumeric('set', $('#infra' ).val());
            costSheetArray = []
            unitModel = App.master.unit.findWhere({id:parseInt(App.unit['name'])})
            uniVariantModel = App.master.unit_variant.findWhere({id:unitModel.get('unitVariant')})
            costSheetArray.push(uniVariantModel.get('sellablearea'))
            costSheetArray.push(unitModel.get('persqftprice'))
            buildingModel = App.master.building.findWhere({id:unitModel.get('building')})
            floorRise = buildingModel.get 'floorrise'
            floorRiseValue = floorRise[unitModel.get 'floor']
            discount = 0
            ratePerSqFtPrice = (parseFloat(costSheetArray[1]) + parseFloat(floorRiseValue))
            if perFlag== 1
                revisedhidden = ""
                discount = parseFloat($('#discountvalue').val())
                # discount = ((parseFloat(uniVariantModel.get('sellablearea')) * parseFloat(unitModel.get('persqftprice'))) - parseFloat($('#discountvalue').val()))/parseFloat(uniVariantModel.get('sellablearea'))
            else if perFlag == 2
                revisedhidden = ""
                pervalue = parseFloat($('#discountper').val())/100
                discount = (parseFloat(ratePerSqFtPrice) * parseFloat(pervalue))
            # discount = Math.ceil(discount.toFixed(2));
            
            
            revisedrate = parseFloat(ratePerSqFtPrice) - (parseFloat(discount))
            costSheetArray.push(revisedrate)
            basicCost = parseFloat(uniVariantModel.get('sellablearea')) * parseFloat(revisedrate)
            costSheetArray.push(basicCost)
            costSheetArray.push(discount)
            table = ""
            buildingModel = App.master.building.findWhere({id:unitModel.get('building')})
            planselectedValue = buildingModel.get('payment_plan')
            milestoneselectedValue = buildingModel.get('milestone')
            $("#paymentplans option[value="+planselectedValue+"]").prop('selected', true)
            $("#milestones option[value="+milestoneselectedValue+"]").prop('selected', true)
            id1= $('#paymentplans').val()

            maintenance = parseFloat(uniVariantModel.get('sellablearea')) * 100
            SettingModel = new Backbone.Model SETTINGS
            stamp_duty = (basicCost * (parseFloat(SettingModel.get('stamp_duty'))/100)) + 110
            reg_amt = parseFloat(SettingModel.get('registration_amount'))
            vat = (basicCost * (parseFloat(SettingModel.get('vat'))/100))
            sales_tax = (basicCost * (parseFloat(SettingModel.get('sales_tax'))/100))
            infraArray = SettingModel.get('infrastructure_charges' )
            membership_fees = SettingModel.get('membership_fees' )
            membership_feesColl = new Backbone.Collection membership_fees
            unitTypeMemeber = membership_feesColl.findWhere({unit_type:parseInt(unitModel.get('unitType'))})
            if unitTypeMemeber.get('membership_fees') == 0
                unitVariantMemeber = unitTypeMemeber.get('unit_variant')
                unitVariantMemeberColl = new Backbone.Collection unitVariantMemeber
                univariantmem = unitVariantMemeberColl.findWhere({unit_variant:parseInt(unitModel.get('unitVariant'))})
                membershipfees = univariantmem.get('membership_fees')
            else
                membershipfees = unitTypeMemeber.get('membership_fees')








            table = ""
            basicCost1 = (costSheetArray[0] * costSheetArray[1])
            agreement1 = parseFloat(basicCost1) + parseFloat($('#infra1').val())
            agreementValue1 = agreement1
            agreement = parseFloat(basicCost) + parseFloat($('#infra').val())
            agreementValue = agreement
            # $('.agreement').autoNumeric('init')
            $('.agreement1').autoNumeric('init')
            # $('.agreement').autoNumeric('set', agreement)
            $('.agreement1').autoNumeric('set', agreement1)
            stamp_duty1 = (basicCost1 * (parseFloat(SettingModel.get('stamp_duty'))/100)) + 110
            reg_amt1 = parseFloat(SettingModel.get('registration_amount'))
            vat1 = (basicCost1 * (parseFloat(SettingModel.get('vat'))/100))
            sales_tax1 = (basicCost1 * (parseFloat(SettingModel.get('sales_tax'))/100))
            totalcost1 = parseFloat(stamp_duty1) + parseFloat( reg_amt1) + parseFloat(vat1) + parseFloat(sales_tax1)
            finalcost1 = parseFloat(maintenance) + parseFloat(membershipfees)
            finalvalue1 = parseFloat(totalcost1) + parseFloat(finalcost1) + parseFloat(agreement1)
            $('.totalcost1').autoNumeric('init')
            $('.finalcost1').autoNumeric('init')
            $('.totalcost1').autoNumeric('set', totalcost1)
            $('.finalcost1').autoNumeric('set', finalcost1)
            $('.finalvalue1').autoNumeric('init')
            $('.finalvalue1').autoNumeric('set', finalvalue1)


            paymentColl = new Backbone.Collection PAYMENTPLANS
            milestones = paymentColl.get(parseInt($('#paymentplans').val()))
            milestonesArray = milestones.get('milestones')
            milestonesArrayColl = new Backbone.Collection milestonesArray
            milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(buildingModel.get('milestone'))})
            milestonesArray = milestonesArray.sort( (a,b)->
                parseInt( a.sort_index) - parseInt( b.sort_index)
            )
            if milestonemodel == undefined
                milesotneVal = _.first(milestonesArray)
                milestonemodel = milestonesArrayColl.findWhere({'milestone':parseInt(milesotneVal.milestone)})

            milestoneColl = new Backbone.Collection MILESTONES
            count = 0
            for element in milestonesArray
                if element.sort_index <= milestonemodel.get('sort_index')
                    percentageValue = (agreement * ((parseFloat(element.payment_percentage))/100))
                    count = count + percentageValue
            addon = parseFloat($('#payment').val()) - parseFloat(count)

            totalcost = parseFloat(agreement) + parseFloat(stamp_duty) + parseFloat( reg_amt) + parseFloat(vat) + parseFloat(sales_tax)
            finalcost = parseFloat(totalcost) + parseFloat(maintenance)
            # $('#totalcost').autoNumeric('init')
            # $('#finalcost').autoNumeric('init')
            # $('#totalcost' ).text $('#totalcost').autoNumeric('set', totalcost).text()
            # $('#finalcost' ).text $('#finalcost').autoNumeric('set', finalcost).text()



            























    class UnitsView extends Marionette.ItemView

        # template : '<a class="link" href="unit{{id}}">Flat No {{name}}</a>'

        tagName : 'li'

        className : 'vs-nav-current'






    class UnitTypeChildView extends Marionette.CompositeView

        tagName : 'ul'


        className : 'vs-nav'



        childView : UnitsView


    class UnitMainView extends Marionette.CompositeView

        template : '<div class="row m-l-0 m-r-0 bgClass">
						<div class="col-md-5 col-lg-4 p-b-10 b-grey b-r">
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
                                            <h4 class="titles"><span class="sky-banknote"></span> Total Area</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="unitBox">

                                            {{#roomsizearray}}
                                             <div class="rooms">{{type}}: <h4 class="size">{{size}} Sq.Ft.</h4></div>


                                    {{/roomsizearray}}
                                    <h4 class="titles"><span class="sky-maximize"></span> Room Sizes</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="unitBox">
                                            <div class="others"><h4 class="size">Terrace:</h4> {{terraceoptions}} </div>
                                            <div class="others"><h4 class="size">Views:</h4> {{facings_name}}</div>
                                            <div class="others"><h4 class="size">Entrance:</h4> {{views_name}}</div>
                                            <h4 class="titles"><span class="sky-location"></span> Other Details</h4>
                                        </div>
                                    </div>
                                </div>

                                <!--<div class="row">
                                    <div class="col-md-12">
                                        <div class="unitBox facing">
                                            <h4 class="view">{{terraceoptions}}</h4>
                                            <h4 class="titles"><span class="sky-content-left"></span> Terrace</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="unitBox facing">
                                            <h4 class="view facingclass">{{facings_name}}</h4>
                                            <h4 class="titles"><span class="sky-map"></span> Views</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="unitBox facing">
                                            <h4 class="view viewclass">{{views_name}}</h4>
                                            <h4 class="titles"><span class="sky-location"></span> Entrance</h4>
                                        </div>
                                    </div>
                                </div>-->
                            </div>
						</div>

                        <div class="col-md-7 col-lg-8">
                            <div class="liquid-slider center-block" id="slider-plans">
                                <div>
                                    <h2 class="title">2D Layout</h2>
                                    <img src="{{TwoDimage}}" class="img-responsive">
                                </div>
                                <div>
                                    <h2 class="title">3D Layout</h2>
                                    <img src="{{ThreeDimage}}" class="img-responsive">
                                </div>
                                <!--<div>
                                    <h2 class="title">Floor Layout</h2>
                                    <img src="{{floorLayoutimage}}" class="img-responsive">
                                </div>-->
                                <div>
                                    <h2 class="title">Building Position</h2>
                                    <img src="{{BuildingPositionimage}}" class="img-responsive">
                                </div>
                            </div>
                        </div>
					</div>
					
                    '






        tagName  : "section"






        initialize :->
            @$el.prop("id", 'unit'+@model.get("id"))

        onShow:->

            $('#slider-plans').liquidSlider(
                slideEaseFunction: "easeInOutQuad"
                autoSlide: true
                includeTitle:false
                minHeight: 630
                autoSlideInterval: 4000
                # forceAutoSlide: true
                mobileNavigation: false
                hideArrowsWhenMobile: false
                dynamicTabsAlign: "center"
                dynamicArrows: false
                # continuous: false
                # autoHeight: false
            )

            
            

            






    class UnitTypeView extends Marionette.CompositeView

        className : "vs-wrapper"


        childView : UnitMainView


    ScreenFourLayout : ScreenFourLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView



