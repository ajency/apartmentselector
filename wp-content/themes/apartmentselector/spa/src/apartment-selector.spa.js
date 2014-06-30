// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

require(['extm'], function(Extm) {
  var V;
  window.App = new Extm.Application;
  App.addRegions({
    headerRegion: '#header-region'
  });
  V = (function(_super) {
    __extends(V, _super);

    function V() {
      return V.__super__.constructor.apply(this, arguments);
    }

    V.prototype.template = 'hello world';

    return V;

  })(Marionette.ItemView);
  App.start();
  return App.getRegion('headerRegion').show(new V);
});