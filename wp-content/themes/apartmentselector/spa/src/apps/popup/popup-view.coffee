define [ 'marionette' ], ( Mariontte )->


    class PopItemview extends Marionette.ItemView

        template : ' <ul>
        							<li class="unitName">
        								<div class="small"> Tower 1</div>{{name}}
        							</li>
        						</ul>

        						<!--BHK-->
        						<ul>
        							<li>
        								{{unitTypeName}}
        							</li>
        						</ul>

        						<!--Floor Info-->
        						<ul>
        							<li>
        								{{flooRange}}
        							</li>
        							<li>
        								{{floor}}
        							</li>
        						</ul>

        						<!--View Info-->
        						<ul>
        							<li>
        								SE
        							</li>
        							<li>
        								Lake
        							</li>
        						</ul>

        						<!--Area-->
        						<ul>
        							<li>
        								684
        							</li>
        							<li>
        								{{sellablearea}}
        							</li>
        							<li>
        								{{carpetarea}}
        							</li>
        						</ul>'

        className : 'cd-table-column'



    class PopupView extends Marionette.CompositeView

        template : '<div id="cd-table" class="compareWishlist">

                       			<header class="cd-table-column">
                				<ul>
                					<li class="noBG unitName">

                					</li>
                				</ul>
                				<ul>
                					<li>
                						BHK
                					</li>
                				</ul>
                				<div class="compareHeader"><span class="sky-flag"></span> Floor Info </div>
                				<ul>
                					<li>
                						Floor Range
                					</li>
                					<li>
                						Floor
                					</li>
                				</ul>
                				<div class="compareHeader"><span class="sky-location"></span> View Info</div>
                				<ul>
                					<li>
                						Facing
                					</li>
                					<li>
                						Views
                					</li>
                				</ul>
                				<div class="compareHeader"><span class="sky-maximize"></span> Area <small>(Sq. Ft.)</small></div>
                				<ul>
                					<li>
                						Total Area
                					</li>
                					<li>
                						Chargeable Area
                					</li>
                					<li>
                						Carpet Area
                					</li>
                				</ul>
                			</header>
                			<div class="cd-table-container">
        				<div class="cd-table-wrapper"></div></div></div><em class="cd-scroll-right"></em>'

        childView  : PopItemview

        childViewContainer : '.cd-table-wrapper'

        className : 'page-container row-fluid'

        events:
            'click a':(e)->
                e.preventDefault()

























