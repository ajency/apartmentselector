// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'src/apps/screen-two/screen-two-view'], function(Extm, ScreenTwoView) {
  var ScreenTwoController;
  ScreenTwoController = (function(_super) {
    __extends(ScreenTwoController, _super);

    function ScreenTwoController() {
      this._unitCountSelected = __bind(this._unitCountSelected, this);
      this.showViews = __bind(this.showViews, this);
      return ScreenTwoController.__super__.constructor.apply(this, arguments);
    }

    ScreenTwoController.prototype.initialize = function() {
      this.Collection = this._getUnitsCountCollection();
      this.unitTypecoll = this.Collection[2];
      this.layout = new ScreenTwoView.ScreenTwoLayout({
        templateHelpers: {
          unitType: this.unitTypecoll,
          selection: this.Collection[3],
          unitsCount: this.Collection[4]
        }
      });
      this.listenTo(this.layout, "show", this.showViews);
      return this.show(this.layout);
    };

    ScreenTwoController.prototype.showViews = function() {
      this.buildingCollection = this.Collection[0];
      this.unitCollection = this.Collection[1];
      this.showBuildingRegion(this.buildingCollection);
      return this.showUnitRegion(this.unitCollection);
    };

    ScreenTwoController.prototype.showBuildingRegion = function(buildingCollection) {
      var itemview1;
      itemview1 = this.getView(buildingCollection);
      return this.layout.buildingRegion.show(itemview1);
    };

    ScreenTwoController.prototype.showUnitRegion = function(unitCollection) {
      var itemview2;
      itemview2 = this.getUnitsView(unitCollection);
      this.layout.unitRegion.show(itemview2);
      return this.listenTo(itemview2, 'childview:childview:unit:count:selected', this._unitCountSelected);
    };

    ScreenTwoController.prototype.getView = function(buildingCollection) {
      console.log("hi");
      return new ScreenTwoView.UnitTypeChildView({
        collection: buildingCollection
      });
    };

    ScreenTwoController.prototype.getUnitsView = function(unitCollection) {
      return new ScreenTwoView.UnitTypeView({
        collection: unitCollection
      });
    };

    ScreenTwoController.prototype._unitCountSelected = function(childview, childview1) {
      return App.navigate("screen-three", {
        trigger: true
      });
    };

    ScreenTwoController.prototype._getUnitsCountCollection = function() {
      var Countunits, MainCollection, buildingArray, buildingArrayModel, buildingCollection, newarr, param, paramkey, status, templateArr, templateString, unique, unitColl, unitTypeArray, units;
      buildingArray = Array();
      buildingArrayModel = Array();
      unitColl = Array();
      unitTypeArray = Array();
      newarr = [];
      unique = {};
      templateArr = [];
      MainCollection = new Backbone.Model();
      status = App.currentStore.status.findWhere({
        'name': 'Available'
      });
      units = App.currentStore.unit.where({
        'status': status.get('id')
      });
      Countunits = App.currentStore.unit.where({
        'status': status.get('id')
      });
      param = {};
      paramkey = {};
      $.each(App.defaults, function(index, value) {
        var budget_Val, element, key, string_val, valuearr, _i, _len, _results;
        if (value !== 'All') {
          param[index] = value;
          console.log(index);
          string_val = _.isString(value);
          valuearr = "";
          if (string_val === true) {
            valuearr = value.split(',');
          }
          if (valuearr.length > 1) {
            _results = [];
            for (_i = 0, _len = valuearr.length; _i < _len; _i++) {
              element = valuearr[_i];
              console.log(element);
              if (index === 'unitType') {
                key = App.currentStore.unit_type.findWhere({
                  id: parseInt(element)
                });
                console.log(key);
                templateArr.push(key.get('name'));
              }
              if (index === 'unitVariant') {
                key = App.currentStore.unit_variant.findWhere({
                  id: parseInt(element)
                });
                console.log(key);
                templateArr.push(key.get('name'));
              }
              if (index === 'building') {
                key = App.currentStore.building.findWhere({
                  id: parseInt(element)
                });
                console.log(key);
                templateArr.push(key.get('name'));
              }
              if (index === 'budget') {
                budget_Val = value + 'lakhs';
                templateArr.push(budget_Val);
              }
              if (index === 'floor') {
                _results.push(templateArr.push(value));
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          } else {
            if (index === 'unitType') {
              key = App.currentStore.unit_type.findWhere({
                id: parseInt(value)
              });
              console.log(key);
              templateArr.push(key.get('name'));
            }
            if (index === 'unitVariant') {
              key = App.currentStore.unit_variant.findWhere({
                id: parseInt(value)
              });
              console.log(key);
              templateArr.push(key.get('name'));
            }
            if (index === 'building') {
              key = App.currentStore.building.findWhere({
                id: parseInt(value)
              });
              console.log(key);
              templateArr.push(key.get('name'));
            }
            if (index === 'budget') {
              budget_Val = value + 'lakhs';
              templateArr.push(budget_Val);
            }
            if (index === 'floor') {
              return templateArr.push(value);
            }
          }
        }
      });
      console.log(templateArr);
      if (templateArr.length === 0) {
        templateArr.push('All');
      }
      templateString = templateArr.join(',');
      $.each(units, function(index, value) {
        var maxcoll, unitType;
        maxcoll = Array();
        unitType = App.currentStore.unit_type.findWhere({
          id: value.get('unitType')
        });
        unitTypeArray.push({
          id: unitType.get('id'),
          name: unitType.get('name')
        });
        if (buildingArray.indexOf(value.get('building')) === -1) {
          return buildingArray.push(value.get('building'));
        }
      });
      $.each(unitTypeArray, function(key, item) {
        var count;
        if (!unique[item.id]) {
          console.log(count = App.currentStore.unit.where({
            unitType: item.id
          }));
          newarr.push({
            id: item.id,
            name: item.name,
            count: count.length
          });
          return unique[item.id] = item;
        }
      });
      console.log(newarr);
      $.each(buildingArray, function(index, value) {
        var buildingModel, buildingid, highArray, high_max_val, high_min_val, itemCollection, lowArray, low_max_val, low_min_val, mainArray, mediumArray, medium_max_val, medium_min_val, newunits;
        buildingid = value;
        newunits = App.currentStore.unit.where({
          'building': value
        });
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
          name: highArray.length,
          low_max_val: high_max_val,
          low_min_val: high_min_val,
          range: 'high',
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
          name: lowArray.length,
          low_max_val: low_max_val,
          low_min_val: low_min_val,
          range: 'low',
          buildingid: buildingid
        });
        itemCollection = new Backbone.Collection(mainArray);
        buildingModel = App.currentStore.building.findWhere({
          id: value
        });
        unitColl.push({
          buildingname: buildingModel.get('name'),
          units: itemCollection,
          buildingid: buildingModel.get('id')
        });
        return buildingArrayModel.push(buildingModel);
      });
      buildingCollection = new Backbone.Collection(buildingArrayModel);
      units = new Backbone.Collection(unitColl);
      return [buildingCollection, units, newarr, templateString, Countunits.length];
    };

    return ScreenTwoController;

  })(Extm.RegionController);
  return msgbus.registerController('screen:two', ScreenTwoController);
});
