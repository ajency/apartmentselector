define [ 'marionette'], ( Marionette )->

    class ApartmentSelector extends Marionette.AppRouter

        appRoutes:
            'screen-two/unittype/:id/budget/:budget'  : 'show'
            'screen-three/unittype/:unitypeid/range/:range/building/:buildingid' : 'showUnits'
            'screen-four/unit/:unit/unittype/:unittypeid/range/:range/size/:size' : 'showSelectedUnit'





    staticApps = [

    ]
    RouterAPI =
    #Start Sub App
        show :(id,budget)->
            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions({unittypeid:id})
            msgbus.showApp 'screen:two'
                .insideRegion  App.mainRegion
                .withOptions({unittypeid:id})

        showUnits:(unitypeid,range,buildingid)->
            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions({unittypeid:unitypeid,range:range,buildingid:buildingid})
            msgbus.showApp 'screen:three'
            .insideRegion  App.mainRegion
                .withOptions({unittypeid:unitypeid,range:range,buildingid:buildingid})

        showSelectedUnit:(unit,unittypeid,range,size)->

            msgbus.showApp 'header'
            .insideRegion  App.headerRegion
                .withOptions({unit:unit,unittypeid:unittypeid,range:range,size:size})
            msgbus.showApp 'screen:four'
            .insideRegion  App.mainRegion
                .withOptions({unit:unit,unittypeid:unittypeid,range:range,size:size})










    new ApartmentSelector
        controller : RouterAPI