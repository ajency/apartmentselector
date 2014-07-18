
//clear errors warnings and success alerts

function clearAlerts(){
    jQuery(".text-success").remove();
    jQuery(".text-error").remove();
}

//get the display text for the id from the the master collections
function getDisplayText(itemId,collection,field){
console.log(itemId)
console.log(collection)
console.log(field)
    itemFound =  _.findWhere(collection, {id: itemId})

    return itemFound==undefined ?'':itemFound[field];
}

function fileUpload(field){  
    // Change this to the location of your server-side upload handler:
  
    jQuery('#fileupload'+field).fileupload({
        url: AJAXURL+"?action=upload_file",
        
    autoUpload: true,
    add: function (e, data) { 
        data.submit();
    },
    progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);

        jQuery('#progress'+field+' .progress-bar').css(
            'width',
            progress + '%'
        );
    },
    done: function (e, data) {   
        console.log(jQuery('#fileupload'+field).parent().find(".image_id"))
       jQuery('#fileupload'+field).parent().find(".image_id").val(data.result.attachment_id )
       console.log(data.result.attachment_url)
       jQuery('#fileupload'+field).parent().parent().find(".image_display").attr('src',data.result.attachment_url )
    }
    }) 
}