// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['marionette'], function(Marionette) {
  var ScreenOneView, UnitTypeView, m, object, unitType;
  unitType = [];
  object = "";
  m = "";
  UnitTypeView = (function(_super) {
    __extends(UnitTypeView, _super);

    function UnitTypeView() {
      return UnitTypeView.__super__.constructor.apply(this, arguments);
    }

    UnitTypeView.prototype.className = "grid-block-1";

    UnitTypeView.prototype.template = '<a class="grid-link"> <div class="grid-text-wrap"> <span class="grid-main-title">{{name}}</span> <span class="grid-sub-title">{{min_value}} to {{max_value}} (sq. ft.)</span> <input type="hidden" name="check{{id}}"   id="check{{id}}"       value="0" /> </div> </a>';

    UnitTypeView.prototype.events = {
      'click ': 'unitTypeSelected'
    };

    UnitTypeView.prototype.initialize = function() {
      return this.$el.prop("id", 'unittype' + this.model.get("id"));
    };

    UnitTypeView.prototype.unitTypeSelected = function(evt) {
      var buildings, element, index, newColl, newUnits, status, uniqBuildings, unitTypeModel, unitTypeString, _i, _len;
      $.map(App.backFilter, function(value, index) {
        var element, key, screenArray, _i, _len, _results;
        screenArray = App.backFilter[index];
        _results = [];
        for (_i = 0, _len = screenArray.length; _i < _len; _i++) {
          element = screenArray[_i];
          key = App.defaults.hasOwnProperty(element);
          if (key === true) {
            _results.push(App.defaults[element] = 'All');
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      });
      App.layout.screenTwoRegion.el.innerHTML = "";
      App.layout.screenThreeRegion.el.innerHTML = "";
      App.layout.screenFourRegion.el.innerHTML = "";
      App.navigate("");
      App.currentStore.unit.reset(UNITS);
      App.currentStore.building.reset(BUILDINGS);
      App.currentStore.unit_type.reset(UNITTYPES);
      App.currentStore.unit_variant.reset(UNITVARIANTS);
      evt.preventDefault();
      $("li").removeClass('cs-selected');
      $(".cs-placeholder").text('Undecided');
      $('a').removeClass('selected');
      for (index = _i = 0, _len = unitType.length; _i < _len; index = ++_i) {
        element = unitType[index];
        if (parseInt(element) === parseInt(this.model.get('id'))) {
          $("#check" + this.model.get('id')).val('1');
        } else {
          $("#check" + element).val('0');
          unitType = [];
          App.backFilter['screen1'] = [];
        }
      }
      if (parseInt($("#check" + this.model.get('id')).val()) === 0) {
        unitType.push(this.model.get('id'));
        App.backFilter['screen1'].push('unitType');
        $('#unittype' + this.model.get("id") + ' a').addClass('selected');
        $("#check" + this.model.get('id')).val("1");
      } else {
        this.unHighlightedTowers();
        unitType = [];
        App.backFilter['screen1'] = [];
        $("#check" + this.model.get('id')).val("0");
      }
      if (parseInt($("#check" + this.model.get('id')).val()) === 0) {
        $("#finalButton").addClass('disabled btn-default');
        $("#finalButton").removeClass('btn-primary');
        $("#finalButton").text("Show Apartments");
        return false;
      }
      unitTypeString = unitType.join(',');
      App.defaults['unitType'] = unitTypeString;
      App.screenOneFilter['value'] = unitTypeString;
      App.screenOneFilter['key'] = 'unitType';
      $("#finalButton").removeClass('disabled btn-default');
      $("#finalButton").addClass('btn-primary');
      unitTypeModel = App.master.unit_type.findWhere({
        id: parseInt(App.defaults['unitType'])
      });
      $("#finalButton").text("Show " + unitTypeModel.get('name') + " Apartments");
      status = App.currentStore.status.findWhere({
        'name': 'Available'
      });
      newUnits = App.currentStore.unit.where({
        unitType: parseInt(App.defaults['unitType']),
        status: status.get('id')
      });
      newColl = new Backbone.Collection(newUnits);
      buildings = newColl.pluck("building");
      uniqBuildings = _.uniq(buildings);
      return this.showHighlightedTowers(uniqBuildings);
    };

    object = UnitTypeView;

    UnitTypeView.prototype.showHighlightedTowers = function(uniqBuildings) {
      var building, masterbuilding;
      masterbuilding = App.master.building;
      masterbuilding.each(function(index) {
        return $("#hglighttower" + index.get('id')).attr('class', 'overlay');
      });
      building = uniqBuildings;
      return $.each(uniqBuildings, function(index, value) {
        var buidlingValue;
        buidlingValue = App.master.building.findWhere({
          id: parseInt(value)
        });
        return $("#hglighttower" + buidlingValue.get('id')).attr('class', 'overlay highlight');
      });
    };

    UnitTypeView.prototype.unHighlightedTowers = function() {
      var masterbuilding;
      masterbuilding = App.master.building;
      return masterbuilding.each(function(index) {
        return $("#hglighttower" + index.get('id')).attr('class', 'overlay');
      });
    };

    return UnitTypeView;

  })(Marionette.ItemView);
  return ScreenOneView = (function(_super) {
    __extends(ScreenOneView, _super);

    function ScreenOneView() {
      return ScreenOneView.__super__.constructor.apply(this, arguments);
    }

    ScreenOneView.prototype.template = '<div class="row m-l-0 m-r-0"> <div class="col-sm-4"> <div class="text-center introTxt">The apartment selector helps you find your ideal home. Browse through available apartments and find the location, size, budget and layout that best suit you.</div><div class="introTxt text-center">To get started, either:</div><div class="text-center subTxt">Choose a flat type</div> <div class="grid-container"></div><h5 class="text-center m-t-20 m-b-20 bold">OR</h5> <div class="text-center subTxt">Choose a budget</div><section> <select class="cs-select cs-skin-underline" id="budgetValue"> <option value="" disabled selected>Undecided</option> {{#priceArray}}         			<option value="{{id}}">{{name}}</option> {{/priceArray}} </select> </section><div class="h-align-middle m-t-50 m-b-20"> <a href="#screen-two-region" class="btn btn-default btn-lg disabled" id="finalButton">Show Apartments</a> <br><br> </div> </div> <div class="col-sm-8"> <div id="mapplic_new1" class="towersMap center-block"></div> </div> </div>';

    ScreenOneView.prototype.className = 'page-container row-fluid';

    ScreenOneView.prototype.childView = UnitTypeView;

    ScreenOneView.prototype.childViewContainer = '.grid-container';

    ScreenOneView.prototype.events = {
      'click #finalButton': function(e) {
        var budget_price, budget_val;
        if ($(".cs-placeholder").text() !== 'Undecided') {
          budget_val = $(".cs-selected").text().split(' ');
          if (budget_val[1] === 'lakhs') {
            budget_price = budget_val[0].split('-');
            budget_price[0] = budget_price[0] + '00000';
            budget_price[1] = budget_price[1] + '00000';
            budget_price = budget_price.join('-');
          }
          App.defaults['budget'] = $(".cs-selected").text();
          App.backFilter['screen1'].push('budget');
          App.screenOneFilter['value'] = $(".cs-selected").text();
          App.screenOneFilter['key'] = 'budget';
        } else {
          App.defaults['budget'] = 'All';
        }
        $('#screen-two-region').addClass('section');
        $.fn.fullpage.destroy('all');
        return this.trigger('unit:type:clicked');
      },
      'click .cs-selected': function(e) {
        var budget_val, buildings, element, newColl, newUnits, uniqBuildings, _i, _len;
        $.map(App.backFilter, function(value, index) {
          var element, key, screenArray, _i, _len, _results;
          screenArray = App.backFilter[index];
          _results = [];
          for (_i = 0, _len = screenArray.length; _i < _len; _i++) {
            element = screenArray[_i];
            key = App.defaults.hasOwnProperty(element);
            if (key === true) {
              _results.push(App.defaults[element] = 'All');
            } else {
              _results.push(void 0);
            }
          }
          return _results;
        });
        App.layout.screenTwoRegion.el.innerHTML = "";
        App.layout.screenThreeRegion.el.innerHTML = "";
        App.layout.screenFourRegion.el.innerHTML = "";
        App.navigate("");
        App.currentStore.unit.reset(UNITS);
        App.currentStore.building.reset(BUILDINGS);
        App.currentStore.unit_type.reset(UNITTYPES);
        App.currentStore.unit_variant.reset(UNITVARIANTS);
        for (_i = 0, _len = unitType.length; _i < _len; _i++) {
          element = unitType[_i];
          $('a').removeClass('selected');
          $("#check" + element).val("0");
        }
        unitType = [];
        App.defaults['unitType'] = 'All';
        $("#finalButton").removeClass('disabled btn-default');
        $("#finalButton").addClass('btn-primary');
        $("#finalButton").text("Show Apartments in my Budget");
        budget_val = $(".cs-selected").text().split(' ');
        newUnits = App.getBudget(budget_val[0]);
        newColl = new Backbone.Collection(newUnits);
        buildings = newColl.pluck("building");
        uniqBuildings = _.uniq(buildings);
        return this.showHighlightedTowers(uniqBuildings);
      },
      'click a': function(e) {
        return e.preventDefault();
      },
      'mouseover a': function(e) {
        var id, locationData;
        id = e.target.id;
        locationData = m.getLocationData(id);
        return m.showTooltip(locationData);
      },
      'click .tower-over': function(e) {
        var id, locationData;
        e.preventDefault();
        id = e.target.id;
        m.showLocation(id, 800);
        locationData = m.getLocationData(id);
        return m.showTooltip(locationData);
      }
    };

    ScreenOneView.prototype.showHighlightedTowers = function(uniqBuildings) {
      var building, masterbuilding;
      masterbuilding = App.master.building;
      masterbuilding.each(function(index) {
        return $("#hglighttower" + index.get('id')).attr('class', 'overlay');
      });
      building = uniqBuildings;
      return $.each(uniqBuildings, function(index, value) {
        var buidlingValue;
        buidlingValue = App.master.building.findWhere({
          id: parseInt(value)
        });
        return $("#hglighttower" + buidlingValue.get('id')).attr('class', 'overlay highlight');
      });
    };

    ScreenOneView.prototype.onShow = function() {
      var ajaxurl, i, params, selector;
      $('#finalButton').on('click', function() {
        return new jBox('Notice', {
          content: 'Wait 1 Second',
          autoClose: 2000,
          addClass: 'notifyBox',
          position: {
            x: 'center',
            y: 'top'
          },
          animation: {
            open: 'slide:top',
            close: 'slide:top'
          }
        });
      });
      [].slice.call(document.querySelectorAll('select.cs-select')).forEach(function(el) {
        return new SelectFx(el);
      });
      $(".grid-link").click(function() {
        return $(this).toggleClass("selected");
      });
      unitType = [];
      i = 1;
      while (window['mapplic_new' + i] !== void 0) {
        params = window['mapplic_new' + i];
        selector = '#mapplic_new' + i;
        ajaxurl = AJAXURL;
        $(selector).mapplic_new({
          'id': 6,
          'width': params.width,
          'height': params.height
        });
        i++;
      }
      return m = $('#mapplic_new1').data('mapplic_new');
    };

    return ScreenOneView;

  })(Marionette.CompositeView);
});
