// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['marionette'], function(Marionette) {
  var ScreenTwoView, UnitTypeChildView, UnitTypeView;
  UnitTypeView = (function(_super) {
    __extends(UnitTypeView, _super);

    function UnitTypeView() {
      return UnitTypeView.__super__.constructor.apply(this, arguments);
    }

    UnitTypeView.prototype.className = "grid-block-1";

    UnitTypeView.prototype.template = '<a href="#"  class="grid-link"  data-value="{{range}}" > <div class="grid-text-wrap"  id="{{buildingid}}{{name}}"   > <span class="grid-main-title">{{name}}</span> <span class="grid-sub-title">{{low_min_val}} - {{low_max_val}}</span> </div> </a>';

    UnitTypeView.prototype.events = {
      'click ': 'typeOfUnitSelected'
    };

    UnitTypeView.prototype.typeOfUnitSelected = function(evt) {
      evt.preventDefault();
      return this.trigger('type:unit:clicked', this.model.get('buildingid'), this.model.get('unitType'), this.model.get('range'));
    };

    return UnitTypeView;

  })(Marionette.ItemView);
  UnitTypeChildView = (function(_super) {
    __extends(UnitTypeChildView, _super);

    function UnitTypeChildView() {
      return UnitTypeChildView.__super__.constructor.apply(this, arguments);
    }

    UnitTypeChildView.prototype.template = '<div class="grid-container">{{buildingname}}</div>';

    UnitTypeChildView.prototype.childView = UnitTypeView;

    UnitTypeChildView.prototype.childViewContainer = '.grid-container';

    UnitTypeChildView.prototype.initialize = function() {
      console.log(this.model.get('units'));
      return this.collection = this.model.get('units');
    };

    return UnitTypeChildView;

  })(Marionette.CompositeView);
  return ScreenTwoView = (function(_super) {
    __extends(ScreenTwoView, _super);

    function ScreenTwoView() {
      return ScreenTwoView.__super__.constructor.apply(this, arguments);
    }

    ScreenTwoView.prototype.childView = UnitTypeChildView;

    return ScreenTwoView;

  })(Marionette.CompositeView);
});
