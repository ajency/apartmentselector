define [ 'marionette' ], ( Marionette )->

    unitType = []
    object = ""
    m = ""
    class UnitTypeView extends Marionette.ItemView

        className : "grid-block-1"

        template : '<a class="grid-link">
              	        <div class="grid-text-wrap">
                            <span class="grid-main-title">{{name}}</span>
              	            <span class="grid-sub-title">{{min_value}} to {{max_value}} (sq. ft.)</span>
                            <input type="hidden" name="check{{id}}"   id="check{{id}}"       value="0" />
     	                </div>
                    </a>
              	  	'

        events :
            'click ' : 'unitTypeSelected'



        initialize :->
            @$el.prop("id", 'unittype'+@model.get("id"))

        unitTypeSelected : ( evt )->
            $.map(App.backFilter, (value, index)->
                
                screenArray  = App.backFilter[index]
                for element in screenArray
                    key = App.defaults.hasOwnProperty(element)
                    if key == true
                        App.defaults[element] = 'All'

            )
            App.layout.screenTwoRegion.el.innerHTML = ""
            App.layout.screenThreeRegion.el.innerHTML = ""
            App.layout.screenFourRegion.el.innerHTML = ""
            App.navigate ""
            App.currentStore.unit.reset UNITS
            App.currentStore.building.reset BUILDINGS
            App.currentStore.unit_type.reset UNITTYPES
            App.currentStore.unit_variant.reset UNITVARIANTS
            evt.preventDefault()
            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions()
            
            $("li").removeClass 'cs-selected'
            $(".cs-placeholder").text('Undecided')

            $('a' ).removeClass 'selected'
            
            for element , index in unitType
                
                if parseInt(element) == parseInt(@model.get('id'))
                    $("#check"+@model.get 'id').val '1'
                else
                    $("#check"+element).val '0'
                    unitType = []
                    App.backFilter['screen1'] = []

            
            if  parseInt($("#check"+@model.get 'id').val()) == 0
                unitType.push @model.get 'id'
                App.backFilter['screen1'].push 'unitType'
                $('#unittype'+@model.get("id")+' a' ).addClass 'selected'
                $("#check"+@model.get 'id').val "1"
            else
                @unHighlightedTowers()
                unitType=[]
                App.backFilter['screen1'] = []
                #index = unitType.indexOf( @model.get 'id' )
                #unitType.splice( index, 1 )
                $("#check"+@model.get 'id').val "0"
            if parseInt($("#check"+@model.get 'id').val()) == 0
                $("#finalButton").addClass 'disabled btn-default'
                $("#finalButton").removeClass 'btn-primary'
                $("#finalButton").text "Show Apartments"
                $('#screen-two-region').removeClass 'section'
                $('#screen-three-region').removeClass 'section'
                $('#screen-four-region').removeClass 'section'
                return false

            unitTypeString = unitType.join(',')
            App.defaults['unitType'] = unitTypeString
            
            $('#screen-two-region').removeClass 'section'
            $('#screen-three-region').removeClass 'section'
            $('#screen-four-region').removeClass 'section'
            App.screenOneFilter['value'] = unitTypeString
            App.screenOneFilter['key'] = 'unitType'
            $("#finalButton").removeClass 'disabled btn-default'
            $("#finalButton").addClass 'btn-primary'
            unitTypeModel = App.master.unit_type.findWhere(id:parseInt(App.defaults['unitType']))
            $("#finalButton").text "Show "+unitTypeModel.get('name')+" Apartments"
            status = App.currentStore.status.findWhere({'name':'Available'})
            newUnits = App.currentStore.unit.where(unitType:parseInt(App.defaults['unitType']),status:status.get('id'))
            newColl = new Backbone.Collection newUnits
            buildings = newColl.pluck("building")
            uniqBuildings = _.uniq(buildings)
            @showHighlightedTowers(uniqBuildings)

        object = @

        showHighlightedTowers:(uniqBuildings)->
            masterbuilding = App.master.building
            masterbuilding.each ( index)->
                $("#hglighttower"+index.get('id')).attr('class','overlay')
            building = uniqBuildings
            $.each(uniqBuildings, (index,value)->
                buidlingValue = App.master.building.findWhere(id:parseInt(value))
                $("#hglighttower"+buidlingValue.get('id')).attr('class','overlay highlight')


            )
        unHighlightedTowers:->
            masterbuilding = App.master.building
            masterbuilding.each ( index)->
                $("#hglighttower"+index.get('id')).attr('class','overlay')
           





    class ScreenOneView extends Marionette.CompositeView

                            
        template : '<h3 class="light text-center m-t-0">LOREM IPSUM TITLE</h3>
                    <h4 class="text-center introTxt">We at Skyi have built a unique apartment selector for you.<br>Of the hundreds of apartments available you can now find the one that best fits your requirements.</h4>
                    <!--<div class="text-center introTxt">The apartment selector helps you find your ideal home. Browse through available apartments and find the location, size, budget and layout that best suit you.</div>
                    <div class="introTxt text-center">To get started, either:</div>-->

                    <div class="row m-l-0 m-r-0 bgClass">
                        <div class="col-md-5 col-lg-4">
                            <div class="text-center subTxt">Choose a unit type</div>
                            <div class="grid-container"></div>
                            <h5 class="text-center m-t-20 m-b-20 bold">OR</h5>
        	                <div class="text-center subTxt">Choose a budget</div>
                            <section>
                                <select class="cs-select cs-skin-underline" id="budgetValue">
                                    <option value="" disabled selected>Undecided</option>
                                    {{#priceArray}}
                                    <option value="{{id}}">{{name}}</option>
                                    {{/priceArray}}
                                </select>
                            </section>
                            <div class="h-align-middle m-t-50 m-b-20">
                                <a href="#screen-two-region" class="btn btn-default btn-lg disabled" id="finalButton">Show Apartments</a>
                            </div>
                        </div>
                        <div class="col-md-7 col-lg-8 b-grey b-l visible-md visible-lg">
                            <div id="mapplic_new1" class="towersMap center-block"></div>
                        </div><input type="hidden" name="currency" id="currency" class="demo" data-a-sign="Rs. " data-d-group="2">
                    </div>'

        className : 'page-container row-fluid'

        childView : UnitTypeView

        childViewContainer : '.grid-container'

        events:
            'click #finalButton':(e)->

                

                if $(".cs-placeholder").text() != 'Undecided'
                    budget_val = $(".cs-selected").text().split(' ')
                    if(budget_val[1]=='lakhs')
                        budget_price = budget_val[0].split('-')
                        budget_price[0] = budget_price[0] + ('00000')
                        budget_price[1] = budget_price[1]+ ('00000')
                        budget_price = budget_price.join('-')
                    App.defaults['budget'] = $(".cs-selected").text()
                    App.backFilter['screen1'].push 'budget'
                    App.screenOneFilter['value'] = $(".cs-selected").text()
                    App.screenOneFilter['key'] = 'budget'
                else
                    App.defaults['budget'] = 'All'

                $('#screen-two-region').addClass 'section'
                @trigger 'unit:type:clicked'


            'click .cs-selected':(e)->
                $.map(App.backFilter, (value, index)->
                    screenArray  = App.backFilter[index]
                    for element in screenArray
                        key = App.defaults.hasOwnProperty(element)
                        if key == true
                            App.defaults[element] = 'All'

                )
                if $(".cs-placeholder").text() != 'Undecided'
                    budget_val = $(".cs-selected").text().split(' ')
                    if(budget_val[1]=='lakhs')
                        budget_price = budget_val[0].split('-')
                        budget_price[0] = budget_price[0] + ('00000')
                        budget_price[1] = budget_price[1]+ ('00000')
                        budget_price = budget_price.join('-')
                    App.defaults['budget'] = $(".cs-selected").text()
                    App.backFilter['screen1'].push 'budget'
                    App.screenOneFilter['value'] = $(".cs-selected").text()
                    App.screenOneFilter['key'] = 'budget'
                else
                    App.defaults['budget'] = 'All'
                $('#screen-two-region').removeClass 'section'
                $('#screen-three-region').removeClass 'section'
                $('#screen-four-region').removeClass 'section'
            
                App.layout.screenTwoRegion.el.innerHTML = ""
                App.layout.screenThreeRegion.el.innerHTML = ""
                App.layout.screenFourRegion.el.innerHTML = ""
                App.navigate ""
                App.currentStore.unit.reset UNITS
                App.currentStore.building.reset BUILDINGS
                App.currentStore.unit_type.reset UNITTYPES
                App.currentStore.unit_variant.reset UNITVARIANTS
                msgbus.showApp 'header'
                .insideRegion  App.headerRegion
                    .withOptions()
                
                for element in unitType
                    $('a' ).removeClass 'selected'
                    $("#check"+element).val "0"
                unitType = []
                App.defaults['unitType'] = 'All'
                $("#finalButton").removeClass 'disabled btn-default'
                $("#finalButton").addClass 'btn-primary'
                $("#finalButton").text "Show Apartments in my Budget"
                budget_val = $(".cs-selected").text().split(' ')
                newUnits = App.getBudget(budget_val[0])
                newColl = new Backbone.Collection newUnits
                buildings = newColl.pluck("building")
                uniqBuildings = _.uniq(buildings)
                @showHighlightedTowers(uniqBuildings)

            'click a':(e)->
                e.preventDefault()


            'mouseover a':(e)->
                id  = e.target.id
                locationData = m.getLocationData(id)
                #m.showTooltip(locationData)


            'click .tower-over':(e)->
                e.preventDefault()
                id  = e.target.id
                m.showLocation(id, 800)
                #locationData = m.getLocationData(id)
                #m.showTooltip(locationData)

            'mouseout .tower-over':(e)->
                $('.im-tooltip').hide()

            'mouseover .tower-over':(e)->
                e.preventDefault()
                id  = e.target.id
                str1 = id.replace( /[^\d.]/g, '' )
                floorUnitsArray = []
                myArray = []
                screenonearray = App.backFilter['screen1']
                for element in screenonearray
                    if App.defaults[element] != 'All'
                        key = App.defaults.hasOwnProperty(element)
                        if key == true
                            console.log App.defaults[element]
                            myArray.push({key:element,value:App.defaults[element]})
                
                status = App.master.status.findWhere({'name':'Available'})
                unitslen = App.master.unit.where({'status':status.get('id')})
                console.log myArray
                floorCollunits = []
                $.each(unitslen, (index,value1)->
                    flag = 0
                    $.each(myArray, (index,value)->
                        paramKey = {}
                        paramKey[value.key] = value.value
                        if value.key == 'budget'
                            buildingModel = App.master.building.findWhere({'id':value1.get 'building'})
                            floorRise = buildingModel.get 'floorrise'
                            floorRiseValue = floorRise[value1.get 'floor']
                            unitVariantmodel = App.master.unit_variant.findWhere({'id':value1.get 'unitVariant'})
                            #unitPrice = (parseInt( unitVariantmodel.get('persqftprice')) + parseInt(floorRiseValue)) * parseInt(unitVariantmodel.get 'sellablearea')
                            unitPrice = value1.get 'unitPrice'
                            budget_arr = value.value.split(' ')
                            budget_price = budget_arr[0].split('-')
                            budget_price[0] = budget_price[0]+'00000'
                            budget_price[1] = budget_price[1]+'00000'
                            if parseInt(unitPrice) >= parseInt(budget_price[0]) && parseInt(unitPrice) <= parseInt(budget_price[1])
                                flag++
                        else if value.key != 'floor'
                            if value.key == 'unittypeback'
                                value.key = 'unitVariant'
                            temp = []
                            temp.push value.value
                            tempstring = temp.join(',')
                            initvariant = tempstring.split(',')
                            if initvariant.length > 1
                                for element in initvariant
                                   if value1.get(value.key) == parseInt(element)
                                        flag++ 
                            else
                                if value1.get(value.key) == parseInt(value.value)
                                    flag++
                            


                    )
                    if flag == myArray.length
                        floorCollunits.push(value1)





                )
                if myArray.length == 0 
                    floorCollunits = unitslen
                units  = new Backbone.Collection floorCollunits
                countunits = units.where({building:parseInt(str1)})
                buildigmodel = App.master.building.findWhere({id:parseInt(str1)})
                if App.defaults['unitType'] != 'All'
                    selectorname = App.defaults['unitType']
                    unittypemodel = App.master.unit_type.findWhere({id:parseInt(App.defaults['unitType'])})
                    selectorname = unittypemodel.get 'name'
                else if App.defaults['budget'] != "All"
                    selectorname = App.defaults['budget']
                else if App.defaults['unitType'] == 'All' && App.defaults['budget'] == "All"
                    selectorname = ""
                if buildigmodel == undefined || buildigmodel == ""
                    text = "Not Launched"
                else
                
                    min = ""
                    text = "<span></span>"
                    if countunits.length > 0
                        console.log minmodel = _.min(countunits, (model)->
                            if model.get('unitType') != 14
                                return model.get('unitPrice')
                        )
                        $('#currency').autoNumeric('init')
                        $('#currency').autoNumeric('set', minmodel.get('unitPrice'));
                        currency = $('#currency').val()
                        text = '<span>No. of '+selectorname+' apartments - </span>'+countunits.length+'<br/><span>Starting Price - </span>'+currency
                    else
                        currency = 'Rs. 0'
                    
                        text = '<span>No. of '+selectorname+' apartments - </span>'+countunits.length
                    
                locationData = m.getLocationData(id)
                m.showTooltip(locationData,text)

        showHighlightedTowers:(uniqBuildings)->
            masterbuilding = App.master.building
            masterbuilding.each ( index)->
                $("#hglighttower"+index.get('id')).attr('class','overlay')
            building = uniqBuildings
            $.each(uniqBuildings, (index,value)->
                buidlingValue = App.master.building.findWhere(id:parseInt(value))
                $("#hglighttower"+buidlingValue.get('id')).attr('class','overlay highlight')


            )






        onShow:->
            
            $('#finalButton').on('click',  ()->
                new jBox('Notice', 
                    content: 'Finding available apartments matching your selection...',
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




            )
            
            



            [].slice.call( document.querySelectorAll( 'select.cs-select' ) ).forEach( (el)->
                new SelectFx(el)
            )
            $( ".grid-link" ).click( ()->
                $( this ).toggleClass( "selected" )
            )
            unitType = []
            i = 1
            while (window['mapplic_new' + i] != undefined)
                params = window['mapplic_new' + i]
                selector = '#mapplic_new' + i
                ajaxurl = AJAXURL
                $(selector).mapplic_new(
                    'id': 6,
                    'width': params.width,
                    'height': params.height


                )



                i++;

            m  = $('#mapplic_new1').data('mapplic_new')

















