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

        template : '<div id="vs-container" class="vs-container">
                    <header class="vs-header">
                        <h1>Sliding Triple View Layout <span>with Visible Adjoining Sections</span></h1>
                        <ul class="vs-nav">
                            <li><a id="data0" class="image" href="#section-0" data-value="0">Low</a></li>
                            <li><a id="data1" class="image"  href="#section-1" data-value="1">Medium</a></li>
                            <li><a id="data2" class="image" href="#section-2" data-value="2">High</a></li>

                        </ul>
                    </header><div class="vs-wrapper">
                <section id="section-0">
                    <div id="content0" class="vs-content">
                        <!-- content -->
                    </div>
                </section>
                <section id="section-1"><div id="content1" class="vs-content">
                                <!-- content -->
                            </div></section>
                <section id="section-2"><div id="content2" class="vs-content">
                                <!-- content -->
                            </div></section>
                <!-- ... -->
            </div>'


        childView : UnitTypeChildView


        events:
            'click .image' : 'imageslider'


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
            while w < 1
                if images.length == q
                    q =0
                myArray.push images[q]
                w++
                q++


            $.preload(myArray, 1, (last)->
                i = 0



                while i < this.length
                    $('<img height="200" src="' +this[i] + '" alt="" />').appendTo('div#content'+img_val)
                    i++


                if (last)
                    console.log "aaa"
            )







