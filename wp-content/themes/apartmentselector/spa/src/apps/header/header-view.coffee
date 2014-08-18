define [ 'marionette' ], ( Mariontte )->


    class HeaderView extends Marionette.ItemView

        template : '<div class="backBtn {{textClass}}">
                        <a  class="back text-white"><span class="glyphicon glyphicon-chevron-left "></span></a>
        		    </div>

                    <div class="rightBtns">
                        <a  id="showTop" class="text-white"><span class="glyphicon glyphicon-filter"></span></a>
                        <a id="showRightPush" class="text-white"><span class="glyphicon glyphicon-user"></span></a>
                    </div>

                    <div class="text-center">
                        <h5 class="text-white m-t-20 bold text-uppercase"><span class="slctnTxt">Your selection:</span> {{textString}} </h3>
                    </div>

                    '

        className : "header navbar navbar-inverse"



        events:
            'click .back':(e)->
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
                    console.log App.layout.screenThreeRegion.el.innerHTML = ""
                    msgbus.showApp 'screen:two'
                    .insideRegion  App.layout.screenTwoRegion
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
                    console.log App.layout.screenFourRegion.el.innerHTML = ""
                    msgbus.showApp 'screen:three'
                    .insideRegion  App.layout.screenThreeRegion
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
                    console.log App.layout.screenTwoRegion.el.innerHTML = ""
                    msgbus.showApp 'screen:one'
                    .insideRegion  App.layout.screenOneRegion
                        .withOptions()

            




        onShow:->
            $(window).scroll( ()->
                height = $(window).scrollTop()
                if height == 0
                    $('.backBtn').addClass 'hidden'
                    $('.slctnTxt').addClass 'hidden'
                    $('h3').addClass 'step1'





            )

            disableOther = (button) ->
              classie.toggle showTop, "disabled"  if button isnt "showTop"
              classie.toggle showRightPush, "disabled"  if button isnt "showRightPush"
              return
            menuRight = document.getElementById("cbp-spmenu-s2")
            menuTop = document.getElementById("cbp-spmenu-s3")
            showTop = document.getElementById("showTop")
            showRightPush = document.getElementById("showRightPush")
            body = document.body
            showTop.onclick = ->
              classie.toggle this, "active"
              classie.toggle menuTop, "cbp-spmenu-open"
              disableOther "showTop"
              return

            showRightPush.onclick = ->
              classie.toggle this, "active"
              classie.toggle body, "cbp-spmenu-push-toleft"
              classie.toggle menuRight, "cbp-spmenu-open"
              disableOther "showRightPush"
              return


            if window.location.href.indexOf('screen-two') > -1 || window.location.href.indexOf('screen-three') > -1 || window.location.href.indexOf('screen-four') > -1

            else
                $('.backBtn').addClass 'hidden'
                $('.slctnTxt').addClass 'hidden'
                $('h3').addClass 'step1


                       '

                



