define [ 'marionette' ], ( Marionette )->

   class UnitTypeView extends Marionette.ItemView

      tagName : 'li'

      template : '{{name}}'

      events :
         'click' : 'unitTypeSelected'

      unitTypeSelected : ( evt )->
         @trigger 'unit:type:clicked', @model.get 'id'

   class ScreenOneView extends Marionette.CompositeView

      template : '<p>SOme Test above</p>
                  <ul class="unit-type-view"></ul>'

      childView : UnitTypeView

      childViewContainer : '.unit-type-view'