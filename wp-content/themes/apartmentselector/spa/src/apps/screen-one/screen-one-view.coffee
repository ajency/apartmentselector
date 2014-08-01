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
            $("li").removeClass 'cs-selected'
            $(".cs-placeholder").text('Undecided')

            $('a' ).removeClass 'selected'
            for element , index in unitType
                if parseInt($("#check"+@model.get 'id').val()) != parseInt($("#check"+element).val())
                    $("#check"+@model.get 'id').val '0'
            console.log $("#check"+@model.get 'id').val()
            if  parseInt($("#check"+@model.get 'id').val()) == 0
                unitType.push @model.get 'id'
                App.backFilter['screen1'].push 'unitType'
                $('#unittype'+@model.get("id")+' a' ).addClass 'selected'
                $("#check"+@model.get 'id').val "1"
            else
                unitType=[]
                App.backFilter['screen1'] = []
                #index = unitType.indexOf( @model.get 'id' )
                App.backFilter['screen1'] = []
                #unitType.splice( index, 1 )
                $("#check"+@model.get 'id').val "0"
            if parseInt($("#check"+@model.get 'id').val()) == 0
                $("#finalButton").addClass 'disabled btn-default'
                $("#finalButton").removeClass 'btn-primary'
                return false

            unitTypeString = unitType.join(',')
            App.defaults['unitType'] = unitTypeString
            console.log App.backFilter['screen1']
            console.log App.backFilter['screen1']

            App.screenOneFilter['value'] = unitTypeString
            App.screenOneFilter['key'] = 'unitType'
            $("#finalButton").removeClass 'disabled btn-default'
            $("#finalButton").addClass 'btn-primary'



    class ScreenOneView extends Marionette.CompositeView

        template : '<div class="text-center introTxt">Select your Preference</div><div class="text-center subTxt">Select your flat to get started</div>
        <div class="grid-container"></div><h4 class="text-center m-t-20 m-b-20">OR</h4>
        	<div class="text-center subTxt">What is your budget?</div><section>
        		<select class="cs-select cs-skin-underline" id="budgetValue">
        			<option value="" disabled selected>Undecided</option>

       {{#priceArray}}         			<option value="{{id}}">{{name}}</option>
        			{{/priceArray}}
        		</select>
        	    </section><div class="h-align-middle m-t-50 m-b-20">
        		<a class="btn btn-default btn-large disabled" id="finalButton">Continue with Selection</a>
        		<br><br>
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
                    App.defaults['budget'] = budget_price
                    App.backFilter['screen1'].push 'budget'
                    App.screenOneFilter['value'] = budget_price
                    App.screenOneFilter['key'] = 'budget'
                else
                    App.defaults['budget'] = 'All'


                @trigger 'unit:type:clicked'

            'click .cs-selected':(e)->
                for element in unitType
                    $('a' ).removeClass 'selected'
                    $("#check"+element).val "0"
                unitType = []
                App.defaults['unitType'] = 'All'
                $("#finalButton").removeClass 'disabled btn-default'
                $("#finalButton").addClass 'btn-primary'






        onShow:->

            [].slice.call( document.querySelectorAll( 'select.cs-select' ) ).forEach( (el)->
                new SelectFx(el)
            )
            $( ".grid-link" ).click( ()->
                $( this ).toggleClass( "selected" )
            )
            unitType = []






