define [ 'marionette' ], ( Mariontte )->


    class PopupView extends Marionette.ItemView

        template : '<div class="remodal towerPopup" data-remodal-id="modal">
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

        events:
            'click a':(e)->
                console.log e
                e.preventDefault()
            'click .remodal-close':(e)->
                console.log "aaaaaaaaaaaa"
                App.filter(params={})
                msgbus.showApp 'header'
                .insideRegion  App.headerRegion
                    .withOptions()
                msgbus.showApp 'screen:two'
                .insideRegion  App.mainRegion
                    .withOptions()



        onShow:->
            instance = $('.remodal.towerPopup').remodal()
            if (instance)
                instance.open()

            $('.remodal-close').click( (e)->
                console.log e
                e.preventDefault()
                App.navigate 'screen-two'
                App.filter(params={})
                msgbus.showApp 'header'
                .insideRegion  App.headerRegion
                    .withOptions()
                msgbus.showApp 'screen:two'
                .insideRegion  App.mainRegion
                    .withOptions()


            )





















