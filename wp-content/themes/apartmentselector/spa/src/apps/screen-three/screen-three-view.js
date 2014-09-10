// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['marionette'], function(Marionette) {
  var BuildingView, ScreenThreeLayout, UnitTypeChildView, UnitTypeView, UnitView, cloneunitVariantArrayColl, count, firstElement, flag_set, globalUnitArrayInt, object1, position, rangeunitArray, sudoSlider, tagsArray, unitAssigedArray, unitChildView, unitVariantArray, unitVariantIdArray, unitVariantString, unitVariants;
  flag_set = 0;
  unitVariantArray = '';
  unitVariantIdArray = [];
  unitVariantString = '';
  firstElement = '';
  tagsArray = [];
  count = 0;
  object1 = "";
  unitVariants = [];
  cloneunitVariantArrayColl = "";
  rangeunitArray = [];
  globalUnitArrayInt = [];
  position = "";
  unitAssigedArray = [];
  sudoSlider = "";
  ScreenThreeLayout = (function(_super) {
    var object;

    __extends(ScreenThreeLayout, _super);

    function ScreenThreeLayout() {
      return ScreenThreeLayout.__super__.constructor.apply(this, arguments);
    }

    ScreenThreeLayout.prototype.template = '<div class="text-center subTxt m-b-20 unittype hidden animated pulse">We have <span class="bold text-primary"> {{countUnits }} </span> <strong>{{selection}}</strong> apartments in this floor range of the selected tower.</div> <div class="text-center subTxt m-b-20 budget hidden animated pulse">We have <span class="bold text-primary"> {{countUnits }} </span>  apartments in the budget of <strong>{{selection}}</strong> in this floor range of the selected tower.</div> <div class="text-center subTxt m-b-20 refresh hidden animated pulse">You just refreshed the page. You are now seeing <span class="bold text-primary">All</span> apartments across all the towers.</div> <div class="text-center subTxt m-b-20 All hidden animated pulse">You are seeing <span class="bold text-primary">All</span> apartments in the selected floor range of the tower.</div> <div class="introTxt text-center">These apartments are available in different size variations on different floors of the tower. Click on any available apartment for more details. <!--<br><em>(You can scroll between towers to see other options.)</em>--></div> <div class="row m-l-0 m-r-0"> <div class="col-sm-4"> <div class="text-center light"> You are seeing <div id="tagslist1" class="taglist"> <ul></ul> </div> <span class="text-primary variantToggle"></span>variants of your apartment selection </div> <div class="variantBox"> <div class="pull-left m-l-15"> <input type="checkbox" name="unselectall" id="unselectall" class="checkbox" value="0" checked/> <label for="unselectall">Select/Unselect All</label> </div> <div class="text-right"><span class="variantClose glyphicon glyphicon-remove text-grey"></span></div> <div class="grid-container"> {{#unitVariants}} <div class="grid-block-3" > <a class="grid-link selected" href="#" id="gridlink{{id}}" data-id="{{id}}"> {{sellablearea}} Sq.ft.<input type="hidden" name="checklink{{id}}"   id="checklink{{id}}"   value="1" /> </a> </div> {{/unitVariants}} <div class="variantAction m-t-5 m-b-20"> <a class="btn btn-primary m-r-10 done">DONE</a> <a class="btn btn-default cancel">CANCEL</a> </div> </div> </div> <div id="vs-container" class="vs-container"> <header class="vs-header" id="building-region"></header> <div id="floorsvg" class="floorSvg"></div> <div  id="unit-region"></div> </div> <div class="h-align-middle m-t-20 m-b-20"> <a href="#screen-three-region" class="btn btn-default btn-lg disabled" id="screen-three-button">Show Unit</a> </div> </div> <div class="col-sm-8"> <span>Flat No : </span><span id="flatno"></span> <div id="positionsvg" class="positionSvg"> </div> </div> </div>';

    ScreenThreeLayout.prototype.className = 'page-container row-fluid';

    ScreenThreeLayout.prototype.regions = {
      buildingRegion: '#building-region',
      unitRegion: '#unit-region'
    };

    object = ScreenThreeLayout;

    ScreenThreeLayout.prototype.events = {
      'click .customLink': function(e) {
        var element, id, index, _i, _len;
        console.log(id = parseInt(e.target.id));
        console.log(unitAssigedArray);
        for (index = _i = 0, _len = unitAssigedArray.length; _i < _len; index = ++_i) {
          element = unitAssigedArray[index];
          console.log(element);
          if (element === parseInt(id)) {
            $('#' + element).attr('class', 'floor-pos position');
          } else {
            $('#' + element).attr('class', 'floor-pos ');
          }
        }
        unitAssigedArray.push(id);
        return this.loadsvg(id);
      },
      'click .unit-hover': function(e) {
        var buildinArray, building, buildingCollection, buildingModel, element, flatid, index, indexvalue, svgdata, svgposition, unit, unitModel, unitvalues, _i, _j, _len, _len1;
        console.log(e.target.id);
        console.log(buildingCollection = Marionette.getOption(this, 'buildingCollection'));
        console.log(buildinArray = buildingCollection.toArray());
        console.log(building = _.first(buildinArray));
        buildingModel = App.master.building.findWhere({
          id: parseInt(building.get('id'))
        });
        svgdata = [
          [
            {
              svposition: [1],
              svgfile: "../wp-content/uploads/2014/08/image/floor-pos-1.svg",
              units: {
                1: {
                  1: 49,
                  2: 52,
                  3: 61,
                  4: 67,
                  5: 73,
                  6: 80,
                  7: 85,
                  8: 90,
                  9: 98,
                  10: 113,
                  11: 142,
                  12: 152
                }
              }
            }
          ]
        ];
        svgposition = "";
        unitvalues = "";
        indexvalue = "";
        $.each(svgdata, function(index, value) {
          console.log(value);
          return $.each(value, function(ind, val) {
            console.log(val);
            return $.map(val.svposition, function(index1, val1) {
              var unitsarray;
              console.log(index1);
              console.log(position);
              if (position === index1) {
                svgposition = val.svgfile;
                console.log(unitsarray = val.units);
                return console.log(indexvalue = unitsarray[position]);
              }
            });
          });
        });
        flatid = $('#' + e.target.id).attr('data-id');
        console.log(unit = indexvalue[parseInt(flatid)]);
        unitModel = App.master.unit.findWhere({
          id: parseInt(unit)
        });
        console.log(unitAssigedArray);
        for (index = _i = 0, _len = unitAssigedArray.length; _i < _len; index = ++_i) {
          element = unitAssigedArray[index];
          console.log(element);
          if (element === parseInt(unitModel.get('unitAssigned'))) {
            $('#' + element).attr('class', 'floor-pos position');
          } else {
            $('#' + element).attr('class', 'floor-pos ');
          }
        }
        unitAssigedArray.push(unitModel.get('unitAssigned'));
        $('#' + unitModel.get('unitAssigned')).attr('class', 'position');
        sudoSlider.goToSlide(unitModel.get('unitAssigned'));
        console.log(rangeunitArray);
        for (index = _j = 0, _len1 = rangeunitArray.length; _j < _len1; index = ++_j) {
          element = rangeunitArray[index];
          if (element === parseInt(unit)) {
            $("#select" + unit).val('1');
          } else {
            $("#select" + element).val('0');
            $('#check' + element).removeClass('selected');
            if (unitModel.get('status') === 9) {
              $("#" + element).attr('class', 'unit-hover aviable ');
            } else if (unitModel.get('status') === 8) {
              $("#" + element).attr('class', 'unit-hover sold ');
            }
            rangeunitArray = [];
          }
        }
        rangeunitArray.push(parseInt(unit));
        $('#check' + unit).addClass("selected");
        $("#select" + unit).val("1");
        $("#screen-three-button").removeClass('disabled btn-default');
        return $("#screen-three-button").addClass('btn-primary');
      },
      'mouseover .unit-hover': function(e) {
        var buildinArray, building, buildingCollection, buildingModel, flatid, indexvalue, svgdata, svgposition, unit, unitModel, unitvalues;
        buildingCollection = Marionette.getOption(this, 'buildingCollection');
        buildinArray = buildingCollection.toArray();
        building = _.first(buildinArray);
        buildingModel = App.master.building.findWhere({
          id: parseInt(building.get('id'))
        });
        svgdata = [
          [
            {
              svposition: [1],
              svgfile: "../wp-content/uploads/2014/08/image/floor-pos-1.svg",
              units: {
                1: {
                  1: 49,
                  2: 52,
                  3: 61,
                  4: 67,
                  5: 73,
                  6: 80,
                  7: 85,
                  8: 90,
                  9: 98,
                  10: 113,
                  11: 142,
                  12: 152
                }
              }
            }
          ]
        ];
        svgposition = "";
        unitvalues = "";
        indexvalue = "";
        $.each(svgdata, function(index, value) {
          return $.each(value, function(ind, val) {
            return $.map(val.svposition, function(index1, val1) {
              var unitsarray;
              if (position === index1) {
                svgposition = val.svgfile;
                unitsarray = val.units;
                return indexvalue = unitsarray[position];
              }
            });
          });
        });
        flatid = $('#' + e.target.id).attr('data-id');
        unit = indexvalue[parseInt(flatid)];
        unitModel = App.master.unit.findWhere({
          id: parseInt(unit)
        });
        console.log(this);
        $('#flatno').text(unitModel.get('name'));
        $('.unit-hover').css('content', unitModel.get('name'));
        if (parseInt(unitModel.get('status')) === 9) {
          console.log("qq");
          return $("#" + e.target.id).attr('class', 'unit-hover aviable');
        } else if (parseInt(unitModel.get('status')) === 8) {
          console.log("ww");
          return $("#" + e.target.id).attr('class', 'unit-hover sold');
        }
      },
      'click #screen-three-button': function(e) {
        return this.trigger('unit:item:selected');
      },
      'click a': function(e) {
        return e.preventDefault();
      },
      'click .grid-link': function(e) {
        var id, index, track;
        console.log(unitVariantArray);
        count = unitVariantArray.length;
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
        unitVariantArray = _.uniq(unitVariantArray);
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
          return $('#unselectall').prop('checked', true);
        } else {
          return $('#unselectall').prop('checked', false);
        }
      },
      'click .done': function(e) {
        var params;
        App.layout.screenFourRegion.el.innerHTML = "";
        App.navigate("screen-three");
        App.currentStore.unit.reset(UNITS);
        App.currentStore.building.reset(BUILDINGS);
        App.currentStore.unit_type.reset(UNITTYPES);
        App.currentStore.unit_variant.reset(UNITVARIANTS);
        App.defaults['unitVariant'] = unitVariantString;
        App.backFilter['screen2'].push("unitVariant");
        App.filter(params = {});
        return this.trigger('unit:variants:selected');
      },
      'click .cancel': function(e) {
        var globalUnitVariants;
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
      'click #unselectall': function(e) {
        var remainainArray, tempArray, units, value;
        if ($('#' + e.target.id).prop('checked') === true) {
          cloneunitVariantArrayColl.each(function(index) {
            $('#gridlink' + index.get('id')).addClass('selected');
            $('#checklink' + index.get('id')).val('1');
            return unitVariantArray.push(index.get('id'));
          });
          unitVariantArray = _.uniq(unitVariantArray);
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
            $('#gridlink' + value).removeClass('selected');
            $('#checklink' + value).val('0');
            index = unitVariantArray.indexOf(parseInt(value));
            if (index !== -1) {
              return unitVariantArray.splice(index, 1);
            }
          });
          console.log(unitVariantArray);
          return unitVariantString = value.toString();
        }
      }
    };

    ScreenThreeLayout.prototype.onShow = function() {
      var $columns_number, globalUnitVariants, testtext, unitVariantArrayColl, unitVariantArrayText, unitVariantsArray;
      $('#screen-three-button').on('click', function() {
        return new jBox('Notice', {
          content: 'Wait 1 Second',
          autoClose: 2000,
          addClass: 'notifyBox',
          position: {
            x: 'center',
            y: 'top'
          },
          animation: {
            open: 'flip',
            close: 'slide:top'
          }
        });
      });
      sudoSlider = $("#unitsSlider").sudoSlider({
        customLink: "a",
        prevNext: false,
        responsive: true,
        speed: 800
      });
      $('#mainsvg').text("");
      if (unitVariantString === "All" || App.defaults['unitVariant'] === "All") {
        $('#unselectall').prop('checked', true);
      } else {
        $('#unselectall').prop('checked', false);
      }
      rangeunitArray = [];
      globalUnitArrayInt = [];
      this.loadbuildingsvg();
      $('#sliderplans').liquidSlider({
        slideEaseFunction: "fade",
        autoSlide: true,
        includeTitle: false,
        fadeOutDuration: 1000,
        minHeight: 500,
        forceAutoSlide: true,
        autoSlideInterval: 5000,
        dynamicArrows: false,
        fadeInDuration: 1000
      });
      if (App.screenOneFilter['key'] === 'unitType') {
        $('.unittype').removeClass('hidden');
      } else if (App.screenOneFilter['key'] === 'budget') {
        $('.budget').removeClass('hidden');
      } else if (App.defaults['floor'] === 'All') {
        $('.refresh').removeClass('hidden');
      } else {
        $('.All').removeClass('hidden');
      }
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
      unitVariantsArray = Marionette.getOption(this, 'unitVariants');
      unitVariantArrayColl = new Backbone.Collection(unitVariantsArray);
      cloneunitVariantArrayColl = unitVariantArrayColl.clone();
      console.log(unitVariants = unitVariantArray);
      console.log(firstElement = _.first(unitVariantArray));
      console.log(globalUnitVariants = App.defaults['unitVariant'].split(','));
      if (App.defaults['unitVariant'] !== 'All') {
        globalUnitVariants = App.defaults['unitVariant'].split(',');
        $.each(globalUnitVariants, function(index, value) {
          return globalUnitArrayInt.push(parseInt(value));
        });
      }
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
      } else {
        unitVariantArray = unitVariantArray;
        $.each(unitVariantArray, function(index, value) {
          $('#gridlink' + value).addClass('selected');
          return $('#checklink' + value).val('1');
        });
      }
      $('html, body').animate({
        scrollTop: $('#screen-three-region').offset().top
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
      object1 = this;
      setTimeout(function() {
        return $('#' + 1).attr('class', 'floor-pos position');
      }, 2000);
      return unitAssigedArray.push("1");
    };

    $(document).on("click", ".closeButton1", function() {
      var theidtodel;
      console.log(theidtodel = $(this).parent('li').attr('id'));
      console.log(object1);
      return object1.delItem($('#' + theidtodel).attr('data-itemNum'));
    });

    ScreenThreeLayout.prototype.loadbuildingsvg = function() {
      var buildinArray, building, buildingCollection, buildingModel, path, svgdata, svgpath;
      console.log(buildingCollection = Marionette.getOption(this, 'buildingCollection'));
      console.log(buildinArray = buildingCollection.toArray());
      console.log(building = _.first(buildinArray));
      buildingModel = App.master.building.findWhere({
        id: parseInt(building.get('id'))
      });
      svgpath = buildingModel.get('svgfile');
      svgdata = [
        [
          {
            svposition: [1],
            svgfile: "../wp-content/uploads/2014/08/image/floor-pos-1.svg",
            units: [
              {
                1: [
                  {
                    1: 49,
                    2: 52,
                    3: 61,
                    4: 67,
                    5: 73,
                    6: 80,
                    7: 85,
                    8: 90,
                    9: 98,
                    10: 113,
                    11: 142,
                    12: 152
                  }
                ]
              }
            ]
          }
        ]
      ];
      if (buildingModel.get('id') === 11) {
        path = "../wp-content/uploads/2014/08/image/floor.svg";
        $('<div></div>').load(path).appendTo("#floorsvg");
      } else {
        path = "";
      }
      return this.loadsvg();
    };

    ScreenThreeLayout.prototype.loadsvg = function(floorid) {
      var buildinArray, building, buildingCollection, buildingModel, indexvalue, svgdata, svgpath, svgposition, unitvalues;
      console.log(floorid);
      console.log(buildingCollection = Marionette.getOption(this, 'buildingCollection'));
      console.log(buildinArray = buildingCollection.toArray());
      console.log(building = _.first(buildinArray));
      buildingModel = App.master.building.findWhere({
        id: parseInt(building.get('id'))
      });
      svgpath = buildingModel.get('svgfile');
      svgdata = [
        [
          {
            svposition: [1],
            svgfile: "../wp-content/uploads/2014/08/image/floor-pos-1.svg",
            units: {
              1: {
                1: 49,
                2: 52,
                3: 61,
                4: 67,
                5: 73,
                6: 80,
                7: 85,
                8: 90,
                9: 98,
                10: 113,
                11: 142,
                12: 152
              }
            }
          }
        ]
      ];
      if (buildingModel.get('id') === 11) {
        if (floorid === void 0) {
          floorid = 1;
        }
      }
      svgposition = "";
      unitvalues = "";
      indexvalue = "";
      $('#positionsvg').text("");
      $.each(svgdata, function(index, value) {
        console.log(value);
        return $.each(value, function(ind, val) {
          console.log(val);
          return $.map(val.svposition, function(index1, val1) {
            var unitsarray;
            console.log(index1);
            if (floorid === index1) {
              svgposition = val.svgfile;
              console.log(unitsarray = val.units);
              console.log(indexvalue = unitsarray[floorid]);
              return $('<div></div>').load(svgposition).appendTo("#positionsvg");
            }
          });
        });
      });
      return position = floorid;
    };

    ScreenThreeLayout.prototype.doListing = function() {
      $('#tagslist1 ul li').remove();
      $.each(tagsArray, function(index, value) {
        return $('#tagslist1 ul').append('<li id="uli-item-' + value.id + '" data-itemNum="' + value.id + '"><span class="itemText">' + value.area + '</span><div class="closeButton1"></div></li>');
      });
      if (tagsArray.length === 1) {
        return $('.closeButton1').addClass('hidden');
      }
    };

    ScreenThreeLayout.prototype.delItem = function(delnum) {
      var i, index, key, params, removeItem, unitvariantarrayValues;
      console.log("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
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
        $('#uli-item-' + delnum).remove();
        unitvariantarrayValues = [];
        $.each(tagsArray, function(index, value) {
          return unitvariantarrayValues.push(value.id);
        });
        App.layout.screenFourRegion.el.innerHTML = "";
        App.navigate("screen-three");
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

    return ScreenThreeLayout;

  })(Marionette.LayoutView);
  BuildingView = (function(_super) {
    __extends(BuildingView, _super);

    function BuildingView() {
      return BuildingView.__super__.constructor.apply(this, arguments);
    }

    BuildingView.prototype.template = '<a class="link" >{{name}}</a>';

    BuildingView.prototype.tagName = 'li';

    BuildingView.prototype.events = {
      'click a': function(e) {
        return e.preventDefault();
      },
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
  unitChildView = (function(_super) {
    __extends(unitChildView, _super);

    function unitChildView() {
      return unitChildView.__super__.constructor.apply(this, arguments);
    }

    unitChildView.prototype.template = '<div class="pull-left light"> <h5 class="rangeName bold m-t-5">Floor {{floor}}</h5> </div> <div class="pull-right text-center"> <div class="unitNo">{{name}}</div> <div class="small">{{unittypename}} {{sellablearea}} Sq.ft.</div> </div><input type="hidden" id="flag{{id}}" name="flag{{id}}" value="0"/> <input type="hidden" id="select{{id}}" name="select{{id}}" value="0"/> <div class="clearfix"></div>';

    unitChildView.prototype.className = 'check';

    unitChildView.prototype.initialize = function() {
      return this.$el.prop("id", 'check' + this.model.get("id"));
    };

    unitChildView.prototype.events = {
      'click ': function(e) {
        var element, index, unitModel, _i, _len;
        App.layout.screenFourRegion.el.innerHTML = "";
        App.navigate("screen-three");
        App.currentStore.unit.reset(UNITS);
        App.currentStore.building.reset(BUILDINGS);
        App.currentStore.unit_type.reset(UNITTYPES);
        App.currentStore.unit_variant.reset(UNITVARIANTS);
        unitModel = App.master.unit.findWhere({
          id: this.model.get("id")
        });
        console.log(rangeunitArray);
        for (index = _i = 0, _len = rangeunitArray.length; _i < _len; index = ++_i) {
          element = rangeunitArray[index];
          if (element === this.model.get('id')) {
            $("#select" + this.model.get('id')).val('1');
          } else {
            $("#select" + element).val('0');
            $('#check' + element).removeClass('selected');
            if (unitModel.get('status') === 9) {
              $("#" + element).attr('class', 'unit-hover aviable ');
            } else if (unitModel.get('status') === 8) {
              $("#" + element).attr('class', 'unit-hover sold ');
            }
            rangeunitArray = [];
          }
        }
        if (parseInt($("#select" + this.model.get('id')).val()) === 0) {
          rangeunitArray.push(this.model.get('id'));
          $('#check' + this.model.get("id")).addClass("selected");
          $("#select" + this.model.get('id')).val("1");
          if (unitModel.get('status') === 9) {
            $("#" + this.model.get("id")).attr('class', 'unit-hover aviable selected');
          } else if (unitModel.get('status') === 8) {
            $("#" + this.model.get("id")).attr('class', 'unit-hover sold selected');
          }
          console.log($('#select' + this.model.get("id")));
          App.unit['name'] = this.model.get("id");
          App.backFilter['screen3'].push('floor');
          $("#screen-three-button").removeClass('disabled btn-default');
          $("#screen-three-button").addClass('btn-primary');
        } else {
          rangeunitArray = [];
          $("#select" + this.model.get('id')).val("0");
          $('#check' + this.model.get('id')).removeClass('selected');
          if (unitModel.get('status') === 9) {
            $("#" + this.model.get("id")).attr('class', 'unit-hover aviable ');
          } else if (unitModel.get('status') === 8) {
            $("#" + this.model.get("id")).attr('class', 'unit-hover sold ');
          }
        }
        if (parseInt($("#select" + this.model.get('id')).val()) === 0) {
          $("#screen-three-button").addClass('disabled btn-default');
          $("#screen-three-button").removeClass('btn-primary');
          return false;
        }
      }
    };

    unitChildView.prototype.onShow = function() {
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
      if (track === 1 && this.model.get('status') === 9 && this.model.get('unitType') !== 14) {
        $('#check' + this.model.get("id")).addClass('boxLong filtered');
        return $('#flag' + this.model.get("id")).val('1');
      } else if (track === 1 && this.model.get('status') === 8 && this.model.get('unitType') !== 14) {
        return $('#check' + this.model.get("id")).addClass('boxLong sold');
      } else {
        $('#check' + this.model.get("id")).addClass('boxLong other');
        return $('#check' + this.model.get("id")).text(this.model.get('unitTypeName'));
      }
    };

    return unitChildView;

  })(Marionette.ItemView);
  UnitView = (function(_super) {
    __extends(UnitView, _super);

    function UnitView() {
      return UnitView.__super__.constructor.apply(this, arguments);
    }

    UnitView.prototype.template = '<div class="unitContainer"></div>';

    UnitView.prototype.childView = unitChildView;

    UnitView.prototype.childViewContainer = '.unitContainer';

    UnitView.prototype.initialize = function() {
      this.collection = this.model.get('units');
      return this.$el.prop("id", this.model.get("id"));
    };

    return UnitView;

  })(Marionette.CompositeView);
  UnitTypeView = (function(_super) {
    __extends(UnitTypeView, _super);

    function UnitTypeView() {
      return UnitTypeView.__super__.constructor.apply(this, arguments);
    }

    UnitTypeView.prototype.template = '<div class="unitTable"> <div id="unitsSlider" class="unitSlider"> </div></div>';

    UnitTypeView.prototype.childView = UnitView;

    UnitTypeView.prototype.childViewContainer = '.unitSlider';

    UnitTypeView.prototype.onShow = function() {
      return sudoSlider = $("#unitsSlider").sudoSlider({
        customLink: "a",
        prevNext: false,
        responsive: true,
        speed: 800
      });
    };

    return UnitTypeView;

  })(Marionette.CompositeView);
  return {
    ScreenThreeLayout: ScreenThreeLayout,
    UnitTypeChildView: UnitTypeChildView,
    UnitTypeView: UnitTypeView
  };
});
