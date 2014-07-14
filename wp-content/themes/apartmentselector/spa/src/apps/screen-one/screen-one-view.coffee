define [ 'marionette' ], ( Marionette )->
   class UnitTypeView extends Marionette.ItemView

      className : "grid-block-1"

      template : '
      	  		<a class="grid-link" href="step2.html">
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
         budget = 'NotSet'
         @trigger 'unit:type:clicked', @model.get('id'), budget

   class ScreenOneView extends Marionette.CompositeView

      template : '<div class="grid-container"></div>'

      className : 'page-container row-fluid'

      childView : UnitTypeView

      childViewContainer : '.grid-container'



