// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['marionette'], function(Mariontte) {
  var HeaderView;
  return HeaderView = (function(_super) {
    __extends(HeaderView, _super);

    function HeaderView() {
      return HeaderView.__super__.constructor.apply(this, arguments);
    }

    HeaderView.prototype.template = '<div class="backBtn {{textClass}}"> <a  class="text-white"><span class="glyphicon glyphicon-chevron-left "></span></a> </div> <div class="text-center"> <h3 class="text-white m-t-15 selearr">{{textString}}</h3> </div>';

    HeaderView.prototype.className = "header navbar navbar-inverse";

    HeaderView.prototype.events = {
      'click .text-white': function(e) {
        var element, key, params, screenoneArray, screenthreeArray, screentwoArray, _i, _j, _k, _len, _len1, _len2;
        if (window.location.href.indexOf('screen-three') > -1) {
          App.backFilter['screen3'] = [];
          screentwoArray = App.backFilter['screen2'];
          for (_i = 0, _len = screentwoArray.length; _i < _len; _i++) {
            element = screentwoArray[_i];
            key = App.defaults.hasOwnProperty(element);
            if (key === true) {
              App.defaults[element] = 'All';
            }
          }
          console.log(UNITS);
          App.currentStore.unit.reset(UNITS);
          App.currentStore.building.reset(BUILDINGS);
          App.currentStore.unit_type.reset(UNITTYPES);
          App.currentStore.unit_variant.reset(UNITVARIANTS);
          key = App.defaults.hasOwnProperty(App.screenOneFilter['key']);
          if (key === true) {
            App.defaults[App.screenOneFilter['key']] = App.screenOneFilter['value'];
          }
          App.navigate("screen-two");
          e.preventDefault();
          App.filter(params = {});
          msgbus.showApp('header').insideRegion(App.headerRegion).withOptions();
          return msgbus.showApp('screen:two').insideRegion(App.mainRegion).withOptions();
        } else if (window.location.href.indexOf('screen-four') > -1) {
          console.log(App.backFilter['screen3']);
          screenthreeArray = App.backFilter['screen3'];
          for (_j = 0, _len1 = screenthreeArray.length; _j < _len1; _j++) {
            element = screenthreeArray[_j];
            key = App.defaults.hasOwnProperty(element);
            if (key === true) {
              App.defaults[element] = App.floorFilter['name'];
            }
          }
          console.log(App.defaults);
          App.currentStore.unit.reset(UNITS);
          App.currentStore.building.reset(BUILDINGS);
          App.currentStore.unit_type.reset(UNITTYPES);
          App.currentStore.unit_variant.reset(UNITVARIANTS);
          App.navigate("screen-three");
          e.preventDefault();
          App.filter(params = {});
          msgbus.showApp('header').insideRegion(App.headerRegion).withOptions();
          return msgbus.showApp('screen:three').insideRegion(App.mainRegion).withOptions();
        } else {
          App.backFilter['screen2'] = [];
          screenoneArray = App.backFilter['screen1'];
          for (_k = 0, _len2 = screenoneArray.length; _k < _len2; _k++) {
            element = screenoneArray[_k];
            key = App.defaults.hasOwnProperty(element);
            if (key === true) {
              App.defaults[element] = 'All';
            }
          }
          App.currentStore.unit.reset(UNITS);
          App.currentStore.building.reset(BUILDINGS);
          App.currentStore.unit_type.reset(UNITTYPES);
          App.currentStore.unit_variant.reset(UNITVARIANTS);
          App.navigate("");
          console.log(App.defaults);
          e.preventDefault();
          App.filter(params = {});
          msgbus.showApp('header').insideRegion(App.headerRegion).withOptions();
          return msgbus.showApp('screen:one').insideRegion(App.mainRegion).withOptions();
        }
      }
    };

    HeaderView.prototype.onShow = function() {
      if (window.location.href.indexOf('screen-two') > -1 || window.location.href.indexOf('screen-three') > -1 || window.location.href.indexOf('screen-four') > -1) {

      } else {
        $('.backBtn').addClass('hidden');
        return $('.selearr').text('Apartment Selector');
      }
    };

    return HeaderView;

  })(Marionette.ItemView);
});
