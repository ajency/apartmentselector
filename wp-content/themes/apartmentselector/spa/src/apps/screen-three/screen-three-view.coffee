define [ 'marionette' ], ( Marionette )->

    class UnitTypeView extends Marionette.ItemView

        className : "grid-block-1"

        template : '<a href="#"  class="grid-link"   >
                                    <div class="grid-text-wrap"     >
                                        <span class="grid-main-title">{{name}}</span>
                                         <span class="grid-sub-title">{{view_name}}</span>

                                        </div>
                                 </a>'

        events :
            'click' : 'unitSelected'

        unitSelected:(evt)->
            evt.preventDefault()

            @trigger 'main:unit:clicked', @model.get('id') , @model.get('unitType'),@model.get('range'),@model.get('size')



    class UnitTypeChildView extends Marionette.CompositeView

        template : '<div class="grid-container">{{floorid}}</div>'

        childView : UnitTypeView

        childViewContainer : '.grid-container'

        initialize:->

            @collection = @model.get 'units'


    class ScreenThreeView extends Marionette.CompositeView

        childView : UnitTypeChildView













