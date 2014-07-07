// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['app', 'backbone'], function(App) {
  return App.module("Entities.UnitType", function(UnitType, App) {
    var API, UnitTypeCollection, unitTypeCollection;
    UnitType = (function(_super) {
      __extends(UnitType, _super);

      function UnitType() {
        return UnitType.__super__.constructor.apply(this, arguments);
      }

      UnitType.prototype.idAttribute = 'ID';

      UnitType.prototype.defaults = {
        name: '',
        nooffloors: ''
      };

      UnitType.prototype.name = 'unitType';

      return UnitType;

    })(Backbone.Model);
    UnitTypeCollection = (function(_super) {
      __extends(UnitTypeCollection, _super);

      function UnitTypeCollection() {
        return UnitTypeCollection.__super__.constructor.apply(this, arguments);
      }

      UnitTypeCollection.prototype.model = UnitType;

      UnitTypeCollection.prototype.url = function() {
        return AJAXURL;
      };

      return UnitTypeCollection;

    })(Backbone.Collection);
    unitTypeCollection = new UnitTypeCollection;
    API = {
      getUnitTypes: function() {
        var jsondata;
        jsondata = JSON.parse(UNITTYPE);
        unitTypeCollection.add(jsondata);
        return unitTypeCollection;
      }
    };
    return App.reqres.setHandler("get:unittype:collection", function() {
      return API.getUnitTypes();
    });
  });
});
