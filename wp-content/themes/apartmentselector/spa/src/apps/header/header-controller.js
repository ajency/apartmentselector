// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'src/apps/header/header-view'], function(Extm, HeaderView) {
  var HeaderController;
  HeaderController = (function(_super) {
    __extends(HeaderController, _super);

    function HeaderController() {
      return HeaderController.__super__.constructor.apply(this, arguments);
    }

    HeaderController.prototype.initialize = function(opt) {
      var view;
      if (opt == null) {
        opt = {};
      }
      this.model = this._getHeader();
      this.view = view = this._getHeaderView(this.model);
      return this.show(view);
    };

    HeaderController.prototype._getHeaderView = function(model) {
      return new HeaderView({
        templateHelpers: {
          textString: model[0],
          textClass: model[1]
        }
      });
    };

    HeaderController.prototype._getHeader = function() {
      var flag, templateArr, templateString, textClass, textString;
      templateArr = [];
      flag = 0;
      $.each(App.defaults, function(index, value) {
        var budget_Val, element, key, string_val, valuearr, _i, _len, _results;
        if (value !== 'All') {
          flag = 1;
          string_val = _.isString(value);
          if (string_val === true) {
            valuearr = value.split(',');
          }
          if (valuearr.length > 1) {
            _results = [];
            for (_i = 0, _len = valuearr.length; _i < _len; _i++) {
              element = valuearr[_i];
              console.log(element);
              if (index === 'unitType') {
                key = App.currentStore.unit_type.findWhere({
                  id: parseInt(element)
                });
                console.log(key);
                templateArr.push(key.get('name'));
              }
              if (index === 'unitVariant') {
                key = App.currentStore.unit_variant.findWhere({
                  id: parseInt(element)
                });
                console.log(key);
                templateArr.push(key.get('name'));
              }
              if (index === 'building') {
                key = App.currentStore.building.findWhere({
                  id: parseInt(element)
                });
                console.log(key);
                templateArr.push(key.get('name'));
              }
              if (index === 'budget') {
                budget_Val = value + 'lakhs';
                templateArr.push(budget_Val);
              }
              if (index === 'floor') {
                _results.push(templateArr.push(value));
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          } else {
            if (index === 'unitType') {
              key = App.currentStore.unit_type.findWhere({
                id: parseInt(value)
              });
              console.log(key);
              templateArr.push(key.get('name'));
            }
            if (index === 'unitVariant') {
              key = App.currentStore.unit_variant.findWhere({
                id: parseInt(value)
              });
              console.log(key);
              templateArr.push(key.get('name'));
            }
            if (index === 'building') {
              key = App.currentStore.building.findWhere({
                id: parseInt(value)
              });
              console.log(key);
              templateArr.push(key.get('name'));
            }
            if (index === 'budget') {
              budget_Val = value + 'lakhs';
              templateArr.push(budget_Val);
            }
            if (index === 'floor') {
              return templateArr.push(value);
            }
          }
        }
      });
      console.log(templateArr);
      templateString = templateArr.join(',');
      textString = "";
      if (flag === 1) {
        textString = 'You have selected ' + templateString;
        textClass = '';
      } else {
        textString = 'Apartment Selector';
        textClass = 'hidden';
      }
      return [textString, textClass];
    };

    return HeaderController;

  })(Extm.RegionController);
  return msgbus.registerController('header', HeaderController);
});
