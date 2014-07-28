define [ 'marionette' ], ( Mariontte )->


    class HeaderView extends Marionette.ItemView

        template : '<div class="backBtn {{textClass}}">
        			<a  class="text-white"><span class="glyphicon glyphicon-chevron-left "></span></a>
        		</div>
        <div class="text-center">
        			<h3 class="text-white m-t-15 selearr">{{textString}}</h3>
        		</div>'

        className : "header navbar navbar-inverse"



        events:
            'click .text-white':(e)->
                if window.location.href.indexOf('screen-three') > -1
                    App.defaults['floor'] = 'All'
                    key = App.defaults.hasOwnProperty(App.screenOneFilter['key'])
                    if key == true
                        App.defaults[App.screenOneFilter['key']] = App.screenOneFilter['value']

                    App.navigate "screen-two"
                    e.preventDefault()
                    App.filter(params={})
                    msgbus.showApp 'header'
                    .insideRegion  App.headerRegion
                        .withOptions()
                    msgbus.showApp 'screen:two'
                    .insideRegion  App.mainRegion
                        .withOptions()
                else
                    App.navigate ""
                    App.defaults['floor'] = 'All'
                    e.preventDefault()
                    App.filter(params={})
                    msgbus.showApp 'header'
                    .insideRegion  App.headerRegion
                        .withOptions()
                    msgbus.showApp 'screen:one'
                    .insideRegion  App.mainRegion
                        .withOptions()




        onShow:->
            if window.location.href.indexOf('screen-two') > -1 || window.location.href.indexOf('screen-three') > -1

            else
                $('.backBtn').addClass 'hidden'
                $('.selearr').text 'Apartment Selector'



