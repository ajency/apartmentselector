// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'src/apps/screen-one/screen-one-view'], function(Extm, ScreenOneView) {
  var ScreenOneController;
  ScreenOneController = (function(_super) {
    __extends(ScreenOneController, _super);

    function ScreenOneController() {
      this.unitTypeClicked = __bind(this.unitTypeClicked, this);
      return ScreenOneController.__super__.constructor.apply(this, arguments);
    }

    ScreenOneController.prototype.initialize = function() {
      this._promises.push(App.store.getUnitTypes());
      return this.wait();
    };

    ScreenOneController.prototype.onComplete = function(unitTypesCollection) {
      var screenOneView;
      screenOneView = new ScreenOneView({
        collection: unitTypesCollection
      });
      this.listenTo(screenOneView, 'childview:unit:type:clicked', this.unitTypeClicked);
      return this.show(screenOneView);
    };

    ScreenOneController.prototype.unitTypeClicked = function(childView, unitTypeId) {
      return App.navigate("#/filter/unittype:" + unitTypeId);
    };

    return ScreenOneController;

  })(Extm.RegionController);
  return msgbus.registerController('screen:one', ScreenOneController);
});
