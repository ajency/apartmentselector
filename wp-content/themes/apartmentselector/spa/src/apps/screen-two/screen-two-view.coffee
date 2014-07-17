define [ 'extm','marionette' ], (Extm, Marionette )->
    class UnitTypeView extends Marionette.ItemView

        template : '<section id="tower1">
        							<div class="vs-content">
        								<div class="text-center">
        										<div class="flatNos">05</div>
        								</div>
        								<div class="text-center">
        										<div class="flatNos">05</div>
        								</div>
        								<div class="text-center">
        										<div class="flatNos">05</div>
        								</div>
        							</div>
        						</section>'

        events :
            'click '   : 'typeOfUnitSelected'

        typeOfUnitSelected :(evt)->
            evt.preventDefault()

            @trigger 'type:unit:clicked', @model.get('buildingid') , @model.get('unitType'),@model.get('range')


    class UnitTypeChildView extends Marionette.CompositeView

        template : '<a href="#tower1">{{buildingname}}</a>'

        tagName : 'ul'

        clasName : 'vs-nav'

        initialize:->
            console.log @model.get 'units'
            @collection = @model.get 'units'








    class ScreenTwoView extends Marionette.LayoutView

        template : '<h3 class="text-center introTxt">We have <span class="bold">100 options</span> for 1BHK <br><small>Just select your floors to get started</small></h3>
        <div class="towerTable"><div class="tableHeader">
        				<ul>
        					<li><a href="#modal"><span class="bold">HIGHRISE</span><br>15-11 Floors</a></li>
        					<li><a href="#modal"><span class="bold">MIDRISE</span><br>15-11 Floors</a></li>
        					<li><a href="#modal"><span class="bold">LOWRISE</span><br>15-11 Floors</a></li>
        				</ul>
        			</div><div class="tableBody">
        				<div id="vs-container2" class="vs-container">
        					<header class="vs-header"></header>
        						<ul class="vs-nav" id="building-region"></ul><div id="unit-region" class="vs-wrapper"></div></div></div>'




        className : 'page-container row-fluid'

        regions :
            buildingRegion : '#building-region'
            unitRegion : '#unit-region'


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














