// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['marionette'], function(Marionette) {
  var ScreenOneView, UnitTypeView, unitType;
  unitType = [];
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
      var index, unitTypeString;
      evt.preventDefault();
      $("li").removeClass('cs-selected');
      $(".cs-placeholder").text('Undecided');
      if (parseInt($("#check" + this.model.get('id')).val()) === 0) {
        unitType.push(this.model.get('id'));
        $("#check" + this.model.get('id')).val("1");
      } else {
        index = unitType.indexOf(this.model.get('id'));
        unitType.splice(index, 1);
        $("#check" + this.model.get('id')).val("0");
      }
      console.log(unitType.length);
      if (unitType.length === 0) {
        $("#finalButton").addClass('disabled');
        return false;
      }
      unitTypeString = unitType.join(',');
      App.defaults['unitType'] = unitTypeString;
      return $("#finalButton").removeClass('disabled');
    };

    return UnitTypeView;

  })(Marionette.ItemView);
  return ScreenOneView = (function(_super) {
    __extends(ScreenOneView, _super);

    function ScreenOneView() {
      return ScreenOneView.__super__.constructor.apply(this, arguments);
    }

    ScreenOneView.prototype.template = '<div class="text-center introTxt">Select your Preference</div><div class="text-center subTxt">Select your flat to get started</div> <div class="grid-container"></div><h4 class="text-center m-t-20 m-b-20">OR</h4> <div class="text-center subTxt">What is your budget?</div><section> <select class="cs-select cs-skin-underline" id="budgetValue"> <option value="" disabled selected>Undecided</option> <option value="10-35 lakhs">10-35 lakhs</option> <option value="35-45 lakhs">35-45 lakhs</option> <option value="45-55 lakhs">45-55 lakhs</option> </select> </section><div class="h-align-middle m-t-50 m-b-20"> <a class="btn btn-primary btn-large disabled" id="finalButton">Continue with Selection</a> <br><br> </div>';

    ScreenOneView.prototype.className = 'page-container row-fluid';

    ScreenOneView.prototype.childView = UnitTypeView;

    ScreenOneView.prototype.childViewContainer = '.grid-container';

    ScreenOneView.prototype.events = {
      'click #finalButton': function(e) {
        var budget_price, budget_val;
        console.log($(".cs-placeholder").text());
        if ($(".cs-placeholder").text() !== 'Undecided') {
          budget_val = $(".cs-selected").text().split(' ');
          if (budget_val[1] === 'lakhs') {
            budget_price = budget_val[0].split('-');
            budget_price[0] = budget_price[0] + '00000';
            budget_price[1] = budget_price[1] + '00000';
            budget_price = budget_price.join('-');
          }
          console.log(budget_price);
          App.defaults['budget'] = budget_price;
        } else {
          App.defaults['budget'] = 'All';
        }
        return this.trigger('unit:type:clicked');
      },
      'click .cs-selected': function(e) {
        var element, _i, _len;
        for (_i = 0, _len = unitType.length; _i < _len; _i++) {
          element = unitType[_i];
          $('a').removeClass('selected');
          $("#check" + element).val("0");
        }
        unitType = [];
        App.defaults['unitType'] = 'All';
        return $("#finalButton").removeClass('disabled');
      }
    };

    ScreenOneView.prototype.onShow = function() {
      [].slice.call(document.querySelectorAll('select.cs-select')).forEach(function(el) {
        return new SelectFx(el);
      });
      $(".grid-link").click(function() {
        return $(this).toggleClass("selected");
      });
      return unitType = [];
    };

    return ScreenOneView;

  })(Marionette.CompositeView);
});
