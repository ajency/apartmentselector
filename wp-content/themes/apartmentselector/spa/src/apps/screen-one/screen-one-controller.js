// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'src/apps/screen-one/screen-one-view'], function(Extm, ScreenOneView) {
  var ScreenOneController;
  ScreenOneController = (function(_super) {
    __extends(ScreenOneController, _super);

    function ScreenOneController() {
      this._unitTypeClicked = __bind(this._unitTypeClicked, this);
      return ScreenOneController.__super__.constructor.apply(this, arguments);
    }

    ScreenOneController.prototype.initialize = function() {
      var view;
      console.log("wwwwwwwwwwww");
      this.unitTypeCollection = this._getUnitTypeCollection();
      this.view = view = this._getUnitTypesView(this.unitTypeCollection);
      this.listenTo(view, "childview:unit:type:clicked", this._unitTypeClicked);
      return this.show(view);
    };

    ScreenOneController.prototype._getUnitTypesView = function(unitTypeCollection) {
      return new ScreenOneView({
        collection: unitTypeCollection
      });
    };

    ScreenOneController.prototype._unitTypeClicked = function(childview) {
      console.log("wwwwwwwwwwww");
      return App.navigate("screen-two", {
        trigger: true
      });
    };

    ScreenOneController.prototype._getUnitTypeCollection = function() {
      var Model, UnitsCollection, collection, modelArray, units;
      Model = Backbone.Model.extend({});
      UnitsCollection = Backbone.Collection.extend({
        model: Model
      });
      modelArray = Array();
      collection = new UnitsCollection();
      units = App.currentStore.unit.where({
        'status': 'Available'
      });
      $.each(units, function(index, value) {
        var NewUnitCollection, max_coll, max_val, min_val, unitTypemodel;
        unitTypemodel = App.currentStore.unit_type.findWhere({
          'id': value.get('unitType')
        });
        NewUnitCollection = App.currentStore.unit.where({
          unitType: unitTypemodel.get('id')
        });
        max_coll = Array();
        $.each(NewUnitCollection, function(index, value) {
          var Variant;
          Variant = App.currentStore.unit_variant.findWhere({
            'id': value.get('unitVariant')
          });
          return max_coll.push(Variant.get('sellablearea'));
        });
        max_val = Math.max.apply(Math, max_coll);
        min_val = Math.min.apply(Math, max_coll);
        unitTypemodel.set({
          'max_value': max_val,
          'min_value': min_val
        });
        return modelArray.push(unitTypemodel);
      });
      collection.add(modelArray);
      return collection;
    };

    return ScreenOneController;

  })(Extm.RegionController);
  return msgbus.registerController('screen:one', ScreenOneController);
});
