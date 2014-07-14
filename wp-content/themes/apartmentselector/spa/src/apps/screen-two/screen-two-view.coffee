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

        template : '<div class="grid-container"><div class="grid-block-1"><a  id="data1" class="grid-link"  data-value="0" >
                                            Low
                                         </a></div>
                                         <div class="grid-block-1"><a   id="data2" class="grid-link"  data-value="1" >
                                                    Medium
                                                 </a></div>
                                                 <div class="grid-block-1"><a  id="data3" class="grid-link"  data-value="2" >
                                                    High
                                                 </a></div></div><button type="button"  name="submit" id="submit" value="submit" ></button>'


        childView : UnitTypeChildView


        events:
            'click .grid-link' : 'imageslider'


        imageslider:(e)->
            myArray = Array()
            img_val = $("#"+e.target.id).attr( 'data-value' )
            images = [
                'http://farm4.static.flickr.com/3219/2431886567_c92821aede_o.jpg',
                'http://farm1.static.flickr.com/37/85684217_526797a103_o.jpg',
                'http://farm5.static.flickr.com/4080/4906820567_63fb82fa85_b.jpg',

            ]
            q = img_val
            w = 0
            console.log images.length
            while w < 2
                if images.length == q
                    q =0
                myArray.push images[q]
                w++
                q++


            console.log myArray
            $.preload(myArray, 2, (last)->
                console.log this.length
                i = 0



                while i < this.length
                        $('<img height="200" src="' +this[i] + '" alt="" />').appendTo('body')
                        i++


                if (last)
                    console.log "aaa"
            )







