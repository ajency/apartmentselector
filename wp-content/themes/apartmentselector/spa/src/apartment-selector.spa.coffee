# all modules will start with 'src/'.
# eg: define 'plugins-loader', ['src/bower_component/pluginname'], ->

# add your required plugins here.
define 'plugin-loader', [], ->

# add your marionette apps here
define 'apps-loader', [ 'src/apps/footer/footer-controller'
                        'src/apps/header/header-controller'], ->

# set all plugins for this page here
require [ 'spec/javascripts/fixtures/json/units'
          'spec/javascripts/fixtures/json/views'
          'spec/javascripts/fixtures/json/buildings'
          'spec/javascripts/fixtures/json/unitvariants'
          'spec/javascripts/fixtures/json/unitvariants'
          'plugin-loader'
          'extm'
          'apps-loader' ], ( units, views, buildings, unitvariants,unittypes,plugins, Extm )->

    # global application object
    window.App = new Extm.Application

    # add your application main regions here
    App.addRegions
        headerRegion : '#header-region'
        footerRegion : '#footer-region'
        screenOneRegion : '#screen-one-region'

    App.store.push 'unit', units
    App.store.push 'view', views
    App.store.push 'building', buildings
    App.store.push 'unit_variant', unitvariants
    App.store.push 'unit_type', unittypes

    # load static apps
    App.addStaticApps [
        [ 'footer', App.footerRegion ]
        [ 'header', App.headerRegion ]
    ]

    # start application
    App.start()

