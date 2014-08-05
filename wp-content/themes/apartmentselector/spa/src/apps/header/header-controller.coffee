define [ 'extm', 'src/apps/header/header-view' ], ( Extm, HeaderView )->

    class HeaderController extends Extm.RegionController

        initialize :(opt = {})->

            @model = @_getHeader()

            @view = view = @_getHeaderView @model

            @show view


        _getHeaderView:(model)->
            new HeaderView
                templateHelpers :
                    textString : model[0]
                    textClass : model[1]


        _getHeader:->
            templateArr = []
            flag = 0
            myArray = []
            templateArr = []
            param = {}
            paramkey = {}
            flag = 0
            track = 0
            trackArray = []
            units = App.master.unit
            $.map(App.defaults, (value, index)->
                if value!='All'
                    myArray.push({key:index,value:value})

            )
            $.each(myArray, (index,value)->
                if(value.value !='All')
                    console.log value.key
                    param[value.key] = value.value
                    string_val = _.isString(value.value)
                    valuearr = ""
                    if string_val == true
                        valuearr = value.value.split(',')
                    if valuearr.length > 1
                        for element  in valuearr
                            if value.key == 'unitType'
                                key = App.master.unit_type.findWhere({id:parseInt(element)})
                                templateArr.push key.get 'name'
                            if value.key == 'unitVariant'
                                key = App.master.unit_variant.findWhere({id:parseInt(element)})
                                templateArr.push key.get 'name'
                            if value.key == 'building'
                                key = App.master.building.findWhere({id:parseInt(element)})
                                templateArr.push key.get 'name'
                            if value.key == 'budget'
                                budget_Val = value+'lakhs'
                                templateArr.push budget_Val
                            if value.key == 'floor'
                                if track == 0
                                    trackArray.push value.value
                                flag = 1
                                track = 1
                    else
                        if value.key == 'unitType'
                            key = App.master.unit_type.findWhere({id:parseInt(value.value)})
                            templateArr.push key.get 'name'
                        if value.key == 'unitVariant'
                            key = App.master.unit_variant.findWhere({id:parseInt(value.value)})
                            templateArr.push key.get 'name'
                        if value.key == 'building'
                            key = App.master.building.findWhere({id:parseInt(value.value)})
                            templateArr.push key.get 'name'
                        if value.key == 'budget'
                            budget_Val = value.value
                            templateArr.push budget_Val
                        if value.key == 'floor'
                            if track == 0
                                trackArray.push value.value
                            flag = 1
                            track = 1




            )
            textClass = "hidden"
            if window.location.href.indexOf('screen-two') > -1 || window.location.href.indexOf('screen-three') > -1 || window.location.href.indexOf('screen-four') > -1
                textClass = ""
            console.log templateArr
            if templateArr.length == 0
                templateArr.push 'All'

            if(flag==1)
                first = _.first(trackArray)
                lowUnits = App.master.range.findWhere({name:'low'})
                if parseInt(first) >= lowUnits.get('start') &&  parseInt(first) <= lowUnits.get 'end'
                    range = 'LOWRISE'
                    templateArr.push range



                mediumUnits = App.master.range.findWhere({name:'medium'})
                if parseInt(first) >= mediumUnits.get('start') &&  parseInt(first) <= mediumUnits.get 'end'
                    range = 'MIDRISE'
                    templateArr.push range


                highUnits = App.master.range.findWhere({name:'high'})
                if parseInt(first) >= highUnits.get('start') &&  parseInt(first) <= highUnits.get 'end'
                    range = 'HIGHRISE'
                    templateArr.push range
                templateString  = templateArr.join('|')

            else
                templateString  = templateArr.join('|')

            [templateString,textClass]



    msgbus.registerController 'header', HeaderController