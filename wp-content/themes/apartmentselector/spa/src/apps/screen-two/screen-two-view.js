// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'marionette'], function(Extm, Marionette) {
  var BuildingView, ScreenTwoLayout, UnitTypeChildView, UnitTypeView, UnitView, UnitViewChildView, cloneunitVariantArrayColl, count, firstElement, globalUnitArrayInt, m, object, rangeArray, tagsArray, unitVariantArray, unitVariantIdArray, unitVariantString, unitVariants;
  m = "";
  unitVariantArray = '';
  unitVariantIdArray = [];
  unitVariantString = '';
  globalUnitArrayInt = [];
  firstElement = '';
  rangeArray = [];
  tagsArray = [];
  count = 0;
  object = "";
  unitVariants = [];
  cloneunitVariantArrayColl = "";
  ScreenTwoLayout = (function(_super) {
    __extends(ScreenTwoLayout, _super);

    function ScreenTwoLayout() {
      return ScreenTwoLayout.__super__.constructor.apply(this, arguments);
    }

    ScreenTwoLayout.prototype.template = '<div class="row m-l-0 m-r-0"> <div class="col-sm-4"> <div class="text-center subTxt m-b-20 unittype hidden animated pulse">We have <span class="bold text-primary"> {{unitsCount }} </span> <strong>{{selection}}</strong> apartments</div> <div class="text-center subTxt m-b-20 budget hidden animated pulse">We have <span class="bold text-primary"> {{unitsCount }} </span>  apartments in the budget of <strong>{{selection}}</strong></div> <div class="text-center subTxt m-b-20 refresh hidden animated pulse">You are now seeing <span class="bold text-primary">All</span> apartments across all the towers.</div> <div class="text-center introTxt m-b-10">These apartments are spread over different towers. Each tower has three floor blocks. The number in the boxes indicate the number of apartments of your selection. Select one for more details.</div> <div class="introTxt text-center">You are seeing <div id="tagslist" class="taglist"> <ul></ul> </div><span class="text-primary variantToggle1"> </span>variants of your apartment selection</div> <div class="variantBox1"> <div class="pull-left m-l-15"> <input type="checkbox" name="selectall" id="selectall" class="checkbox" value="0" checked/> <label for="selectall">Select/Unselect All</label> </div> <div class="text-right m-b-20"> <span class="variantClose1 glyphicon glyphicon-remove text-grey"></span> </div> <div class="grid-container"> {{#unitVariants}} <div class="grid-block-3" > <a class="grid-link selected" href="#" id="grid{{id}}" data-id="{{id}}"> {{sellablearea}} Sq.ft.<input type="hidden" name="check{{id}}"   id="check{{id}}"   value="1" /> </a> </div> {{/unitVariants}} <div class="variantAction m-t-5 m-b-20"> <a class="btn btn-primary m-r-10 done">DONE</a> <a class="btn btn-default cancel">CANCEL</a> </div> </div> </div> <div class="legend text-center m-b-20"> {{#unittypes}} <span class={{classname}}>.</span>{{name}} {{/unittypes}} </div> <div class="towerTable"> <div class="tableBody"> <div id="vs-container2" class="vs-container"> <header class="vs-header" id="building-region"></header> <div id="unit-region"></div> </div> </div> </div> <div class="h-align-middle m-t-20 m-b-20"> <a href="#screen-three-region" class="btn btn-default btn-lg disabled" id="screen-two-button">Show Apartments</a> </div> </div> <div class="col-sm-8"> <div class="m-t-10 text-center"> <h4 class="bold m-t-0">Where is this tower located in the project?</h4> <p class="light">This is a map of the entire project that shows the location of the tower selected (on the left).</p> <div id="mapplic1" class="towersMap center-block"></div> </div> </div> </div>';

    ScreenTwoLayout.prototype.className = 'page-container row-fluid';

    ScreenTwoLayout.prototype.regions = {
      buildingRegion: '#building-region',
      unitRegion: '#unit-region'
    };

    ScreenTwoLayout.prototype.events = {
      'mouseout .im-pin': function(e) {
        return $('.im-tooltip').hide();
      },
      'mouseover a': function(e) {
        var id, locationData;
        console.log(id = e.target.id);
        locationData = m.getLocationData(id);
        return m.showTooltip(locationData);
      },
      'click a': function(e) {
        var id;
        e.preventDefault();
        console.log(e.target.id);
        return console.log(id = e.target.id);
      },
      'click .tower-link': function(e) {
        var id, locationData;
        e.preventDefault();
        console.log(e.target.id);
        console.log(id = e.target.id);
        m.showLocation(id, 800);
        locationData = m.getLocationData(id);
        return m.showTooltip(locationData);
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
        return this.trigger('show:updated:building', $('#' + e.target.id).attr('data-7'));
      },
      'click .grid-link': function(e) {
        var id, index, track;
        console.log(unitVariantArray);
        count = unitVariantArray.length;
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
        if (globalUnitArrayInt.length !== 0) {
          if (track === 0) {
            console.log(track);
            unitVariantArray = _.intersection(unitVariantArray, globalUnitArrayInt);
          } else {
            globalUnitArrayInt.push(parseInt(id));
            unitVariantArray = globalUnitArrayInt;
          }
        }
        console.log(unitVariantArray = _.uniq(unitVariantArray));
        console.log(firstElement);
        if (unitVariantArray.length === 0) {
          unitVariantString = firstElement.toString();
        } else {
          if (cloneunitVariantArrayColl.length === unitVariantArray.length) {
            unitVariantString = 'All';
          } else {
            unitVariantString = unitVariantArray.join(',');
          }
        }
        console.log(unitVariantString);
        if (unitVariantString === "All") {
          return $('#selectall').attr('checked', true);
        } else {
          return $('#selectall').attr('checked', false);
        }
      },
      'click .done': function(e) {
        var params;
        console.log(unitVariantString);
        App.currentStore.unit.reset(UNITS);
        App.currentStore.building.reset(BUILDINGS);
        App.currentStore.unit_type.reset(UNITTYPES);
        App.currentStore.unit_variant.reset(UNITVARIANTS);
        App.defaults['unitVariant'] = unitVariantString;
        App.filter(params = {});
        return this.trigger('unit:variants:selected');
      },
      'click .cancel': function(e) {
        var globalUnitVariants;
        console.log(unitVariantIdArray);
        unitVariantArray = _.union(unitVariantArray, unitVariantIdArray);
        $(".variantBox1").slideToggle();
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
      },
      'click #selectall': function(e) {
        var remainainArray, tempArray, units, value;
        console.log(cloneunitVariantArrayColl);
        if ($('#' + e.target.id).prop('checked') === true) {
          cloneunitVariantArrayColl.each(function(index) {
            console.log(index.get('id'));
            $('#grid' + index.get('id')).addClass('selected');
            return $('#check' + index.get('id')).val('1');
          });
          units = cloneunitVariantArrayColl.toArray();
          units.sort(function(a, b) {
            return a.get('id') - b.get('id');
          });
          return unitVariantString = 'All';
        } else {
          tempArray = [];
          cloneunitVariantArrayColl.each(function(value) {
            return tempArray.push(parseInt(value.get('id')));
          });
          console.log(value = _.first(tempArray));
          remainainArray = _.rest(tempArray);
          $.each(remainainArray, function(index, value) {
            $('#grid' + value).removeClass('selected');
            $('#check' + value).val('0');
            index = unitVariantArray.indexOf(parseInt(value));
            if (index !== -1) {
              return unitVariantArray.splice(index, 1);
            }
          });
          return unitVariantString = value.toString();
        }
      },
      'click #screen-two-button': function(e) {
        rangeArray = [];
        return this.trigger('unit:count:selected');
      }
    };

    ScreenTwoLayout.prototype.showHighlightedTowers = function() {
      var buidlingValue, building;
      console.log(building = Marionette.getOption(this, 'buildingColl').toArray());
      buidlingValue = _.first(building);
      return setTimeout(function() {
        return $("#highlighttower" + buidlingValue.get('id')).attr('class', 'overlay highlight');
      }, 1000);
    };

    ScreenTwoLayout.prototype.onShow = function() {
      var ajaxurl, globalUnitVariants, i, params, scr, selector, testtext, unitVariantArrayColl, unitVariantArrayText, unitVariantsArray;
      globalUnitArrayInt = [];
      if (App.defaults['unitVariant'] !== 'All') {
        globalUnitVariants = App.defaults['unitVariant'].split(',');
        $.each(globalUnitVariants, function(index, value) {
          return globalUnitArrayInt.push(parseInt(value));
        });
      }
      if (unitVariantString === "All" || App.defaults['unitVariant'] === "All") {
        $('#selectall').attr('checked', true);
      } else {
        $('#selectall').attr('checked', false);
      }
      console.log(document.getElementsByTagName('g')['highlighttower13']);
      if (App.screenOneFilter['key'] === 'unitType') {
        $('.unittype').removeClass('hidden');
      } else if (App.screenOneFilter['key'] === 'budget') {
        $('.budget').removeClass('hidden');
      } else if (App.screenOneFilter['key'] === "") {
        $('.refresh').removeClass('hidden');
      }
      console.log(unitVariantArray = Marionette.getOption(this, 'uintVariantId'));
      unitVariantsArray = Marionette.getOption(this, 'unitVariants');
      unitVariantArrayColl = new Backbone.Collection(unitVariantsArray);
      cloneunitVariantArrayColl = unitVariantArrayColl.clone();
      console.log(unitVariants = unitVariantArray);
      console.log(firstElement = _.first(unitVariantArray));
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
      $(".variantToggle1").click(function() {
        $(this).toggleClass("open");
        $(".variantBox1").slideToggle();
      });
      $(".variantClose1").click(function() {
        $(".variantBox1").slideToggle();
        $(".variantToggle1").toggleClass("open");
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
          'id': 5,
          'width': params.width,
          'height': params.height
        });
        i++;
      }
      m = $('#mapplic1').data('mapplic');
      this.showHighlightedTowers();
      $('html, body').animate({
        scrollTop: $('#screen-two-region').offset().top
      }, 'slow');
      tagsArray = [];
      console.log(testtext = App.defaults['unitVariant']);
      if (testtext !== 'All') {
        unitVariantArrayText = testtext.split(',');
        $.each(unitVariantArrayText, function(index, value) {
          var unitVariantModel;
          console.log(value);
          console.log(unitVariantModel = App.master.unit_variant.findWhere({
            id: parseInt(value)
          }));
          return tagsArray.push({
            id: value,
            area: unitVariantModel.get('sellablearea') + 'Sq.ft.'
          });
        });
      } else {
        unitVariantArrayText = testtext.split(',');
        tagsArray.push({
          id: 'All',
          area: 'All'
        });
      }
      this.doListing();
      return object = this;
    };

    $(document).on("click", ".closeButton", function() {
      var theidtodel;
      console.log(object);
      theidtodel = $(this).parent('li').attr('id');
      console.log("aaaaaaaaaaaaaaaaaaaa");
      return object.delItem($('#' + theidtodel).attr('data-itemNum'));
    });

    ScreenTwoLayout.prototype.doListing = function() {
      $('#tagslist ul li').remove();
      $.each(tagsArray, function(index, value) {
        return $('#tagslist ul').append('<li id="li-item-' + value.id + '" data-itemNum="' + value.id + '"><span class="itemText">' + value.area + '</span><div class="closeButton"></div></li>');
      });
      if (tagsArray.length === 1) {
        return $('.closeButton').addClass('hidden');
      }
    };

    ScreenTwoLayout.prototype.delItem = function(delnum) {
      var i, index, key, params, removeItem, unitvariantarrayValues;
      removeItem = delnum;
      i = 0;
      key = "";
      $.each(tagsArray, function(index, val) {
        if (val.id === delnum) {
          key = i;
        }
        return i++;
      });
      console.log(index = key);
      if (index >= 0) {
        tagsArray.splice(index, 1);
        $('#li-item-' + delnum).remove();
        unitvariantarrayValues = [];
        $.each(tagsArray, function(index, value) {
          return unitvariantarrayValues.push(value.id);
        });
        App.defaults['unitVariant'] = unitvariantarrayValues.join(',');
        console.log(App.defaults['unitVariant']);
        App.currentStore.unit.reset(UNITS);
        App.currentStore.building.reset(BUILDINGS);
        App.currentStore.unit_type.reset(UNITTYPES);
        App.currentStore.unit_variant.reset(UNITVARIANTS);
        App.filter(params = {});
        return this.trigger('unit:variants:selected');
      }
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
        var i, id, params, selector;
        id = 'tower' + this.model.get('id');
        i = 1;
        params = window['mapplic' + i];
        selector = '#mapplic' + i;
        return this.showHighlightedBuildings(this.model.get('id'));
      }
    };

    BuildingView.prototype.showHighlightedBuildings = function(id) {
      var building, masterbuilding;
      if (id == null) {
        id = {};
      }
      masterbuilding = App.master.building;
      masterbuilding.each(function(index) {
        return $("#highlighttower" + index.get('id')).attr('class', 'overlay');
      });
      console.log(building = id);
      return $("#highlighttower" + building).attr('class', 'overlay highlight');
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

    UnitViewChildView.prototype.template = '<!--<div class="box psuedoBox {{classname}} pull-left">{{count}}</div>--> <div id="range{{range}}{{buildingid}}" class="boxLong {{classname}}"> <div class="pull-left light"> <h5 class="rangeName bold m-t-5">{{rangetext}}</h5> <div class="small">{{rangeNo}}</div> </div> <div class="unitCount">{{count}}</div> <div class="clearfix"></div> </div> <input type="hidden" name="checkrange{{range}}{{buildingid}}"   id="checkrange{{range}}{{buildingid}}"       value="0" />                             </div>';

    UnitViewChildView.prototype.className = 'towerSelect';

    UnitViewChildView.prototype.events = {
      'click ': function(e) {
        var element, end, i, index, param, rangeArrayVal, rangeModel, rangeString, start, _i, _len;
        console.log(rangeArray);
        for (index = _i = 0, _len = rangeArray.length; _i < _len; index = ++_i) {
          element = rangeArray[index];
          if (element === this.model.get('range') + this.model.get('buildingid')) {
            $("#checkrange" + this.model.get('range') + this.model.get('buildingid')).val('1');
          } else {
            $("#checkrange" + element).val('0');
            $('#range' + element).removeClass('selected');
            rangeArray = [];
          }
        }
        console.log($("#checkrange" + this.model.get('range') + this.model.get('buildingid')).val());
        if (parseInt($("#checkrange" + this.model.get('range') + this.model.get('buildingid')).val()) === 0) {
          rangeArray.push(this.model.get('range') + this.model.get('buildingid'));
          $('#range' + this.model.get('range') + this.model.get('buildingid')).addClass('selected');
          $("#checkrange" + this.model.get('range') + this.model.get('buildingid')).val("1");
          param = {};
          param['name'] = this.model.get('range');
          console.log(param);
          rangeModel = App.currentStore.range.findWhere(param);
          rangeArrayVal = [];
          i = 0;
          start = rangeModel.get('start');
          end = rangeModel.get('end');
          while (parseInt(start) <= parseInt(end)) {
            rangeArrayVal[i] = start;
            start = parseInt(start) + 1;
            i++;
          }
          rangeArrayVal;
          rangeString = rangeArrayVal.join(',');
          App.defaults['floor'] = rangeString;
          App.backFilter['screen2'].push('floor');
          App.defaults['building'] = parseInt(this.model.get('buildingid'));
          App.backFilter['screen2'].push('building');
          console.log($('#screen-two-button'));
          $('#screen-two-button').removeClass('disabled btn-default');
          $("#screen-two-button").addClass('btn-primary');
        } else {
          rangeArray = [];
          $("#checkrange" + this.model.get('range') + this.model.get('buildingid')).val("0");
          $('#range' + this.model.get('range') + this.model.get('buildingid')).removeClass('selected');
        }
        if (parseInt($("#checkrange" + this.model.get('range') + this.model.get('buildingid')).val()) === 0) {
          $("#screen-two-button").addClass('disabled btn-default');
          $("#screen-two-button").removeClass('btn-primary');
          return false;
        }
      }
    };

    return UnitViewChildView;

  })(Marionette.ItemView);
  UnitView = (function(_super) {
    __extends(UnitView, _super);

    function UnitView() {
      return UnitView.__super__.constructor.apply(this, arguments);
    }

    UnitView.prototype.template = '<div class="vs-content"> <div class="towerUnits"> <div class="subHeader "> <div class="row small light"> <div class="col-xs-5"> FLOOR<br>RANGE </div> <div class="col-xs-7 text-right"> NO. OF UNITS OF<br>YOUR SELECTION </div> </div> </div> </div> <!--<div class="towerDetails m-t-10"> <div class="row"> <div class="col-xs-4"> <h4 class="m-t-0 m-b-0 bold">Total Apartments</h4> <h3 class="light m-t-0">{{totalunits}}</h3> </div> <div class="col-xs-4"> <h4 class="m-t-0 m-b-0 bold">Available Apartments</h4> <h3 class="light m-t-0">{{availableunits}}</h3> </div> <div class="col-xs-4"> <h4 class="m-t-0 m-b-0 bold">Number of Floors</h4> <h3 class="light m-t-0">{{totalfloors}}</h3> </div> </div> <div class="row"> <div class="col-sm-12 m-t-10"> <div class="col"> <p>Climb leg make muffins or sweet beast play time and hate dog or chew foot. Stretch climb leg. Play time give attitude for all of a sudden go crazy chase imaginary bugs lick butt. Claw drapes burrow under covers so hide when guests come over, inspect anything brought into the house hopped up on goofballs. Nap all day swat at dog and rub face on everything stick butt in face all of a sudden go crazy need to chase tail yet rub face on everything.</p> </div> </div> </div> <h4 class="m-t-0 m-b-5 text-primary"><span class="bold">VIEWS</span> for this tower</h4> <div class="row m-b-20"> {{#views}} <div class="col-sm-6"> {{#data}}<span class="glyphicon glyphicon-asterisk small text-grey"></span> {{name}}<br>{{/data}} </div> {{/views}} </div> </div>--> </div>';

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
