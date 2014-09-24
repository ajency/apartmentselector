define [ 'extm', 'marionette' ], ( Extm, Marionette )->
    m = ""
    unitVariantArray = ''
    unitVariantIdArray = []
    unitVariantString = ''
    globalUnitArrayInt = []
    firstElement = ''
    rangeArray =[]
    tagsArray = []
    count = 0
    object = ""
    unitVariants = []
    cloneunitVariantArrayColl = ""
    class ScreenTwoLayout extends Marionette.LayoutView

        template : '<div class="">
                        <div class="text-center subTxt m-b-20 unittype hidden animated pulse">We have <span class="bold text-primary"> {{unitsCount }} </span> <strong>{{selection}}</strong> apartments</div>
                        <div class="text-center subTxt m-b-20 budget hidden animated pulse">We have <span class="bold text-primary"> {{unitsCount }} </span>  apartments in the budget of <strong>{{selection}}</strong></div>
                        <div class="text-center subTxt m-b-20 refresh hidden animated pulse">You are now seeing <span class="bold text-primary">All</span> apartments across all the towers.</div>

                        <div class="text-center introTxt m-b-10">These apartments are spread over different towers. Each tower has three floor blocks. The number in the boxes indicate the number of apartments of your selection. Select one for more details.</div>

                        <div class="introTxt text-center">You are seeing 
                            <div id="tagslist" class="taglist">
                              <ul></ul>
                            </div>
                            <span class="text-primary variantToggle1"> </span>variants of your apartment selection
                        </div>
                        
                        <div class="variantBox1">
                            <div class="pull-left m-l-15">
                                <input type="checkbox" name="selectall" id="selectall" class="checkbox" value="0" checked/>
                                <label for="selectall">Select/Unselect All</label>
                            </div>
                            <div class="text-right m-b-20">
                                <span class="variantClose1 glyphicon glyphicon-remove text-grey"></span>
                            </div>

                            <div class="grid-container">
                                {{#unitVariants}}
                                <div class="grid-block-3" >
                                    <a class="grid-link selected" href="#" id="grid{{id}}" data-id="{{id}}">
                                        {{sellablearea}} Sq.ft.<input type="hidden" name="check{{id}}"   id="check{{id}}"   value="1" />
                                    </a>
                                </div>
                                {{/unitVariants}}
                                <div class="variantAction m-t-5 m-b-20">
                                    <a class="btn btn-primary m-r-10 done">DONE</a>
                                    <a class="btn btn-default cancel">CANCEL</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row m-l-0 m-r-0 bgClass">

                        <div class="col-md-5 col-lg-4">
                            
                    		<div class="legend text-center m-b-20">
                                {{#unittypes}}
                                <span class={{classname}}>.</span>{{name}}
                                {{/unittypes}}
                		    </div>

                            <div class="towerTable">
                                <div class="tableBody">
                    				<div id="vs-container2" class="vs-container vs-triplelayout">
                    				    <header class="vs-header" id="building-region"></header>
                    				    <div id="unit-region"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="h-align-middle m-t-20 m-b-20">
                                <a href="#screen-three-region" class="btn btn-default btn-lg disabled" id="screen-two-button">Show Apartments</a>
                            </div>
                        </div>

                        <div class="col-md-7 col-lg-8 b-grey b-l visible-md visible-lg">
                            <div class="m-t-10 text-center">
                               <!--<h4 class="bold m-t-0">Where is this tower located in the project?</h4>
                                <p class="light">This is a map of the entire project that shows the location of the tower selected (on the left).</p>-->
                                <div id="loadmap"><div id="mapplic1" class="towersMap center-block"></div></div>
                            </div>
                        </div><input type="hidden" name="currency1" id="currency1" class="demo" data-a-sign="Rs. " data-d-group="2">
                    </div>'




        className : 'page-container row-fluid'




        regions :
            buildingRegion : '#building-region'
            unitRegion : '#unit-region'

        onAfterRender:(Collection)->
            @itemview1 = new UnitTypeChildView
                collection : Collection[0]

            @itemview2 = new UnitTypeView
                collection : Collection[1]
            this.$el.empty();
            this.itemview1.delegateEvents();
            this.$el.append(@itemview1.render().el ); 
            this.$el.append(@itemview2.render().el );            
            

                
                

             
    

               
    

        events:
            'mouseout .im-pin':(e)->
                $('.im-tooltip').hide()
            'mouseout .tower-link':(e)->
                $('.im-tooltip').hide()
            'mouseover a.tower-link':(e)->
                id  = e.target.id
                console.log str1 = id.replace( /[^\d.]/g, '' )
                floorUnitsArray = []
                myArray = []
                buildigmodel = App.master.building.findWhere({id:parseInt(str1)})
                if buildigmodel == undefined || buildigmodel == ""
                    return false
                screenonearray = App.backFilter['screen1']
                for element in screenonearray
                    if App.defaults[element] != 'All'
                        key = App.defaults.hasOwnProperty(element)
                        if key == true
                            console.log App.defaults[element]
                            myArray.push({key:element,value:App.defaults[element]})
                $.map(App.defaults, (value, index)->
                    if value!='All'
                        if  index == 'unittypeback'
                            myArray.push({key:index,value:value})

                    )
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
                mainnewarr =  []
                mainunique = {}
                if myArray.length == 0 
                    floorCollunits = unitslen
                units  = new Backbone.Collection floorCollunits
                mainunitTypeArray1 = []
                units1 = App.master.unit.where({'status':status.get('id')})
                $.each(units1, (index,value)->
                    unitTypemodel = App.master.unit_type.findWhere({id:value.get 'unitType'})
                    mainunitTypeArray1.push({id:unitTypemodel.get('id'),name: unitTypemodel.get('name')})
                )
                console.log mainunitTypeArray1
                $.each(mainunitTypeArray1, (key,item)->
                    if (!mainunique[item.id])
                        if item.id != 14 && item.id != 16
                            status = App.master.status.findWhere({'name':'Available'})

                            count = units.where({unitType:item.id,'status':status.get('id'),'building':parseInt(str1)})

                            if parseInt(item.id) == 9
                                classname = 'twoBHK'
                            else
                                classname = 'threeBHK'

                            mainnewarr.push({id:item.id,name:item.name,classname:classname,count:count})
                            mainunique[item.id] = item;


                )
                countunits = units.where({building:parseInt(str1)})
                buildigmodel = App.master.building.findWhere({id:parseInt(str1)})
                unittypetext = ""
                if buildigmodel == undefined || buildigmodel == ""
                    text = "Not Launched"
                else
                
                    min = ""
                    text = "<span></span>"
                    if countunits.length > 0
                        console.log minmodel = _.min(countunits, (model)->
                            if model.get('unitType') != 14 && model.get('unitType') != 16
                                return model.get('unitPrice')
                        )
                        $('#currency1').autoNumeric('init')
                        $('#currency1').autoNumeric('set', minmodel.get('unitPrice'));
                        currency = $('#currency1').val()
                        if App.defaults['unitType'] != 'All'
                            selectorname = App.defaults['unitType']
                            unittypemodel = App.master.unit_type.findWhere({id:parseInt(App.defaults['unitType'])})
                            selectorname = unittypemodel.get 'name'
                            text = selectorname+' apartments - </span>'+countunits.length+'<br/><span>Starting Price - </span>'+currency
                        else if App.defaults['budget'] != "All"
                            selectorname = App.defaults['budget']
                            $.each(mainnewarr, (index,value)->
                                unittypetext  += '<span>'+value.name+' :</span><span>'+value.count.length+'</span></br>'


                            )
                            text = '<span>Apartments within '+selectorname+' - </span>'+countunits.length+'<br/>'+unittypetext+'<br/><span>Starting Price - </span>'+currency
                        else if App.defaults['unitType'] == 'All' && App.defaults['budget'] == "All"
                            selectorname = ""
                            $.each(mainnewarr, (index,value)->
                                unittypetext  += '<span>'+value.name+' :</span><span>'+value.count.length+'</span></br>'


                            )
                            text = '<span>No. of '+selectorname+' apartments - </span>'+countunits.length+'<br/>'+unittypetext+'<br/><span>Starting Price - </span>'+currency
                    else
                        if App.defaults['unitType'] != 'All'
                            selectorname = App.defaults['unitType']
                            unittypemodel = App.master.unit_type.findWhere({id:parseInt(App.defaults['unitType'])})
                            selectorname = unittypemodel.get 'name'
                            text = selectorname+' apartments - </span>'+countunits.length+'<br/><span>'
                        else if App.defaults['budget'] != "All"
                            selectorname = App.defaults['budget']
                            
                            text = '<span>Apartments within '+selectorname+' - </span>'+countunits.length
                    
                locationData = m.getLocationData(id)
                m.showTooltip(locationData,text)

            'mouseover a.im-pin':(e)->
                id  = e.target.id
                locationData = m.getLocationData(id)
                m.showTooltip(locationData)


            'click a':(e)->
                e.preventDefault()
                id  = e.target.id
                #m.showLocation(id, 800)
                #locationData = m.getLocationData(id)
                #m.showTooltip(locationData)

            'click .tower-link':(e)->
                e.preventDefault()
                id  = e.target.id
                #location.href = "tower13"
                #m.showLocation(id, 800)
                #locationData = m.getLocationData(id)
                #m.showTooltip(locationData)




            'click .remodalcheck':(e)->
                #App.navigate "modal"
                e.preventDefault()


            'click .tower-link':(e)->
                console.log id = e.target.id
                console.log str1 = id.replace( /[^\d.]/g, '' )
                buildigmodel = App.master.building.findWhere({id:parseInt(str1)})
                if buildigmodel == undefined || buildigmodel == ""
                    return false
                floorUnitsArray = []
                myArray = []
                screenonearray = App.backFilter['screen1']
                for element in screenonearray
                    if App.defaults[element] != 'All'
                        key = App.defaults.hasOwnProperty(element)
                        if key == true
                            console.log App.defaults[element]
                            myArray.push({key:element,value:App.defaults[element]})
                $.map(App.defaults, (value, index)->
                    if value!='All'
                        if  index == 'unittypeback'
                            myArray.push({key:index,value:value})

                    )
                status = App.master.status.findWhere({'name':'Available'})
                unitslen = App.master.unit.where({'status':status.get('id')})


                
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
                floorColl  = new Backbone.Collection floorCollunits
                
                units = floorColl.where({building:parseInt(str1)})
                console.log units.length
                if units.length != 0
                    App.layout.screenThreeRegion.el.innerHTML = ""
                    App.layout.screenFourRegion.el.innerHTML = ""
                    $('#screen-three-region').removeClass 'section'
                    $('#screen-four-region').removeClass 'section' 
                    screentwoArray  = App.backFilter['screen2']
                    for element in screentwoArray
                        key = App.defaults.hasOwnProperty(element)
                        if key == true
                            App.defaults[element] = 'All'
                    screenthreeArray  = App.backFilter['screen3']
                    for element in screenthreeArray
                        key = App.defaults.hasOwnProperty(element)
                        if key == true
                            App.defaults[element] = 'All'
                    console.log App.defaults['unittypeback']
                    App.defaults['unitVariant'] = App.defaults['unittypeback']
                    App.navigate "screen-two"
                    App.currentStore.unit.reset UNITS
                    App.currentStore.building.reset BUILDINGS
                    App.currentStore.unit_type.reset UNITTYPES
                    App.currentStore.unit_variant.reset UNITVARIANTS
                    console.log App.defaults
                    App.filter(params={})
                    msgbus.showApp 'header'
                    .insideRegion  App.headerRegion
                        .withOptions()
                    #App.filter(params={})
                    @trigger 'show:updated:building' , $('#'+e.target.id ).attr('data-id')
                else
                    text = "This Tower does not contain any apartments as per your current selection"
                    locationData = m.getLocationData(id)
                    m.showTooltip(locationData,text)




            'click .grid-link':(e)->
                count = unitVariantArray.length
                id = $('#'+e.target.id).attr('data-id')
                track = 0
                if $('#check'+id).val() == '1'
                    index = unitVariantArray.indexOf(parseInt(id))
                    if index != -1
                        unitVariantArray.splice( index, 1 )
                        $('#check'+id).val '0'
                        track = 0
                        unitVariantIdArray.push(parseInt(id))
                else
                    track = 1
                    unitVariantArray.push(parseInt(id))
                    $('#check'+id).val '1'


                

                if globalUnitArrayInt.length != 0
                    if track == 0
                        unitVariantArray = _.intersection(unitVariantArray,globalUnitArrayInt)
                    else
                        globalUnitArrayInt.push(parseInt(id))
                        unitVariantArray = globalUnitArrayInt

                unitVariantArray = _.uniq(unitVariantArray)
                if unitVariantArray.length == 0
                    unitVariantString = firstElement.toString()

                else



                    if cloneunitVariantArrayColl.length == unitVariantArray.length
                        unitVariantString = 'All'

                    else
                        unitVariantString = unitVariantArray.join(',')
                if unitVariantString == "All"
                    $('#selectall' ).prop 'checked', true
                else
                    $('#selectall' ).prop 'checked', false




            'click .done':(e)->
                q = 1
                if unitVariantString == ""
                    unitVariantString = "All"
                $(".variantBox1").slideToggle()
                $.map(App.backFilter, (value, index)->

                    if q!=1
                        screenArray  = App.backFilter[index]
                        for element in screenArray
                            if element == 'unitVariant'
                                App.defaults[element] = unitVariantString
                            else
                                key = App.defaults.hasOwnProperty(element)
                                if key == true
                                    App.defaults[element] = 'All'
                    q++

                )
                App.layout.screenThreeRegion.el.innerHTML = ""
                App.layout.screenFourRegion.el.innerHTML = ""
                App.navigate "screen-two"
                App.currentStore.unit.reset UNITS
                App.currentStore.building.reset BUILDINGS
                App.currentStore.unit_type.reset UNITTYPES
                App.currentStore.unit_variant.reset UNITVARIANTS
                if unitVariantString == ""
                    unitVariantString = 'All'
                App.defaults['unitVariant'] = unitVariantString
                App.defaults['unittypeback'] = unitVariantString
                App.backFilter['screen2'].push 'unitVariant'
                App.filter(params={})
                @trigger 'unit:variants:selected'

            'click .cancel':(e)->
                unitVariantArray = _.union(unitVariantArray,unitVariantIdArray)
                $(".variantBox1").slideToggle()
                globalUnitVariants = App.defaults['unitVariant'].split(',')
                globalUnitArrayInt = []
                $.each(globalUnitVariants, (index,value)->
                    globalUnitArrayInt.push(parseInt(value))

                )

                if App.defaults['unitVariant'] != 'All'
                    $.each(unitVariantArray, (index,value)->
                        key = _.contains(globalUnitArrayInt,parseInt(value))
                        if key == true
                            $('#grid'+value).addClass 'selected'
                            $('#check'+value).val '1'
                        else
                            $('#grid'+value).removeClass 'selected'
                            $('#check'+value).val '0'








                    )

            'click #selectall':(e)->
                if $('#'+e.target.id).prop('checked') == true
                    cloneunitVariantArrayColl.each ( index)->
                        $('#grid'+index.get('id')).addClass 'selected'
                        $('#check'+index.get('id')).val '1'

                        unitVariantArray.push(index.get('id'))
                    unitVariantArray = _.uniq(unitVariantArray)
                    units = cloneunitVariantArrayColl.toArray()
                    units.sort(  (a,b)->
                        a.get('id') - b.get('id')
                    )
                    unitVariantString = 'All'
                else
                    tempArray = []
                    cloneunitVariantArrayColl.each ( value)->
                        tempArray.push(parseInt(value.get('id')))


                    value = _.first(tempArray)
                    remainainArray = _.rest(tempArray)
                    $.each(remainainArray, (index,value)->
                        $('#grid'+value).removeClass 'selected'
                        $('#check'+value).val '0'
                        index = unitVariantArray.indexOf(parseInt(value))
                        if index != -1
                            unitVariantArray.splice( index, 1 )


                    )
                    unitVariantString = value.toString()

            'click #screen-two-button':(e)->
                #rangeArray = []
                $('#screen-three-region').addClass 'section'
                @trigger 'unit:count:selected'

        showHighlightedTowers:()->
            building = Marionette.getOption( @, 'buildingColl' ).toArray()
            buidlingValue = _.first(building)
            masterbuilding = App.master.building
            masterbuilding.each ( index)->
                $("#highlighttower"+index.get('id')).attr('class','overlay')
            
        






















        onShow:->
            $('#screen-two-button').on('click',  ()->
                new jBox('Notice', 
                    content: 'Wait 1 Second',
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
            rangeArray = []
            globalUnitArrayInt = []
            if App.defaults['unitVariant'] != 'All'
                globalUnitVariants = App.defaults['unitVariant'].split(',')
                $.each(globalUnitVariants, (index,value)->
                    globalUnitArrayInt.push(parseInt(value))

                )
            if unitVariantString == "All" || App.defaults['unitVariant'] == "All"
                $('#selectall' ).prop 'checked', true
            else
                $('#selectall' ).prop 'checked', false
            if App.screenOneFilter['key'] == 'unitType'
                $('.unittype' ).removeClass 'hidden'
            else if App.screenOneFilter['key'] == 'budget'
                $('.budget' ).removeClass 'hidden'
            else if App.screenOneFilter['key'] == ""
                $('.refresh' ).removeClass 'hidden'


            unitVariantArray  = Marionette.getOption( @, 'uintVariantId' )
            unitVariantsArray  = Marionette.getOption( @, 'unitVariants' )
            unitVariantArrayColl = new Backbone.Collection unitVariantsArray
            cloneunitVariantArrayColl = unitVariantArrayColl.clone()
            unitVariants  = unitVariantArray

            firstElement = _.first(unitVariantArray)


            if App.defaults['unitVariant'] != 'All'
                unitVariantArray = _.union(unitVariantArray,unitVariantIdArray)
                $.each(unitVariantArray, (index,value)->
                    key = _.contains(globalUnitArrayInt,parseInt(value))
                    if key == true
                        $('#grid'+value).addClass 'selected'
                        $('#check'+value).val '1'
                    else
                        index = unitVariantArray.indexOf(parseInt(value))
                        $('#grid'+value).removeClass 'selected'
                        $('#check'+value).val '0'
                )
            else
                unitVariantArray = unitVariantArray
                $.each(unitVariantArray, (index,value)->
                    $('#grid'+value).addClass 'selected'
                    $('#check'+value).val '1'

                )


            $(".variantToggle1").click ->
                $(this).toggleClass("open")
                $(".variantBox1").slideToggle()
                return

            $(".variantClose1").click ->
                $(".variantBox1").slideToggle()
                $(".variantToggle1").toggleClass("open")
                return

            $(".grid-link").click  (e)->
                $(this).toggleClass("selected")
                return




            i = 1
            building = Marionette.getOption( @, 'buildingColl' ).toArray()
            buidlingValue = _.first(building)
            while (window['mapplic' + i] != undefined)
                params = window['mapplic' + i]
                selector = '#mapplic' + i
                ajaxurl = AJAXURL
                defer = $(selector).mapplic(
                    'id': 5,
                    'width': params.width,
                    'height': params.height,
                    'option':buidlingValue


                )
                



                i++;

            m  = $('#mapplic1').data('mapplic')
            @showHighlightedTowers()


            $('html, body').delay(600).animate({
                scrollTop: $('#screen-two-region').offset().top
            }, 'slow')


            tagsArray = []
            testtext = App.defaults['unitVariant']
            if testtext != 'All'
                unitVariantArrayText = testtext.split(',')
                $.each(unitVariantArrayText, (index,value)->
                    unitVariantModel = App.master.unit_variant.findWhere({id:parseInt(value)})
                    tagsArray.push({id:value , area : unitVariantModel.get('sellablearea')+'Sq.ft.'})


                )
            else
                unitVariantArrayText = testtext.split(',')
                tagsArray.push({id:'All' , area : 'All'})

            @doListing()
            object = @
            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/main2.js'

            document.body.appendChild(scr)
            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/jquery.remodal.js'
            document.body.appendChild(scr)

           
            

            
        $(document).on("click", ".closeButton",  ()->
                theidtodel = $(this).parent('li').attr('id')
               

                object.delItem($('#' + theidtodel).attr('data-itemNum'))
        )

        doListing:->
            $('#tagslist ul li').remove()
            $.each(tagsArray,  (index, value) ->
                $('#tagslist ul').append('<li id="li-item-' + value.id + '" data-itemNum="' + value.id + '"><span class="itemText">' + value.area + '</span><div class="closeButton"></div></li>')
            )
            if tagsArray.length == 1
                $('.closeButton').addClass 'hidden'

        delItem:(delnum)->
            removeItem = delnum
            i =0
            key = ""

            $.each(tagsArray, (index,val)->
                if val.id == delnum
                    key = i
                i++

            )
            index = key
            if (index >= 0)
                tagsArray.splice(index, 1)
                $('#li-item-' + delnum).remove()
                unitvariantarrayValues = []
                $.each(tagsArray , (index,value)->
                    unitvariantarrayValues.push(value.id)

                )
                q = 1
                $.map(App.backFilter, (value, index)->

                    if q!=1
                        screenArray  = App.backFilter[index]
                        for element in screenArray
                            if element == 'unitVariant'
                                App.defaults[element] = unitVariantString
                            else
                                key = App.defaults.hasOwnProperty(element)
                                if key == true
                                    App.defaults[element] = 'All'
                    q++

                )
                App.layout.screenThreeRegion.el.innerHTML = ""
                App.layout.screenFourRegion.el.innerHTML = ""
                App.navigate "screen-two"
                App.defaults['unitVariant'] = unitvariantarrayValues.join(',')
                App.currentStore.unit.reset UNITS
                App.currentStore.building.reset BUILDINGS
                App.currentStore.unit_type.reset UNITTYPES
                App.currentStore.unit_variant.reset UNITVARIANTS
                App.filter(params={})
                @trigger 'unit:variants:selected'
























    class BuildingView extends Marionette.ItemView

        template : '<a  class="link" href="tower{{id}}">{{name}}</a>'

        tagName : 'li'

        className : 'vs-nav-current'

        events:
            'click .link':(e)->
                #m = mapplic()
                #m  = $('#mapplic1').data('mapplic')
                id = @model.get('id')

                i = 1
                params = window['mapplic' + i]
                selector = '#mapplic' + i
                if @model.get('id') == undefined
                    id = ""
                @showHighlightedBuildings(id)
                #m.initial($(selector),params)
                #m.showLocation(id, 800)
                #locationData = m.getLocationData(id);
                #m.showTooltip(locationData);
                #App.navigate "tower"+@model.get('id') , trigger:true

        showHighlightedBuildings:(id)->
            masterbuilding = App.master.building
            masterbuilding.each ( index)->
                $("#highlighttower"+index.get('id')).attr('class','overlay')
            if id != ""
                building = id
                $("#highlighttower"+building).attr('class','overlay highlight')


        initialize :->
            @$el.prop("id", 'towerlink'+@model.get("id"))














    class UnitTypeChildView extends Marionette.CompositeView

        tagName : 'ul'


        className : 'vs-nav'



        childView : BuildingView

        onShow:->
            model = @collection.at(0)

            id = 'tower'+model.get('id')
            #m.showLocation(id, 800)

            #App.navigate "tower"+model.get('id') , trigger:true

        






    class UnitViewChildView extends Marionette.ItemView

        template : '<div id="range{{range}}{{buildingid}}" class="boxBlank {{classname}} {{disable}}">
                        <div class="pull-left light text-center">
                            <h4 class="rangeName bold m-t-5">{{rangetext}}</h4>
                            <div class="small">{{rangeNo}}</div>
                        </div>
                        <div class="unitCount pull-right text-center">
                            <h4 class="bold m-b-5 m-t-0">{{count}}</h4>
                            <div class="small">FLATS</div>
                        </div>
                        <div class="clearfix"></div>
                    </div>                    

                    <input type="hidden" name="checkrange{{range}}{{buildingid}}"   id="checkrange{{range}}{{buildingid}}"       value="0" />                             </div>'

        className : 'towerSelect'






        events:

            'click ':(e)->

                q = 1
                $.map(App.backFilter, (value, index)->

                    if q!=1
                        screenArray  = App.backFilter[index]
                        for element in screenArray
                            if element == 'unitVariant'
                                if unitVariantString == ""
                                    unitVariantString = "All"
                                App.defaults[element] = unitVariantString
                            else
                                key = App.defaults.hasOwnProperty(element)
                                if key == true
                                    App.defaults[element] = 'All'
                    q++

                )
                App.navigate "screen-two"
                $('#screen-three-region').removeClass 'section'
                $('#screen-four-region').removeClass 'section'
                App.layout.screenThreeRegion.el.innerHTML = ""
                App.layout.screenFourRegion.el.innerHTML = ""
                App.currentStore.unit.reset UNITS
                App.currentStore.building.reset BUILDINGS
                App.currentStore.unit_type.reset UNITTYPES
                App.currentStore.unit_variant.reset UNITVARIANTS
                msgbus.showApp 'header'
                .insideRegion  App.headerRegion
                    .withOptions()
                
                if @model.get('count') !=0
                    for element , index in rangeArray
                        if element == @model.get('range')+@model.get('buildingid')
                            $("#checkrange"+@model.get('range')+@model.get('buildingid')).val '1'
                        else
                            $("#checkrange"+element).val '0'
                            $('#range'+element).removeClass 'selected'
                            rangeArray = []
                    
                    if  parseInt($("#checkrange"+@model.get('range')+@model.get('buildingid')).val()) == 0
                        rangeArray.push @model.get('range')+@model.get('buildingid')
                        $('#range'+@model.get('range')+@model.get('buildingid')).addClass 'selected'

                        $("#checkrange"+@model.get('range')+@model.get('buildingid')).val "1"
                        buildingModel = App.currentStore.building.findWhere({id:@model.get('buildingid')})
                        floorriserange = buildingModel.get 'floorriserange'
                        #floorriserange = [{"name":"low","start":"1","end":"2"},{"name":"medium","start":"3","end":"4"},{"name":"high","start":"5","end":"6"}]
                        object = @
                        rangeArrayVal = []
                        i = 0
                        $.each(floorriserange, (index,value)->
                            if object.model.get('range') == value.name
                                start = parseInt(value.start)
                                end = parseInt(value.end)
                                while parseInt(start) <= parseInt(end)
                                    rangeArrayVal[i] = start
                                    start = parseInt(start) + 1
                                    i++
                                rangeArrayVal



                        )


                        rangeString = rangeArrayVal.join(',')


                        App.defaults['floor'] = rangeString
                        App.backFilter['screen2'].push 'floor'
                        App.defaults['building'] = parseInt(@model.get 'buildingid')
                        App.backFilter['screen2'].push 'building'
                        $('#screen-two-button').removeClass 'disabled btn-default'
                        $("#screen-two-button").addClass 'btn-primary'
                        console.log App.defaults
                        @trigger 'unit:count:selected'
                    else
                        rangeArray=[]
                        $("#checkrange"+@model.get('range')+@model.get('buildingid')).val "0"
                        $('#range'+@model.get('range')+@model.get('buildingid')).removeClass 'selected'
                if parseInt($("#checkrange"+@model.get('range')+@model.get('buildingid')).val()) == 0
                    $("#screen-two-button").addClass 'disabled btn-default'
                    $("#screen-two-button").removeClass 'btn-primary'
                    return false











    class UnitView extends Marionette.CompositeView

        template : '<div class="vs-content">
                            <div class="towerUnits">
                                <div class="subHeader ">
                                    <div class="row small light">
                                        <div class="col-xs-5">
                                            FLOOR<br>RANGE
                                        </div>
                                        <div class="col-xs-7 text-right">
                                            NO. OF UNITS OF<br>YOUR SELECTION
                                        </div>
                                    </div>
                                </div>
                            </div>
                                <!--<div class="towerDetails m-t-10">
                                    <div class="row">
                                        <div class="col-xs-4">
                                           <h4 class="m-t-0 m-b-0 bold">Total Apartments</h4>
                                           <h3 class="light m-t-0">{{totalunits}}</h3>
                                        </div>

                                        <div class="col-xs-4">
                                           <h4 class="m-t-0 m-b-0 bold">Available Apartments</h4>
                                           <h3 class="light m-t-0">{{availableunits}}</h3>
                                        </div>
                                        <div class="col-xs-4">
                                           <h4 class="m-t-0 m-b-0 bold">Number of Floors</h4>
                                           <h3 class="light m-t-0">{{totalfloors}}</h3>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12 m-t-10">
                                            <div class="col">
                                                <p>Climb leg make muffins or sweet beast play time and hate dog or chew foot. Stretch climb leg. Play time give attitude for all of a sudden go crazy chase imaginary bugs lick butt. Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs. Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <h4 class="m-t-0 m-b-5 text-primary"><span class="bold">VIEWS</span> for this tower</h4>
                                    <div class="row m-b-20">
                                        {{#views}}
                                        <div class="col-sm-6">
                                            {{#data}}<span class="glyphicon glyphicon-asterisk small text-grey"></span> {{name}}<br>{{/data}}
                                        </div>
                                        {{/views}}
                                    </div>
                                </div>-->
                    </div>'



        tagName : 'section'



        childView : UnitViewChildView


        childViewContainer : '.towerUnits'





        initialize :->
            @collection = @model.get 'units'
            @$el.prop("id", 'tower'+@model.get("buildingid"))

        onShow :->
            $("#unit-region section").addClass "vs-current" if $("#unit-region section").length < 2
            return






    class UnitTypeView extends Marionette.CompositeView




        childView : UnitView

        className : "vs-wrapper"






            




    ScreenTwoLayout : ScreenTwoLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView


















