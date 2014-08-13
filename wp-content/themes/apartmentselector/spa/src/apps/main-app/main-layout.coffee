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

        template: '<div id="screen-one-region" >

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