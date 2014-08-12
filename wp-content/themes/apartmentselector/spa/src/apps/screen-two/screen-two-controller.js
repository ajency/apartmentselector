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
      this.showUpdateBuilding = __bind(this.showUpdateBuilding, this);
      return ScreenTwoController.__super__.constructor.apply(this, arguments);
    }

    ScreenTwoController.prototype.initialize = function() {
      this.Collection = this._getUnitsCountCollection();
      this.layout = new ScreenTwoView.ScreenTwoLayout({
        collection: this.Collection[1],
        buildingColl: this.Collection[0],
        uintVariantId: this.Collection[9],
        uintVariantIdArray: this.Collection[9],
        templateHelpers: {
          selection: this.Collection[2],
          unitsCount: this.Collection[3],
          unittypes: this.Collection[4],
          high: this.Collection[5],
          medium: this.Collection[6],
          low: this.Collection[7],
          unitVariants: this.Collection[8],
          AJAXURL: AJAXURL
        }
      });
      this.listenTo(this.layout, "show", this.showViews);
      this.listenTo(this.layout, "show:updated:building", this.showUpdateBuilding);
      this.listenTo(this.layout, 'unit:variants:selected', this.showUpdateBuilding);
      return this.show(this.layout);
    };

    ScreenTwoController.prototype.showUpdateBuilding = function(id) {
      console.log(id);
      this.Collection = this._getUnitsCountCollection(id);
      this.layout = new ScreenTwoView.ScreenTwoLayout({
        collection: this.Collection[1],
        buildingColl: this.Collection[0],
        uintVariantId: this.Collection[9],
        uintVariantIdArray: this.Collection[9],
        templateHelpers: {
          selection: this.Collection[2],
          unitsCount: this.Collection[3],
          unittypes: this.Collection[4],
          high: this.Collection[5],
          medium: this.Collection[6],
          low: this.Collection[7],
          unitVariants: this.Collection[8],
          AJAXURL: AJAXURL
        }
      });
      this.listenTo(this.layout, "show", this.showViews);
      this.listenTo(this.layout, "show:updated:building", this.showUpdateBuilding);
      this.listenTo(this.layout, 'unit:variants:selected', this.showUpdateBuilding);
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

    ScreenTwoController.prototype._getUnitsCountCollection = function(paramid) {
      var Countunits, MainCollection, ModelActualArr, arrayvalue, buildingArray, buildingArrayModel, buildingCollection, buildingModel, buildingUnits, buildingsactual, buildingvalue, first, flag, flag1, floorCollection, floorCollunits, floorUnitsArray, hclassname, hcount, highLength, highUnits, hnewarr, hunique, hunitTypeArray, i, index, j, key, keycheck, lclassname, lcount, lnewarr, lowUnits, lunique, lunitTypeArray, mainnewarr, mainunique, mainunitTypeArray, mainunitsTypeArray, mclassname, mcount, mediumUnits, mnewarr, modelArr, modelIdArr, munique, munitTypeArray, myArray, param, paramkey, range, status, templateArr, templateString, uniqUnitvariant, unitColl, unitVariantID, unitVariantModels, units, unitsactual, unitslen, unitvariant;
      if (paramid == null) {
        paramid = {};
      }
      buildingArray = Array();
      buildingArrayModel = Array();
      unitColl = Array();
      templateArr = [];
      mainunitTypeArray = [];
      mainnewarr = [];
      mainunique = {};
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
      flag = 0;
      mainunitsTypeArray = [];
      lunitTypeArray = [];
      lnewarr = [];
      lunique = {};
      munitTypeArray = [];
      mnewarr = [];
      munique = {};
      hunitTypeArray = [];
      hnewarr = [];
      hunique = {};
      lcount = [];
      mcount = [];
      hcount = [];
      lclassname = "";
      mclassname = "";
      hclassname = "";
      $.each(App.defaults, function(index, value) {
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
              return templateArr.push(value);
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
      param = {};
      paramkey = {};
      flag = 0;
      floorUnitsArray = [];
      myArray = [];
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
      floorCollunits = [];
      $.each(floorUnitsArray, function(index, value1) {
        flag = 0;
        $.each(myArray, function(index, value) {
          var budget_arr, budget_price, floorRise, floorRiseValue, paramKey, unitPrice, unitVariantmodel;
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
        if (flag === myArray.length) {
          return floorCollunits.push(value1);
        }
      });
      console.log(floorCollunits);
      floorCollection = new Backbone.Collection(floorCollunits);
      unitvariant = floorCollection.pluck("unitVariant");
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
      console.log(units);
      $.each(units, function(index, value) {
        var maxcoll, unitType, unittypemodel;
        maxcoll = Array();
        if (buildingArray.indexOf(value.get('building')) === -1) {
          buildingArray.push(value.get('building'));
        }
        lowUnits = App.currentStore.range.findWhere({
          name: 'low'
        });
        if (value.get('floor') >= lowUnits.get('start') && value.get('floor') <= lowUnits.get('end')) {
          unittypemodel = App.currentStore.unit_type.findWhere({
            id: value.get('unitType')
          });
          mainunitsTypeArray.push({
            id: unittypemodel.get('id'),
            name: unittypemodel.get('name')
          });
        }
        unitType = App.currentStore.unit_type.findWhere({
          id: value.get('unitType')
        });
        return mainunitTypeArray.push({
          id: unitType.get('id'),
          name: unitType.get('name')
        });
      });
      flag = 0;
      flag1 = 0;
      $.each(mainunitsTypeArray, function(key, item) {
        var count;
        if (!lunique[item.id]) {
          lunitTypeArray = [];
          status = App.currentStore.status.findWhere({
            'name': 'Available'
          });
          count = App.currentStore.unit.where({
            unitType: item.id,
            'status': status.get('id')
          });
          $.each(count, function(index, value) {
            if (value.get('unitType') === 9) {
              flag = 1;
            }
            if (value.get('unitType') === 10) {
              flag1 = 1;
            }
            lowUnits = App.currentStore.range.findWhere({
              name: 'low'
            });
            if ((value.get('floor') >= lowUnits.get('start') && value.get('floor') <= lowUnits.get('end')) && item.id === value.get('unitType')) {
              return lunitTypeArray.push(value.get('id'));
            }
          });
          if (parseInt(flag) === 1) {
            lclassname = 'twoBHK';
          }
          if (parseInt(flag1) === 1) {
            lclassname = 'threeBHK';
          }
          if (parseInt(flag) === 1 && parseInt(flag1) === 1) {
            lclassname = 'multiBHK';
          }
          lnewarr.push({
            id: item.id,
            name: item.name,
            count: lunitTypeArray.length,
            classname: lclassname
          });
          return lunique[item.id] = item;
        }
      });
      flag = 0;
      flag1 = 0;
      $.each(mainunitsTypeArray, function(key, item) {
        var count;
        if (!munique[item.id]) {
          munitTypeArray = [];
          status = App.currentStore.status.findWhere({
            'name': 'Available'
          });
          count = App.currentStore.unit.where({
            unitType: item.id,
            'status': status.get('id')
          });
          $.each(count, function(index, value) {
            if (value.get('unitType') === 9) {
              flag = 1;
            }
            if (value.get('unitType') === 10) {
              flag1 = 1;
            }
            mediumUnits = App.currentStore.range.findWhere({
              name: 'medium'
            });
            if ((value.get('floor') >= mediumUnits.get('start') && value.get('floor') <= mediumUnits.get('end')) && item.id === value.get('unitType')) {
              return munitTypeArray.push(value.get('id'));
            }
          });
          if (parseInt(flag) === 1) {
            mclassname = 'twoBHK';
          }
          if (parseInt(flag1) === 1) {
            mclassname = 'threeBHK';
          }
          if (parseInt(flag) === 1 && parseInt(flag1) === 1) {
            mclassname = 'multiBHK';
          }
          mnewarr.push({
            id: item.id,
            name: item.name,
            count: munitTypeArray.length,
            classname: mclassname
          });
          return munique[item.id] = item;
        }
      });
      flag = 0;
      flag1 = 0;
      $.each(mainunitsTypeArray, function(key, item) {
        var count;
        if (!hunique[item.id]) {
          hunitTypeArray = [];
          status = App.currentStore.status.findWhere({
            'name': 'Available'
          });
          count = App.currentStore.unit.where({
            unitType: item.id,
            'status': status.get('id')
          });
          $.each(count, function(index, value) {
            if (value.get('unitType') === 9) {
              flag = 1;
            }
            if (value.get('unitType') === 10) {
              flag1 = 1;
            }
            highUnits = App.currentStore.range.findWhere({
              name: 'high'
            });
            if ((value.get('floor') >= highUnits.get('start') && value.get('floor') <= highUnits.get('end')) && item.id === value.get('unitType')) {
              return hunitTypeArray.push(value.get('id'));
            }
          });
          console.log(flag);
          console.log(flag1);
          if (parseInt(flag) === 1) {
            hclassname = 'twoBHK';
          }
          if (parseInt(flag1) === 1) {
            hclassname = 'threeBHK';
          }
          if (parseInt(flag) === 1 && parseInt(flag1) === 1) {
            hclassname = 'multiBHK';
          }
          console.log(hclassname);
          hnewarr.push({
            id: item.id,
            name: item.name,
            count: hunitTypeArray.length,
            classname: hclassname
          });
          return hunique[item.id] = item;
        }
      });
      $.each(mainunitTypeArray, function(key, item) {
        var classname, count;
        if (!mainunique[item.id]) {
          status = App.currentStore.status.findWhere({
            'name': 'Available'
          });
          count = App.currentStore.unit.where({
            unitType: item.id,
            'status': status.get('id')
          });
          if (parseInt(item.id) === 9) {
            classname = 'twoBHK';
          } else {
            classname = 'threeBHK';
          }
          mainnewarr.push({
            id: item.id,
            name: item.name,
            classname: classname,
            count: count
          });
          return mainunique[item.id] = item;
        }
      });
      buildingUnits = [];
      console.log(buildingArray);
      $.each(buildingArray, function(index, value) {
        var availableunits, buildingid, data, floors, highArray, high_max_val, high_min_val, itemCollection, lowArray, low_max_val, low_min_val, mainArray, mediumArray, medium_max_val, medium_min_val, newarr, newunits, totalunits, uniqFloors, unique, uniqueViewArry, unitTypeArray, variantsDataValues, viewmodels;
        buildingid = value;
        unitTypeArray = Array();
        newarr = [];
        unique = {};
        viewmodels = [];
        status = App.currentStore.status.findWhere({
          'name': 'Available'
        });
        totalunits = App.currentStore.unit.where({
          'building': value
        });
        $.each(totalunits, function(index, value) {
          var viewsData;
          viewsData = value.get('views');
          return viewmodels = $.merge(viewmodels, viewsData);
        });
        console.log(uniqueViewArry = _.uniq(viewmodels));
        variantsDataValues = [];
        data = [];
        $.each(uniqueViewArry, function(index, value) {
          var viewModel;
          viewModel = App.master.view.findWhere({
            id: parseInt(value)
          });
          data.push({
            id: viewModel.get('id'),
            name: viewModel.get('name')
          });
          if (data.length === 2) {
            variantsDataValues.push({
              data: data
            });
            return data = [];
          }
        });
        console.log(variantsDataValues);
        availableunits = App.currentStore.unit.where({
          'building': value,
          'status': status.get('id')
        });
        floors = App.currentStore.unit.pluck("floor");
        uniqFloors = _.uniq(floors);
        newunits = App.currentStore.unit.where({
          'building': value,
          'status': status.get('id')
        });
        buildingUnits.push({
          id: buildingid,
          count: newunits.length,
          name: 'tower' + buildingid
        });
        lowArray = Array();
        mediumArray = Array();
        highArray = Array();
        mainArray = Array();
        unitTypeArray = [];
        $.each(newunits, function(index, value) {
          var unitType;
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
            highArray.push(value.get('id'));
          }
          unitType = App.currentStore.unit_type.findWhere({
            id: value.get('unitType')
          });
          return unitTypeArray.push({
            id: unitType.get('id'),
            name: unitType.get('name')
          });
        });
        $.each(unitTypeArray, function(key, item) {
          var classname, count;
          if (!unique[item.id]) {
            status = App.currentStore.status.findWhere({
              'name': 'Available'
            });
            count = App.currentStore.unit.where({
              unitType: item.id,
              'status': status.get('id'),
              'building': buildingid
            });
            console.log(item.id);
            if (parseInt(item.id) === 9) {
              classname = 'twoBHK m-l-20';
            } else {
              classname = 'oneBHK';
            }
            newarr.push({
              id: item.id,
              name: item.name,
              count: count.length,
              classname: classname
            });
            return unique[item.id] = item;
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
          munitTypeArray.push({
            id: unittypemodel.get('id'),
            name: unittypemodel.get('name')
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
          hunitTypeArray.push({
            id: unittypemodel.get('id'),
            name: unittypemodel.get('name')
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
          count: highArray.length,
          low_max_val: high_max_val,
          low_min_val: high_min_val,
          range: 'high',
          buildingid: buildingid,
          unittypes: hnewarr,
          classname: hclassname
        });
        mainArray.push({
          count: mediumArray.length,
          low_max_val: medium_max_val,
          low_min_val: medium_min_val,
          range: 'medium',
          buildingid: buildingid,
          unittypes: mnewarr,
          classname: mclassname
        });
        mainArray.push({
          count: lowArray.length,
          low_max_val: low_max_val,
          low_min_val: low_min_val,
          range: 'low',
          buildingid: buildingid,
          unittypes: lnewarr,
          classname: lclassname
        });
        itemCollection = new Backbone.Collection(mainArray);
        buildingModel = App.currentStore.building.findWhere({
          id: value
        });
        unitColl.push({
          id: buildingModel.get('id'),
          buildingname: buildingModel.get('name'),
          units: itemCollection,
          buildingid: buildingModel.get('id'),
          unittypes: newarr,
          availableunits: availableunits.length,
          totalunits: totalunits.length,
          totalfloors: uniqFloors.length,
          views: variantsDataValues
        });
        return buildingArrayModel.push(buildingModel);
      });
      console.log(unitColl);
      console.log(buildingUnits);
      buildingvalue = _.max(buildingUnits, function(model) {
        return model.count;
      });
      console.log(buildingvalue);
      buildingUnits.sort(function(a, b) {
        return a.id - b.id;
      });
      modelIdArr = [];
      modelArr = [];
      ModelActualArr = [];
      $.each(buildingUnits, function(index, value) {
        return modelIdArr.push(value.id);
      });
      console.log(buildingUnits);
      console.log(paramid);
      key = _.isEmpty(paramid);
      if (key === true) {
        index = _.indexOf(modelIdArr, buildingvalue.id);
        modelArr.push(buildingvalue.id);
      } else {
        console.log(keycheck = _.findWhere(buildingUnits, {
          name: paramid
        }));
        index = _.indexOf(modelIdArr, keycheck.id);
        modelArr.push(keycheck.id);
      }
      console.log(modelArr);
      highLength = modelIdArr.length - index;
      i = index + 1;
      while (i < modelIdArr.length) {
        modelArr.push(modelIdArr[i]);
        i++;
      }
      j = 0;
      while (j < index) {
        modelArr.push(modelIdArr[j]);
        j++;
      }
      console.log(modelArr);
      if (modelArr.length === 2) {
        arrayvalue = _.last(modelArr);
        modelArr.push(arrayvalue);
      }
      console.log(modelArr);
      buildingsactual = [];
      unitsactual = [];
      buildingCollection = new Backbone.Collection(buildingArrayModel);
      units = new Backbone.Collection(unitColl);
      $.each(modelArr, function(index, value) {
        value = value;
        buildingsactual.push(buildingCollection.get(value));
        return unitsactual.push(units.get(value));
      });
      console.log(buildingsactual);
      buildingCollection = new Backbone.Collection(buildingsactual);
      units = new Backbone.Collection(unitsactual);
      if (App.defaults['unitType'] !== 'All') {
        mainnewarr = [];
      }
      return [buildingCollection, units, templateString, Countunits.length, mainnewarr, hnewarr, mnewarr, lnewarr, unitVariantModels, unitVariantID];
    };

    return ScreenTwoController;

  })(Extm.RegionController);
  return msgbus.registerController('screen:two', ScreenTwoController);
});
