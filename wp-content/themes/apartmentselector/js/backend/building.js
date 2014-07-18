
jQuery(document).ready(function($) {
    var collections = [];
    //load unit variants
    $(document).on("change", ".no_of_flats", function(e) {

        prev_flat_count =  $(e.target).attr('prev_flat_count');

        $("#"+$(e.target).attr('flats_container_id')).html("");

        exception_no = $(e.target).attr('exception_no');

        prefix = (exception_no!="")? 'exception_'+exception_no+'_':exception_no;
        for(i=1;i<=$(e.target).val();i++){

           $("#"+$(e.target).attr('flats_container_id')).append("<div flatno ='"+i+"'>"+getFlatUi(i,exception_no)+'</div>')

            //bind file upload ui to the fileupload function

            fileUpload(prefix+i)
        }
         $(e.target).attr('prev_flat_count',$(e.target).val())  ;

    })

    $(document).on("change", "#no_of_floors", function(e) {

        loadExceptionsOption($(e.target).val());

        


    })

    $(document).on("click", "#addExceptions", function(e) {

         exception_no = parseInt($(e.target).attr("exception_count"))+1

        $(e.target).attr("exception_count",exception_no)

        $(".exception_container").append(addException(exception_no))


    });

function loadExceptionsOption(floors){

    if(parseInt(floors)>0){

        $("#exceptions").show()

        //display one exception option ...button option to add multiple disabled for now
        $(".exception_container").html(addException(1))

        $("#exceptions_count").val(1)

        $(".exception_floors").html(getFloorOptions(floors,1))


    }
    else{

        $("#exceptions").hide()


        $("#exceptions_count").val(0)

    }
   

}

function getFlatUi(flatNo,exception_no){

    html =  '<div class="form-group">'
        +'<label class="form-label">'
        +'Flat No:'+flatNo
        +'</label>'
        +'<span class="help">'
        +'</span>'
        +'<div class="row">'
        +'<div class="col-md-4">'
        + getImageUploadUi(flatNo,exception_no)
        +'</div>'
        +'</div>'
        +'</div>'
        +'<div class="row-fluid">'
        +'<div class="col-md-12">'
        +'<img src="">'
        +'</div>'
        +'</div>'
    return html;
}

function getImageUploadUi(flatNo,exception_no){

    prefix = (exception_no!="")? 'exception_'+exception_no+'_':exception_no;
    html =  '<span class="btn btn-success fileinput-button">'
            +'<i class="glyphicon glyphicon-plus"></i>'
            +'<span>Select files...</span>'
            +'<input type="hidden" class="image_id" name="'+prefix+'image_id'+flatNo+'"><input id="fileupload'+prefix+''+flatNo+'" class="fileupload" type="file" name="files">'
            +'</span>'
            +'<br>'
            +'<br>'
            +'<div id="progress'+prefix+flatNo+'" class="progress">'
            +'<div class="progress-bar progress-bar-success"></div>'
            +'</div>'
            +'<div id="'+prefix+flatNo+'"files" class="files'+prefix+flatNo+'"></div>'
            +'<br><div class="row-fluid">'
            +'<div class="col-md-12">'
            +'<img src="" class="image_display">'
            +'</div>';
    return html;
}


function getFloorOptions(floors,exception_no){
    html =  '<table width="100%">'
    col = 1
    for(i=1;i<=floors;i++){


        if(col==1){
            html +=  '<tr>'
        }
        html +='<td><input type="checkbox" name="exception_floors'+exception_no+'[]" value="'+i+'">'+i+'</td>'
        col++
        if(col==5){
            html +=  '</tr>'
            col=1
        }

    }

    if(col > 1){
        html +=  '</tr>'
    }
      html +='</table>'; 
    return html;

}

function getFlatsDropdown(exception_no){
html = '<select name="no_of_flats'+exception_no+'"  class="no_of_flats"  id="no_of_flats'+exception_no+'" flats_container_id="flats_container'+exception_no+'" exception_no="'+exception_no+'">'
    +'<option value="">Please Select</option>'

    for(i=1;i<=$('#no_of_flats > option').length-1;i++){
     html +='<option value="'+i+'">'+i+'</option>' 
    }
   html +='</select>'; 
   return html
}
function addException(exception_no){


    html =  ' <div class="form-group">'
        +  '<div class="input-with-icon  right exception_floors"><br><br>' 
        +  getFloorOptions($("#no_of_floors").val(),exception_no)
        +  '</div>'
        +  '</div>'
        +' <div class="form-group">'
        +'<label class="form-label">'
        +  'No Of Flats'
        + '</label>' 
        +  '<div class="input-with-icon  right">'
        +  '<i class="">'
        +  '</i>'
        +  getFlatsDropdown(exception_no)
        +  '</div>'
        +  '</div>'
        +  '<div class="well" id="flats_container'+exception_no+'">'
        +  '<div class="form-group">'
        +  '<label class="form-label">'
        +  '<i>Select No Of Flats</i>'
        +  '</label>'
        +  '</div>'
        +  '</div>'

    return html
}



//save building ajax call
    $(document).on("click", "#save_building", function(e) {

        clearAlerts();
        var data, _e;

        var _e = e;

        data = $("#form_add_edit_building").serialize();

        $(e.target).hide().parent().append("<div class='loading-animator'></div>")


        $.post(AJAXURL+"?action=save_building", data, function(response) {

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




    //building listing 


  if($('.tablesorter').length){

        _collections = collections
        $.post(AJAXURL, {
            action: "get_list_view",
            list: "buildings", //the list required
            masters:["phases"] //the masters required for the list
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
                 "<td>"+getDisplayText(listItems.building_phase,collections.masters["phases"],"name")+"</td>" +
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

        window.location.href = SITEURL + "/add-edit-building/?id="+$(e.target).parent().attr('data-id');
    });


})

