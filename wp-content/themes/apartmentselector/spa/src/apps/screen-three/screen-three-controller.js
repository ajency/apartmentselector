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
        countUnits: this.Collection[3],
        templateHelpers: {
          selection: this.Collection[2],
          countUnits: this.Collection[3],
          range: this.Collection[4]
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
      var ModelActualArr, building, buildingArray, buildingArrayModel, buildingCollection, buildings, countUnits, first, flag, floorCollunits, floorUnitsArray, highLength, highUnits, i, index, j, lowUnits, mediumUnits, modelArr, modelIdArr, myArray, newunitCollection, param, paramkey, range, status, templateArr, templateString, track, trackArray, uniqBuildings, unitArray, units, unitsArray, unitsactual, unitslen;
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
      $.map(App.defaults, function(value, index) {
        if (value !== 'All') {
          return myArray.push({
            key: index,
            value: value
          });
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
              if (value.key === 'unitVariant') {
                key = App.master.unit_variant.findWhere({
                  id: parseInt(element)
                });
                templateArr.push(key.get('name'));
              }
              if (value.key === 'building') {
                key = App.master.building.findWhere({
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
                flag = 1;
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
            if (value.key === 'unitVariant') {
              key = App.master.unit_variant.findWhere({
                id: parseInt(value.value)
              });
              templateArr.push(key.get('name'));
            }
            if (value.key === 'building') {
              key = App.master.building.findWhere({
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
              flag = 1;
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
          templateArr.push(range);
        }
        mediumUnits = App.master.range.findWhere({
          name: 'medium'
        });
        if (parseInt(first) >= mediumUnits.get('start') && parseInt(first) <= mediumUnits.get('end')) {
          range = 'MIDRISE';
          templateArr.push(range);
        }
        highUnits = App.master.range.findWhere({
          name: 'high'
        });
        if (parseInt(first) >= highUnits.get('start') && parseInt(first) <= highUnits.get('end')) {
          range = 'HIGHRISE';
          templateArr.push(range);
        }
        templateString = templateArr.join(',');
      } else {
        templateString = templateArr.join(',');
      }
      countUnits = 0;
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
      $.each(unitslen, function(index, value1) {
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
            console.log(unitPrice = (parseInt(unitVariantmodel.get('persqftprice')) + parseInt(floorRiseValue)) * parseInt(unitVariantmodel.get('sellablearea')));
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
      units.each(function(item) {
        if (buildingArray.indexOf(item.get('building')) === -1) {
          return buildingArray.push(item.get('building'));
        }
      });
      $.each(buildingArray, function(index, value) {
        var buildingModel, buildingid, floorArray, floorCountArray, unitCollection, unitsCollection;
        buildingid = value;
        floorArray = [];
        floorCountArray = [];
        unitsArray = [];
        console.log(unitsCollection = units.where({
          building: value
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
        $.each(floorArray, function(index, value) {
          var floorCollection, floorunits;
          floorunits = App.master.unit.where({
            floor: value,
            building: buildingid
          });
          floorunits.sort(function(a, b) {
            return a.get('id') - b.get('id');
          });
          floorCollection = new Backbone.Collection(floorunits);
          unitsArray.push({
            floorunits: floorCollection
          });
          return $.each(floorunits, function(index, value) {
            var str, unitType, unitVariant;
            unitType = App.master.unit_type.findWhere({
              id: value.get('unitType')
            });
            str = unitType.get('name');
            str = str.replace(/\s/g, '');
            value.set('unitTypeName', str);
            unitVariant = App.master.unit_variant.findWhere({
              id: value.get('unitVariant')
            });
            return value.set('unitVariantName', unitVariant.get('name'));
          });
        });
        buildingModel = App.master.building.findWhere({
          id: value
        });
        buildingArrayModel.push(buildingModel);
        unitCollection = new Backbone.Collection(unitsArray);
        return unitArray.push({
          id: value,
          buildingid: value,
          units: unitCollection,
          floorcount: floorCountArray
        });
      });
      building = App.master.building.toArray();
      buildingCollection = App.master.building;
      building.sort(function(a, b) {
        return a.get('id') - b.get('id');
      });
      modelIdArr = [];
      modelArr = [];
      ModelActualArr = [];
      unitsactual = [];
      $.each(building, function(index, value) {
        return modelIdArr.push(value.get('id'));
      });
      index = _.indexOf(modelIdArr, App.defaults['building']);
      highLength = modelIdArr.length - index;
      i = index;
      while (i < modelIdArr.length) {
        modelArr.push(modelIdArr[i]);
        i++;
      }
      j = 0;
      while (j < index) {
        modelArr.push(modelIdArr[j]);
        j++;
      }
      newunitCollection = new Backbone.Collection(unitArray);
      $.each(modelArr, function(index, value) {
        ModelActualArr.push(buildingCollection.get(value));
        return unitsactual.push(newunitCollection.get(value));
      });
      buildingCollection = new Backbone.Collection(ModelActualArr);
      newunitCollection = new Backbone.Collection(unitsactual);
      return [buildingCollection, newunitCollection, templateString, floorCollunits.length, templateString];
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
