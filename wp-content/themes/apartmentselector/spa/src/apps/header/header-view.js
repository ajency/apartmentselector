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

    HeaderView.prototype.template = '<div class="backBtn {{textClass}}"> <a  class="back text-white"><span class="glyphicon glyphicon-chevron-left "></span></a> </div> <div class="rightBtns {{btnClass}}"> <a  id="showTop" class="text-white"><span class="glyphicon glyphicon-filter"></span></a> <a id="showRightPush" class="text-white"><span class="glyphicon glyphicon-user"></span></a> </div> <div class="text-center"> <h4 class="text-white m-t-15 bold text-uppercase"><span class="slctnTxt">Your selection:</span> {{textString}} </h4> </div>';

    HeaderView.prototype.className = "header navbar navbar-inverse";

    HeaderView.prototype.events = {
      'click .back': function(e) {
        var element, key, myArray, params, screenoneArray, screenthreeArray, screentwoArray, _i, _j, _k, _len, _len1, _len2;
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
          console.log(App.layout.screenThreeRegion.el.innerHTML = "");
          return msgbus.showApp('screen:two').insideRegion(App.layout.screenTwoRegion).withOptions();
        } else if (window.location.href.indexOf('screen-four') > -1) {
          console.log(App.backFilter['screen3']);
          screenthreeArray = App.backFilter['screen3'];
          for (_j = 0, _len1 = screenthreeArray.length; _j < _len1; _j++) {
            element = screenthreeArray[_j];
            key = App.defaults.hasOwnProperty(element);
            if (key === true) {
              App.defaults[element] = App.defaults['floor'];
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
          console.log(App.layout.screenFourRegion.el.innerHTML = "");
          return msgbus.showApp('screen:three').insideRegion(App.layout.screenThreeRegion).withOptions();
        } else {
          App.backFilter['screen2'] = [];
          screenoneArray = App.backFilter['screen1'];
          myArray = [];
          $.map(App.defaults, function(value, index) {
            if (value !== 'All') {
              return myArray.push({
                key: index,
                value: value
              });
            }
          });
          for (_k = 0, _len2 = myArray.length; _k < _len2; _k++) {
            element = myArray[_k];
            App.defaults[element.key] = 'All';
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
          console.log(App.layout.screenTwoRegion.el.innerHTML = "");
          return msgbus.showApp('screen:one').insideRegion(App.layout.screenOneRegion).withOptions();
        }
      }
    };

    HeaderView.prototype.onShow = function() {
      var body, disableOther, flag, menuRight, menuTop, showRightPush, showTop;
      console.log("wwwwwwwwwww");
      flag = 0;
      console.log(window.location.href.indexOf('wishList'));
      if (window.location.href.indexOf('wishList') > -1) {
        flag = 1;
      }
      $(window).scroll(function() {
        var height;
        flag = 0;
        height = $(window).scrollTop();
        console.log(flag);
        if (height === 0 && flag === 0) {
          $('.backBtn').addClass('hidden');
          $('.slctnTxt').addClass('hidden');
          return $('h4').addClass('step1');
        }
      });
      disableOther = function(button) {
        if (button !== "showTop") {
          classie.toggle(showTop, "disabled");
        }
        if (button !== "showRightPush") {
          classie.toggle(showRightPush, "disabled");
        }
      };
      menuRight = document.getElementById("cbp-spmenu-s2");
      menuTop = document.getElementById("cbp-spmenu-s3");
      showTop = document.getElementById("showTop");
      showRightPush = document.getElementById("showRightPush");
      body = document.body;
      showTop.onclick = function() {
        classie.toggle(this, "active");
        classie.toggle(menuTop, "cbp-spmenu-open");
        disableOther("showTop");
      };
      showRightPush.onclick = function() {
        classie.toggle(this, "active");
        classie.toggle(body, "cbp-spmenu-push-toleft");
        classie.toggle(menuRight, "cbp-spmenu-open");
        disableOther("showRightPush");
      };
      if (window.location.href.indexOf('screen-two') > -1 || window.location.href.indexOf('screen-three') > -1 || window.location.href.indexOf('screen-four') > -1) {
        return console.log("aaaaaaaaaaa");
      } else if (window.location.href.indexOf('wishList') > -1) {
        $('.rightBtns').addClass('hidden');
        $('.backBtn').addClass('hidden');
        $('.slctnTxt').addClass('hidden');
        return $('h4').addClass('step1');
      } else {
        $('.backBtn').addClass('hidden');
        $('.slctnTxt').addClass('hidden');
        return $('h4').addClass('step1');
      }
    };

    return HeaderView;

  })(Marionette.ItemView);
});
