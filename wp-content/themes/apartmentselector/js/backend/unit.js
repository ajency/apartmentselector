

jQuery(document).ready(function($) {
 
    var collections = [];
    //load unit variants on selection of unit type
    $(document).on("change", "#unit_type", function(e) {

        $("#unit_variant").empty();

        $("#unit_variant").append(new Option("Select", ""));

        $.post(AJAXURL, {
            action: "get_unit_variants",
            unit_type: $("option:selected", $(e.target)).val()
        }, function(response) {

            $.each(response, function(i, val) {
                $("#unit_variant").append(new Option(val.variant_name, val.variant_id));
            });

        });
    });

//on chnage of building load the no of floors in the building
     $(document).on("change", "#building", function(e) {

        floors = $("option:selected", $(e.target)).attr("floors");

        $("#floor").empty();

        $("#floor").append(new Option("Select", ""));
 
        for(i=1;i<=floors;i++){

            $("#floor").append(new Option(i, i));

        }

        $("#floor").trigger('change')

});

//on selection of floor get the flats on the floor making an ajax call
$(document).on("change", "#floor", function(e) {

      if($("option:selected", $(e.target)).val()==""){
         $("#flat_container").html("<i>select building and floor</i>")
         return
      }
      $("#flat_container").html("<div class='loading-animator'></div>")
      $.post(AJAXURL, {

            action: "get_flats_on_floor",
            building:$("option:selected", $("#building")).val(),
            floor: $("option:selected", $(e.target)).val()

        }, function(response) {
                
            flats_html = "";
             $.each(response, function(i, val) {
               flats_html += '<div class="col-md-6"><input type="radio" name="unit_assigned" value="'+val.flat_no+'">'+val.flat_no+'<br><img src="'+val.image_url+'" class="image_display"></div>';
            });

             $("#flat_container").html('<div class="row-fluid" > <div class="row">'+flats_html+'</div></div>');
        
         

        });

});

//save apartment ajax call
    $(document).on("click", "#save_apartment", function(e) {

        clearAlerts();

        if($('form').valid()){

            var data, _e;

            var _e = e;

            data = $("#form_add_edit_apartment").serialize();

            $(e.target).hide().parent().append("<div class='loading-animator'></div>")


            $.post(AJAXURL, data, function(response) {

                resetForm(e,$('#apartment_id').val(),response);
       
            });
        }
    });

    if($('.tablesorter').length){

        _collections = collections
        $.post(AJAXURL, {
            action: "get_list_view",
            list: "units", //the list required
            masters:["unit_status", "unit_types", "unit_variants","buildings"] //the masters required for the list
        }, function(response) {

            _collections.list = response.list

            _collections.masters = response.masters

            //load the list view with rows
            loadListContents();


        });
    }

    function loadListContents(){
        $(".tablesorter tbody").empty();
 
        floors =  _.pluck(collections.list, 'floor');
 
       console.log(floors); 

        _.each(collections.list, function(listItems,listItemsValue){
            //add the row items
            $(".tablesorter tbody").append("<tr >" +
                "<td class='edit-link' data-id='"+listItems.id+"'>"+listItems.name+"</td>" +
                "<td class='edit-link' data-id='"+listItems.id+"'>"+getDisplayText(listItems.status,collections.masters["unit_status"],"name")+"</td>" +
                "<td class='edit-link' data-id='"+listItems.id+"'>"+getDisplayText(listItems.unitType,collections.masters["unit_types"],"name")+"</td>" +
                "<td class='edit-link' data-id='"+listItems.id+"'>"+getDisplayText(listItems.unitVariant,collections.masters["unit_variants"],"name")+"</td>" +
                "<td class='edit-link' data-id='"+listItems.id+"'>"+getDisplayText(listItems.building,collections.masters["buildings"],"name")+"</td>" +
                "<td class='edit-link' data-id='"+listItems.id+"'>"+listItems.floor+"</td>" +
                "<td><i  class='fa fa-trash-o delete_unit' data-id='"+listItems.id+"'></i></td>" +
               "</tr>")
        })


            $(".tablesorter").tablesorter({
                theme : 'jui',
                sortList: [[0,0]] ,
                headerTemplate : '{content}{icon}',
                // hidden filter input/selects will resize the columns, so try to minimize the change
                widthFixed : true,
                // initialize zebra striping and filter widgets
                widgets : ["zebra", "filter", "stickyHeaders", "uitheme"],
                widgetOptions : {
                    // Use the $.tablesorter.storage utility to save the most recent filters
                    filter_saveFilters : true,
                    // jQuery selector string of an element used to reset the filters
                    filter_reset : 'button.reset',
                    // add custom selector elements to the filter row
                    filter_formatter : {



                        // Total (jQuery selector added v2.17.0)
                       5 : function($cell, indx){
                            return $.tablesorter.filterFormatter.uiRange( $cell, indx, {
                                delayed : false,
                                valueToHeader : false,
                                // jQuery UI slider options
                                values : [1, Math.max.apply(Math, floors)],
                                min : 1,
                                max : Math.max.apply(Math, floors)
                            });
                        },




                    },


                }
            });

    }



    $(document).on("click", ".edit-link", function(e) {

        window.location.href = SITEURL + "/add-edit-apartment/?id="+$(e.target).attr('data-id');
    });
    //delete unit
$(document).on("click", ".delete_unit", function(e) {
 
        var _e = e
        clearAlerts();
        flat_no = $(e.target).parent().parent().children(':first-child').html() 
        confirmUserAction = confirm("Are you sure you want to delete apartment "+flat_no+" ?")
        if(confirmUserAction){
          $.post(AJAXURL, {

            action: "delete_unit", 

            id:$(e.target).attr('data-id')

        }, function(response) {

            $(_e.target).parent().parent().remove();
            
            $(".grid-body").prepend('<div class="text-success">'+response.msg+'</div>')
             
        });
      }
    });

     //validations 
    $('form').validate({
                focusInvalid: false, 
                ignore: "",
                rules: {
                    flat_no: { 
                        required: true
                    },
                    unit_type: { 
                        required: true
                    },
                    unit_variant: { 
                        required: true
                    },
                    building: { 
                        required: true
                    },
                    
                },

                invalidHandler: function (event, validator) {
                    //display error alert on form submit    
                },

                errorPlacement: function (label, element) { // render error placement for each input type   
                    $('<span class="error"></span>').insertAfter(element).append(label)
                    var parent = $(element).parent('.input-with-icon');
                    parent.removeClass('success-control').addClass('error-control');  
                },

                highlight: function (element) { // hightlight error inputs
                    var parent = $(element).parent();
                    parent.removeClass('success-control').addClass('error-control'); 
                },

                unhighlight: function (element) { // revert the change done by hightlight
                    
                },

                success: function (label, element) {
                    var parent = $(element).parent('.input-with-icon');
                    parent.removeClass('error-control').addClass('success-control'); 
                },

                submitHandler: function (form) {
                
                }
            }); 

 


});