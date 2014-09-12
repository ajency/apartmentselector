// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['marionette'], function(Marionette) {
  var ApartmentSelector, RouterAPI;
  ApartmentSelector = (function(_super) {
    __extends(ApartmentSelector, _super);

    function ApartmentSelector() {
      return ApartmentSelector.__super__.constructor.apply(this, arguments);
    }

    ApartmentSelector.prototype.appRoutes = {
      'wishList': 'showpopup',
      'screen-four': 'showSelectedUnit',
      'screen-three': 'showUnits',
      'screen-two': 'show',
      'screen-one': 'showValues',
      ':params': 'showValues',
      'screen-two/:params': 'show',
      'screen-three/:params': 'showUnits',
      'screen-four/:params': 'showSelectedUnit'
    };

    return ApartmentSelector;

  })(Marionette.AppRouter);
  RouterAPI = {
    showValues: function(params) {
      if (params == null) {
        params = {};
      }
      App.filter(params);
      setTimeout(function(x) {
        return msgbus.showApp('header').insideRegion(App.headerRegion).withOptions();
      }, 1000);
      return msgbus.showApp('screen:one').insideRegion(App.layout.screenOneRegion).withOptions();
    },
    show: function(params) {
      var flag;
      if (params == null) {
        params = {};
      }
      App.filter(params);
      setTimeout(function(x) {
        return msgbus.showApp('header').insideRegion(App.headerRegion).withOptions();
      }, 1000);
      flag = 0;
      $.map(App.defaults, function(value, index) {
        if (value !== 'All') {
          return flag = 1;
        }
      });
      if (flag === 0) {
        msgbus.showApp('main:app').insideRegion(App.mainRegion).withOptions();
        msgbus.showApp('screen:one').insideRegion(App.layout.screenOneRegion).withOptions();
      }
      return msgbus.showApp('screen:two').insideRegion(App.layout.screenTwoRegion).withOptions();
    },
    showUnits: function(params) {
      var flag;
      if (params == null) {
        params = {};
      }
      App.filter(params = {});
      setTimeout(function(x) {
        return msgbus.showApp('header').insideRegion(App.headerRegion).withOptions();
      }, 1000);
      flag = 0;
      $.map(App.defaults, function(value, index) {
        if (value !== 'All') {
          return flag = 1;
        }
      });
      if (flag === 0) {
        msgbus.showApp('main:app').insideRegion(App.mainRegion).withOptions();
        msgbus.showApp('screen:one').insideRegion(App.layout.screenOneRegion).withOptions();
        msgbus.showApp('screen:two').insideRegion(App.layout.screenTwoRegion).withOptions();
      }
      return msgbus.showApp('screen:three').insideRegion(App.layout.screenThreeRegion).withOptions();
    },
    showSelectedUnit: function(params) {
      var flag;
      if (params == null) {
        params = {};
      }
      App.filter(params = {});
      setTimeout(function(x) {
        return msgbus.showApp('header').insideRegion(App.headerRegion).withOptions();
      }, 1000);
      flag = 0;
      $.map(App.defaults, function(value, index) {
        if (value !== 'All') {
          return flag = 1;
        }
      });
      if (flag === 0) {
        msgbus.showApp('main:app').insideRegion(App.mainRegion).withOptions();
        msgbus.showApp('screen:one').insideRegion(App.layout.screenOneRegion).withOptions();
        msgbus.showApp('screen:two').insideRegion(App.layout.screenTwoRegion).withOptions();
        msgbus.showApp('screen:three').insideRegion(App.layout.screenThreeRegion).withOptions();
      }
      return msgbus.showApp('screen:four').insideRegion(App.layout.screenFourRegion).withOptions();
    },
    showpopup: function() {
      msgbus.showApp('header').insideRegion(App.headerRegion).withOptions();
      return msgbus.showApp('popup').insideRegion(App.mainRegion).withOptions();
    }
  };
  return new ApartmentSelector({
    controller: RouterAPI
  });
});
