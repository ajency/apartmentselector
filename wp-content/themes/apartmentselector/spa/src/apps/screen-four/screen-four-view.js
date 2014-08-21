// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['marionette'], function(Marionette) {
  var ScreenFourLayout, UnitMainView, UnitTypeChildView, UnitTypeView, UnitsView;
  ScreenFourLayout = (function(_super) {
    __extends(ScreenFourLayout, _super);

    function ScreenFourLayout() {
      return ScreenFourLayout.__super__.constructor.apply(this, arguments);
    }

    ScreenFourLayout.prototype.template = '<div id="vs-container" class="vs-container flatContainer"> <header class="vs-header" id="unitblock-region"> </header> <div  id="mainunit-region"> </div> <div class="h-align-middle"> <a class="btn btn-primary m-t-20 m-b-20 h-align-middle" name="list" id="list"><span class="glyphicon glyphicon-star"></span> Add to Wishlist</a> <div class="alert alert-success alert-dismissible hide" role="alert" id="errormsg"></div> </div> </div>';

    ScreenFourLayout.prototype.className = 'page-container row-fluid';

    ScreenFourLayout.prototype.regions = {
      unitRegion: '#unitblock-region',
      mainRegion: '#mainunit-region'
    };

    ScreenFourLayout.prototype.events = function() {
      return {
        'click #list': function(e) {
          var cookieOldValue, key;
          console.log(App.unit['name']);
          console.log(cookieOldValue = $.cookie("key"));
          console.log(typeof cookieOldValue);
          if (cookieOldValue === void 0 || $.cookie("key") === "") {
            cookieOldValue = "";
          } else {
            console.log(cookieOldValue = $.cookie("key").split(',').map(function(item) {
              return parseInt(item);
            }));
          }
          console.log(key = $.inArray(App.unit['name'], cookieOldValue));
          if (parseInt(key) === -1) {
            $('#errormsg').text("");
            App.cookieArray.push(parseInt(App.unit['name']));
          } else {
            console.log("Already entered");
            $('#errormsg').text("Already entered");
            $('#errormsg').addClass("inline");
            return false;
          }
          console.log(App.cookieArray);
          console.log(App.cookieArray = $.merge(App.cookieArray, cookieOldValue));
          console.log(App.cookieArray = _.uniq(App.cookieArray));
          $.cookie('key', App.cookieArray);
          console.log($.cookie("key"));
          $('#errormsg').text("The selected flat has been added to your WishList");
          $('#errormsg').addClass("inline");
          return this.showWishList();
        },
        'click .del': function(e) {
          var index, val;
          console.log(App.cookieArray);
          console.log(val = $('#' + e.target.id).attr('data-id'));
          console.log(index = App.cookieArray.indexOf(parseInt(val)));
          App.cookieArray.splice(index, 1);
          $.cookie('key', App.cookieArray);
          console.log($.cookie('key'));
          return this.showWishList();
        },
        'click a': function(e) {
          return e.preventDefault();
        },
        'click .selectedunit': function(e) {
          var body, menuRight, menuTop, rangeModel, showRightPush, showTop, unitModel;
          menuRight = document.getElementById("cbp-spmenu-s2");
          menuTop = document.getElementById("cbp-spmenu-s3");
          showTop = document.getElementById("showTop");
          showRightPush = document.getElementById("showRightPush");
          body = document.body;
          classie.toggle(showRightPush, "active");
          classie.toggle(body, "cbp-spmenu-push-toleft");
          classie.toggle(menuRight, "cbp-spmenu-open");
          App.unit['name'] = e.target.id;
          App.unit['flag'] = 1;
          unitModel = App.master.unit.findWhere({
            id: parseInt(e.target.id)
          });
          App.defaults['unitType'] = unitModel.get('unitType');
          App.defaults['building'] = unitModel.get('building');
          console.log(rangeModel = App.master.range);
          App.backFilter['screen3'].push("floor");
          App.backFilter['screen2'].push("floor", "unitVariant");
          rangeModel.each(function(item) {
            var end, i, rangeArrayVal, start;
            rangeArrayVal = [];
            i = 0;
            start = item.get('start');
            end = item.get('end');
            while (parseInt(start) <= parseInt(end)) {
              rangeArrayVal[i] = parseInt(start);
              start = parseInt(start) + 1;
              i++;
            }
            console.log(jQuery.inArray(parseInt(unitModel.get('floor')), rangeArrayVal));
            if (jQuery.inArray(parseInt(unitModel.get('floor')), rangeArrayVal) === 0) {
              console.log("aaaaaaaaaaa");
              return App.defaults['floor'] = rangeArrayVal.join(',');
            }
          });
          console.log(App.defaults);
          msgbus.showApp('header').insideRegion(App.headerRegion).withOptions();
          return msgbus.showApp('screen:four').insideRegion(App.layout.screenFourRegion).withOptions();
        }
      };
    };

    ScreenFourLayout.prototype.onShow = function() {
      $('#slider-plans').liquidSlider({
        slideEaseFunction: "easeInOutQuad",
        autoSlide: true,
        includeTitle: false
      });
      $('html, body').animate({
        scrollTop: $('#screen-four-region').offset().top
      }, 'slow');
      return this.showWishList();
    };

    ScreenFourLayout.prototype.showWishList = function() {
      var building, element, model, selectedUnitsArray, table, unitType, unitVariant, _i, _len;
      table = "";
      console.log(typeof $.cookie("key"));
      if ($.cookie("key") !== void 0 && $.cookie("key") !== "") {
        selectedUnitsArray = $.cookie("key").split(",");
        table = "<table>";
        for (_i = 0, _len = selectedUnitsArray.length; _i < _len; _i++) {
          element = selectedUnitsArray[_i];
          model = App.master.unit.findWhere({
            id: parseInt(element)
          });
          unitType = App.master.unit_type.findWhere({
            id: model.get('unitType')
          });
          unitVariant = App.master.unit_variant.findWhere({
            id: model.get('unitVariant')
          });
          building = App.master.building.findWhere({
            id: model.get('building')
          });
          table += '<li><a href="#" id="' + element + '" class="selectedunit">' + model.get('name') + '</a> <a href="#" class="del" id="' + element + '" data-id="' + element + '"  >Remove</a></li>';
        }
        table += '</table>';
      }
      return $('#showWishlist').html(table);
    };

    return ScreenFourLayout;

  })(Marionette.LayoutView);
  UnitsView = (function(_super) {
    __extends(UnitsView, _super);

    function UnitsView() {
      return UnitsView.__super__.constructor.apply(this, arguments);
    }

    UnitsView.prototype.template = '<a class="link" href="unit{{id}}">Flat No {{name}}</a>';

    UnitsView.prototype.tagName = 'li';

    UnitsView.prototype.className = 'vs-nav-current';

    return UnitsView;

  })(Marionette.ItemView);
  UnitTypeChildView = (function(_super) {
    __extends(UnitTypeChildView, _super);

    function UnitTypeChildView() {
      return UnitTypeChildView.__super__.constructor.apply(this, arguments);
    }

    UnitTypeChildView.prototype.tagName = 'ul';

    UnitTypeChildView.prototype.className = 'vs-nav';

    UnitTypeChildView.prototype.childView = UnitsView;

    return UnitTypeChildView;

  })(Marionette.CompositeView);
  UnitMainView = (function(_super) {
    __extends(UnitMainView, _super);

    function UnitMainView() {
      return UnitMainView.__super__.constructor.apply(this, arguments);
    }

    UnitMainView.prototype.template = '<div class="vs-content"> <div class="row"> <div class="col-sm-7 p-b-10"> <div class="liquid-slider center-block" id="slider-plans"> <div> <h2 class="title">2D Layout</h2> <img src="{{TwoDimage}}" class="img-responsive"> </div> <div> <h2 class="title">3D Layout</h2> <img src="{{ThreeDimage}}" class="img-responsive"> </div> <div> <h2 class="title">Floor Layout</h2> <img src="{{floorLayoutimage}}" class="img-responsive"> </div> <div> <h2 class="title">Building Position</h2> <img src="{{BuildingPositionimage}}" class="img-responsive"> </div> </div> </div> <div class="col-sm-5"> <h4 class="bold">FLAT SUMMARY</h4> <div class="summary"> <div class="row"> <div class="col-xs-6">CARPET AREA</div> <div class="col-xs-6 text-right text-primary">{{carpetarea}} sqft</div> </div> <div class="row"> <div class="col-xs-6">TERRACE AREA</div> <div class="col-xs-6 text-right text-primary">{{terracearea}} sqft</div> </div> <div class="row"> <div class="col-xs-6">CHARGEABLE AREA</div> <div class="col-xs-6 text-right text-primary">{{sellablearea}} sqft</div> </div> <div class="row"> <div class="col-xs-6">PRICE per SQ.FT - starts from</div> <div class="col-xs-6 text-right text-primary">-</div> </div> </div> </div> </div> <div class="row m-t-20 p-t-20 b-grey b-t"> <div class="col-md-6 p-b-10"> <h4 class="bold">ROOM DIMENSIONS</h4> <div class="summary"> <div class="row p-b-10"> <div class="col-sm-6"> TERRACE <h3 class="text-primary"</h3> </div> <div class="col-sm-6"> TOILET {{#toiletArray}}                                             <h3 class="text-primary">{{size}}</h3> {{/toiletArray}} 										</div> </div> <div class="row m-t-20"> <div class="col-sm-6"> LIVING ROOM <h3 class="text-primary"></h3> </div> <div class="col-sm-6"> KITCHEN <h3 class="text-primary"></h3> </div> </div> </div> </div> <div class="col-md-6"> <h4 class="bold">ROOM DIMENSIONS</h4> <div class="summary facilities"> <div class="row"> </div> <div class="row m-t-20"> </div> </div> </div> </div> </div>';

    UnitMainView.prototype.tagName = "section";

    UnitMainView.prototype.initialize = function() {
      return this.$el.prop("id", 'unit' + this.model.get("id"));
    };

    UnitMainView.prototype.onShow = function() {
      return $('#slider-plans').liquidSlider({
        slideEaseFunction: "easeInOutQuad",
        autoSlide: true,
        includeTitle: false,
        minHeight: 500,
        autoSlideInterval: 500,
        forceAutoSlide: true
      });
    };

    return UnitMainView;

  })(Marionette.CompositeView);
  UnitTypeView = (function(_super) {
    __extends(UnitTypeView, _super);

    function UnitTypeView() {
      return UnitTypeView.__super__.constructor.apply(this, arguments);
    }

    UnitTypeView.prototype.className = "vs-wrapper";

    UnitTypeView.prototype.childView = UnitMainView;

    return UnitTypeView;

  })(Marionette.CompositeView);
  return {
    ScreenFourLayout: ScreenFourLayout,
    UnitTypeChildView: UnitTypeChildView,
    UnitTypeView: UnitTypeView
  };
});
