// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['marionette'], function(Mariontte) {
  var FooterView;
  return FooterView = (function(_super) {
    __extends(FooterView, _super);

    function FooterView() {
      return FooterView.__super__.constructor.apply(this, arguments);
    }

    FooterView.prototype.template = '<p style="text-align:center;" class="termsTxt"><a  href="http://manaslake.com/terms-conditions/" target="_new">Terms &amp; Conditions</a></p>';

    return FooterView;

  })(Marionette.ItemView);
});
