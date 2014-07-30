define [ 'extm', 'marionette' ], ( Extm, Marionette )->
    m = ""
    class ScreenTwoLayout extends Marionette.LayoutView

        template : '<div class="text-center introTxt">We have <span class="bold text-primary"> {{unitsCount }} options</span>
                    for {{selection}} </div>
        		<div class="text-center subTxt m-b-10">Just select your floors to get started</div>

        		<div class="legend text-center m-b-20">

       {{#unittypes}}
<span class={{classname}}>.</span>{{name}}
        {{/unittypes}}
        		</div>
                <div class="row m-r-0 m-l-0">
        			<div class="col-sm-7 p-l-0 p-r-0">
                        <div class="towerTable">
                            <div class="tableHeader">
                				<ul>
                					<li><a href="#modal" ><span class="bold">HIGHRISE</span><br>15-11 Floors</a></li>
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

                    </div>

                    <div class="col-sm-5 hidden-xs">
        				<h3 class="bold m-t-0">Climb leg make muffins or sweet</h3>
        				<p>Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs.</p>

        			</div><div id="mapplic1"></div>
                </div><div class="remodal towerPopup" data-remodal-id="modal">
        		<div class="header navbar navbar-inverse ">
        			<!-- <div class="backBtn">
        				<a href="#" class="text-white remodal-close"><span class="glyphicon glyphicon-chevron-left "></span></a>
        			</div> -->
        			<div class="m-t-15">
        				<h4 class="text-white m-t-15">WHAT IS THE FLOOR RISE?</h4>
        			</div>
        		</div>
        		<div id="vs-container" class="vs-container">
        			<header class="vs-header">
        				<ul class="vs-nav">
        					<li><a href="#section-1">HIGHRISE</a></li>
        					<li><a href="#section-2">MIDRISE</a></li>
        					<li><a href="#section-3">LOWRISE</a></li>
        				</ul>
        			</header>
        			<div class="vs-wrapper">
        				<section id="section-1">
        					<div class="vs-content">
        						<div class="row">
        							<div class="col-sm-4 col-xs-9">
        								<img src="assets/img/floor-rise.jpg" class="img-responsive">
        							</div>
        							<div class="col-sm-8 col-xs-3">
        								<div class="row">

       {{#high}}         									<div class="col-sm-4 p-l-0 p-r-0">
        										<h1><small>Total {{name}}</small><br>{{count}}</h1>
        									</div>

       {{/high}}
        								</div>
        								<div class="row">
        									<div class="col-sm-12 hidden-xs m-t-30 p-l-0">
        										<div class="col">
        											<p>Climb leg make muffins or sweet beast play time and hate dog or chew foot. Stretch climb leg. Play time give attitude for all of a sudden go crazy chase imaginary bugs lick butt. Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs. Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.</p>
        										</div>
        									</div>
        								</div>
        								<div class="row">
        									<div class="col-sm-4">
        									</div>
        									<div class="col-sm-4">
        									</div>
        									<div class="col-sm-4">
        									</div>
        								</div>
        							</div>
        							<div class="clearfix visible-xs"></div>
        							<div class="viewsNo m-t-20">
        								<div class="row">
        									<div class="col-xs-4">
        										<h4>
        											NO OF <span class="text-primary bold">VIEWS</span>
        										</H4>
        									</div>
        									<div class="col-xs-4">
        										Garden view<br>
        										Pond View<br>
        										Manas Lake<br>
        										Eco pond
        									</div>
        									<div class="col-xs-4">
        										Garden view<br>
        										Pond View<br>
        										Manas Lake<br>
        										Eco pond
        									</div>
        								</div>
        							</div>
        						</div>
        					</div>
        				</section>
        				<section id="section-2">
        					<div class="vs-content">
        						<div class="row">
        							<div class="col-sm-4 col-xs-9">
        								<img src="assets/img/floor-rise.jpg" class="img-responsive">
        							</div>
        							<div class="col-sm-8 col-xs-3">
        								<div class="row">

       {{#medium}}         									<div class="col-sm-4 p-l-0 p-r-0">
        										<h1><small>Total {{name}}</small><br>{{count}}</h1>
        									</div>
{{/medium}}
        								</div>
        								<div class="row">
        									<div class="col-sm-12 hidden-xs m-t-30 p-l-0">
        										<div class="col">
        											<p>Climb leg make muffins or sweet beast play time and hate dog or chew foot. Stretch climb leg. Play time give attitude for all of a sudden go crazy chase imaginary bugs lick butt. Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs. Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.</p>
        										</div>
        									</div>
        								</div>
        								<div class="row">
        									<div class="col-sm-4">
        									</div>
        									<div class="col-sm-4">
        									</div>
        									<div class="col-sm-4">
        									</div>
        								</div>
        							</div>
        							<div class="clearfix visible-xs"></div>
        							<div class="viewsNo m-t-20">
        								<div class="row">
        									<div class="col-xs-4">
        										<h4>
        											NO OF <span class="text-primary bold">VIEWS</span>
        										</H4>
        									</div>
        									<div class="col-xs-4">
        										Garden view<br>
        										Pond View<br>
        										Manas Lake<br>
        										Eco pond
        									</div>
        									<div class="col-xs-4">
        										Garden view<br>
        										Pond View<br>
        										Manas Lake<br>
        										Eco pond
        									</div>
        								</div>
        							</div>
        						</div>
        					</div>
        				</section>
        				<section id="section-3">
        					<div class="vs-content">
        						<div class="row">
        							<div class="col-sm-4 col-xs-9">
        								<img src="assets/img/floor-rise.jpg" class="img-responsive">
        							</div>
        							<div class="col-sm-8 col-xs-3">
        								<div class="row">

       {{#low}}         									<div class="col-sm-4 p-l-0 p-r-0">
        										<h1><small>Total {{name}}</small><br>{{count}}</h1>
        									</div>
{{/low}}
        								</div>
        								<div class="row">
        									<div class="col-sm-12 hidden-xs m-t-30 p-l-0">
        										<div class="col">
        											<p>Climb leg make muffins or sweet beast play time and hate dog or chew foot. Stretch climb leg. Play time give attitude for all of a sudden go crazy chase imaginary bugs lick butt. Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs. Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.</p>
        										</div>
        									</div>
        								</div>
        								<div class="row">
        									<div class="col-sm-4">
        									</div>
        									<div class="col-sm-4">
        									</div>
        									<div class="col-sm-4">
        									</div>
        								</div>
        							</div>
        							<div class="clearfix visible-xs"></div>
        							<div class="viewsNo m-t-20">
        								<div class="row">
        									<div class="col-xs-4">
        										<h4>
        											NO OF <span class="text-primary bold">VIEWS</span>
        										</H4>
        									</div>
        									<div class="col-xs-4">
        										Garden view<br>
        										Pond View<br>
        										Manas Lake<br>
        										Eco pond
        									</div>
        									<div class="col-xs-4">
        										Garden view<br>
        										Pond View<br>
        										Manas Lake<br>
        										Eco pond
        									</div>
        								</div>
        							</div>
        						</div>
        					</div>
        				</section>
        			</div>
        		</div><!-- /vs-container -->
        	</div>'




        className : 'page-container row-fluid'




        regions :
            buildingRegion : '#building-region'
            unitRegion : '#unit-region'

        events:
            'click a':(e)->
                e.preventDefault()

            'click .towerPopup':->
                console.log "remodal"


            #if App.defaults['budget'] != 'All'



        onShow:->

            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/main2.js'
            document.body.appendChild(scr)
            scr = document.createElement('script')
            scr.src = '../wp-content/themes/apartmentselector/js/src/preload/jquery.remodal.js'
            document.body.appendChild(scr)


            i = 1
            while (window['mapplic' + i] != undefined)
                params = window['mapplic' + i]
                selector = '#mapplic' + i
                ajaxurl = AJAXURL
                $(selector).mapplic(
                    'id': 4,
                    'width': params.width,
                    'height': params.height


                )



                i++;

            m  = $('#mapplic1').data('mapplic')
















    class BuildingView extends Marionette.ItemView

        template : '<a class="link" href="tower{{id}}">{{name}}</a>'

        tagName : 'li'

        events:
            'click .link':->
                #m = mapplic()
                #m  = $('#mapplic1').data('mapplic')
                id = 'tower'+@model.get('id')
                i =1
                params = window['mapplic' + i]
                selector = '#mapplic' + i

                #m.initial($(selector),params)
                m.showLocation(id, 800)
                #locationData = m.getLocationData(id);
                #m.showTooltip(locationData);
                #App.navigate "tower"+@model.get('id') , trigger:true







    class UnitTypeChildView extends Marionette.CompositeView

        tagName : 'ul'


        className : 'vs-nav'



        childView : BuildingView

        onShow:->
            model = @collection.at(0)

            id = 'tower'+model.get('id')
            #m.showLocation(id, 800)

            #App.navigate "tower"+model.get('id') , trigger:true






    class UnitViewChildView extends Marionette.ItemView

        template : '<div class="flatNos">{{name}}</div>
                            </div>'

        className : 'text-center'


        events:
            'click .flatNos':(e)->
                param = {}
                param['name'] = @model.get 'range'
                rangeModel = App.currentStore.range.findWhere(param)
                rangeArray = []
                i = 0
                start = rangeModel.get('start')
                end = rangeModel.get('end')
                while parseInt(start) <= parseInt(end)
                    rangeArray[i] = start
                    start = parseInt(start) + 1
                    i++
                rangeArray
                rangeString = rangeArray.join(',')


                App.defaults['floor'] = rangeString
                App.backFilter['screen2'].push 'floor'
                App.building['name'] = parseInt(@model.get 'buildingid')
                @trigger 'unit:count:selected'






    class UnitView extends Marionette.CompositeView

        template : '<div class="vs-content"></div><div class="towerDetails">

        										<div class="row">
        											{{#unittypes}}         		<div class="col-xs-4">
                							<h1><small>Total {{name}}</small><br>{{count}}</h1>
                						    </div>
        {{/unittypes}}
        										</div>
        										<div class="row">
        											<div class="col-sm-12 m-t-10">
        												<div class="col">
        													<p>Climb leg make muffins or sweet beast play time and hate dog or chew foot. Stretch climb leg. Play time give attitude for all of a sudden go crazy chase imaginary bugs lick butt. Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs. Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.</p>
        												</div>
        											</div>
        										</div>
        									</div>'



        tagName : 'section'



        childView : UnitViewChildView


        childViewContainer : '.vs-content'





        initialize :->
            @collection = @model.get 'units'
            @$el.prop("id", 'tower'+@model.get("buildingid"))






    class UnitTypeView extends Marionette.CompositeView




        childView : UnitView

        className : "vs-wrapper"




    ScreenTwoLayout : ScreenTwoLayout
    UnitTypeChildView : UnitTypeChildView
    UnitTypeView : UnitTypeView


















