

jQuery(document).ready(function($) {
    var collections = [];
    //load unit variants
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

//save apartment ajax call
    $(document).on("click", "#save_apartment", function(e) {

        clearAlerts();
        var data, _e;

        var _e = e;

        data = $("#form_add_edit_apartment").serialize();

        $(e.target).hide().parent().append("<div class='loading-animator'></div>")


        $.post(AJAXURL, data, function(response) {

            if(response.error==false){

                $('form').prepend('<div class="text-success">'+response.msg+'</div>')

                $('form').find("input[type=text], textarea ,select").val("");

            }else{

                $('form').prepend('<div class="text-error">'+response.msg+'</div>')

            }

            $(".loading-animator").remove();
            $(_e.target).show() ;
        });
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


        _.each(collections.list, function(listItems,listItemsValue){
            //add the row items
            $(".tablesorter tbody").append("<tr class='edit-link' data-id='"+listItems.id+"'>" +
                "<td>"+listItems.name+"</td>" +
                 "<td>"+getDisplayText(listItems.status,collections.masters["unit_status"],"name")+"</td>" +
                "<td>"+getDisplayText(listItems.unit_type,collections.masters["unit_types"],"name")+"</td>" +
                 "<td>"+getDisplayText(listItems.unit_variant,collections.masters["unit_variants"],"name")+"</td>" +
                 "<td>"+getDisplayText(listItems.building,collections.masters["buildings"],"name")+"</td>" +
                "<td>"+listItems.floor+"</td>" +
                "</tr>")
        })


            $(".tablesorter").tablesorter({
                theme : 'jui',
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
                                max : 12
                            });
                        },




                    },


                }
            });

    }



    $(document).on("click", ".edit-link", function(e) {

        window.location.href = SITEURL + "/add-edit-apartment/?id="+$(e.target).parent().attr('data-id');
    });

});