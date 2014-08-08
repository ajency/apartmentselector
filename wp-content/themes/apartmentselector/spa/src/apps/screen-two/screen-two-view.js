// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'marionette'], function(Extm, Marionette) {
  var BuildingView, ScreenTwoLayout, UnitTypeChildView, UnitTypeView, UnitView, UnitViewChildView, m, unitVariantArray, unitVariantIdArray, unitVariantString;
  m = "";
  unitVariantArray = '';
  unitVariantIdArray = [];
  unitVariantString = '';
  ScreenTwoLayout = (function(_super) {
    __extends(ScreenTwoLayout, _super);

    function ScreenTwoLayout() {
      return ScreenTwoLayout.__super__.constructor.apply(this, arguments);
    }

    ScreenTwoLayout.prototype.template = '<div class="text-center subTxt m-b-20 unittype hidden animated fadeIn">We have <span class="bold text-primary"> {{unitsCount }} </span> <strong>{{selection}}</strong> apartments</div> <div class="text-center subTxt m-b-20 budget hidden animated fadeIn">We have <span class="bold text-primary"> {{unitsCount }} </span>  apartments in the budget of <strong>{{selection}}</strong></div> <div class="text-center introTxt m-b-10">These apartments are spread over different towers. Each tower has three floor blocks. The number in the boxes indicate the number of apartments of your selection. Select one for more details.</div> <div class="introTxt text-center">You are seeing <span class="text-primary variantToggle"> All  </span> variants of your apartment selection</div> <div class="variantBox"> <div class="text-right"><span class="variantClose glyphicon glyphicon-remove text-grey"></span></div> <div class="grid-container"> {{#unitVariants}} <div class="grid-block-3" > <a class="grid-link selected" href="#" id="grid{{id}}" data-id="{{id}}"> {{sellablearea}} Sq.ft.<input type="hidden" name="check{{id}}"   id="check{{id}}"   value="1" /> </a> </div> {{/unitVariants}} <div class="variantAction m-t-5 m-b-20"> <a class="btn btn-primary m-r-10 done">DONE</a> <a class="btn btn-default cancel">CANCEL</a> </div> </div> </div> <div class="legend text-center m-b-20"> {{#unittypes}} <span class={{classname}}>.</span>{{name}} {{/unittypes}} </div> <div class="towerTable"> <div class="tableHeader"> <ul> <li><a href="#modal" class="remodalcheck"><span class="bold">HIGHRISE</span><br>15-11 Floors</a></li> <li><a href="#modal" class="remodalcheck"><span class="bold">MIDRISE</span><br>10-6 Floors</a></li> <li><a href="#modal" class="remodalcheck"><span class="bold">LOWRISE</span><br>5-1 Floors</a></li> </ul> </div> <div class="tableBody"> <div id="vs-container2" class="vs-container"> <header class="vs-header" id="building-region"></header> <div id="unit-region"></div> </div> </div> </div> <div class="m-t-40 p-l-15 p-r-15 text-center"> <h4 class="bold m-t-0">Where is this tower located in the project?</h4> <p>This is a map of the entire project that shows the location of the tower selected (on the left).</p> <div id="mapplic1" class="towersMap center-block"></div> </div>';

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
      },
      'click .grid-link': function(e) {
        var globalUnitArrayInt, globalUnitVariants, id, index, track;
        console.log(unitVariantArray);
        id = $('#' + e.target.id).attr('data-id');
        track = 0;
        if ($('#check' + id).val() === '1') {
          console.log(id);
          console.log(index = unitVariantArray.indexOf(parseInt(id)));
          if (index !== -1) {
            unitVariantArray.splice(index, 1);
            $('#check' + id).val('0');
            track = 0;
            unitVariantIdArray.push(parseInt(id));
          }
        } else {
          console.log("aaaaaaaaaa");
          track = 1;
          unitVariantArray.push(parseInt(id));
          $('#check' + id).val('1');
        }
        console.log(unitVariantArray);
        globalUnitArrayInt = [];
        if (App.defaults['unitVariant'] !== 'All') {
          globalUnitVariants = App.defaults['unitVariant'].split(',');
          $.each(globalUnitVariants, function(index, value) {
            return globalUnitArrayInt.push(parseInt(value));
          });
        }
        console.log(globalUnitArrayInt);
        if (globalUnitArrayInt.length !== 0) {
          if (track === 0) {
            console.log(track);
            unitVariantArray = _.intersection(unitVariantArray, globalUnitArrayInt);
          } else {
            globalUnitArrayInt.push(id);
            unitVariantArray = globalUnitArrayInt;
          }
        }
        return unitVariantString = unitVariantArray.join(',');
      },
      'click .done': function(e) {
        var params;
        App.defaults['unitVariant'] = unitVariantString;
        App.filter(params = {});
        return this.trigger('unit:variants:selected');
      },
      'click .cancel': function(e) {
        var globalUnitArrayInt, globalUnitVariants;
        console.log(unitVariantIdArray);
        unitVariantArray = _.union(unitVariantArray, unitVariantIdArray);
        $(".variantBox").slideToggle();
        console.log(globalUnitVariants = App.defaults['unitVariant'].split(','));
        globalUnitArrayInt = [];
        $.each(globalUnitVariants, function(index, value) {
          return globalUnitArrayInt.push(parseInt(value));
        });
        if (App.defaults['unitVariant'] !== 'All') {
          return $.each(unitVariantArray, function(index, value) {
            var key;
            console.log(value);
            key = _.contains(globalUnitArrayInt, parseInt(value));
            console.log(key);
            if (key === true) {
              $('#grid' + value).addClass('selected');
              return $('#check' + value).val('1');
            } else {
              $('#grid' + value).removeClass('selected');
              return $('#check' + value).val('0');
            }
          });
        }
      }
    };

    ScreenTwoLayout.prototype.onShow = function() {
      var ajaxurl, globalUnitArrayInt, globalUnitVariants, i, params, scr, selector;
      if (App.screenOneFilter['key'] === 'unitType') {
        $('.unittype').removeClass('hidden');
      } else if (App.screenOneFilter['key'] === 'budget') {
        $('.budget').removeClass('hidden');
      }
      console.log(unitVariantArray = Marionette.getOption(this, 'uintVariantId'));
      console.log(globalUnitVariants = App.defaults['unitVariant'].split(','));
      globalUnitArrayInt = [];
      $.each(globalUnitVariants, function(index, value) {
        return globalUnitArrayInt.push(parseInt(value));
      });
      if (App.defaults['unitVariant'] !== 'All') {
        unitVariantArray = _.union(unitVariantArray, unitVariantIdArray);
        $.each(unitVariantArray, function(index, value) {
          var key;
          console.log(value);
          key = _.contains(globalUnitArrayInt, parseInt(value));
          console.log(key);
          if (key === true) {
            return $('#grid' + value).addClass('selected');
          } else {
            console.log(index = unitVariantArray.indexOf(parseInt(value)));
            $('#grid' + value).removeClass('selected');
            return $('#check' + value).val('0');
          }
        });
      }
      scr = document.createElement('script');
      scr.src = '../wp-content/themes/apartmentselector/js/src/preload/main2.js';
      document.body.appendChild(scr);
      scr = document.createElement('script');
      scr.src = '../wp-content/themes/apartmentselector/js/src/preload/jquery.remodal.js';
      document.body.appendChild(scr);
      $(".variantToggle").click(function() {
        $(this).toggleClass("open");
        $(".variantBox").slideToggle();
      });
      $(".variantClose").click(function() {
        $(".variantBox").slideToggle();
        $(".variantToggle").toggleClass("open");
      });
      $(".grid-link").click(function(e) {
        $(this).toggleClass("selected");
      });
      i = 1;
      while (window['mapplic' + i] !== void 0) {
        params = window['mapplic' + i];
        selector = '#mapplic' + i;
        ajaxurl = AJAXURL;
        $(selector).mapplic({
          'id': 4,
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

    UnitView.prototype.template = '<div class="vs-content"> <div class="row"> <div class="col-sm-6 towerUnits"> <div class="subHeader"> <div class="row"> <div class="col-xs-5"> FLOOR<br>RANGE </div> <div class="col-xs-7 text-right"> NO. OF UNITS OF<br>YOUR SELECTION </div> </div> </div> </div> <div class="col-sm-6 b-grey b-l"> <div class="towerUnits psuedoUnits"></div> <div class="towerDetails"> <div class="row"> <div class="col-xs-4"> <h3 class="m-t-0 m-b-0">Total Apartments</h3> <h2 class="semi-bold m-t-5">{{totalunits}}</h2> </div> <div class="col-xs-4"> <h3 class="m-t-0 m-b-0">Available Apartments</h3> <h2 class="semi-bold m-t-5">{{availableunits}}</h2> </div> <div class="col-xs-4"> <h3 class="m-t-0 m-b-0">Number of Floors</h3> <h2 class="semi-bold m-t-5">{{totalfloors}}</h2> </div> </div> <div class="row"> <div class="col-sm-12 m-t-10"> <div class="col"> <p>Climb leg make muffins or sweet beast play time and hate dog or chew foot. Stretch climb leg. Play time give attitude for all of a sudden go crazy chase imaginary bugs lick butt. Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs. Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything.</p> </div> </div> </div> <div class="row m-l-0 m-r-0 m-b-20"> <div class="col-xs-4"> <h4 class="m-t-0 text-primary"><div class="bold">VIEWS</div>for this tower</h4> </div> <div class="col-xs-4"> <span class="glyphicon glyphicon-asterisk small text-grey"></span> Garden view<br><span class="glyphicon glyphicon-asterisk small text-grey"></span> Pond View </div> <div class="col-xs-4"> <span class="glyphicon glyphicon-asterisk small text-grey"></span> Manas Lake<br><span class="glyphicon glyphicon-asterisk small text-grey"></span> Eco pond </div> </div> </div> </div> </div> </div>';

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
