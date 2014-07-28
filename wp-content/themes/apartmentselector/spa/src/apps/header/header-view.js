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
        var params;
        if (window.location.href.indexOf('screen-three') > -1) {
          App.navigate("screen-two");
          e.preventDefault();
          App.filter(params = {});
          msgbus.showApp('header').insideRegion(App.headerRegion).withOptions();
          return msgbus.showApp('screen:two').insideRegion(App.mainRegion).withOptions();
        } else {
          App.navigate("");
          App.defaults['floor'] = 'All';
          e.preventDefault();
          App.filter(params = {});
          msgbus.showApp('header').insideRegion(App.headerRegion).withOptions();
          return msgbus.showApp('screen:one').insideRegion(App.mainRegion).withOptions();
        }
      }
    };

    HeaderView.prototype.onShow = function() {
      if (window.location.href.indexOf('screen-two') > -1 || window.location.href.indexOf('screen-three') > -1) {

      } else {
        $('.backBtn').addClass('hidden');
        return $('.selearr').text('Apartment Selector');
      }
    };

    return HeaderView;

  })(Marionette.ItemView);
});
