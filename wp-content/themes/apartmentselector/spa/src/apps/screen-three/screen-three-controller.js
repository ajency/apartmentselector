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
        templateHelpers: {
          selection: this.Collection[2]
        }
      });
      this.listenTo(this.layout, "show", this.showViews);
      return this.show(this.layout);
    };

    ScreenThreeController.prototype.showViews = function() {
      this.buildingCollection = this.Collection[0];
      this.unitCollection = this.Collection[1];
      this.showBuildingRegion(this.buildingCollection);
      return this.showUnitRegion(this.unitCollection);
    };

    ScreenThreeController.prototype.showBuildingRegion = function(buildingCollection) {
      var itemview1;
      itemview1 = this.getView(buildingCollection);
      return this.layout.buildingRegion.show(itemview1);
    };

    ScreenThreeController.prototype.showUnitRegion = function(unitCollection) {
      var itemview2;
      itemview2 = this.getUnitsView(unitCollection);
      this.layout.unitRegion.show(itemview2);
      return this.listenTo(itemview2, 'childview:childview:childview:unit:item:selected', this._unitItemSelected);
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
      var buildingArray, buildingArrayModel, buildingCollection, buildingModel, element, first, flag, highUnits, index, lowUnits, mediumUnits, newunitCollection, param, paramkey, range, temp, temp1, templateArr, templateString, unitArray, units, unitsArray, _i, _len;
      buildingArray = [];
      unitArray = [];
      unitsArray = [];
      buildingArrayModel = [];
      templateArr = [];
      param = {};
      paramkey = {};
      flag = 0;
      units = App.currentStore.unit;
      $.each(App.Cloneddefaults, function(index, value) {
        var budget_Val, element, key, string_val, valuearr, _i, _len, _results;
        if (value !== 'All') {
          param[index] = value;
          string_val = _.isString(value);
          valuearr = "";
          if (string_val === true) {
            valuearr = value.split(',');
          }
          if (valuearr.length > 1) {
            _results = [];
            for (_i = 0, _len = valuearr.length; _i < _len; _i++) {
              element = valuearr[_i];
              if (index === 'unitType') {
                key = App.currentStore.unit_type.findWhere({
                  id: parseInt(element)
                });
                templateArr.push(key.get('name'));
              }
              if (index === 'unitVariant') {
                key = App.currentStore.unit_variant.findWhere({
                  id: parseInt(element)
                });
                templateArr.push(key.get('name'));
              }
              if (index === 'building') {
                key = App.currentStore.building.findWhere({
                  id: parseInt(element)
                });
                templateArr.push(key.get('name'));
              }
              if (index === 'budget') {
                budget_Val = value + 'lakhs';
                templateArr.push(budget_Val);
              }
              if (index === 'floor') {
                templateArr.push(value);
                _results.push(flag = 1);
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
              templateArr.push(key.get('name'));
            }
            if (index === 'unitVariant') {
              key = App.currentStore.unit_variant.findWhere({
                id: parseInt(value)
              });
              templateArr.push(key.get('name'));
            }
            if (index === 'building') {
              key = App.currentStore.building.findWhere({
                id: parseInt(value)
              });
              templateArr.push(key.get('name'));
            }
            if (index === 'budget') {
              budget_Val = value;
              templateArr.push(budget_Val);
            }
            if (index === 'floor') {
              templateArr.push(value);
              return flag = 1;
            }
          }
        }
      });
      if (templateArr.length === 0) {
        templateArr.push('All');
      }
      if (flag === 1) {
        first = _.first(templateArr);
        buildingModel = App.currentStore.building.findWhere({
          id: App.building['name']
        });
        lowUnits = App.currentStore.range.findWhere({
          name: 'low'
        });
        if (parseInt(first) >= lowUnits.get('start') && parseInt(first) <= lowUnits.get('end')) {
          range = 'LOWRISE' + ',' + buildingModel.get('name');
        }
        mediumUnits = App.currentStore.range.findWhere({
          name: 'medium'
        });
        if (parseInt(first) >= mediumUnits.get('start') && parseInt(first) <= mediumUnits.get('end')) {
          range = 'MIDRISE' + ',' + buildingModel.get('name');
        }
        highUnits = App.currentStore.range.findWhere({
          name: 'high'
        });
        if (parseInt(first) >= highUnits.get('start') && parseInt(first) <= highUnits.get('end')) {
          range = 'HIGHRISE' + ',' + buildingModel.get('name');
        }
        templateString = range;
      } else {
        templateString = templateArr.join(',');
      }
      units.each(function(item) {
        if (buildingArray.indexOf(item.get('building')) === -1) {
          return buildingArray.push(item.get('building'));
        }
      });
      $.each(buildingArray, function(index, value) {
        var buildingid, floorArray, floorCountArray, unitCollection, unitsCollection;
        buildingid = value;
        floorArray = [];
        floorCountArray = [];
        unitsArray = [];
        unitsCollection = App.currentStore.unit.where({
          building: value
        });
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
        $.each(floorArray, function(index, value) {
          var floorCollection, floorunits;
          floorunits = App.currentStore.unit.where({
            floor: value,
            building: buildingid
          });
          floorunits.sort(function(a, b) {
            console.log(a.get('id'));
            return a.get('id') - b.get('id');
          });
          floorCollection = new Backbone.Collection(floorunits);
          unitsArray.push({
            floorunits: floorCollection
          });
          return $.each(floorunits, function(index, value) {
            var str, unitType, unitVariant;
            unitType = App.currentStore.unit_type.findWhere({
              id: value.get('unitType')
            });
            str = unitType.get('name');
            str = str.replace(/\s/g, '');
            value.set('unitTypeName', str);
            unitVariant = App.currentStore.unit_variant.findWhere({
              id: value.get('unitVariant')
            });
            return value.set('unitVariantName', unitVariant.get('name'));
          });
        });
        buildingModel = App.currentStore.building.findWhere({
          id: value
        });
        buildingArrayModel.push(buildingModel);
        unitCollection = new Backbone.Collection(unitsArray);
        return unitArray.push({
          buildingid: value,
          units: unitCollection,
          floorcount: floorCountArray
        });
      });
      temp = [];
      temp1 = [];
      for (index = _i = 0, _len = unitArray.length; _i < _len; index = ++_i) {
        element = unitArray[index];
        if (unitArray[index].buildingid === App.building['name']) {
          temp[0] = unitArray[0];
          unitArray[0] = unitArray[index];
          unitArray[index] = temp[0];
          temp1[0] = buildingArrayModel[0];
          buildingArrayModel[0] = buildingArrayModel[index];
          buildingArrayModel[index] = temp1[0];
        }
      }
      buildingCollection = new Backbone.Collection(buildingArrayModel);
      newunitCollection = new Backbone.Collection(unitArray);
      return [buildingCollection, newunitCollection, templateString];
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
