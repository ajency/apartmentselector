define [ 'marionette' ], ( Marionette )->

    class ScreenThreeLayout extends Marionette.LayoutView

        template : '<h3 class="text-center introTxt m-b-30">We have <span class="bold text-primary">25 options</span> for 1BHK <br><small>Select your flat to get started</small></h3>
                    <div id="vs-container" class="vs-container">
                    <header class="vs-header" id="building-region">

        			</header>

                    <div  id="unit-region">
                    </div>
                    </div>'




        className : 'page-container row-fluid'




        regions :
            buildingRegion : '#building-region'
            unitRegion : '#unit-region'

        onShow:->
            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/main.js'
            document.body.appendChild(scr)

            $columns_number = $('.unitTable .cd-table-container').find('.cd-block').length

            $('.cd-table-container').on('scroll', ()->
                $this = $(this)
                total_table_width = parseInt($('.cd-table-wrapper').css('width').replace('px', ''))
                table_viewport = parseInt($('.unitTable').css('width').replace('px', ''))
                if( $this.scrollLeft() >= total_table_width - table_viewport - $columns_number)
                    $('.unitTable').addClass('table-end');
                    $('.cd-scroll-right').hide()
                else
                    $('.unitTable').removeClass('table-end')
                    $('.cd-scroll-right').show()






            )
            $('.cd-scroll-right').on('click', ()->
                $this= $(this)
                column_width = $(this).siblings('.cd-table-container').find('.cd-block').eq(0).css('width').replace('px', '')
                new_left_scroll = parseInt($('.cd-table-container').scrollLeft()) + parseInt(column_width)
                $('.cd-table-container').animate( {scrollLeft: new_left_scroll}, 200 )





            )







    class BuildingView extends Marionette.ItemView

        template : '<a class="link" href="tower{{id}}">{{name}}</a>'

        tagName : 'li'

        events :
            'click .link' : ( e )->
                $( '#tower'+@model.get 'id' ).removeClass 'hidden'


    class UnitTypeChildView extends Marionette.CompositeView

        tagName : 'ul'


        className : 'vs-nav'



        childView : BuildingView





    class childViewUnit extends Marionette.ItemView

        template : '<div id="check{{id}}" class="check" >
        												{{name}}
        												<div class="small">{{unitTypeName}} {{unitVariantName}} SQF</div>
        											</div>

        												'



        className : 'cd-block'

        initialize :->
            @$el.prop("id", 'unit'+@model.get("id"))

        onShow :->
            myArray = []
            console.log App.Cloneddefaults
            console.log App.backFilter
            for element in App.backFilter['screen1']
                key = App.Cloneddefaults.hasOwnProperty(element)
                if key == true
                    myArray.push({key:element,value: App.Cloneddefaults[element]})
            console.log myArray
            flag = 0
            object = @
            $.each(myArray, (index,value)->
                paramKey = {}

                if value.key == 'budget'
                    buildingModel = App.currentStore.building.findWhere({'id':object.model.get 'building'})
                    floorRise = buildingModel.get 'floorrise'
                    floorRiseValue = floorRise[object.model.get 'floor']
                    unitVariantmodel = App.currentStore.unit_variant.findWhere({'id':object.model.get 'unitVariant'})
                    console.log unitPrice = (parseInt( unitVariantmodel.get('persqftprice')) + parseInt(floorRiseValue)) * parseInt(unitVariantmodel.get 'sellablearea')
                    budget_price = value.value.split('-')
                    console.log budget_price[0] = budget_price[0]
                    console.log budget_price[1] = budget_price[1]
                    if parseInt(unitPrice) >= parseInt(budget_price[0]) && parseInt(unitPrice) <= parseInt(budget_price[1])
                        flag = 1
                else


                    if object.model.get(value.key) == parseInt(value.value)
                       console.log  flag=1

            )



            console.log myArray.length
            if myArray.length == 0
                flag = 1
            console.log flag
            if flag==1 && @model.get('status') == 9
                $('#check'+@model.get("id")).addClass 'box filtered'
            else if flag==1 &&  @model.get('status') == 8
                $('#check'+@model.get("id")).addClass 'box sold'
            else
                $('#check'+@model.get("id")).addClass 'box other'
                $('#check'+@model.get("id")).text @model.get 'unitTypeName'

        events:
            'click .check':(e)->
                App.unit['name'] = @model.get("id")
                App.floorFilter['name'] = App.defaults['floor']
                App.defaults['floor'] = @model.get("floor")
                App.backFilter['screen3'].push 'floor'
                App.building['name'] = parseInt(@model.get 'building')
                @trigger 'unit:item:selected'





    class unitChildView extends Marionette.CompositeView

        template : '<div class="clearfix"></div>'



        className : 'cd-table-row'



        childView : childViewUnit






        initialize :->
            @collection = @model.get 'floorunits'






    class UnitView extends Marionette.CompositeView

        template : '<div class="vs-content"><div  class="unitTable">
                            <header class="cd-table-column">
                								<ul>

                    {{#floorcount}}         									<li>
                										Floor {{id}}

                									</li>
                    {{/floorcount}}
                								</ul>
                							</header>
                			<div class="cd-table-container"><div class="cd-table-wrapper">
                            </div></div><em class="cd-scroll-right"></em></div></div>'




        childView : unitChildView


        tagName  : "section"

        childViewContainer : '.cd-table-wrapper'





        initialize :->
            @collection = @model.get 'units'
            @$el.prop("id", 'tower'+@model.get("buildingid"))





    class UnitTypeView extends Marionette.CompositeView

        className : "vs-wrapper"


        childView : UnitView






    ScreenThreeLayout : ScreenThreeLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView














