// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'marionette'], function(Extm, Marionette) {
  var BuildingView, ScreenTwoLayout, UnitTypeChildView, UnitTypeView, UnitView;
  ScreenTwoLayout = (function(_super) {
    __extends(ScreenTwoLayout, _super);

    function ScreenTwoLayout() {
      return ScreenTwoLayout.__super__.constructor.apply(this, arguments);
    }

    ScreenTwoLayout.prototype.template = '<div class="text-center introTxt">We have <span class="bold text-primary"> {{unitsCount }} options</span> for {{selection}} </div> <div class="text-center subTxt m-b-10">Just select your floors to get started</div> <div class="legend text-center m-b-20"> {{#unitType}} <span class="oneBHK">.</span>{{name}} {{/unitType}} </div> <div class="row m-r-0 m-l-0"> <div class="col-sm-7 p-l-0 p-r-0"> <div class="towerTable"> <div class="tableHeader"> <ul> <li><a href="#modal"><span class="bold">HIGHRISE</span><br>15-11 Floors</a></li> <li><a href="#modal"><span class="bold">MIDRISE</span><br>15-11 Floors</a></li> <li><a href="#modal"><span class="bold">LOWRISE</span><br>15-11 Floors</a></li> </ul> </div> <div class="tableBody"> <div id="vs-container2" class="vs-container"> <header class="vs-header" id="building-region"></header> <div id="unit-region"></div> </div> </div> </div> <div class="towerDetails"> <div class="row"> <div class="col-sm-12"> <img src="assets/img/towerA.jpg" class="img-responsive"> </div> </div> <div class="row"> {{#unitType}}         						<div class="col-xs-4"> <h1><small>Total {{name}}</small><br>{{count}}</h1> </div> {{/unitType}} </div> <div class="row"> <div class="col-sm-12 m-t-10"> <div class="col"> <p>Climb leg make muffins or sweet beast play time and hate dog or chew foot. Stretch climb leg. Play time give attitude for all of a sudden go crazy chase imaginary bugs lick butt. Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs. Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.</p> </div> </div> </div> </div> </div> <div class="col-sm-5 hidden-xs"> <h3 class="bold m-t-0">Climb leg make muffins or sweet</h3> <p>Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs.</p> <img src="../../../.../../../HTML/assets/img/map1.jpg" class="img-responsive m-t-20"> </div> </div>';

    ScreenTwoLayout.prototype.className = 'page-container row-fluid';

    ScreenTwoLayout.prototype.regions = {
      buildingRegion: '#building-region',
      unitRegion: '#unit-region'
    };

    ScreenTwoLayout.prototype.onShow = function() {
      var scr;
      scr = document.createElement('script');
      scr.src = '../wp-content/themes/apartmentselector/spa/src/bower_components/preload/main2.js';
      return document.body.appendChild(scr);
    };

    return ScreenTwoLayout;

  })(Marionette.LayoutView);
  BuildingView = (function(_super) {
    __extends(BuildingView, _super);

    function BuildingView() {
      return BuildingView.__super__.constructor.apply(this, arguments);
    }

    BuildingView.prototype.template = '<a class="link" href="tower{{id}}">{{name}}</a>';

    BuildingView.prototype.tagName = 'li';

    BuildingView.prototype.events = {
      'click .link': function(e) {
        console.log(this.model.get('id'));
        return $('#tower' + this.model.get('id')).removeClass('hidden');
      }
    };

    return BuildingView;

  })(Marionette.ItemView);
  UnitTypeChildView = (function(_super) {
    __extends(UnitTypeChildView, _super);

    function UnitTypeChildView() {
      return UnitTypeChildView.__super__.constructor.apply(this, arguments);
    }

    UnitTypeChildView.prototype.tagName = 'ul';

    UnitTypeChildView.prototype.className = 'vs-nav';

    UnitTypeChildView.prototype.childView = BuildingView;

    UnitTypeChildView.prototype.onShow = function() {
      return console.log("aaaaaaaaaaaaa");
    };

    return UnitTypeChildView;

  })(Marionette.CompositeView);
  UnitView = (function(_super) {
    __extends(UnitView, _super);

    function UnitView() {
      return UnitView.__super__.constructor.apply(this, arguments);
    }

    UnitView.prototype.template = '<div class="vs-content"> {{#units}}<div class="text-center"> <div class="flatNos">{{name}}</div> </div> {{/units}} </div>';

    UnitView.prototype.tagName = 'section';

    UnitView.prototype.initialize = function() {
      return this.$el.prop("id", 'tower' + this.model.get("buildingid"));
    };

    UnitView.prototype.onShow = function() {
      return $("#tower1").removeClass('hidden');
    };

    return UnitView;

  })(Marionette.ItemView);
  UnitTypeView = (function(_super) {
    __extends(UnitTypeView, _super);

    function UnitTypeView() {
      return UnitTypeView.__super__.constructor.apply(this, arguments);
    }

    UnitTypeView.prototype.childView = UnitView;

    UnitTypeView.prototype.className = "vs-wrapper";

    UnitTypeView.prototype.initialize = function() {
      var tower;
      tower = this.collection.at(0);
      return $("#tower" + tower.get('id')).show();
    };

    return UnitTypeView;

  })(Marionette.CompositeView);
  return {
    ScreenTwoLayout: ScreenTwoLayout,
    UnitTypeChildView: UnitTypeChildView,
    UnitTypeView: UnitTypeView
  };
});
