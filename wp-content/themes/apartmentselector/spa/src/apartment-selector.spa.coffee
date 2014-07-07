# set all plugins for this page here
require [ 'extm' ], ( Extm )->

   window.App = new Extm.Application

   App.addRegions
         headerRegion : '#header-region'

   class V extends Marionette.ItemView

      template : 'hello world'

   App.start()

   App.getRegion 'headerRegion'
      .show new V