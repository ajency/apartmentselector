// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'src/apps/screen-four/screen-four-view'], function(Extm, ScreenFourView) {
  var ScreenFourController;
  ScreenFourController = (function(_super) {
    __extends(ScreenFourController, _super);

    function ScreenFourController() {
      this.showViews = __bind(this.showViews, this);
      return ScreenFourController.__super__.constructor.apply(this, arguments);
    }

    ScreenFourController.prototype.initialize = function(opt) {
      this.Collection = this._getSelelctedUnit();
      this.layout = new ScreenFourView.ScreenFourLayout();
      this.listenTo(this.layout, "show", this.showViews);
      return this.show(this.layout);
    };

    ScreenFourController.prototype.showViews = function() {
      this.unitCollection = this.Collection;
      this.mainCollection = this.Collection;
      this.showUnitRegion(this.unitCollection);
      return this.showMainRegion(this.mainCollection);
    };

    ScreenFourController.prototype.showUnitRegion = function(unitCollection) {
      var itemview1;
      itemview1 = this.getView(unitCollection);
      return this.layout.unitRegion.show(itemview1);
    };

    ScreenFourController.prototype.showMainRegion = function(mainCollection) {
      var itemview2;
      itemview2 = this.getUnitsView(mainCollection);
      return this.layout.mainRegion.show(itemview2);
    };

    ScreenFourController.prototype.getView = function(unitCollection) {
      return new ScreenFourView.UnitTypeChildView({
        collection: unitCollection
      });
    };

    ScreenFourController.prototype.getUnitsView = function(mainCollection) {
      return new ScreenFourView.UnitTypeView({
        collection: mainCollection
      });
    };

    ScreenFourController.prototype._getSelelctedUnit = function() {
      var units;
      units = App.currentStore.unit;
      units.each(function(item) {
        var unitTypeModel, unitVariantModel;
        unitVariantModel = App.currentStore.unit_variant.findWhere({
          id: item.get('unitVariant')
        });
        unitTypeModel = App.currentStore.unit_type.findWhere({
          id: item.get('unitType')
        });
        item.set('terracearea', unitVariantModel.get('terracearea'));
        item.set('sellablearea', unitVariantModel.get('sellablearea'));
        item.set('carpetarea', unitVariantModel.get('carpetarea'));
        return item.set('unittypename', unitTypeModel.get('name'));
      });
      return units;
    };

    return ScreenFourController;

  })(Extm.RegionController);
  return msgbus.registerController('screen:four', ScreenFourController);
});
