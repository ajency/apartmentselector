define [ 'marionette' ], ( Mariontte )->


    class HeaderView extends Marionette.ItemView

        template : '<div class="backBtn {{textClass}}">
                        <a  class="text-white"><span class="glyphicon glyphicon-chevron-left "></span></a>
        		    </div>
                    <div class="text-center">
                        <h5 class="text-white m-t-20 bold text-uppercase"><span class="slctnTxt">Your selection:</span> {{textString}} </h3>
                    </div>'

        className : "header navbar navbar-inverse"



        events:
            'click .text-white':(e)->
                if window.location.href.indexOf('screen-three') > -1
                    App.backFilter['screen3'] = []
                    screentwoArray  = App.backFilter['screen2']
                    for element in screentwoArray
                        key = App.defaults.hasOwnProperty(element)
                        if key == true
                            App.defaults[element] = 'All'
                    console.log UNITS
                    App.currentStore.unit.reset UNITS
                    App.currentStore.building.reset BUILDINGS
                    App.currentStore.unit_type.reset UNITTYPES
                    App.currentStore.unit_variant.reset UNITVARIANTS
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
                else if window.location.href.indexOf('screen-four') > -1
                    console.log App.backFilter['screen3']
                    screenthreeArray  = App.backFilter['screen3']
                    for element in screenthreeArray
                        key = App.defaults.hasOwnProperty(element)
                        if key == true
                            App.defaults[element] = App.defaults['floor']
                    console.log App.defaults
                    App.currentStore.unit.reset UNITS
                    App.currentStore.building.reset BUILDINGS
                    App.currentStore.unit_type.reset UNITTYPES
                    App.currentStore.unit_variant.reset UNITVARIANTS
                    App.navigate "screen-three"
                    e.preventDefault()
                    App.filter(params={})
                    msgbus.showApp 'header'
                    .insideRegion  App.headerRegion
                        .withOptions()
                    msgbus.showApp 'screen:three'
                    .insideRegion  App.mainRegion
                        .withOptions()



                else
                    App.backFilter['screen2'] = []
                    screenoneArray  = App.backFilter['screen1']
                    myArray = []
                    $.map(App.defaults, (value, index)->
                        if value!='All' && index != 'floor'
                            myArray.push({key:index,value:value})

                    )
                    for element in myArray
                            App.defaults[element.key] = 'All'



                    App.currentStore.unit.reset UNITS
                    App.currentStore.building.reset BUILDINGS
                    App.currentStore.unit_type.reset UNITTYPES
                    App.currentStore.unit_variant.reset UNITVARIANTS
                    App.navigate ""


                    console.log App.defaults

                    e.preventDefault()
                    App.filter(params={})
                    msgbus.showApp 'header'
                    .insideRegion  App.headerRegion
                        .withOptions()
                    msgbus.showApp 'screen:one'
                    .insideRegion  App.mainRegion
                        .withOptions()




        onShow:->
            if window.location.href.indexOf('screen-two') > -1 || window.location.href.indexOf('screen-three') > -1 || window.location.href.indexOf('screen-four') > -1

            else
                $('.backBtn').addClass 'hidden'
                $('.slctnTxt').addClass 'hidden'
                $('h3').addClass 'step1
                '

                



