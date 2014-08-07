# all modules will start with 'src/'.
# eg: define 'plugins-loader', ['src/bower_component/pluginname'], ->

# add your required plugins here.
define 'plugin-loader', ['slick','selectFx','jquerymousewheel','jqueryeasing','mapplic','jqueryEasingmin'
                            ,'jquerytouchswipe','jqueryliquidslider'], ->

    # add your marionette apps here
define 'apps-loader', [
    'src/apps/footer/footer-controller'
    'src/apps/header/header-controller'
    'src/apps/screen-one/screen-one-controller'
    'src/apps/screen-two/screen-two-controller'
    'src/apps/screen-three/screen-three-controller'
    'src/apps/screen-four/screen-four-controller'
    'src/apps/popup/popup-controller'
], ->

    # set all plugins for this page here
require [ 'plugin-loader'
          'spec/javascripts/fixtures/json/units'
          'spec/javascripts/fixtures/json/views'
          'spec/javascripts/fixtures/json/building'
          'spec/javascripts/fixtures/json/unitvariants'
          'spec/javascripts/fixtures/json/unittypes'
          'spec/javascripts/fixtures/json/range'
          'spec/javascripts/fixtures/json/status'
          'extm'
          'src/classes/ap-store'
          'src/apps/router'
          'apps-loader'], ( plugins,units, views, buildings, unitvariants, unittypes,range,status,  Extm )->

    # global application object
    window.App = new Extm.Application

    # add your application main regions here
    App.addRegions
        headerRegion : '#header-region'
        footerRegion : '#footer-region'
        filterRegion : '#filter-region'
        mainRegion : '#main-region'



    App.currentStore =
        'unit' : new Backbone.Collection UNITS
        'view' : new Backbone.Collection  views
        'building' : new Backbone.Collection  BUILDINGS
        'unit_variant' : new Backbone.Collection  UNITVARIANTS
        'unit_type' : new Backbone.Collection  UNITTYPES
        'range': new Backbone.Collection  range
        'status': new Backbone.Collection  STATUS

    App.master =
        'unit' : new Backbone.Collection UNITS
        'view' : new Backbone.Collection  views
        'building' : new Backbone.Collection  BUILDINGS
        'unit_variant' : new Backbone.Collection  UNITVARIANTS
        'unit_type' : new Backbone.Collection  UNITTYPES
        'range': new Backbone.Collection  range
        'status': new Backbone.Collection  STATUS


    App.unit = {name:''}

    App.screenOneFilter = {key:'',value:''}

    App.backFilter = {'screen1':[],'screen2':[],'screen3':[]}

    App.defaults = {"unitType" :'All' ,"building":'All',"unitVariant":'All','floor':'All','view':'All','budget':'All'}




    App.filter = (params={})->
        #check whether url contains any parameters
        if  window.location.href.indexOf('=') > -1
            params = params
            paramsArray = params.split('&')
            #loop through all the parameters
            for element,index in paramsArray
                param_key = element.split('=')
                #check whether defaults has the param key
                key = App.defaults.hasOwnProperty(param_key[0])
                #If yes , assign the new value to the matched key of the defaults
                if key == true
                    if  window.location.href.indexOf('screen-two') > -1
                        App.backFilter['screen2'].push param_key[0]
                    else if  window.location.href.indexOf('screen-three') > -1
                        App.backFilter['screen3'].push param_key[0]
                    else
                        App.backFilter['screen1'].push param_key[0]
                    App.defaults[param_key[0]] = param_key[1]



            params = 'unitType='+App.defaults['unitType']+'&building='+App.defaults['building']+'&unitVariant='+App.defaults['unitVariant']+
            '&floor='+App.defaults['floor']+'&view='+App.defaults['view']+'&budget='+App.defaults['budget']




        else

            #url doesnt contain any parameters take the value of the defaults
            params = 'unitType='+App.defaults['unitType']+'&building='+App.defaults['building']+'&unitVariant='+App.defaults['unitVariant']+
            '&floor='+App.defaults['floor']+'&view='+App.defaults['view']+'&budget='+App.defaults['budget']




        console.log App.defaults
        param_arr = params.split('&')
        budgetUnitArray = []
        $.each(param_arr, (index,value)->
            value_arr  =  value.split('=')
            attribute = {}
            attribute[param_key] = param_key
            param_key = value_arr[0]
            param_val = value_arr[1]
            param_val_arr = param_val.split(',')
            paramkey = {}
            paramkey[param_key] = parseInt(param_val)
            if param_val_arr.length > 1
                collection = Array()
                $.each(param_val_arr, (index,value)->
                    paramkey = {}
                    collectionNew = Array()
                    paramkey[param_key] = parseInt(value)
                    collectionNew = App.currentStore.unit.where(paramkey)
                    $.each(collectionNew , (index,value)->
                        collection.push value


                    )



                )
            else if param_val_arr.length ==  1
                budget_val = param_val_arr[0].split(' ')
                if(budget_val[1]=='lakhs')
                    budget_arr = budget_val[0].split('-')
                    budget_arr[0] = budget_arr[0] + ('00000')
                    budget_arr[1] = budget_arr[1]+ ('00000')
                if param_val_arr[0].toUpperCase() == 'ALL'
                    collection =  App.currentStore.unit.toArray()
                else if budget_val.length>1
                    units = App.currentStore.unit
                    units.each (item)->
                        buildingModel = App.currentStore.building.findWhere({'id':item.get 'building'})
                        floorRise = buildingModel.get 'floorrise'
                        floorRiseValue = floorRise[item.get 'floor']
                        unitVariantmodel = App.currentStore.unit_variant.findWhere({'id':item.get 'unitVariant'})
                        unitPrice = (parseInt( unitVariantmodel.get('persqftprice')) + parseInt(floorRiseValue)) * parseInt(unitVariantmodel.get 'sellablearea')
                        item.set({'unitPrice' , unitPrice})
                        if item.get('unitPrice') > parseInt(budget_arr[0]) && item.get('unitPrice') < parseInt(budget_arr[1])
                            budgetUnitArray.push item
                        collection  = budgetUnitArray

                else
                    collection =  App.currentStore.unit.where(paramkey)


            App.currentStore.unit.reset collection


        )
        buildings = App.currentStore.unit.pluck("building")
        uniqBuildings = _.uniq(buildings)
        buildingArray = Array()
        for element , index in uniqBuildings
            buildingModel = App.currentStore.building.get element
            buildingArray.push buildingModel

        unittype = App.currentStore.unit.pluck("unitType")
        uniqUnittype = _.uniq(unittype)
        unittypeArray = Array()
        for element , index in uniqUnittype
            unittypeModel = App.currentStore.unit_type.get element
            unittypeArray.push unittypeModel

        unitvariant = App.currentStore.unit.pluck("unitVariant")
        uniqUnitvariant = _.uniq(unitvariant)
        unitvariantArray = Array()
        for element , index in uniqUnitvariant
            unitvariantModel = App.currentStore.unit_variant.get element
            unitvariantArray.push unitvariantModel

        view = App.currentStore.unit.pluck("view")
        uniqviews = _.uniq(buildings)
        viewArray = Array()
        for element , index in uniqviews
            viewModel = App.currentStore.view.get element
            viewArray.push viewModel
        App.currentStore.building.reset buildingArray
        App.currentStore.unit_type.reset unittypeArray
        App.currentStore.unit_variant.reset unitvariantArray
        App.currentStore.view.reset viewArray
        App.currentStore.unit



    App.filterparam = (params={})->
            App.defaults = {"building" :[2,3] ,"unitType":3,"unitVariant":'All','floor':'All','view':'All'}
            App.defaults.hasOwnProperty("name" )
            units = App.currentStore.unit.filter (model)->
                App.defaults['building'].length
                buildingArray = Array()
                for element , index in App.defaults['building']
                    building = model.get('building') == element




                building
            units




    App.currentRoute = []

    # load static apps
    staticApps = [

    ]

    if window.location.hash is ''
        App.filter()
        staticApps.push [ 'header', App.headerRegion ]
        staticApps.push [ 'screen:one', App.mainRegion ]

















    App.addStaticApps staticApps

        # start application
    App.start()

