
jQuery(document).ready(function($) {
    var collections = [];
    //load unit variants 

    $('.fileupload').each(function(e,val) { 
         
        file_field =  val.id.replace(/fileupload/g,'');
        fileUploadByIndex(file_field);
    });

if($("#fileuploadposition_in_project").length>0){

    fileUploadById("position_in_project")
}


if($("#slider").length>0){
alert("fg")

    // the code belows assume the colors array is exactly one element bigger than the handlers array.
    var handlers = [25, 50, 75];
    var colors = ["#ff0000", "#00ff00", "#0000ff", "#00ffff"];
    updateColors(handlers);
    
    $("#slider").slider({
        min: 0,
        max: 100,
        values: handlers,
        slide: function (evt, ui) {
            updateColors(ui.values);
        }
    });
    
    function updateColors(values) {
        var colorstops = colors[0] + ", "; // start left with the first color
            for (var i=0; i< values.length; i++) {
                colorstops += colors[i] + " " + values[i] + "%,";
                colorstops += colors[i+1] + " " + values[i] + "%,";
            }
            // end with the last color to the right
            colorstops += colors[colors.length-1];
            
            /* Safari 5.1, Chrome 10+ */
            var css = '-webkit-linear-gradient(left,' + colorstops + ')';
            $('#slider').css('background-image', css);
    }
}
$(document).on("change", ".no_of_flats", function(e) {


        exception_no = $(e.target).attr('exception_no');
        //check the number of flats before the change of the no of flats
        prevCountOfFlats = $('.belongs_to_'+$(e.target).attr("id")).length 
 
       
        $("#"+$(e.target).attr('flats_container_id')).show() ;
        //if prev count less then the the new selection add the additional flats UI 
        if(prevCountOfFlats < $(e.target).val()){
 
            startFrom = prevCountOfFlats + 1;

            endTo = $(e.target).val();
 
            addFlatsUI(startFrom,$(e.target));
       
        }else{ //if the previous coun is greater then the current slection then find the differnce and remove the flats UI
 
            removeFlatsUI(prevCountOfFlats,$(e.target));
        }
       
        if($(e.target).val()==""){
          
            $("#"+$(e.target).attr('flats_container_id')).hide() ;
            return;
        }

    })

    $(document).on("change", "#no_of_floors", function(e) {

        loadExceptionsOption($(e.target).val());

        loadFloorRiseOption($(e.target).val());

        


    })

    $(document).on("click", "#addExceptions", function(e) {

         exception_no = parseInt($(e.target).attr("exception_count"))+1

        $(e.target).attr("exception_count",exception_no)

        $(".exception_container").append(addException(exception_no))


    });

function addFlatsUI(startFrom,element){
 
    for(i=startFrom;i<=element.val();i++){
 
        exception_no = element.attr('exception_no');

        var prefix = (exception_no!="")? 'exception_'+exception_no+'_':exception_no;
      
        $("#"+element.attr('flats_container_id')).append("<div flatno ='"+i+"' class='flat_ui belongs_to_"+element.attr("id")+"' >"+getFlatUi(i,exception_no)+'</div>')

        //bind file upload ui to the fileupload function

        fileUploadByIndex('basic_'+prefix+i)

        fileUploadByIndex('detailed_'+prefix+i)
        }
}

function removeFlatsUI(prevCountOfFlats,element){
 
     for(i=prevCountOfFlats;i>=element.val();i--){
      
         $('.belongs_to_'+element.attr("id")).eq(i).remove();
     }
    }

function loadExceptionsOption(floors){

    if(parseInt(floors)>0){

        $("#exceptions").show()

        //display one exception option ...button option to add multiple disabled for now
       if($("#exceptions_count").val()!=1){
         
            $(".exception_container").html(addException(1))

            $("#exceptions_count").val(1)
            
       }
      

        getFloorOptions(floors,1) ;


    }
    else{

        $("#exceptions").hide()


        $("#exceptions_count").val(0)

    }
   

}

function loadFloorRiseOption(floors){

    
    prevCount = $('.floor_rise').length;

    editfloors = floors - prevCount;
 
    if(editfloors>0){
         for(floor=prevCount+1;floor<=floors;floor++){

            $("#floor_rise_container").append("<div class='floor_rise form-group' id='floor_rise_item"+floor+"'><label class='form-label  form-label-inline'> Floor "+floor+": </label> <label class='form-label form-label-prefix'> Rs.</label><input type='text' class='form-control  form-control-small' value='0' name='floor_rise_"+floor+"'> per sq ft</div>");
         }
                 
    }else{

 
        for(floor=prevCount;floor>floors;floor--){
         
            $("#floor_rise_item"+floor).remove();
        }
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
        +'<div class="col-md-12">'; 
    html += getImageUploadUi(flatNo,exception_no,'basic'); 
    html += getImageUploadUi(flatNo,exception_no,'detailed')
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

function getImageUploadUi(flatNo,exception_no,field){

    prefix = (exception_no!="")? field+'_exception_'+exception_no+'_':field+'_'+exception_no;
    
    html =  toProperCase(field)+': <span class="btn btn-success fileinput-button">'
            +'<i class="glyphicon glyphicon-plus"></i>'
            +'<span>Select files...</span>'
            +'<input type="hidden" id="fileupload'+prefix+''+flatNo+'_image_id" name="'+prefix+'image_id'+flatNo+'"><input id="fileupload'+prefix+''+flatNo+'" class="fileupload" type="file" name="files">'
            +'</span>'
            +'<br>'
            +'<br>'
            +'<div id="progress'+prefix+flatNo+'" class="progress">'
            +'<div class="progress-bar progress-bar-success"></div>'
            +'</div>'
            +'<div id="'+prefix+flatNo+'"files" class="files'+prefix+flatNo+'"></div>'
            +'<br><div class="row-fluid">'
            +'<div class="col-md-12">'
            +'<img src="" id="fileupload'+prefix+''+flatNo+'_image_display">'
            +'</div>';
    return html;
}


function getFloorOptions(floors,exception_no){


    prevCount = $('.exception_floor').length;

    editfloors = floors - prevCount;
 
    if(editfloors>0){
       
         for(floor=prevCount+1;floor<=floors;floor++){
 
            $("#exception_floors_container"+exception_no).append("<div class='col-md-4'><div class='exception_floor checkbox check-default' id='"+exception_no+"exception_floor_item"+floor+"'><input type='checkbox' name='exception_floors"+exception_no+"[]' id='"+floor+"exception_floors"+exception_no+"'  value='"+floor+"'><label for='"+floor+"exception_floors"+exception_no+"'>"+floor+"</label></li></div></div>");
                
          }
    }else{
 
        for(floor=prevCount;floor>floors;floor--){
          
            $("#"+exception_no+"exception_floor_item"+floor).remove();
        }
    }

     

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
        +  '<div class="row-fluid" id="exception_floors_container'+exception_no+'">'+getFloorOptions($("#no_of_floors").val(),exception_no)+'</div>'//
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
        +  '<div class="well" id="flats_container'+exception_no+'" style="display:none">' 
        +  '</div>'
console.log("html")
console.log(html)
    return html
}



//save building ajax call
    $(document).on("click", "#save_building", function(e) {
              
        clearAlerts();

        //validate form
        if($('form').valid()){
            var data, _e;

            var _e = e;

            data = $("#form_add_edit_building").serialize();

            $(e.target).hide().parent().append("<div class='loading-animator'></div>")


            $.post(AJAXURL+"?action=save_building", data, function(response) {

            resetForm(e,$('#building_id').val(),response);
        });
        }
        
    });




    //building listing 


  if($('.tablesorter').length){

        _collections = collections
        $.post(AJAXURL, {
            action: "get_list_view",
            list: "buildings", //the list required
            masters:["phases","views"] //the masters required for the list
        }, function(response) {

            _collections.list = response.list

            _collections.masters = response.masters

            //load the list view with rows
            loadListContents();


        });
    }

    function loadListContents(){
        $(".tablesorter tbody").empty();


        _.each(collections.list, function(listItems,listItemsValue){
            //add the row items
            $(".tablesorter tbody").append("<tr  >" +
                "<td class='edit-link' data-id='"+listItems.id+"'>"+listItems.name+"</td>" +
                 "<td class='edit-link' data-id='"+listItems.id+"'>"+getDisplayText(listItems.phase,collections.masters["phases"],"name")+"</td>" +
                "<td  style='text-align:center'><i  class='fa fa-trash-o delete_building'  data-id='"+listItems.id+"'></i></td>" +
                "</tr>")
        })


            $(".tablesorter").tablesorter({
                theme : 'jui',
                sortList: [[0,0]],
                     headerTemplate: '<span>{content}</span>' +
                        '<div class="arrows">' +
                            '<i class="tablesorter-headerAsc"></i>' +
                            '<i class="tablesorter-headerDesc"></i>' +
                        '</div>',
                // hidden filter input/selects will resize the columns, so try to minimize the change
                widthFixed : true,
                // initialize zebra striping and filter widgets
                widgets : ["zebra", "filter", "stickyHeaders", "uitheme"],
                widgetOptions : {
                    // Use the $.tablesorter.storage utility to save the most recent filters
                    filter_saveFilters : true,
                    // jQuery selector string of an element used to reset the filters
                    filter_reset : '.reset-filters',
                    // add custom selector elements to the filter row
                    filter_formatter : {


                        // Total (jQuery selector added v2.17.0)
                         '.floor' : function($cell, indx){
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

        $(".reset-filters").trigger('click');

    }



    $(document).on("click", ".edit-link", function(e) {

        window.location.href = SITEURL + "/add-edit-building/?id="+$(e.target) .attr('data-id');
    });

     $(document).on("click", ".delete_building", function(e) {
 
        var _e = e
        clearAlerts();
         building_name = $(e.target).parent().parent().children(':first-child').html() 
        confirmUserAction = confirm("Are you sure you want to delete building "+building_name+" ?")
        if(confirmUserAction){

            $.post(AJAXURL, {

            action: "delete_building", 

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
                    building_name: { 
                        required: true
                    },
                    building_phase: { 
                        required: true
                    },
                    no_of_floors: { 
                        required: true
                    },
                    no_of_flats: { 
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

   $(document).on("change", "#building_payment_plan", function(e) {

        $("#building_milestone").empty();

        $("#building_milestone").append(new Option("Select", ""));
        if($(e.target).val()!=""){
 
        $.post(AJAXURL, {
            action: "get_payment_plan_milestones",

            payment_plan: $("option:selected", $(e.target)).val()
        }, function(response) {

        sortedresponse = _.sortBy(response, function (obj) { 
            
         return parseInt(obj.sort_index);
        });

            $.each(sortedresponse, function(i, val) {
                $("#building_milestone").append(new Option(val.name, val.milestone));
            });

        });
        }
   });
 
})

