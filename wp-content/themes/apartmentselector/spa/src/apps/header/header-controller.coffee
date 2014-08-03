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
            $.each(App.defaults, (index,value)->
                if(value !='All')

                    string_val = _.isString(value)
                    valuearr = ""
                    if string_val == true
                        valuearr = value.split(',')
                    if valuearr.length > 1
                        for element  in valuearr
                            if index == 'unitType'
                                key = App.currentStore.unit_type.findWhere({id:parseInt(element)})
                                templateArr.push key.get 'name'
                            if index == 'unitVariant'
                                key = App.currentStore.unit_variant.findWhere({id:parseInt(element)})
                                templateArr.push key.get 'name'
                            if index == 'building'
                                key = App.currentStore.building.findWhere({id:parseInt(element)})
                                templateArr.push key.get 'name'
                            if index == 'budget'
                                budget_Val = element+'lakhs'
                                templateArr.push budget_Val
                            if index == 'floor'
                                templateArr.push element
                                flag = 1
                    else
                        if index == 'unitType'
                            key = App.currentStore.unit_type.findWhere({id:parseInt(value)})
                            templateArr.push key.get 'name'
                        if index == 'unitVariant'
                            key = App.currentStore.unit_variant.findWhere({id:parseInt(value)})
                            templateArr.push key.get 'name'
                        if index == 'building'
                            key = App.currentStore.building.findWhere({id:parseInt(value)})
                            templateArr.push key.get 'name'
                        if index == 'budget'
                            budget_Val = value
                            templateArr.push budget_Val
                        if index == 'floor'
                            templateArr.push value
                            flag = 1




            )
            templateString  = templateArr.join(',')
            textString = ""
            if window.location.href.indexOf('screen-two') > -1
                if templateArr.length == 0
                    templateArr.push 'All'
                    templateString  = templateArr.join(',')
                if flag==1
                    first = _.first(templateArr)
                    buildingModel = App.currentStore.building.findWhere({id:App.building['name']})
                    lowUnits = App.currentStore.range.findWhere({name:'low'})
                    if parseInt(first) >= lowUnits.get('start') &&  parseInt(first) <= lowUnits.get 'end'
                        templateString = 'LOWRISE' +',' +buildingModel.get('name')



                    mediumUnits = App.currentStore.range.findWhere({name:'medium'})
                    if parseInt(first) >= mediumUnits.get('start') &&  parseInt(first) <= mediumUnits.get 'end'
                        templateString = 'MIDRISE' +',' +buildingModel.get('name')


                    highUnits = App.currentStore.range.findWhere({name:'high'})
                    if parseInt(first) >= highUnits.get('start') &&  parseInt(first) <= highUnits.get 'end'
                        templateString = 'HIGHRISE'+',' +buildingModel.get('name')

                textString  = 'You have selected '+templateString
                textClass = ''

            else if window.location.href.indexOf('screen-three') > -1
                first = _.first(templateArr)
                mark = ''
                range = "All"

                console.log buildingModel = App.currentStore.building.findWhere({id:App.building['name']})
                if (buildingModel !=undefined)
                    buildingText = buildingModel.get('name')
                    mark = '>'
                else
                    buildingText = ""

                lowUnits = App.currentStore.range.findWhere({name:'low'})
                if parseInt(first) >= lowUnits.get('start') &&  parseInt(first) <= lowUnits.get 'end'
                    range = 'LOWRISE'



                mediumUnits = App.currentStore.range.findWhere({name:'medium'})
                if parseInt(first) >= mediumUnits.get('start') &&  parseInt(first) <= mediumUnits.get 'end'
                    range = 'MIDRISE'


                highUnits = App.currentStore.range.findWhere({name:'high'})
                if parseInt(first) >= highUnits.get('start') &&  parseInt(first) <= highUnits.get 'end'
                    range = 'HIGHRISE'
                textString  = range+mark+buildingText
                textClass = ''
            else if window.location.href.indexOf('screen-four') > -1
                filterstring = templateArr.join('<')
                mark = '<'
                buildingModel = App.currentStore.building.findWhere({id:App.building['name']})
                buildingText = buildingModel.get('name')
                textString  = buildingText+mark+filterstring
                textClass = ''


            else
                textString  = 'Apartment Selector'
                textClass = 'hidden'
            console.log textString
            [textString,textClass]



    msgbus.registerController 'header', HeaderController