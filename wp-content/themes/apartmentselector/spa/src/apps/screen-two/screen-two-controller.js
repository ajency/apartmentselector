// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'src/apps/screen-two/screen-two-view'], function(Extm, ScreenTwoView) {
  var ScreenTwoController;
  ScreenTwoController = (function(_super) {
    __extends(ScreenTwoController, _super);

    function ScreenTwoController() {
      return ScreenTwoController.__super__.constructor.apply(this, arguments);
    }

    ScreenTwoController.prototype.initialize = function() {
      var view;
      this.unitsCountCollection = this._getUnitsCountCollection();
      this.view = view = this._getUnitTypesCountView(this.unitsCountCollection);
      return this.show(this.view);
    };

    ScreenTwoController.prototype._getUnitTypesCountView = function(unitsCountCollection) {
      return new ScreenTwoView({
        collection: unitsCountCollection
      });
    };

    ScreenTwoController.prototype._getUnitsCountCollection = function() {
      var buildingArray, unitColl, units;
      buildingArray = Array();
      unitColl = Array();
      units = App.currentStore.unit.where({
        status: 'Available'
      });
      $.each(units, function(index, value) {
        var maxcoll;
        maxcoll = Array();
        if (buildingArray.indexOf(value.get('building')) === -1) {
          return buildingArray.push(value.get('building'));
        }
      });
      $.each(buildingArray, function(index, value) {
        var buildingModel, buildingid, highArray, high_max_val, high_min_val, itemCollection, lowArray, low_max_val, low_min_val, mainArray, mediumArray, medium_max_val, medium_min_val, newunits;
        buildingid = value;
        newunits = App.currentStore.unit.where({
          'building': value
        });
        console.log(newunits);
        lowArray = Array();
        mediumArray = Array();
        highArray = Array();
        mainArray = Array();
        $.each(newunits, function(index, value) {
          var highUnits, lowUnits, mediumUnits;
          lowUnits = App.currentStore.range.findWhere({
            name: 'low'
          });
          if (value.get('floor') >= lowUnits.get('start') && value.get('floor') <= lowUnits.get('end')) {
            lowArray.push(value.get('id'));
          }
          mediumUnits = App.currentStore.range.findWhere({
            name: 'medium'
          });
          if (value.get('floor') >= mediumUnits.get('start') && value.get('floor') <= mediumUnits.get('end')) {
            mediumArray.push(value.get('id'));
          }
          highUnits = App.currentStore.range.findWhere({
            name: 'high'
          });
          if (value.get('floor') >= highUnits.get('start') && value.get('floor') <= highUnits.get('end')) {
            return highArray.push(value.get('id'));
          }
        });
        low_max_val = 0;
        low_min_val = 0;
        medium_max_val = 0;
        medium_min_val = 0;
        high_min_val = 0;
        high_max_val = 0;
        $.each(lowArray, function(index, value) {
          var max_coll, unitCollection, unitmodel, unittypemodel;
          unitmodel = App.currentStore.unit.findWhere({
            id: value
          });
          unittypemodel = App.currentStore.unit_type.findWhere({
            id: unitmodel.get('unitType')
          });
          unitCollection = App.currentStore.unit.where({
            unitType: unittypemodel.get('id')
          });
          max_coll = Array();
          $.each(unitCollection, function(index, value) {
            var variantmodel;
            variantmodel = App.currentStore.unit_variant.findWhere({
              id: value.get('unitVariant')
            });
            return max_coll.push(variantmodel.get('sellablearea'));
          });
          low_max_val = Math.max.apply(Math, max_coll);
          return low_min_val = Math.min.apply(Math, max_coll);
        });
        $.each(mediumArray, function(index, value) {
          var max_coll, unitCollection, unitmodel, unittypemodel;
          unitmodel = App.currentStore.unit.findWhere({
            id: value
          });
          unittypemodel = App.currentStore.unit_type.findWhere({
            id: unitmodel.get('unitType')
          });
          unitCollection = App.currentStore.unit.where({
            unitType: unittypemodel.get('id')
          });
          max_coll = Array();
          $.each(unitCollection, function(index, value) {
            var variantmodel;
            variantmodel = App.currentStore.unit_variant.findWhere({
              id: value.get('unitVariant')
            });
            return max_coll.push(variantmodel.get('sellablearea'));
          });
          medium_max_val = Math.max.apply(Math, max_coll);
          return medium_min_val = Math.min.apply(Math, max_coll);
        });
        $.each(highArray, function(index, value) {
          var max_coll, unitCollection, unitmodel, unittypemodel;
          unitmodel = App.currentStore.unit.findWhere({
            id: value
          });
          unittypemodel = App.currentStore.unit_type.findWhere({
            id: unitmodel.get('unitType')
          });
          unitCollection = App.currentStore.unit.where({
            unitType: unittypemodel.get('id')
          });
          max_coll = Array();
          $.each(unitCollection, function(index, value) {
            var variantmodel;
            variantmodel = App.currentStore.unit_variant.findWhere({
              id: value.get('unitVariant')
            });
            return max_coll.push(variantmodel.get('sellablearea'));
          });
          high_max_val = Math.max.apply(Math, max_coll);
          return high_min_val = Math.min.apply(Math, max_coll);
        });
        mainArray.push({
          name: lowArray.length,
          low_max_val: low_max_val,
          low_min_val: low_min_val,
          range: 'low',
          buildingid: buildingid
        });
        mainArray.push({
          name: mediumArray.length,
          low_max_val: medium_max_val,
          low_min_val: medium_min_val,
          range: 'medium',
          buildingid: buildingid
        });
        mainArray.push({
          name: highArray.length,
          low_max_val: high_max_val,
          low_min_val: high_min_val,
          range: 'high',
          buildingid: buildingid
        });
        itemCollection = new Backbone.Collection(mainArray);
        buildingModel = App.currentStore.building.findWhere({
          id: value
        });
        return unitColl.push({
          buildingname: buildingModel.get('name'),
          units: itemCollection,
          buildingid: buildingModel.get('id')
        });
      });
      units = new Backbone.Collection(unitColl);
      return console.log(units);
    };

    return ScreenTwoController;

  })(Extm.RegionController);
  return msgbus.registerController('screen:two', ScreenTwoController);
});
