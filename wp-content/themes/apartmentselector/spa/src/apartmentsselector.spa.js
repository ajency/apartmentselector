// Generated by CoffeeScript 1.7.1
define('plugin-loader', ['selectFx', 'jquerymousewheel', 'mapplic', 'mapplic_new', 'jqueryEasingmin', 'jquerytouchswipe', 'jqueryliquidslider', 'jqueryCookie', 'sudoSlider', 'underscorestring', 'jbox', 'jReject'], function() {});

define('apps-loader', ['src/apps/footer/footer-controller', 'src/apps/header/header-controller', 'src/apps/screen-one/screen-one-controller', 'src/apps/screen-two/screen-two-controller', 'src/apps/screen-three/screen-three-controller', 'src/apps/screen-four/screen-four-controller', 'src/apps/popup/popup-controller', 'src/apps/main-app/main-layout'], function() {});

require(['plugin-loader', 'extm', 'src/classes/ap-store', 'src/apps/router', 'apps-loader'], function(plugins, Extm) {
  var NEW_BUILDINGS, NEW_UNITS, staticApps;
  window.App = new Extm.Application;
  App.layout = "";
  App.addRegions({
    headerRegion: '#header-region',
    footerRegion: '#footer-region',
    filterRegion: '#filter-region',
    mainRegion: '#main-region',
    wishListRegion: '#wishlist-region'
  });
  NEW_BUILDINGS = _.where(BUILDINGS, {
    phase: 26
  });
  NEW_UNITS = [];
  $.each(BUILDINGS, function(index, value) {
    var temp;
    temp = _.where(UNITS, {
      building: value.id
    });
    return $.merge(NEW_UNITS, temp);
  });
  App.currentStore = {
    'unit': new Backbone.Collection(NEW_UNITS),
    'view': new Backbone.Collection(VIEWS),
    'building': new Backbone.Collection(NEW_BUILDINGS),
    'unit_variant': new Backbone.Collection(UNITVARIANTS),
    'unit_type': new Backbone.Collection(UNITTYPES),
    'status': new Backbone.Collection(STATUS),
    'facings': new Backbone.Collection(FACINGS)
  };
  App.master = {
    'unit': new Backbone.Collection(NEW_UNITS),
    'view': new Backbone.Collection(VIEWS),
    'building': new Backbone.Collection(NEW_BUILDINGS),
    'unit_variant': new Backbone.Collection(UNITVARIANTS),
    'unit_type': new Backbone.Collection(UNITTYPES),
    'status': new Backbone.Collection(STATUS),
    'facings': new Backbone.Collection(FACINGS)
  };
  App.backFilter = {
    'screen1': [],
    'screen2': [],
    'screen3': [],
    'back': ""
  };
  App.defaults = {
    "unitType": 'All',
    'budget': 'All',
    "building": 'All',
    "unitVariant": 'All',
    'floor': 'All',
    'view': 'All',
    'facing': 'All'
  };
  App.filter = function(params) {
    var budgetUnitArray, buildingArray, buildingModel, buildings, element, index, key, param_arr, param_key, paramsArray, uniqBuildings, uniqUnittype, uniqUnitvariant, uniqviews, unittype, unittypeArray, unittypeModel, unitvariant, unitvariantArray, unitvariantModel, view, viewArray, viewModel, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _m;
    if (params == null) {
      params = {};
    }
    if (window.location.href.indexOf('=') > -1) {
      params = params;
      paramsArray = params.split('&');
      for (index = _i = 0, _len = paramsArray.length; _i < _len; index = ++_i) {
        element = paramsArray[index];
        param_key = element.split('=');
        key = App.defaults.hasOwnProperty(param_key[0]);
        if (key === true) {
          if (window.location.href.indexOf('screen-two') > -1) {
            App.backFilter['screen2'].push(param_key[0]);
          } else if (window.location.href.indexOf('screen-three') > -1) {
            App.backFilter['screen3'].push(param_key[0]);
          } else {
            App.backFilter['screen1'].push(param_key[0]);
          }
          App.defaults[param_key[0]] = param_key[1];
        }
      }
      params = 'unitType=' + App.defaults['unitType'] + '&budget=' + App.defaults['budget'] + '&building=' + App.defaults['building'] + '&unitVariant=' + App.defaults['unitVariant'] + '&floor=' + App.defaults['floor'] + '&view=' + App.defaults['view'] + '&facing=' + App.defaults['facing'];
    } else {
      params = 'unitType=' + App.defaults['unitType'] + '&budget=' + App.defaults['budget'] + '&building=' + App.defaults['building'] + '&unitVariant=' + App.defaults['unitVariant'] + '&floor=' + App.defaults['floor'] + '&view=' + App.defaults['view'] + '&facing=' + App.defaults['facing'];
    }
    param_arr = params.split('&');
    budgetUnitArray = [];
    $.each(param_arr, function(index, value) {
      var budget_val, collection, param_val, param_val_arr, paramkey, unitSplitArray, units, value_arr;
      value_arr = value.split('=');
      param_key = value_arr[0];
      param_val = value_arr[1];
      param_val_arr = param_val.split(',');
      paramkey = {};
      paramkey[param_key] = parseInt(param_val);
      if (param_val_arr.length > 1) {
        collection = [];
        unitSplitArray = [];
        $.each(param_val_arr, function(index, value) {
          var collectionNew, units;
          paramkey = {};
          collectionNew = [];
          paramkey[param_key] = parseInt(value);
          collectionNew = App.currentStore.unit.where(paramkey);
          if (collectionNew.length === 0) {
            units = App.currentStore.unit;
            units.each(function(item) {
              if ($.inArray(value, item.get('views')) >= 0 || $.inArray(value, item.get('facing')) >= 0) {
                return unitSplitArray.push(item);
              }
            }, collectionNew = unitSplitArray);
          }
          return $.each(collectionNew, function(index, value) {
            return collection.push(value);
          });
        });
      } else if (param_val_arr.length === 1) {
        budget_val = param_val_arr[0].split(' ');
        if (param_val_arr[0].toUpperCase() === 'ALL') {
          collection = App.currentStore.unit.toArray();
        } else if (budget_val.length > 1) {
          budgetUnitArray = App.getBudget(budget_val[0]);
          collection = budgetUnitArray;
        } else {
          unitSplitArray = [];
          collection = App.currentStore.unit.where(paramkey);
          units = App.currentStore.unit;
          if (collection.length === 0) {
            units.each(function(item) {
              if ($.inArray(value_arr[1], item.get('views')) >= 0 || $.inArray(value, item.get('facing')) >= 0) {
                return unitSplitArray.push(item);
              }
            });
            collection = unitSplitArray;
          }
        }
      }
      return App.currentStore.unit.reset(collection);
    });
    buildings = App.currentStore.unit.pluck("building");
    uniqBuildings = _.uniq(buildings);
    buildingArray = Array();
    for (index = _j = 0, _len1 = uniqBuildings.length; _j < _len1; index = ++_j) {
      element = uniqBuildings[index];
      buildingModel = App.currentStore.building.get(element);
      buildingArray.push(buildingModel);
    }
    unittype = App.currentStore.unit.pluck("unitType");
    uniqUnittype = _.uniq(unittype);
    unittypeArray = Array();
    for (index = _k = 0, _len2 = uniqUnittype.length; _k < _len2; index = ++_k) {
      element = uniqUnittype[index];
      unittypeModel = App.currentStore.unit_type.get(element);
      unittypeArray.push(unittypeModel);
    }
    unitvariant = App.currentStore.unit.pluck("unitVariant");
    uniqUnitvariant = _.uniq(unitvariant);
    unitvariantArray = Array();
    for (index = _l = 0, _len3 = uniqUnitvariant.length; _l < _len3; index = ++_l) {
      element = uniqUnitvariant[index];
      unitvariantModel = App.currentStore.unit_variant.get(element);
      unitvariantArray.push(unitvariantModel);
    }
    view = App.currentStore.unit.pluck("view");
    uniqviews = _.uniq(buildings);
    viewArray = Array();
    for (index = _m = 0, _len4 = uniqviews.length; _m < _len4; index = ++_m) {
      element = uniqviews[index];
      viewModel = App.currentStore.view.get(element);
      viewArray.push(viewModel);
    }
    App.currentStore.building.reset(buildingArray);
    App.currentStore.unit_type.reset(unittypeArray);
    App.currentStore.unit_variant.reset(unitvariantArray);
    App.currentStore.view.reset(viewArray);
    return App.currentStore.unit;
  };
  App.getBudget = function(budget) {
    var budgetUnitArray, budget_arr, status, units, unitsColl;
    budgetUnitArray = [];
    budget_arr = budget.split('-');
    budget_arr[0] = budget_arr[0] + '00000';
    budget_arr[1] = budget_arr[1] + '00000';
    status = App.currentStore.status.findWhere({
      'name': 'Available'
    });
    units = App.currentStore.unit.where({
      'status': status.get('id')
    });
    unitsColl = new Backbone.Collection(units);
    unitsColl.each(function(item) {
      var buildingModel, floorRise, floorRiseValue, unitPrice, unitVariantmodel;
      buildingModel = App.currentStore.building.findWhere({
        'id': item.get('building')
      });
      floorRise = buildingModel.get('floorrise');
      floorRiseValue = floorRise[item.get('floor')];
      unitVariantmodel = App.currentStore.unit_variant.findWhere({
        'id': item.get('unitVariant')
      });
      unitPrice = item.get('unitPrice');
      item.set({
        'unitPrice': 'unitPrice',
        unitPrice: unitPrice
      });
      if (item.get('unitPrice') > parseInt(budget_arr[0]) && item.get('unitPrice') < parseInt(budget_arr[1])) {
        return budgetUnitArray.push(item);
      }
    });
    return budgetUnitArray;
  };
  App.currentRoute = [];
  staticApps = [];
  App.unit = {
    name: '',
    flag: 0
  };
  App.screenOneFilter = {
    key: '',
    value: ''
  };
  if (window.location.hash === '') {
    App.filter();
    staticApps.push(['main:app', App.mainRegion]);
  }
  App.addStaticApps(staticApps);
  return App.start();
});
