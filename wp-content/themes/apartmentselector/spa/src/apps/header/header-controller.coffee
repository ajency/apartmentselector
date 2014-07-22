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
                    flag = 1
                    string_val = _.isString(value)
                    if string_val == true
                        valuearr = value.split(',')
                    if valuearr.length > 1
                        for element  in valuearr
                            console.log element
                            if index == 'unitType'
                                key = App.currentStore.unit_type.findWhere({id:parseInt(element)})
                                console.log key
                                templateArr.push key.get 'name'
                            if index == 'unitVariant'
                                key = App.currentStore.unit_variant.findWhere({id:parseInt(element)})
                                console.log key
                                templateArr.push key.get 'name'
                            if index == 'building'
                                key = App.currentStore.building.findWhere({id:parseInt(element)})
                                console.log key
                                templateArr.push key.get 'name'
                            if index == 'budget'
                                budget_Val = value+'lakhs'
                                templateArr.push budget_Val
                            if index == 'floor'
                                templateArr.push value
                    else
                        if index == 'unitType'
                            key = App.currentStore.unit_type.findWhere({id:parseInt(value)})
                            console.log key
                            templateArr.push key.get 'name'
                        if index == 'unitVariant'
                            key = App.currentStore.unit_variant.findWhere({id:parseInt(value)})
                            console.log key
                            templateArr.push key.get 'name'
                        if index == 'building'
                            key = App.currentStore.building.findWhere({id:parseInt(value)})
                            console.log key
                            templateArr.push key.get 'name'
                        if index == 'budget'
                            budget_Val = value+'lakhs'
                            templateArr.push budget_Val
                        if index == 'floor'
                            templateArr.push value




            )
            console.log templateArr
            templateString  = templateArr.join(',')
            textString = ""
            if(flag==1)
                textString  = 'You have selected '+templateString
                textClass = ''
            else
                textString  = 'Apartment Selector'
                textClass = 'hidden'
            [textString,textClass]



    msgbus.registerController 'header', HeaderController