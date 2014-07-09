# all modules will start with 'src/'.
# eg: define 'plugins-loader', ['src/bower_component/pluginname'], ->

# add your required plugins here.
define 'plugin-loader', [], ->

# add your marionette apps here
define 'apps-loader', [], ->

# set all plugins for this page here
require ['spec/javascripts/fixtures/json/flats'
         'spec/javascripts/fixtures/json/views'
         'spec/javascripts/fixtures/json/buildings'
         'spec/javascripts/fixtures/json/unitvariants'
         'plugin-loader'
         'extm'
         'apps-loader' ], ( flats, views, buildings, unitvariants, plugins, Extm )->

            # global application object
            window.App = new Extm.Application

            # add your application main regions here
            App.addRegions
               headerRegion : '#header-region'

            App.store.push 'flat', flats
            App.store.push 'view', views
            App.store.push 'building', buildings
            App.store.push 'unit_variant', unitvariants

            # start application
            App.start()
