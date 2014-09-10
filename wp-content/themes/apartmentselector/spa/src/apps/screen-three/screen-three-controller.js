// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'src/apps/screen-three/screen-three-view'], function(Extm, ScreenThreeView) {
  var ScreenThreeController;
  ScreenThreeController = (function(_super) {
    __extends(ScreenThreeController, _super);

    function ScreenThreeController() {
      this.mainUnitSelected = __bind(this.mainUnitSelected, this);
      this._unitItemSelected = __bind(this._unitItemSelected, this);
      this.showViews = __bind(this.showViews, this);
      return ScreenThreeController.__super__.constructor.apply(this, arguments);
    }

    ScreenThreeController.prototype.initialize = function() {
      this.Collection = this._getUnits();
      this.layout = new ScreenThreeView.ScreenThreeLayout({
        buildingCollection: this.Collection[0],
        countUnits: this.Collection[3],
        uintVariantId: this.Collection[8],
        uintVariantIdArray: this.Collection[8],
        unitVariants: this.Collection[7],
        templateHelpers: {
          selection: this.Collection[2],
          countUnits: this.Collection[3],
          range: this.Collection[4],
          high: this.Collection[5],
          rangetext: this.Collection[6],
          unitVariants: this.Collection[7]
        }
      });
      this.listenTo(this.layout, "show", this.showViews);
      this.listenTo(this.layout, 'unit:variants:selected', this._showBuildings);
      this.listenTo(this.layout, 'unit:item:selected', this._unitItemSelected);
      return this.show(this.layout);
    };

    ScreenThreeController.prototype.showViews = function() {
      this.buildingCollection = this.Collection[0];
      this.unitCollection = this.Collection[1];
      this.showBuildingRegion(this.buildingCollection);
      return this.showUnitRegion(this.unitCollection);
    };

    ScreenThreeController.prototype._showBuildings = function() {
      this.Collection = this._getUnits();
      this.layout = new ScreenThreeView.ScreenThreeLayout({
        buildingCollection: this.Collection[0],
        countUnits: this.Collection[3],
        uintVariantId: this.Collection[8],
        uintVariantIdArray: this.Collection[8],
        unitVariants: this.Collection[7],
        templateHelpers: {
          selection: this.Collection[2],
          countUnits: this.Collection[3],
          range: this.Collection[4],
          high: this.Collection[5],
          rangetext: this.Collection[6],
          unitVariants: this.Collection[7]
        }
      });
      this.listenTo(this.layout, "show", this.showViews);
      this.listenTo(this.layout, 'unit:variants:selected', this._showBuildings);
      this.listenTo(this.layout, 'unit:item:selected', this._unitItemSelected);
      return this.show(this.layout);
    };

    ScreenThreeController.prototype.showBuildingRegion = function(buildingCollection) {
      var itemview1;
      itemview1 = this.getView(buildingCollection);
      this.layout.buildingRegion.show(itemview1);
      return this.listenTo(itemview1, 'childview:building:link:selected', this._showBuildings);
    };

    ScreenThreeController.prototype.showUnitRegion = function(unitCollection) {
      var itemview2;
      itemview2 = this.getUnitsView(unitCollection);
      return this.layout.unitRegion.show(itemview2);
    };

    ScreenThreeController.prototype.getView = function(buildingCollection) {
      return new ScreenThreeView.UnitTypeChildView({
        collection: buildingCollection
      });
    };

    ScreenThreeController.prototype.getUnitsView = function(unitCollection) {
      return new ScreenThreeView.UnitTypeView({
        collection: unitCollection
      });
    };

    ScreenThreeController.prototype._unitItemSelected = function(childview, childview1, childview2) {
      console.log("hi");
      return App.navigate("screen-four", {
        trigger: true
      });
    };

    ScreenThreeController.prototype._getUnits = function() {
      var Countunits, buildingArray, buildingArrayModel, buildingCollection, buildingModel, buildings, buildingvalue, first, flag, floorArray, floorCollunits, floorCountArray, floorUnitsArray, highUnits, lowUnits, mainnewarr, mediumUnits, myArray, newunitCollection, param, paramkey, range, status, templateArr, templateString, track, trackArray, uniqBuildings, uniqUnitvariant, uniqunitAssigned, uniqunitAssignedval, unitArray, unitAssigned, unitColl, unitVariantID, unitVariantModels, units, units1, unitsArray, unitsCollection, unitslen, unitslen1, unitvariant;
      console.log(App.defaults);
      buildingArray = [];
      unitArray = [];
      unitsArray = [];
      buildingArrayModel = [];
      templateArr = [];
      param = {};
      paramkey = {};
      flag = 0;
      track = 0;
      trackArray = [];
      floorUnitsArray = [];
      myArray = [];
      units = App.master.unit;
      status = App.currentStore.status.findWhere({
        'name': 'Available'
      });
      Countunits = App.currentStore.unit.where({
        'status': status.get('id')
      });
      $.map(App.defaults, function(value, index) {
        if (value !== 'All') {
          if (index !== 'unitVariant') {
            return myArray.push({
              key: index,
              value: value
            });
          }
        }
      });
      $.each(myArray, function(index, value) {
        var budget_Val, element, key, string_val, valuearr, _i, _len, _results;
        if (value.value !== 'All') {
          console.log(value.key);
          param[value.key] = value.value;
          string_val = _.isString(value.value);
          valuearr = "";
          if (string_val === true) {
            valuearr = value.value.split(',');
          }
          if (valuearr.length > 1) {
            _results = [];
            for (_i = 0, _len = valuearr.length; _i < _len; _i++) {
              element = valuearr[_i];
              if (value.key === 'unitType') {
                key = App.master.unit_type.findWhere({
                  id: parseInt(element)
                });
                templateArr.push(key.get('name'));
              }
              if (value.key === 'budget') {
                budget_Val = value + 'lakhs';
                templateArr.push(budget_Val);
              }
              if (value.key === 'floor') {
                if (track === 0) {
                  trackArray.push(value.value);
                }
                _results.push(track = 1);
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          } else {
            if (value.key === 'unitType') {
              key = App.master.unit_type.findWhere({
                id: parseInt(value.value)
              });
              templateArr.push(key.get('name'));
            }
            if (value.key === 'budget') {
              budget_Val = value.value;
              templateArr.push(budget_Val);
            }
            if (value.key === 'floor') {
              if (track === 0) {
                trackArray.push(value.value);
              }
              return track = 1;
            }
          }
        }
      });
      console.log(templateArr);
      if (templateArr.length === 0) {
        templateArr.push('All');
      }
      if (flag === 1) {
        first = _.first(trackArray);
        lowUnits = App.master.range.findWhere({
          name: 'low'
        });
        if (parseInt(first) >= lowUnits.get('start') && parseInt(first) <= lowUnits.get('end')) {
          range = 'LOWRISE';
        }
        mediumUnits = App.master.range.findWhere({
          name: 'medium'
        });
        if (parseInt(first) >= mediumUnits.get('start') && parseInt(first) <= mediumUnits.get('end')) {
          range = 'MIDRISE';
        }
        highUnits = App.master.range.findWhere({
          name: 'high'
        });
        if (parseInt(first) >= highUnits.get('start') && parseInt(first) <= highUnits.get('end')) {
          range = 'HIGHRISE';
        }
      } else {
        templateString = templateArr.join(',');
      }
      flag = 0;
      console.log(templateArr);
      console.log(templateString);
      console.log(myArray);
      status = App.master.status.findWhere({
        'name': 'Available'
      });
      console.log(unitslen = App.master.unit.where({
        'status': status.get('id')
      }));
      console.log(unitslen1 = App.master.unit.where({
        'status': status.get('id'),
        'building': parseInt(App.defaults['building'])
      }));
      $.each(unitslen1, function(index, value1) {
        var floorArray, floorstring;
        if (App.defaults['floor'] !== 'All') {
          floorstring = App.defaults['floor'];
          floorArray = floorstring.split(',');
          return $.each(floorArray, function(index, value) {
            if (value1.get('floor') === parseInt(value)) {
              return floorUnitsArray.push(value1);
            }
          });
        }
      });
      if (App.defaults['floor'] === "All") {
        floorUnitsArray = unitslen;
      }
      console.log(floorUnitsArray.length);
      floorCollunits = [];
      $.each(floorUnitsArray, function(index, value1) {
        flag = 0;
        $.each(myArray, function(index, value) {
          var budget_arr, budget_price, buildingModel, floorRise, floorRiseValue, paramKey, unitPrice, unitVariantmodel;
          paramKey = {};
          paramKey[value.key] = value.value;
          if (value.key === 'budget') {
            buildingModel = App.master.building.findWhere({
              'id': value1.get('building')
            });
            floorRise = buildingModel.get('floorrise');
            floorRiseValue = floorRise[value1.get('floor')];
            unitVariantmodel = App.master.unit_variant.findWhere({
              'id': value1.get('unitVariant')
            });
            unitPrice = value1.get('unitPrice');
            budget_arr = value.value.split(' ');
            budget_price = budget_arr[0].split('-');
            console.log(budget_price[0] = budget_price[0] + '00000');
            console.log(budget_price[1] = budget_price[1] + '00000');
            if (parseInt(unitPrice) >= parseInt(budget_price[0]) && parseInt(unitPrice) <= parseInt(budget_price[1])) {
              return flag++;
            }
          } else if (value.key !== 'floor') {
            console.log(value.key);
            console.log(value1.get(value.key) + '== ' + parseInt(value.value));
            if (value1.get(value.key) === parseInt(value.value)) {
              return flag++;
            }
          }
        });
        console.log(flag);
        if (flag === myArray.length - 1) {
          return floorCollunits.push(value1);
        }
      });
      console.log(floorCollunits);
      if (App.defaults['floor'] === "All") {
        floorCollunits = unitslen;
      }
      console.log(floorCollunits.length);
      units = new Backbone.Collection(floorCollunits);
      buildings = units.pluck("building");
      console.log(uniqBuildings = _.uniq(buildings));
      unitvariant = units.pluck("unitVariant");
      console.log(uniqUnitvariant = _.uniq(unitvariant));
      unitVariantModels = [];
      unitVariantID = [];
      $.each(uniqUnitvariant, function(index, value) {
        var unitVarinatModel;
        unitVarinatModel = App.master.unit_variant.findWhere({
          id: value
        });
        unitVariantModels.push({
          id: unitVarinatModel.get('id'),
          name: unitVarinatModel.get('name'),
          sellablearea: unitVarinatModel.get('sellablearea')
        });
        return unitVariantID.push(parseInt(unitVarinatModel.get('id')));
      });
      unitVariantModels.sort(function(a, b) {
        return a.id - b.id;
      });
      unitVariantID.sort(function(a, b) {
        return a - b;
      });
      console.log(unitVariantModels);
      floorArray = [];
      floorCountArray = [];
      unitsArray = [];
      buildingvalue = App.defaults['building'];
      if (App.defaults['building'] === "All") {
        buildings = App.currentStore.building;
        buildings.each(function(item) {
          var unitsColl;
          unitsColl = App.master.unit.where({
            building: item.get('id')
          });
          return unitsArray.push({
            id: item.get('id'),
            count: unitsColl.length
          });
        });
        buildingvalue = _.max(unitsArray, function(model) {
          return model.count;
        });
        console.log(buildingvalue = buildingvalue.id);
      }
      units1 = new Backbone.Collection(floorUnitsArray);
      console.log(unitsCollection = units1.where({
        building: parseInt(buildingvalue)
      }));
      $.each(unitsCollection, function(index, value) {
        if (floorArray.indexOf(value.get('floor')) === -1) {
          floorArray.push(value.get('floor'));
          return floorCountArray.push({
            id: value.get('floor')
          });
        }
      });
      floorArray = floorArray.sort();
      floorArray.sort(function(a, b) {
        return b - a;
      });
      floorCountArray.sort(function(a, b) {
        return b.id - a.id;
      });
      unitArray = [];
      unitColl = new Backbone.Collection(unitsCollection);
      unitAssigned = unitColl.pluck("unitAssigned");
      console.log(uniqunitAssignedval = _.uniq(unitAssigned));
      uniqunitAssigned = _.without(uniqunitAssignedval, 0);
      uniqunitAssigned.sort(function(a, b) {
        return a - b;
      });
      $.each(uniqunitAssigned, function(index, value) {
        var floorColl, unitAssgendModels, unitAssgendModelsColl;
        floorColl = new Backbone.Collection(floorUnitsArray);
        console.log(unitAssgendModels = floorColl.where({
          unitAssigned: value
        }));
        $.each(unitAssgendModels, function(index, value) {
          var unitType, unitVariant;
          unitType = App.master.unit_type.findWhere({
            id: value.get('unitType')
          });
          value.set("unittypename", unitType.get("name"));
          unitVariant = App.master.unit_variant.findWhere({
            id: value.get('unitVariant')
          });
          return value.set("sellablearea", unitVariant.get("sellablearea"));
        });
        console.log(unitAssgendModels = _.uniq(unitAssgendModels));
        unitAssgendModels.sort(function(a, b) {
          return b.get('floor') - a.get('floor');
        });
        unitAssgendModelsColl = new Backbone.Collection(unitAssgendModels);
        return unitArray.push({
          id: value,
          units: unitAssgendModelsColl
        });
      });
      unitArray.sort(function(a, b) {
        return a.id - b.id;
      });
      console.log(unitArray);
      console.log(newunitCollection = new Backbone.Collection(unitArray));
      buildingModel = App.currentStore.building.where({
        id: parseInt(buildingvalue)
      });
      console.log(buildingCollection = new Backbone.Collection(buildingModel));
      mainnewarr = "";
      return [buildingCollection, newunitCollection, templateString, Countunits.length, templateString, mainnewarr, range, unitVariantModels, unitVariantID];
    };

    ScreenThreeController.prototype.mainUnitSelected = function(childview, childview1, unit, unittypeid, range, size) {
      return App.navigate("#screen-four/unit/" + unit + "/unittype/" + unittypeid + "/range/" + range + "/size/" + size, {
        trigger: true
      });
    };

    return ScreenThreeController;

  })(Extm.RegionController);
  return msgbus.registerController('screen:three', ScreenThreeController);
});
