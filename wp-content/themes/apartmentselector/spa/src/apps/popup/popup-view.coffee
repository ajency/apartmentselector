define [ 'marionette' ], ( Mariontte )->


    class PopItemview extends Marionette.ItemView

        template : ' <ul>
        							<li class="unitName">
        								{{name}}<span class="small"> T1</span>
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
                					<li class="noBG">

                					</li>
                				</ul>
                				<ul>
                					<li>
                						BHK
                					</li>
                				</ul>
                				<div class="compareHeader"><span class="sky-location"></span> Floor Info </div>
                				<ul>
                					<li>
                						Floor Range
                					</li>
                					<li>
                						Floor
                					</li>
                				</ul>
                				<div class="compareHeader"><span class="sky-milestone"></span> View Info</div>
                				<ul>
                					<li>
                						Facing
                					</li>
                					<li>
                						Views
                					</li>
                				</ul>
                				<div class="compareHeader"><span class="sky-mirror"></span> Area <small>(Sq. Ft.)</small></div>
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

        events:
            'click a':(e)->
                e.preventDefault()

























