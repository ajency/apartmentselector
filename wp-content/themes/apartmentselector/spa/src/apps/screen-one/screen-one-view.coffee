define [ 'marionette' ], ( Marionette )->
   class UnitTypeView extends Marionette.ItemView

      className : "grid-block-1"

      template : '<a href="#" class="grid-link" >
                        <div class="grid-text-wrap">
                            <span class="grid-main-title">{{name}}</span>
                             <span class="grid-sub-title">{{min_value}} - {{max_value}}</span>
                        </div>
                     </a>'

      events :
         'click' : 'unitTypeSelected'

      unitTypeSelected : ( evt )->
         evt.preventDefault()
         @trigger 'unit:type:clicked', @model.get 'id'

   class ScreenOneView extends Marionette.CompositeView

      template : '<div class="grid-container"></div>'

      childView : UnitTypeView

      childViewContainer : '.grid-container'