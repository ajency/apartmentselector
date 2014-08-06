// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'marionette'], function(Extm, Marionette) {
  var BuildingView, ScreenTwoLayout, UnitTypeChildView, UnitTypeView, UnitView, UnitViewChildView, m;
  m = "";
  ScreenTwoLayout = (function(_super) {
    __extends(ScreenTwoLayout, _super);

    function ScreenTwoLayout() {
      return ScreenTwoLayout.__super__.constructor.apply(this, arguments);
    }

    ScreenTwoLayout.prototype.template = '<div class="text-center subTxt m-b-20">We have <span class="bold text-primary"> {{unitsCount }} </span> <strong>{{selection}}</strong> apartments</div> <div class="text-center introTxt m-b-10">These apartments are spread over different towers. Each tower has three floor blocks. The number in the boxes indicate the number of apartments of your selection. Select one for more details.</div> <div class="legend text-center m-b-20"> {{#unittypes}} <span class={{classname}}>.</span>{{name}} {{/unittypes}} </div> <div> <div class="towerTable"> <div class="tableHeader"> <ul> <li><a href="#modal" class="remodalcheck"><span class="bold">HIGHRISE</span><br>15-11 Floors</a></li> <li><a href="#modal" class="remodalcheck"><span class="bold">MIDRISE</span><br>10-6 Floors</a></li> <li><a href="#modal" class="remodalcheck"><span class="bold">LOWRISE</span><br>5-1 Floors</a></li> </ul> </div> <div class="tableBody"> <div id="vs-container2" class="vs-container"> <header class="vs-header" id="building-region"></header> <div id="unit-region"></div> </div> </div> </div> </div> <div class="m-t-40 p-l-15 p-r-15 text-center"> <h4 class="bold m-t-0">Where is this tower located in the project?</h4> <p>This is a map of the entire project that shows the location of the tower selected (on the left).</p> <div id="mapplic1"></div> </div>';

    ScreenTwoLayout.prototype.className = 'page-container row-fluid';

    ScreenTwoLayout.prototype.regions = {
      buildingRegion: '#building-region',
      unitRegion: '#unit-region'
    };

    ScreenTwoLayout.prototype.events = {
      'click a': function(e) {
        return e.preventDefault();
      },
      'click .remodalcheck': function(e) {
        console.log(this);
        return e.preventDefault();
      },
      'click .scroll': function(e) {
        console.log($('#' + e.target.id).attr('data-id'));
        $('html, body').animate({
          scrollTop: 0
        }, 'slow');
        return this.trigger('show:updated:building', $('#' + e.target.id).attr('data-id'));
      }
    };

    ScreenTwoLayout.prototype.onShow = function() {
      var ajaxurl, i, params, points, scr, selector;
      console.log(points = Marionette.getOption(this, 'buildingColl'));
      scr = document.createElement('script');
      scr.src = '../wp-content/themes/apartmentselector/js/src/preload/main2.js';
      document.body.appendChild(scr);
      scr = document.createElement('script');
      scr.src = '../wp-content/themes/apartmentselector/js/src/preload/jquery.remodal.js';
      document.body.appendChild(scr);
      i = 1;
      while (window['mapplic' + i] !== void 0) {
        params = window['mapplic' + i];
        selector = '#mapplic' + i;
        ajaxurl = AJAXURL;
        $(selector).mapplic({
          'id': 5,
          'width': params.width,
          'height': params.height
        });
        i++;
      }
      return m = $('#mapplic1').data('mapplic');
    };

    return ScreenTwoLayout;

  })(Marionette.LayoutView);
  BuildingView = (function(_super) {
    __extends(BuildingView, _super);

    function BuildingView() {
      return BuildingView.__super__.constructor.apply(this, arguments);
    }

    BuildingView.prototype.template = '<a  class="link" href="tower{{id}}">{{name}}</a>';

    BuildingView.prototype.tagName = 'li';

    BuildingView.prototype.events = {
      'click .link': function() {
        var i, id, locationData, params, selector;
        id = 'tower' + this.model.get('id');
        i = 1;
        params = window['mapplic' + i];
        selector = '#mapplic' + i;
        m.showLocation(id, 800);
        locationData = m.getLocationData(id);
        return m.showTooltip(locationData);
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
      var id, model;
      model = this.collection.at(0);
      return id = 'tower' + model.get('id');
    };

    return UnitTypeChildView;

  })(Marionette.CompositeView);
  UnitViewChildView = (function(_super) {
    __extends(UnitViewChildView, _super);

    function UnitViewChildView() {
      return UnitViewChildView.__super__.constructor.apply(this, arguments);
    }

    UnitViewChildView.prototype.template = '<div class="box psuedoBox {{classname}} pull-left">{{count}}</div> <div class="box {{classname}}">{{count}}</div> </div>';

    UnitViewChildView.prototype.className = 'text-center';

    UnitViewChildView.prototype.events = {
      'click .box': function(e) {
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
        App.backFilter['screen2'].push('floor');
        App.defaults['building'] = parseInt(this.model.get('buildingid'));
        App.backFilter['screen2'].push('building');
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

    UnitView.prototype.template = '<div class="vs-content"> <div class="row"> <div class="col-sm-6 towerUnits"> <div class="subHeader"> <div class="row"> <div class="col-xs-5"> FLOOR<br>BLOCK </div> <div class="col-xs-7 text-right"> NO. OF UNITS OF<br>YOUR SELECTION </div> </div> </div> </div> <div class="col-sm-6"> <div class="towerUnits psuedoUnits"></div> <div class="towerDetails"> <div class="row"> <div class="col-sm-12"> <img src="../HTML/assets/img/towerA.jpg" class="img-responsive center-block"> </div> </div> <div class="row"> {{#unittypes}} <div class="col-xs-6"> <h1><small>Total {{name}}</small><br>{{count}}</h1> </div> {{/unittypes}} </div> <div class="row"> <div class="col-sm-12 m-t-10"> <div class="col"> <p>Climb leg make muffins or sweet beast play time and hate dog or chew foot. Stretch climb leg. Play time give attitude for all of a sudden go crazy chase imaginary bugs lick butt. Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs. Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything.</p> </div> </div> </div> <div class="row m-l-0 m-r-0 m-b-20"> <div class="col-xs-4"> <h4> NO OF <div class="text-primary bold">VIEWS</div> </h4> </div> <div class="col-xs-4"> Garden view<br> Pond View<br> Manas Lake<br> Eco pond </div> <div class="col-xs-4"> Garden view<br> Pond View<br> Manas Lake<br> Eco pond </div> </div> </div> </div> </div> </div>';

    UnitView.prototype.tagName = 'section';

    UnitView.prototype.childView = UnitViewChildView;

    UnitView.prototype.childViewContainer = '.towerUnits';

    UnitView.prototype.initialize = function() {
      this.collection = this.model.get('units');
      return this.$el.prop("id", 'tower' + this.model.get("buildingid"));
    };

    UnitView.prototype.onShow = function() {
      if ($("#unit-region section").length < 2) {
        $("#unit-region section").addClass("vs-current");
      }
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
