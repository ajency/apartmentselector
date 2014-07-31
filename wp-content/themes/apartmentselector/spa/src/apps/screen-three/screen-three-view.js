// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['marionette'], function(Marionette) {
  var BuildingView, ScreenThreeLayout, UnitTypeChildView, UnitTypeView, UnitView, childViewUnit, unitChildView;
  ScreenThreeLayout = (function(_super) {
    __extends(ScreenThreeLayout, _super);

    function ScreenThreeLayout() {
      return ScreenThreeLayout.__super__.constructor.apply(this, arguments);
    }

    ScreenThreeLayout.prototype.template = '<h3 class="text-center introTxt m-b-30">We have <span class="bold text-primary">25 options</span> for 1BHK <br><small>Select your flat to get started</small></h3> <div id="vs-container" class="vs-container"> <header class="vs-header" id="building-region"> </header> <div  id="unit-region"> </div> </div>';

    ScreenThreeLayout.prototype.className = 'page-container row-fluid';

    ScreenThreeLayout.prototype.regions = {
      buildingRegion: '#building-region',
      unitRegion: '#unit-region'
    };

    ScreenThreeLayout.prototype.onShow = function() {
      var $columns_number, scr;
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
      return $('.cd-scroll-right').on('click', function() {
        var $this, column_width, new_left_scroll;
        $this = $(this);
        column_width = $(this).siblings('.cd-table-container').find('.cd-block').eq(0).css('width').replace('px', '');
        new_left_scroll = parseInt($('.cd-table-container').scrollLeft()) + parseInt(column_width);
        return $('.cd-table-container').animate({
          scrollLeft: new_left_scroll
        }, 200);
      });
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

    return UnitTypeChildView;

  })(Marionette.CompositeView);
  childViewUnit = (function(_super) {
    __extends(childViewUnit, _super);

    function childViewUnit() {
      return childViewUnit.__super__.constructor.apply(this, arguments);
    }

    childViewUnit.prototype.template = '<div id="check{{id}}" class="check" > {{name}} <div class="small">{{unitTypeName}} {{unitVariantName}} SQF</div> </div>';

    childViewUnit.prototype.className = 'cd-block';

    childViewUnit.prototype.initialize = function() {
      return this.$el.prop("id", 'unit' + this.model.get("id"));
    };

    childViewUnit.prototype.onShow = function() {
      var element, flag, key, myArray, object, _i, _len, _ref;
      myArray = [];
      console.log(App.Cloneddefaults);
      console.log(App.backFilter);
      _ref = App.backFilter['screen1'];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        element = _ref[_i];
        key = App.Cloneddefaults.hasOwnProperty(element);
        if (key === true) {
          myArray.push({
            key: element,
            value: App.Cloneddefaults[element]
          });
        }
      }
      console.log(myArray);
      flag = 0;
      object = this;
      $.each(myArray, function(index, value) {
        var budget_price, buildingModel, floorRise, floorRiseValue, paramKey, unitPrice, unitVariantmodel;
        paramKey = {};
        if (value.key === 'budget') {
          buildingModel = App.currentStore.building.findWhere({
            'id': object.model.get('building')
          });
          floorRise = buildingModel.get('floorrise');
          floorRiseValue = floorRise[object.model.get('floor')];
          unitVariantmodel = App.currentStore.unit_variant.findWhere({
            'id': object.model.get('unitVariant')
          });
          console.log(unitPrice = (parseInt(unitVariantmodel.get('persqftprice')) + parseInt(floorRiseValue)) * parseInt(unitVariantmodel.get('sellablearea')));
          budget_price = value.value.split('-');
          console.log(budget_price[0] = budget_price[0]);
          console.log(budget_price[1] = budget_price[1]);
          if (parseInt(unitPrice) >= parseInt(budget_price[0]) && parseInt(unitPrice) <= parseInt(budget_price[1])) {
            return flag = 1;
          }
        } else {
          if (object.model.get(value.key) === parseInt(value.value)) {
            return console.log(flag = 1);
          }
        }
      });
      console.log(myArray.length);
      if (myArray.length === 0) {
        flag = 1;
      }
      console.log(flag);
      if (flag === 1 && this.model.get('status') === 9) {
        return $('#check' + this.model.get("id")).addClass('box filtered');
      } else if (flag === 1 && this.model.get('status') === 8) {
        return $('#check' + this.model.get("id")).addClass('box sold');
      } else {
        $('#check' + this.model.get("id")).addClass('box other');
        return $('#check' + this.model.get("id")).text(this.model.get('unitTypeName'));
      }
    };

    childViewUnit.prototype.events = {
      'click .check': function(e) {
        App.unit['name'] = this.model.get("id");
        App.floorFilter['name'] = App.defaults['floor'];
        App.defaults['floor'] = this.model.get("floor");
        App.backFilter['screen3'].push('floor');
        App.building['name'] = parseInt(this.model.get('building'));
        return this.trigger('unit:item:selected');
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
  UnitView = (function(_super) {
    __extends(UnitView, _super);

    function UnitView() {
      return UnitView.__super__.constructor.apply(this, arguments);
    }

    UnitView.prototype.template = '<div class="vs-content"><div  class="unitTable"> <header class="cd-table-column"> <ul> {{#floorcount}}         									<li> Floor {{id}} </li> {{/floorcount}} </ul> </header> <div class="cd-table-container"><div class="cd-table-wrapper"> </div></div><em class="cd-scroll-right"></em></div></div>';

    UnitView.prototype.childView = unitChildView;

    UnitView.prototype.tagName = "section";

    UnitView.prototype.childViewContainer = '.cd-table-wrapper';

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
