define [ 'marionette' ], ( Marionette )->

    unitType = []
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
            evt.preventDefault()


            if  parseInt($("#check"+@model.get 'id').val()) == 0
                unitType.push @model.get 'id'
                $("#check"+@model.get 'id').val "1"
            else
                index = unitType.indexOf( @model.get 'id' )

                unitType.splice( index, 1 )
                $("#check"+@model.get 'id').val "0"
            console.log unitType.length
            if unitType.length == 0
                $("#finalButton").addClass 'disabled'
                return false

            unitTypeString = unitType.join(',')
            App.defaults['unitType'] = unitTypeString
            console.log $('#budgetvalue').text()
            $("#finalButton").removeClass 'disabled'
            $(".slick-next").addClass 'slick-disabled'
            $(".slick-prev").addClass 'slick-disabled'


    class ScreenOneView extends Marionette.CompositeView

        template : '<div class="text-center introTxt">Select your Preference</div><div class="text-center subTxt">Select your flat to get started</div>
        <div class="grid-container"></div><h4 class="text-center m-t-20 m-b-20">OR</h4>
        	<div class="text-center subTxt">What is your budget?</div><div class="budgetSelect" id="budgetvalue">
        		<div class="budget">undecided</div>
        		<div class="budget">10-35 lakhs</div>
        		<div class="budget">35-45 lakhs</div>
        		<div class="budget">45-55 lakhs</div>
        	    </div><div class="h-align-middle m-t-50 m-b-20">
        		<a class="btn btn-primary btn-large disabled" id="finalButton">Continue with Selection</a>
        		<br><br>
        		</div>'

        className : 'page-container row-fluid'

        childView : UnitTypeView

        childViewContainer : '.grid-container'

        events:
            'click #finalButton':(e)->
                console.log $(".slick-active").text()
                if $(".slick-active").text() != 'undecided'
                    budget_val = $(".slick-active").text().split(' ')
                    if(budget_val[1]=='lakhs')
                        budget_price = budget_val[0].split('-')
                        budget_price[0] = budget_price[0] + ('00000')
                        budget_price[1] = budget_price[1]+ ('00000')
                        budget_price = budget_price.join('-')
                    console.log budget_price
                    App.defaults['budget'] = budget_price
                else
                    App.defaults['budget'] = 'All'


                @trigger 'unit:type:clicked'

            'click .budget':(e)->
                console.log "aaaaaaaaaaaaa"

            'click .slick-next':(e)->
                if $(".slick-active").text() != 'undecided'
                    $("#finalButton").removeClass 'disabled'
                else
                    $("#finalButton").addClass 'disabled'

                @collection.each ( item)->
                    $('#unittype'+item.get('id')).click(  ()->


                    )
            'click .slick-prev':(e)->
                if $(".slick-active").text() != 'undecided'
                    $("#finalButton").removeClass 'disabled'
                else
                    $("#finalButton").addClass 'disabled'




        onShow:->

            $('.budgetSelect').slick(
                infinite: false
            )
            $( ".grid-link" ).click( ()->
                $( this ).toggleClass( "selected" )
            )
            unitType = []






