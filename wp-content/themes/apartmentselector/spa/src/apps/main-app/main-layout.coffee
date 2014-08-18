define [ 'extm'], ( Extm)->

    # Main controller
    class MainController extends Extm.RegionController

        initialize : ->

            @layout = layout = @_getView()

            App.layout = @layout

            #listen to show event of layout to trigger sub apps
            @listenTo layout, 'show', @showRegionViews

            #show the layout
            @show layout

        showRegionViews: =>
            App.filter(params={})
            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions()

            msgbus.showApp 'screen:one'
            .insideRegion  @layout.screenOneRegion
                .withOptions()

        _getView: =>
            new mainView


    class mainView extends Marionette.LayoutView

        template: '
        <nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-right" id="cbp-spmenu-s2">
            <h3>My Menu</h3>
            <ul>
                <li><a href="#"><span class="glyphicon glyphicon-star"></span> Wishlist</a>
                    <ul class="menuWishlist">
                        <li><a href="#">Wishlist 1</a></li>
                        <li><a href="#">Wishlist 2</a></li>
                    </ul>
                </li>
            </ul>
        </nav>

        <nav class="cbp-spmenu cbp-spmenu-horizontal cbp-spmenu-top" id="cbp-spmenu-s3">
            <div class="row m-l-0 m-r-0">
                <div class="col-md-2">
                    <h3>Additional Filters</h3>
                </div>
                <div class="col-md-8 b-l b-r b-grey">
                    <div class="filterBox">
                        <input type="checkbox" name="fliter1" id="fliter1" class="checkbox" value="0"/>
                        <label for="fliter1">Filter 1</label>
                    </div>
                    <div class="filterBox">
                        <input type="checkbox" name="fliter2" id="fliter2" class="checkbox" value="0"/>
                        <label for="fliter2">Filter 2</label>
                    </div>
                    <div class="filterBox">
                        <input type="checkbox" name="fliter3" id="fliter3" class="checkbox" value="0"/>
                        <label for="fliter3">Filter 3</label>
                    </div>
                    <div class="filterBox">
                        <input type="checkbox" name="fliter4" id="fliter4" class="checkbox" value="0"/>
                        <label for="fliter4">Filter 4</label>
                    </div>
                    <div class="filterBox">
                        <input type="checkbox" name="fliter5" id="fliter5" class="checkbox" value="0"/>
                        <label for="fliter5">Filter 5</label>
                    </div>
                    <div class="filterBox">
                        <input type="checkbox" name="fliter6" id="fliter6" class="checkbox" value="0"/>
                        <label for="fliter6">Filter 6</label>
                    </div>
                    <div class="filterBox">
                        <input type="checkbox" name="fliter7" id="fliter7" class="checkbox" value="0"/>
                        <label for="fliter7">Filter 7</label>
                    </div>
                    <div class="filterBox">
                        <input type="checkbox" name="fliter8" id="fliter8" class="checkbox" value="0"/>
                        <label for="fliter8">Filter 8</label>
                    </div>
                    <div class="filterBox">
                        <input type="checkbox" name="fliter9" id="fliter9" class="checkbox" value="0"/>
                        <label for="fliter9">Filter 9</label>
                    </div>
                    <div class="filterBox">
                        <input type="checkbox" name="fliter10" id="fliter10" class="checkbox" value="0"/>
                        <label for="fliter10">Filter 10</label>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="col-md-2">
                    <a href="#" class="btn btn-primary m-t-20 m-b-10" id="">Apply</a>
                </div>
            </div>
        </nav>

        <div id="screen-one-region" >

        </div>
        <div id="screen-two-region" >

        </div>
        <div id="screen-three-region" >

        </div>
        <div id="screen-four-region" >

        </div>'

        regions:
            screenOneRegion: '#screen-one-region'
            screenTwoRegion: '#screen-two-region'
            screenThreeRegion: '#screen-three-region'
            screenFourRegion: '#screen-four-region'


        onShow:->
            console.log height = $(window).scrollTop()

            $(window).scroll( ()->
                height = $(window).scrollTop()
                if height < 300
                    $('.backBtn').addClass 'hidden'
                    $('.slctnTxt').addClass 'hidden'

                else
                    $('.backBtn').removeClass 'hidden'
                    $('.slctnTxt').removeClass 'hidden'







            )




    msgbus.registerController 'main:app', MainController