# all modules will start with 'src/'.
# eg: define 'plugins-loader', ['src/bower_component/pluginname'], ->

# add your required plugins here.
define 'plugin-loader', ['preload'], ->

    # add your marionette apps here
define 'apps-loader', [
    'src/apps/footer/footer-controller'
    'src/apps/header/header-controller'
    'src/apps/screen-one/screen-one-controller'
    'src/apps/screen-two/screen-two-controller'
    'src/apps/screen-three/screen-three-controller'
    'src/apps/screen-four/screen-four-controller'
], ->

    # set all plugins for this page here
require [ 'spec/javascripts/fixtures/json/units'
          'spec/javascripts/fixtures/json/views'
          'spec/javascripts/fixtures/json/buildings'
          'spec/javascripts/fixtures/json/unitvariants'
          'spec/javascripts/fixtures/json/unittypes'
          'spec/javascripts/fixtures/json/lowrange'
          'spec/javascripts/fixtures/json/mediumrange'
          'spec/javascripts/fixtures/json/highrange'
          'plugin-loader'
          'extm'
          'src/classes/ap-store'
          'src/apps/router'
          'apps-loader' ], ( units, views, buildings, unitvariants, unittypes,low,medium,high, plugins, Extm )->

    # global application object
    window.App = new Extm.Application

    # add your application main regions here
    App.addRegions
        headerRegion : '#header-region'
        footerRegion : '#footer-region'
        filterRegion : '#filter-region'
        mainRegion : '#main-region'


    App.store =
        'unit' : new Backbone.Collection units
        'view' : new Backbone.Collection  views
        'building' : new Backbone.Collection  buildings
        'unit_variant' : new Backbone.Collection  unitvariants
        'unit_type' : new Backbone.Collection  unittypes
        'low' : new Backbone.Collection  low
        'medium':  new Backbone.Collection  medium
        'high': new Backbone.Collection  high

    App.currentStore = App.store

    App.filter = (params={})->
        param_arr = params.split('&')
        othermodels = Array()
        $.each(param_arr, (index,value)->
            value_arr  =  value.split('=')
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
                if param_val_arr[0].toUpperCase() == 'ALL'
                    collection =  App.currentStore.unit.toArray()
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





    App.currentRoute = []

    # load static apps
    staticApps = [
        [ 'footer', App.footerRegion ]
    ]

    if window.location.hash is ''
        staticApps.push [ 'header', App.headerRegion ]
        staticApps.push [ 'screen:one', App.mainRegion ]

















    App.addStaticApps staticApps

        # start application
    App.start()

