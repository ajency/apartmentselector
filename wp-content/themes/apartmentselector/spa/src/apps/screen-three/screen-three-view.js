// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['marionette'], function(Marionette) {
  var ScreenThreeView, UnitTypeChildView, UnitTypeView;
  UnitTypeView = (function(_super) {
    __extends(UnitTypeView, _super);

    function UnitTypeView() {
      return UnitTypeView.__super__.constructor.apply(this, arguments);
    }

    UnitTypeView.prototype.className = "grid-block-1";

    UnitTypeView.prototype.template = '<a href="#"  class="grid-link"   > <div class="grid-text-wrap"     > <span class="grid-main-title">{{name}}</span> <span class="grid-sub-title">{{view_name}}</span> </div> </a>';

    UnitTypeView.prototype.events = {
      'click': 'unitSelected'
    };

    UnitTypeView.prototype.unitSelected = function(evt) {
      evt.preventDefault();
      return this.trigger('main:unit:clicked', this.model.get('id'), this.model.get('unitType'), this.model.get('range'), this.model.get('size'));
    };

    return UnitTypeView;

  })(Marionette.ItemView);
  UnitTypeChildView = (function(_super) {
    __extends(UnitTypeChildView, _super);

    function UnitTypeChildView() {
      return UnitTypeChildView.__super__.constructor.apply(this, arguments);
    }

    UnitTypeChildView.prototype.template = '<div class="grid-container">{{floorid}}</div>';

    UnitTypeChildView.prototype.childView = UnitTypeView;

    UnitTypeChildView.prototype.childViewContainer = '.grid-container';

    UnitTypeChildView.prototype.initialize = function() {
      console.log(this.model.get('units'));
      return this.collection = this.model.get('units');
    };

    return UnitTypeChildView;

  })(Marionette.CompositeView);
  return ScreenThreeView = (function(_super) {
    __extends(ScreenThreeView, _super);

    function ScreenThreeView() {
      return ScreenThreeView.__super__.constructor.apply(this, arguments);
    }

    ScreenThreeView.prototype.childView = UnitTypeChildView;

    return ScreenThreeView;

  })(Marionette.CompositeView);
});
