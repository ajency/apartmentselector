# all modules will start with 'src/'.
# eg: define 'plugins-loader', ['src/bower_component/pluginname'], ->

# add your required plugins here.
define 'plugin-loader', [], ->

   # add your marionette apps here
define 'apps-loader', [
   'src/apps/footer/footer-controller'
   'src/apps/header/header-controller'
   'src/apps/screen-one/screen-one-controller'
], ->

   # set all plugins for this page here
require [ 'spec/javascripts/fixtures/json/units'
          'spec/javascripts/fixtures/json/views'
          'spec/javascripts/fixtures/json/buildings'
          'spec/javascripts/fixtures/json/unitvariants'
          'spec/javascripts/fixtures/json/unittypes'
          'plugin-loader'
          'extm'
          'src/classes/ap-store'
          'apps-loader' ], ( units, views, buildings, unitvariants, unittypes, plugins, Extm )->

   # global application object
   window.App = new Extm.Application

   # add your application main regions here
   App.addRegions
      headerRegion : '#header-region'
      footerRegion : '#footer-region'
      filterRegion : '#filter-region'
      mainRegion : '#main-region'

   App.store.push 'unit', units
   App.store.push 'view', views
   App.store.push 'building', buildings
   App.store.push 'unit_variant', unitvariants
   App.store.push 'unit_type', unittypes

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

