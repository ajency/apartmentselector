# all modules will start with 'src/'.
# eg: define 'plugins-loader', ['src/bower_component/pluginname'], ->

# add your required plugins here.
define 'plugin-loader', [], ->

# add your marionette apps here
define 'apps-loader', [], ->

# add your entities here
define 'entitites-loader', [], ->

# set all plugins for this page here
require [ 'plugin-loader', 'extm', 'entitites-loader', 'apps-loader' ], ( plugins, Extm )->

   # global application object
   window.App = new Extm.Application

   # add your application main regions here
   App.addRegions
      headerRegion : '#header-region'

   # start application
   App.start()
