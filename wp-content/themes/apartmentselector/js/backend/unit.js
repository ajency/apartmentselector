

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

        var data, _e;

        var _e = e;

        data = $("#form_add_edit_apartment").serialize();

        $.post(AJAXURL, data, function(response) {

             console.log(response)
        });
    });
    if($('.tablesorter').length){

        _collections = collections
        $.post(AJAXURL, {
            action: "get_list_view",
            list: "units",
            masters:["unit_status", "unit_types", "unit_variants","buildings"]
        }, function(response) {

            _collections.list = response.list

            _collections.masters = response.masters

            loadListContents();


        });
    }

    function loadListContents(){
        $(".tablesorter tbody").empty();
        _.each(collections.list, function(listItems,listItemsValue){

            $(".tablesorter tbody").append("<tr>" +
                "<td>"+listItems.name+"</td>" +
                 "<td>"+getDisplayText(listItems.status,"unit_status","name")+"</td>" +
                "<td>"+getDisplayText(listItems.unit_type,"unit_types","name")+"</td>" +
                 "<td>"+getDisplayText(listItems.unit_variant,"unit_variants","name")+"</td>" +
                 "<td>"+getDisplayText(listItems.building,"buildings","name")+"</td>" +
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
                                values : [1, 12],
                                min : 1,
                                max : 12
                            });
                        },




                    },


                }
            });

    }

    function getDisplayText(itemId,collectionName,field){

        item_found =  _.findWhere(collections.masters[collectionName], {id: itemId})

        return item_found==undefined ?'':item_found[field];
    }

});