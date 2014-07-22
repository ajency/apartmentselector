define [ 'extm', 'marionette' ], ( Extm, Marionette )->
    class ScreenTwoLayout extends Marionette.LayoutView

        template : '<div class="text-center introTxt">We have <span class="bold text-primary"> {{unitsCount }} options</span>
                    for {{selection}} </div>
        		<div class="text-center subTxt m-b-10">Just select your floors to get started</div>

        		<div class="legend text-center m-b-20">

       {{#unitType}}
<span class="oneBHK">.</span>{{name}}
        {{/unitType}}
        		</div>
                <div class="row m-r-0 m-l-0">
        			<div class="col-sm-7 p-l-0 p-r-0">
                        <div class="towerTable">
                            <div class="tableHeader">
                				<ul>
                					<li><a href="#modal"><span class="bold">HIGHRISE</span><br>15-11 Floors</a></li>
                					<li><a href="#modal"><span class="bold">MIDRISE</span><br>10-6 Floors</a></li>
                					<li><a href="#modal"><span class="bold">LOWRISE</span><br>5-1 Floors</a></li>
                				</ul>
                		    </div>
                            <div class="tableBody">
                				<div id="vs-container2" class="vs-container">
                				<header class="vs-header" id="building-region"></header>
                				    <div id="unit-region"></div>
                                </div>
                            </div>
                        </div>
                        <div class="towerDetails">
        					<div class="row">
        						<div class="col-sm-12">
        							<img src="assets/img/towerA.jpg" class="img-responsive">
        						</div>
        					</div>
        					<div class="row">

       {{#unitType}}         						<div class="col-xs-4">
        							<h1><small>Total {{name}}</small><br>{{count}}</h1>
        						</div>
{{/unitType}}
        					</div>
        					<div class="row">
        						<div class="col-sm-12 m-t-10">
        							<div class="col">
        								<p>Climb leg make muffins or sweet beast play time and hate dog or chew foot. Stretch climb leg. Play time give attitude for all of a sudden go crazy chase imaginary bugs lick butt. Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs. Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.</p>
        							</div>
        						</div>
        					</div>
        				</div>
                    </div>

                    <div class="col-sm-5 hidden-xs">
        				<h3 class="bold m-t-0">Climb leg make muffins or sweet</h3>
        				<p>Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs.</p>
        				<img src="../../../.../../../HTML/assets/img/map1.jpg" class="img-responsive m-t-20">
        			</div>
                </div>'




        className : 'page-container row-fluid'




        regions :
            buildingRegion : '#building-region'
            unitRegion : '#unit-region'

        onShow:->
            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/spa/src/bower_components/preload/main2.js'
            document.body.appendChild(scr);


    class BuildingView extends Marionette.ItemView

        template : '<a class="link" href="tower{{id}}">{{name}}</a>'

        tagName : 'li'

        events :
            'click .link' : ( e )->
                console.log @model.get 'id'
                $( '#tower'+@model.get 'id' ).removeClass 'hidden'


    class UnitTypeChildView extends Marionette.CompositeView

        tagName : 'ul'


        className : 'vs-nav'



        childView : BuildingView



        onShow : ->
            console.log "aaaaaaaaaaaaa"


    class UnitViewChildView extends Marionette.ItemView

        template : '
                            <div class="flatNos">{{name}}</div>
                            </div>



                    '

        className : 'text-center'


        events:
            'click .vs-content':(e)->
                console.log @model.get 'buildingid'






    class UnitView extends Marionette.CompositeView

        template : '<div class="vs-content"></div>'



        tagName : 'section'



        childView : UnitViewChildView


        childViewContainer : '.vs-content'





        initialize :->
            @model.get 'units'
            @$el.prop("id", 'tower'+@model.get("buildingid"))


        onShow : ->
            console.log @model
            $("#tower1" ).removeClass 'hidden'


    class UnitTypeView extends Marionette.CompositeView




        childView : UnitView

        className : "vs-wrapper"

        initialize : ->
            tower = @collection.at( 0 )
            $( "#tower"+tower.get('id') ).show()


    ScreenTwoLayout : ScreenTwoLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView


















