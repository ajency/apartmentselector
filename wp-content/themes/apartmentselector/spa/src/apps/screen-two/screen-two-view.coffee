define [ 'marionette' ], ( Marionette )->
    class UnitTypeView extends Marionette.ItemView

        className : "grid-block-1"

        template : '<a href="#"  class="grid-link"  data-value="{{range}}" >
                            <div class="grid-text-wrap"  id="{{buildingid}}{{name}}"   >
                                <span class="grid-main-title">{{name}}</span>
                                 <span class="grid-sub-title">{{low_min_val}} - {{low_max_val}}</span>

                                </div>
                         </a>'

        events :
            'click '   : 'typeOfUnitSelected'

        typeOfUnitSelected :(evt)->
            evt.preventDefault()

            @trigger 'type:unit:clicked', @model.get('buildingid') , @model.get('unitType'),@model.get('range')



    class UnitTypeChildView extends Marionette.CompositeView

        template : '<div class="grid-container">{{buildingname}}</div>'

        childView : UnitTypeView

        childViewContainer : '.grid-container'

        initialize:->
            console.log @model.get 'units'
            @collection = @model.get 'units'




    class ScreenTwoView extends Marionette.CompositeView


        childView : UnitTypeChildView







