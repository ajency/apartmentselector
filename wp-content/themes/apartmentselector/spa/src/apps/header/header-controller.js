// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'src/apps/header/header-view'], function(Extm, HeaderView) {
  var HeaderController;
  HeaderController = (function(_super) {
    __extends(HeaderController, _super);

    function HeaderController() {
      return HeaderController.__super__.constructor.apply(this, arguments);
    }

    HeaderController.prototype.initialize = function(opt) {
      if (opt == null) {
        opt = {};
      }
      this._promises.push(App.store.getHeaderView(opt));
      return this.wait();
    };

    HeaderController.prototype.onComplete = function(model) {
      var headerView;
      console.log(model);
      headerView = new HeaderView({
        model: model
      });
      return this.show(headerView);
    };

    return HeaderController;

  })(Extm.RegionController);
  return msgbus.registerController('header', HeaderController);
});
