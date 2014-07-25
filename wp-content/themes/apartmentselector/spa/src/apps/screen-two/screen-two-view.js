// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'marionette'], function(Extm, Marionette) {
  var BuildingView, ScreenTwoLayout, UnitTypeChildView, UnitTypeView, UnitView, UnitViewChildView;
  ScreenTwoLayout = (function(_super) {
    __extends(ScreenTwoLayout, _super);

    function ScreenTwoLayout() {
      return ScreenTwoLayout.__super__.constructor.apply(this, arguments);
    }

    ScreenTwoLayout.prototype.template = '<div class="text-center introTxt">We have <span class="bold text-primary"> {{unitsCount }} options</span> for {{selection}} </div> <div class="text-center subTxt m-b-10">Just select your floors to get started</div> <div class="legend text-center m-b-20"> {{#unittypes}} <span class="oneBHK">.</span>{{name}} {{/unittypes}} </div> <div class="row m-r-0 m-l-0"> <div class="col-sm-7 p-l-0 p-r-0"> <div class="towerTable"> <div class="tableHeader"> <ul> <li><a href="#modal"><span class="bold">HIGHRISE</span><br>15-11 Floors</a></li> <li><a href="#modal"><span class="bold">MIDRISE</span><br>10-6 Floors</a></li> <li><a href="#modal"><span class="bold">LOWRISE</span><br>5-1 Floors</a></li> </ul> </div> <div class="tableBody"> <div id="vs-container2" class="vs-container"> <header class="vs-header" id="building-region"></header> <div id="unit-region"></div> </div> </div> </div> </div> <div class="col-sm-5 hidden-xs"> <h3 class="bold m-t-0">Climb leg make muffins or sweet</h3> <p>Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs.</p> </div><div id="mapplic1"></div> </div>';

    ScreenTwoLayout.prototype.className = 'page-container row-fluid';

    ScreenTwoLayout.prototype.regions = {
      buildingRegion: '#building-region',
      unitRegion: '#unit-region'
    };

    ScreenTwoLayout.prototype.onShow = function() {
      var ajaxurl, i, params, scr, selector, _results;
      scr = document.createElement('script');
      scr.src = '../wp-content/themes/apartmentselector/js/src/preload/main2.js';
      document.body.appendChild(scr);
      console.log(AJAXURL);
      i = 1;
      console.log(window['mapplic' + i]);
      _results = [];
      while (window['mapplic' + i] !== void 0) {
        params = window['mapplic' + i];
        selector = '#mapplic' + i;
        ajaxurl = AJAXURL;
        console.log(params.id);
        $(selector).mapplic({
          'id': 4,
          'width': params.width,
          'height': params.height
        });
        _results.push(i++);
      }
      return _results;
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
      'click .link': function() {
        return App.navigate("tower" + this.model.get('id'), {
          trigger: true
        });
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
      var model;
      console.log(this.collection);
      model = this.collection.at(0);
      console.log(model);
      return App.navigate("tower" + model.get('id'), {
        trigger: true
      });
    };

    return UnitTypeChildView;

  })(Marionette.CompositeView);
  UnitViewChildView = (function(_super) {
    __extends(UnitViewChildView, _super);

    function UnitViewChildView() {
      return UnitViewChildView.__super__.constructor.apply(this, arguments);
    }

    UnitViewChildView.prototype.template = '<div class="flatNos">{{name}}</div> </div>';

    UnitViewChildView.prototype.className = 'text-center';

    UnitViewChildView.prototype.events = {
      'click .flatNos': function(e) {
        var end, i, param, rangeArray, rangeModel, rangeString, start;
        param = {};
        param['name'] = this.model.get('range');
        rangeModel = App.currentStore.range.findWhere(param);
        rangeArray = [];
        i = 0;
        start = rangeModel.get('start');
        end = rangeModel.get('end');
        while (parseInt(start) <= parseInt(end)) {
          rangeArray[i] = start;
          start = parseInt(start) + 1;
          i++;
        }
        rangeArray;
        rangeString = rangeArray.join(',');
        App.defaults['floor'] = rangeString;
        App.defaults['unitType'] = 'All';
        App.defaults['unitVariant'] = 'All';
        App.defaults['view'] = 'All';
        App.defaults['budget'] = 'All';
        App.defaults['building'] = 'All';
        App.building['name'] = parseInt(this.model.get('buildingid'));
        return this.trigger('unit:count:selected');
      }
    };

    return UnitViewChildView;

  })(Marionette.ItemView);
  UnitView = (function(_super) {
    __extends(UnitView, _super);

    function UnitView() {
      return UnitView.__super__.constructor.apply(this, arguments);
    }

    UnitView.prototype.template = '<div class="vs-content"></div><div class="towerDetails"> <div class="row"> <div class="col-sm-12"> <img src="assets/img/towerA.jpg" class="img-responsive"> </div> </div> <div class="row"> {{#unittypes}}         		<div class="col-xs-4"> <h1><small>Total {{name}}</small><br>{{count}}</h1> </div> {{/unittypes}} </div> <div class="row"> <div class="col-sm-12 m-t-10"> <div class="col"> <p>Climb leg make muffins or sweet beast play time and hate dog or chew foot. Stretch climb leg. Play time give attitude for all of a sudden go crazy chase imaginary bugs lick butt. Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs. Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything. Give attitude chew iPad power cord, and stick butt in face or chase imaginary bugs. Hate dog destroy couch or under the bed and nap all day. Hate dog flop over and missing until dinner time. Chew iPad power cord stick butt in face so leave hair everywhere. Stretch swat at dog. Stand in front of the computer screen hunt anything that moves yet behind the couch or lick butt intrigued by the shower. Give attitude hate dog but chase imaginary bugs sleep on keyboard or play time.</p> </div> </div> </div> </div>';

    UnitView.prototype.tagName = 'section';

    UnitView.prototype.childView = UnitViewChildView;

    UnitView.prototype.childViewContainer = '.vs-content';

    UnitView.prototype.initialize = function() {
      this.collection = this.model.get('units');
      return this.$el.prop("id", 'tower' + this.model.get("buildingid"));
    };

    return UnitView;

  })(Marionette.CompositeView);
  UnitTypeView = (function(_super) {
    __extends(UnitTypeView, _super);

    function UnitTypeView() {
      return UnitTypeView.__super__.constructor.apply(this, arguments);
    }

    UnitTypeView.prototype.childView = UnitView;

    UnitTypeView.prototype.className = "vs-wrapper";

    return UnitTypeView;

  })(Marionette.CompositeView);
  return {
    ScreenTwoLayout: ScreenTwoLayout,
    UnitTypeChildView: UnitTypeChildView,
    UnitTypeView: UnitTypeView
  };
});
