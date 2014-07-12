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
            .insideRegion  App.mainRegion
                .withOptions({unittypeid:id})
            msgbus.showApp 'screen:two'
                .insideRegion  App.mainRegion
                .withOptions({unittypeid:id})

        showUnits:(unitypeid,range,buildingid)->
            msgbus.showApp 'screen:three'
            .insideRegion  App.mainRegion
                .withOptions({unitypeid:unitypeid,range:range,buildingid:buildingid})

        showSelectedUnit:(unit,unittypeid,range,size)->
            msgbus.showApp 'screen:four'
            .insideRegion  App.mainRegion
                .withOptions({unit:unit,unitypeid:unittypeid,range:range,size:size})










    new ApartmentSelector
        controller : RouterAPI