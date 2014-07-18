define [ 'marionette' ], ( Marionette )->
    class UnitTypeView extends Marionette.ItemView

        className : "grid-block-1"

        template : '<a class="grid-link" href="step2.html">
              	        <div class="grid-text-wrap">
              	          <span class="grid-main-title">{{name}}</span>
              	          <span class="grid-sub-title">{{min_value}} to {{max_value}} (sq. ft.)</span>
              	        </div>
              	      </a>
              	  	'

        events :
            'click' : 'unitTypeSelected'

        unitTypeSelected : ( evt )->
            evt.preventDefault()
            App.defaults['unitType'] = @model.get 'id'
            console.log $('#budgetvalue').text()
            $("#finalButton").removeClass 'disabled'


    class ScreenOneView extends Marionette.CompositeView

        template : '<div class="text-center introTxt">Select your Preference</div><div class="text-center subTxt">Select your flat to get started</div>
        <div class="grid-container"></div><h4 class="text-center m-t-20 m-b-20">OR</h4>
        	<div class="text-center subTxt">What is your budget?</div><div class="budgetSelect" id="budgetvalue">
        		<div class="budget">undecided</div>
        		<div class="budget">25-35 lakhs</div>
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
                @trigger 'unit:type:clicked'




        onShow:->

            $('.budgetSelect').slick(
                infinite: false
            )
            $( ".grid-link" ).click( ()->
                $( this ).toggleClass( "selected" )
            )






