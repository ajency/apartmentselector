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
                <li ><a href="#"><span class="glyphicon glyphicon-star"></span> Wishlist</a>
                    <ul class="menuWishlist" id="showWishlist">
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

        events:
            'click .del':(e)->
                console.log App.cookieArray = App.cookieArray
                console.log val = $('#'+e.target.id).attr('data-id')
                console.log index = App.cookieArray.indexOf( parseInt(val) )
                App.cookieArray.splice( index, 1 )
                $.cookie('key',App.cookieArray)
                $('#errormsg' ).text ""
                @showWishList()

            'click a':(e)->
                e.preventDefault()
            'click .selectedunit':(e)->
                menuRight = document.getElementById("cbp-spmenu-s2")
                menuTop = document.getElementById("cbp-spmenu-s3")
                showTop = document.getElementById("showTop")
                showRightPush = document.getElementById("showRightPush")
                body = document.body
                classie.toggle showRightPush, "active"
                classie.toggle body, "cbp-spmenu-push-toleft"
                classie.toggle menuRight, "cbp-spmenu-open"
                App.unit['name'] = $('#unit'+e.target.id ).attr('data-id')
                App.unit['flag'] = 1
                unitModel = App.master.unit.findWhere({id:parseInt(e.target.id)})
                App.defaults['unitType'] = unitModel.get 'unitType'
                App.defaults['building'] =  unitModel.get 'building'
                console.log rangeModel = App.master.range
                App.backFilter['screen3'].push("floor")
                App.backFilter['screen2'].push("floor","unitVariant")
                rangeModel.each( (item)->
                    rangeArrayVal = []
                    i = 0
                    start = item.get('start')
                    end = item.get('end')
                    while parseInt(start) <= parseInt(end)
                        rangeArrayVal[i] = parseInt(start)
                        start = parseInt(start) + 1
                        i++
                    console.log jQuery.inArray(parseInt(unitModel.get('floor')),rangeArrayVal)
                    if jQuery.inArray(parseInt(unitModel.get('floor')),rangeArrayVal) >= 0
                        console.log "aaaaaaaaaaa"
                        App.defaults['floor'] = rangeArrayVal.join(',')




                )
                console.log App.defaults
                App.navigate "screen-four"
                msgbus.showApp 'header'
                .insideRegion  App.headerRegion
                    .withOptions()
                msgbus.showApp 'screen:four'
                .insideRegion  App.layout.screenFourRegion
                    .withOptions()






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
            console.log cookieOldValue = $.cookie("key")
            console.log typeof cookieOldValue
            if cookieOldValue == undefined || $.cookie("key") == ""
                cookieOldValue = []
            else
                console.log cookieOldValue = $.cookie("key" ).split(',' ).map( (item)->
                    parseInt(item)
                )
            App.cookieArray = cookieOldValue
            @showWishList()
        showWishList:->
            table = ""
            console.log typeof $.cookie("key")
            if $.cookie("key")!= undefined && $.cookie("key") != ""
                selectedUnitsArray = $.cookie("key").split(",")
                table = "<table>"
                for element in selectedUnitsArray
                    model = App.master.unit.findWhere(id:parseInt(element))
                    unitType = App.master.unit_type.findWhere(id:model.get('unitType'))
                    unitVariant = App.master.unit_variant.findWhere(id:model.get('unitVariant'))
                    building = App.master.building.findWhere(id:model.get('building'))
                    table += '<li><a href="#" id="unit'+element+'" data-id="'+element+'" class="selectedunit">'+model.get('name')+'</a>
                                        <a href="#" class="del" id="'+element+'" data-id="'+element+'"  ></a></li>
                                            <div class="clearfix"></div>'

                table += '</table>'
            console.log table
            $('#showWishlist').html table




    msgbus.registerController 'main:app', MainController