define [ 'extm'], ( Extm)->

    # Main controller
    view = []
    facing = []
    facingnames = []
    viewnames = []
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
                templateHelpers:
                    SITEURL : SITEURL
                    VIEWS : VIEWS
                    FACINGS : FACINGS


    class mainView extends Marionette.LayoutView

        template: '

        <nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-right" id="cbp-spmenu-s2">
            <h3>My Menu</h3>
            <ul>
                <li ><a href="#"><span class="glyphicon glyphicon-heart"></span> Wishlist</a>
                    <ul class="menuWishlist" id="showWishlist">
                        <li><a href="#">Wishlist 1</a></li>
                        <li><a href="#">Wishlist 2</a></li>
                    </ul>
                </li>
            </ul>
            <a href="#" id="compare" >Compare</a>
        </nav>

        <nav class="cbp-spmenu cbp-spmenu-horizontal cbp-spmenu-top" id="cbp-spmenu-s3">
            <div class="row m-l-0 m-r-0">
                <div class="col-sm-3">
                    <!--<h3>Additional Filters</h3>-->
                    <div class="small blockTitle">Select Position</div>
                    <div id="mainsvg"><label id="floorText">Floormap can be selected only on screen three</label></div>
                </div>
                <div class="col-sm-3 b-l b-r b-grey">
                    <div class="small blockTitle">Select View</div>

                    {{#VIEWS}}
                     <div class="filterBox">
                        <input type="checkbox" name="view{{id}}" data-name="{{name}}" id="view{{id}}" class="checkbox view" value="{{id}}"/>
                        <label for="view{{id}}">{{name}}</label>
                    </div>
                     {{/VIEWS}}
                    <div class="clearfix"></div>
                </div>
                <div class="col-sm-3 b-r b-grey">
                    <div class="small blockTitle">Select Facing</div>

                    {{#FACINGS}}
                     <div class="filterBox">
                        <input type="checkbox" name="facing{{id}}" data-name="{{name}}" id="facing{{id}}" class="checkbox facing" value="{{id}}"/>
                        <label for="facing{{id}}">{{name}}</label>
                    </div>
                    {{/FACINGS}}
                    <div class="clearfix"></div>
                </div>
                <div class="col-sm-3 summaryBox">
                    <div class="small blockTitle">Option Selected</div>
                    <div class="section">
                        <div class="small">Position</div>
                        5
                    </div>
                    <div class="section">
                        <div class="small" >View</div>
                        <span id="viewName"></span>
                    </div>
                    <div class="section">
                        <div class="small" >Facing</div>
                        <span id="facingName"></span>
                    </div>
                    
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
            'click .view':(e)->
                viewString = 'All'
                if $('#'+e.target.id).prop('checked') == true
                    view.push $('#'+e.target.id).val()
                    viewnames.push $('#'+e.target.id).attr('data-name')
                else
                    console.log index = view.indexOf(($('#'+e.target.id).val()))
                    if index != -1
                        view.splice( index, 1 )
                        viewnames.splice( index, 1 )
                if view.length != 0
                    viewString = view.join(',')
                App.defaults['view'] = viewString
                $('#viewName' ).text  viewnames.join(',')
                console.log App.defaults
                #App.filter(params={})

            'click .facing':(e)->
                facingString = 'All'
                console.log $('#'+e.target.id)
                if $('#'+e.target.id).prop('checked') == true
                    facing.push $('#'+e.target.id).val()
                    facingnames.push $('#'+e.target.id).attr('data-name')
                else
                    console.log index = facing.indexOf(($('#'+e.target.id).val()))
                    if index != -1
                        facing.splice( index, 1 )
                        facingnames.splice( index, 1 )
                if facing.length != 0
                    facingString = facing.join(',')
                App.defaults['facing'] = facingString
                $('#facingName' ).text facingnames.join(',')
                console.log App.defaults
                #App.filter(params={})



            'click #compare':(e)->
                console.log $.cookie("key")
                win = window.open(SITEURL+"/wishlist/#wishList", '_blank')
                win.focus()
                menuRight = document.getElementById("cbp-spmenu-s2")
                menuTop = document.getElementById("cbp-spmenu-s3")
                showTop = document.getElementById("showTop")
                showRightPush = document.getElementById("showRightPush")
                body = document.body
                classie.toggle showRightPush, "active"
                classie.toggle body, "cbp-spmenu-push-toleft"
                classie.toggle menuRight, "cbp-spmenu-open"


            'click .del':(e)->
                App.cookieArray = App.cookieArray
                val = $('#'+e.target.id).attr('data-id')
                index = App.cookieArray.indexOf( parseInt(val) )
                App.cookieArray.splice( index, 1 )
                $.cookie('key',App.cookieArray)
                localStorage.setItem("cookievalue", App.cookieArray)
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
                App.unit['name'] = $('#'+e.target.id ).attr('data-id')
                App.unit['flag'] = 1
                unitModel = App.master.unit.findWhere({id:parseInt($('#'+e.target.id ).attr('data-id'))})
                App.defaults['unitType'] = unitModel.get 'unitType'
                App.defaults['building'] =  unitModel.get 'building'
                rangeModel = App.master.range
                App.backFilter['screen3'].push("floor")
                App.backFilter['screen2'].push("floor","unitVariant")
                buildingModel = App.master.building.findWhere({id:unitModel.get 'building'})
                floorriserange = buildingModel.get 'floorriserange'
                #floorriserange = [{"name":"low","start":"1","end":"2"},{"name":"medium","start":"3","end":"4"},{"name":"high","start":"5","end":"6"}]
                object = @
                rangeArrayVal = []
                $.each(floorriserange, (index,value)->
                    rangeArrayVal = []
                    i = 0

                    start = parseInt(value.start)
                    end = parseInt(value.end)
                    while parseInt(start) <= parseInt(end)
                        rangeArrayVal[i] = start
                        start = parseInt(start) + 1
                        i++
                    if jQuery.inArray(parseInt(unitModel.get('floor')),rangeArrayVal) >= 0
                        App.defaults['floor'] = rangeArrayVal.join(',')



                )






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
            cookieOldValue = $.cookie("key")
            if cookieOldValue == undefined || $.cookie("key") == ""
                cookieOldValue = []
            else
                cookieOldValue = $.cookie("key" ).split(',' ).map( (item)->
                    parseInt(item)
                )
            App.cookieArray = cookieOldValue
            localStorage.setItem("cookievalue" , App.cookieArray)
            @showWishList()
        showWishList:->
            table = ""
            if $.cookie("key")!= undefined && $.cookie("key") != ""
                console.log selectedUnitsArray = $.cookie("key").split(",")
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