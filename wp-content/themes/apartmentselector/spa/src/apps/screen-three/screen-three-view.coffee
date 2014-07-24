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

        template : '<div >
        												{{name}}
        												<div class="small">{{unitTypeName}}  {{unitVariantName}} SQF</div>
        											</div>

        												'



        className : 'cd-block'

        initialize :->
            @$el.prop("id", 'unit'+@model.get("id"))

        onShow :->

            if @model.get('status') == 1
                $('#unit'+@model.get("id")).addClass 'box filtered'
            else if @model.get('status') == 2
                $('#unit'+@model.get("id")).addClass 'box sold'
            else
                $('#unit'+@model.get("id")).addClass 'box other'



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
                										<small>95 per sqft</small>
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














