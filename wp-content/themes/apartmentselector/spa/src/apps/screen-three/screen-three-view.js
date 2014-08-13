// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['marionette'], function(Marionette) {
  var BuildingView, ScreenThreeLayout, UnitTypeChildView, UnitTypeView, UnitView, childViewUnit, emptyChildView, flag_set, unitChildView, unitVariantArray, unitVariantIdArray, unitVariantString;
  flag_set = 0;
  unitVariantArray = '';
  unitVariantIdArray = [];
  unitVariantString = '';
  ScreenThreeLayout = (function(_super) {
    __extends(ScreenThreeLayout, _super);

    function ScreenThreeLayout() {
      return ScreenThreeLayout.__super__.constructor.apply(this, arguments);
    }

    ScreenThreeLayout.prototype.template = '<div class="text-center subTxt m-b-20 unittype hidden animated pulse">We have <span class="bold text-primary"> {{countUnits }} </span> <strong>{{selection}}</strong> apartments in this floor range of the selected tower.</div> <div class="text-center subTxt m-b-20 budget hidden animated pulse">We have <span class="bold text-primary"> {{countUnits }} </span>  apartments in the budget of <strong>{{selection}}</strong> in this floor range of the selected tower.</div> <div class="text-center subTxt m-b-20 refresh hidden animated pulse">You just refreshed the page. You are now seeing <span class="bold text-primary">All</span> apartments across all the towers.</div> <div class="text-center subTxt m-b-20 All hidden animated pulse">You are seeing <span class="bold text-primary">All</span> apartments in the selected floor range of the tower.</div> <div class="introTxt text-center">These apartments are available in different size variations on different floors of the tower. Click on any available apartment for more details. <br><em>(You can scroll between towers to see other options.)</em></div> <div class="introTxt text-center">You are seeing <span class="text-primary variantToggle"> All  </span> variants of your apartment selection</div> <div class="variantBox"> <input type="radio" name="selectall" id="selectall" value="0" />Select All<input type="radio" name="selectall" id="unselectall" value="1" />Unselect All                         <div class="text-right"><span class="variantClose glyphicon glyphicon-remove text-grey"></span></div> <div class="grid-container"> {{#unitVariants}} <div class="grid-block-3" > <a class="grid-link selected" href="#" id="gridlink{{id}}" data-id="{{id}}"> {{sellablearea}} Sq.ft.<input type="hidden" name="checklink{{id}}"   id="checklink{{id}}"   value="1" /> </a> </div> {{/unitVariants}} <div class="variantAction m-t-5 m-b-20"> <a class="btn btn-primary m-r-10 done">DONE</a> <a class="btn btn-default cancel">CANCEL</a> </div> </div> </div> <div id="vs-container" class="vs-container"> <header class="vs-header" id="building-region"></header> <div  id="unit-region"></div> </div> {{#high}} <div class="towerRange"> <h3 class="text-primary text-center semi-bold m-t-40"><u>{{rangetext}}</u></h3> <div class="row m-l-0 m-r-0 m-b-20"> <div class="col-sm-4 col-xs-12"> <img src="../HTML/assets/img/floor-rise.jpg" class="img-responsive center-block"> </div> <!--<div class="col-sm-8 col-xs-3"> <div class="row"> {{#high}} <div class="col-sm-4 p-l-0 p-r-0"> <h1><small>Total {{name}}</small><br>{{count}}</h1> </div> {{/high}} </div>--> <div class="col-sm-8 col-xs-12 m-t-30"> <p>{{text}}</p></div> <!--<div class="row"> <div class="col-sm-4"> </div> <div class="col-sm-4"> </div> <div class="col-sm-4"> </div> </div>--> </div> <!-- <div class="viewsNo m-t-20"> <div class="row m-l-0 m-r-0"> <div class="col-xs-4"> <h4> NO OF <span class="text-primary bold">VIEWS</span> </H4> </div> <div class="col-xs-4"> Garden view<br> Pond View<br> Manas Lake<br> Eco pond </div> <div class="col-xs-4"> Garden view<br> Pond View<br> Manas Lake<br> Eco pond </div> </div> </div>--> </div> {{/high}}                     ';

    ScreenThreeLayout.prototype.className = 'page-container row-fluid';

    ScreenThreeLayout.prototype.regions = {
      buildingRegion: '#building-region',
      unitRegion: '#unit-region'
    };

    ScreenThreeLayout.prototype.events = {
      'click a': function(e) {
        return e.preventDefault();
      },
      'click .grid-link': function(e) {
        var globalUnitArrayInt, globalUnitVariants, id, index, track;
        console.log(unitVariantArray);
        id = $('#' + e.target.id).attr('data-id');
        track = 0;
        if ($('#checklink' + id).val() === '1') {
          console.log(id);
          console.log(index = unitVariantArray.indexOf(parseInt(id)));
          if (index !== -1) {
            unitVariantArray.splice(index, 1);
            $('#checklink' + id).val('0');
            track = 0;
            unitVariantIdArray.push(parseInt(id));
          }
        } else {
          console.log("aaaaaaaaaa");
          track = 1;
          unitVariantArray.push(parseInt(id));
          $('#checklink' + id).val('1');
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
            globalUnitArrayInt.push(parseInt(id));
            unitVariantArray = globalUnitArrayInt;
          }
        }
        if (globalUnitArrayInt.length === unitVariantArray.length) {
          return unitVariantString = 'All';
        } else {
          return unitVariantString = unitVariantArray.join(',');
        }
      },
      'click .done': function(e) {
        var params;
        App.currentStore.unit.reset(UNITS);
        App.currentStore.building.reset(BUILDINGS);
        App.currentStore.unit_type.reset(UNITTYPES);
        App.currentStore.unit_variant.reset(UNITVARIANTS);
        App.filter(params = {});
        App.defaults['unitVariant'] = unitVariantString;
        App.backFilter['screen2'].push("unitVariant");
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
              $('#gridlink' + value).addClass('selected');
              return $('#checklink' + value).val('1');
            } else {
              $('#gridlink' + value).removeClass('selected');
              return $('#checklink' + value).val('0');
            }
          });
        }
      },
      'click #selectall': function(e) {
        console.log(unitVariantArray);
        $.each(unitVariantArray, function(index, value) {
          $('#gridlink' + value).addClass('selected');
          return $('#checklink' + value).val('1');
        });
        return unitVariantString = 'All';
      },
      'click #unselectall': function(e) {
        var remainainArray, value;
        console.log(value = _.first(unitVariantArray));
        remainainArray = _.rest(unitVariantArray);
        unitVariantArray = [];
        unitVariantArray.push(value);
        $.each(remainainArray, function(index, value) {
          $('#gridlink' + value).removeClass('selected');
          return $('#checklink' + value).val('0');
        });
        return unitVariantString = unitVariantArray.join(',');
      }
    };

    ScreenThreeLayout.prototype.onShow = function() {
      var $columns_number, globalUnitArrayInt, globalUnitVariants, scr;
      if (App.screenOneFilter['key'] === 'unitType') {
        $('.unittype').removeClass('hidden');
      } else if (App.screenOneFilter['key'] === 'budget') {
        $('.budget').removeClass('hidden');
      } else if (App.defaults['floor'] === 'All') {
        $('.refresh').removeClass('hidden');
      } else {
        $('.All').removeClass('hidden');
      }
      scr = document.createElement('script');
      scr.src = '../wp-content/themes/apartmentselector/js/src/preload/main.js';
      document.body.appendChild(scr);
      $columns_number = $('.unitTable .cd-table-container').find('.cd-block').length;
      $('.cd-table-container').on('scroll', function() {
        var $this, table_viewport, total_table_width;
        $this = $(this);
        total_table_width = parseInt($('.cd-table-wrapper').css('width').replace('px', ''));
        table_viewport = parseInt($('.unitTable').css('width').replace('px', ''));
        if ($this.scrollLeft() >= total_table_width - table_viewport - $columns_number) {
          $('.unitTable').addClass('table-end');
          return $('.cd-scroll-right').hide();
        } else {
          $('.unitTable').removeClass('table-end');
          return $('.cd-scroll-right').show();
        }
      });
      $('.cd-scroll-right').on('click', function() {
        var $this, column_width, new_left_scroll;
        $this = $(this);
        column_width = $(this).siblings('.cd-table-container').find('.cd-block').eq(0).css('width').replace('px', '');
        new_left_scroll = parseInt($('.cd-table-container').scrollLeft()) + parseInt(column_width);
        return $('.cd-table-container').animate({
          scrollLeft: new_left_scroll
        }, 200);
      });
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
      console.log(unitVariantArray = Marionette.getOption(this, 'uintVariantId'));
      console.log(globalUnitVariants = App.defaults['unitVariant'].split(','));
      globalUnitArrayInt = [];
      $.each(globalUnitVariants, function(index, value) {
        return globalUnitArrayInt.push(parseInt(value));
      });
      if (App.defaults['unitVariant'] !== 'All') {
        console.log(unitVariantArray = _.union(unitVariantArray, unitVariantIdArray));
        $.each(unitVariantArray, function(index, value) {
          var key;
          console.log(value);
          key = _.contains(globalUnitArrayInt, parseInt(value));
          console.log(key);
          if (key === true) {
            $('#gridlink' + value).addClass('selected');
            return $('#checklink' + value).val('1');
          } else {
            console.log(index = unitVariantArray.indexOf(parseInt(value)));
            $('#gridlink' + value).removeClass('selected');
            return $('#checklink' + value).val('0');
          }
        });
      }
      return $('html, body').animate({
        scrollTop: $('#screen-three-region').offset().top
      }, 'slow');
    };

    return ScreenThreeLayout;

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
        var params;
        $('#tower' + this.model.get('id')).removeClass('hidden');
        App.defaults['building'] = this.model.get('id');
        App.filter(params = {});
        msgbus.showApp('header').insideRegion(App.headerRegion).withOptions();
        return this.trigger('building:link:selected');
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

    return UnitTypeChildView;

  })(Marionette.CompositeView);
  childViewUnit = (function(_super) {
    __extends(childViewUnit, _super);

    function childViewUnit() {
      return childViewUnit.__super__.constructor.apply(this, arguments);
    }

    childViewUnit.prototype.template = '<div id="check{{id}}" class="check" > <input type="hidden" id="flag{{id}}" name="flag{{id}}" value="0"/>     												{{name}} <div class="small">{{unitTypeName}} {{unitVariantName}} SQF</div> </div>';

    childViewUnit.prototype.className = 'cd-block';

    childViewUnit.prototype.initialize = function() {
      return this.$el.prop("id", 'unit' + this.model.get("id"));
    };

    childViewUnit.prototype.onShow = function() {
      var flag, myArray, object, track;
      myArray = [];
      $.map(App.defaults, function(value, index) {
        if (value !== 'All' && index !== 'floor') {
          return myArray.push({
            key: index,
            value: value
          });
        }
      });
      console.log(myArray);
      flag = 0;
      object = this;
      track = 0;
      $.each(myArray, function(index, value) {
        var budget_arr, budget_price, buildingModel, floorRise, floorRiseValue, paramKey, unitPrice, unitVariantmodel;
        paramKey = {};
        if (value.key === 'budget') {
          buildingModel = App.master.building.findWhere({
            'id': object.model.get('building')
          });
          floorRise = buildingModel.get('floorrise');
          floorRiseValue = floorRise[object.model.get('floor')];
          unitVariantmodel = App.master.unit_variant.findWhere({
            'id': object.model.get('unitVariant')
          });
          unitPrice = object.model.get('unitPrice');
          budget_arr = value.value.split(' ');
          budget_price = budget_arr[0].split('-');
          console.log(budget_price[0] = budget_price[0] + '00000');
          console.log(budget_price[1] = budget_price[1] + '00000');
          if (parseInt(unitPrice) >= parseInt(budget_price[0]) && parseInt(unitPrice) <= parseInt(budget_price[1])) {
            return flag++;
          }
        } else if (value.key !== 'floor') {
          console.log(value.key);
          console.log(value.value);
          if (object.model.get(value.key) === parseInt(value.value)) {
            return console.log(flag++);
          }
        }
      });
      if (flag === myArray.length) {
        track = 1;
      }
      console.log(flag);
      if (myArray.length === 0) {
        track = 1;
      }
      console.log(this.model.get('unitType'));
      console.log(this.model.get('name'));
      if (track === 1 && this.model.get('status') === 9) {
        $('#check' + this.model.get("id")).addClass('box filtered');
        return $('#flag' + this.model.get("id")).val('1');
      } else if (track === 1 && this.model.get('status') === 8) {
        return $('#check' + this.model.get("id")).addClass('box sold');
      } else {
        $('#check' + this.model.get("id")).addClass('box other');
        return $('#check' + this.model.get("id")).text(this.model.get('unitTypeName'));
      }
    };

    childViewUnit.prototype.events = {
      'click .check': function(e) {
        console.log($('#flag' + this.model.get("id")));
        App.unit['name'] = this.model.get("id");
        App.backFilter['screen3'].push('floor');
        if (parseInt($('#flag' + this.model.get("id")).val()) === 1) {
          return this.trigger('unit:item:selected');
        }
      }
    };

    return childViewUnit;

  })(Marionette.ItemView);
  unitChildView = (function(_super) {
    __extends(unitChildView, _super);

    function unitChildView() {
      return unitChildView.__super__.constructor.apply(this, arguments);
    }

    unitChildView.prototype.template = '<div class="clearfix"></div>';

    unitChildView.prototype.className = 'cd-table-row';

    unitChildView.prototype.childView = childViewUnit;

    unitChildView.prototype.initialize = function() {
      return this.collection = this.model.get('floorunits');
    };

    return unitChildView;

  })(Marionette.CompositeView);
  emptyChildView = (function(_super) {
    __extends(emptyChildView, _super);

    function emptyChildView() {
      return emptyChildView.__super__.constructor.apply(this, arguments);
    }

    emptyChildView.prototype.template = 'No units available for the current selection';

    emptyChildView.prototype.className = 'noUnits';

    return emptyChildView;

  })(Marionette.CompositeView);
  UnitView = (function(_super) {
    __extends(UnitView, _super);

    function UnitView() {
      return UnitView.__super__.constructor.apply(this, arguments);
    }

    UnitView.prototype.template = '<div class="vs-content"> <div  class="unitTable"> <header class="cd-table-column"> <ul> {{#floorcount}} <li> Floor {{id}} </li> {{/floorcount}} </ul> </header> <div class="cd-table-container"> <div class="cd-table-wrapper"> </div> </div> <em class="cd-scroll-right"></em> </div> </div>';

    UnitView.prototype.childView = unitChildView;

    UnitView.prototype.emptyView = emptyChildView;

    UnitView.prototype.tagName = "section";

    UnitView.prototype.childViewContainer = '.cd-table-wrapper';

    UnitView.prototype.collectionEvents = {
      'reset': 'dataUpdated'
    };

    UnitView.prototype.dataUpdated = function() {
      return console.log("aaaaaaaaaaaaa");
    };

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

    UnitTypeView.prototype.className = "vs-wrapper";

    UnitTypeView.prototype.childView = UnitView;

    return UnitTypeView;

  })(Marionette.CompositeView);
  return {
    ScreenThreeLayout: ScreenThreeLayout,
    UnitTypeChildView: UnitTypeChildView,
    UnitTypeView: UnitTypeView
  };
});
