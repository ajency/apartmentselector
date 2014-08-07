 jQuery(document).ready(function($) {

    init();

    function init(){

    $(".frm_submit").remove();

   

    $("#main-form-container").show();
     
    $(":file").each(function(index,file) {
      customFileUploadUi($(file)) 
      $(file).parent().append(customFileUploadUi($(file)))
      
      

fileUploadByformidable($(file))

$(file).remove()

    
    });
  }
    var AddDetailsLink, DisplayFormVIew, GetSubFormEntries;
    DisplayFormVIew = function(FormId, EntryIds, Element) {
      $.post(AJAXURL, {
        action: "fetch_form_views",
        form_id: FormId,
        entry_ids: EntryIds,
        async: false
      }, function(response) {
        var FormNo, NoOfForms, i, store_entry_data;
        store_entry_data = $(Element).attr("store-entry-data");
        i = 0;
        while (i < response.length) {
          FormNo = parseInt(i) + 1;
          $(Element).parent().append("<div class='form-container bordered' store-entry-data='" + store_entry_data + "' form-no='" + FormNo + "' entry-id='" + response[i].entry_id + "'>" + response[i].form_html + "</div>");
          ++i;
        }
        NoOfForms = ($("option:selected", $(Element)).attr("no-of-forms") !== undefined ? $("option:selected", $(Element)).attr("no-of-forms") : 0);
        NoOfForms = ($(Element).attr("no-of-forms") !== undefined && NoOfForms === 0 ? $(Element).attr("no-of-forms") : NoOfForms) - i;
        return AddDetailsLink(Element, NoOfForms);
      });
    };
    AddDetailsLink = function(Element, NoOfForms) {
      var FieldStoreEntryData, FormId, I;
      FormId = $(Element).attr("form-id");
      FieldStoreEntryData = $(Element).attr("store-entry-data");
      I = 1;
      while (I <= NoOfForms) {
        $(Element).parent().append("<div class='form-container bordered' store-entry-data='" + FieldStoreEntryData + "'   ><a href='javascript:void(0)'form-id='" + FormId + "' class='show-add-form' store-entry-data='" + FieldStoreEntryData + "' >Add Details</a></div>");
        I++;
      }
    };
    GetSubFormEntries = function(e) {
      var SaveEntries, StoreEntryData, entries, parent, sub_forms, _e;
      _e = e;
      sub_forms = $(e.target).prev().children('.frm_forms .frm_form_fields').children().children().find(".form-container");
      parent = $(e.target).prev().children('.frm_forms .frm_form_fields').children().children();
      if (sub_forms.length === 0) {
        sub_forms = $(e.target).prev().children().children('.frm_form_fields').children().children().find(".form-container");
        parent = $(e.target).prev().children().children('.frm_form_fields').children().children();
      }
      if (sub_forms.length !== 0) {
        entries = [];
        StoreEntryData = "";
        $.each(sub_forms, function(i, val) {
          StoreEntryData = $(val).attr("store-entry-data");
          entries[$(val).attr("form-no")] = $(val).attr("entry-id");
        });
        SaveEntries = [];
        Object.keys(entries).length === entries.length;
        $.each(entries, function(i, val) {
          if (val !== undefined) {
            SaveEntries.push(val);
          }
        });
        return parent.children("." + StoreEntryData).val(SaveEntries);
      }
    };

    $(document).on("click", ".add-rooms", function(e) {
      var FormNo, field_store_entry_data, form_id;
      form_id = $(this).attr("form-id");
      FormNo = parseInt($(this).parent().children('.form-container').length) + 1;
      field_store_entry_data = $(this).attr("store-entry-data");
      $(e.target).parent().append("<div class='form-container bordered' store-entry-data='" + field_store_entry_data + "' form-no= '" + FormNo + "'  ><a href='javascript:void(0)'form-id='" + form_id + "' class='show-add-form' >Add Details</a></div>");
    });
    $(".show_sub_form").each(function(e) {
      var entry_ids, field_store_entry_data, form_id, get_form_id, _this;
      _this = this;
      get_form_id = $("option:selected", $(this)).attr("form-id");
      form_id = (get_form_id === "" || get_form_id === undefined ? $(this).attr("form-id") : get_form_id);
      field_store_entry_data = $(this).attr("store-entry-data");
      entry_ids = $(this).parent().parent().find("." + field_store_entry_data).val();
      if (entry_ids !== "" && entry_ids !== undefined) {
        DisplayFormVIew(form_id, entry_ids, _this);
      }
    });
    $(document).on("change", ".room_type", function(e) {
      var entry_id, field_id, field_store_entry_data, form_id, selected_value;
      form_id = $("option:selected", $(this)).attr("form-id");
      field_store_entry_data = $(this).attr("store-entry-data");
      $(e.target).parent().parent().find("." + field_store_entry_data).val('');
      selected_value = $(this).attr("selected-value");
      entry_id = $(this).parent().parent().find("." + field_store_entry_data).val();
      field_id = $(this).attr("field-id");
      if (form_id === "") {
        $(e.target).parent().find(".form-container").remove();
        return;
      }
      if (form_id === selected_value) {
        DisplayFormVIew(form_id, entry_id, $(e.target));
      } else {
        $(e.target).parent().find(".form-container").remove();
        $(e.target).parent().append("<div class='form-container bordered' store-entry-data='" + field_store_entry_data + "' form-no=1 ><a href='javascript:void(0)'form-id='" + form_id + "' class='show-add-form' >Add Details</a></div>");
      }
    });
    $(document).on("change", ".unit_type", function(e) {
      var entry_id, field_id, field_store_entry_data, form_id, i, no_of_forms, selected_value;
      form_id = $("option:selected", $(e.target)).attr("form-id");
      field_store_entry_data = $(this).attr("store-entry-data");
      $(e.target).parent().parent().find("." + field_store_entry_data).val('');
      selected_value = $(this).attr("selected-value");
      entry_id = $("#" + field_store_entry_data).val();
      field_id = $(e.target).attr("field-id");
      no_of_forms = $("option:selected", $(e.target)).attr("no-of-forms");
      if (form_id === "") {
        $(e.target).parent().find(".form-container").remove();
        return;
      }
      if (no_of_forms !== "" && no_of_forms !== undefined) {
        $(e.target).parent().find(".form-container").remove();
        i = 1;
        while (i <= no_of_forms) {
          $(e.target).parent().append("<div class='form-container bordered' store-entry-data='" + field_store_entry_data + "' selected_value = " + selected_value + " form_id = " + form_id + " form-no=" + i + "><a href='javascript:void(0)'form-id='" + form_id + "' class='show-add-form'  floor-no=" + i + "  >Add Details</a></div>");
          i++;
        }
      }
    });
    $(document).on("click", ".save-form", function(e) {
      var data, _e;
      _e = e;
      GetSubFormEntries(_e);
      data = $("form").serializeArray();
      $.post(AJAXURL, {
        action: "save_entry",
        data: data
      }, function(response) {
        if (response.entry_id === false) {
          alert("error saving the entry");
          return;
        }
        $(_e.target).parent().attr('entry-id', response.entry_id);
        return $(_e.target).parent().html(response.entry_html);
      });
    });
    $(document).on("click", "#save-main-entry", function(e) {
      var data;
      $("#save-main-entry").hide().parent().append("saving...")
      GetSubFormEntries(e);
      data = $("#frm_form_" + $("#save-main-entry").attr("form-id") + "_container form").serializeArray();
     

     data = room_type_sizes(data);
        
      $.post(AJAXURL, {
        action: "save_entry",
        data: data
      }, function(response) {
       window.location.href = SITEURL + "/listing/?form_id=" + $("#frm_form_" + $("#save-main-entry").attr("form-id") + "_container form input[name='form_id']").val();
      });
    });
    $(document).on("click", ".show-add-form", function(e) {
      var form_id, _e;
      _e = e;
      form_id = $(e.target).attr("form-id");
      $.post(AJAXURL, {
        action: "fetch_form",
        form_id: form_id,
        async: false
      }, function(response) {
        var parent;
        parent = $(_e.target).parent();
        $(_e.target).parent().html(response);
        $(".frm_submit").remove();
      });
    });
    $(document).on("click", ".edit-entry", function(e) {
      var entry, form_id, _e;
      _e = e;
      form_id = $(e.target).attr("form-id");
      entry = $(e.target).attr("entry-id");
      $.post(AJAXURL, {
        action: "fetch_form",
        form_id: form_id,
        entry: entry,
        frm_action: "edit",
        async: false
      }, function(response) {
        var parent;
        parent = $(_e.target).parent();
        parent.html(response);
        $(".frm_submit").remove();
        parent.find(".show_sub_form").each(function(e) {
          var entry_ids, field_store_entry_data, get_form_id, _this;
          _this = this;
          get_form_id = $("option:selected", $(this)).attr("form-id");
          form_id = (get_form_id === "" || get_form_id === undefined ? $(this).attr("form-id") : get_form_id);
          field_store_entry_data = $(this).attr("store-entry-data");
          entry_ids = $(this).parent().parent().find("." + field_store_entry_data).val();
          if (entry_ids !== "" && entry_ids !== undefined) {
            DisplayFormVIew(form_id, entry_ids, _this);
          }
        });
      });
    });

function room_type_sizes(data){
  room_sizes = []
  if($('#add_more_room_sizes').length!=0){

    for(i=1;i<=$('#add_more_room_sizes').attr("last-sr-no");i++){
  
      if($("#room_type_for_size_"+i).length!=0){ 
        room_sizes.push({'room_type':$("#room_type_for_size_"+i).val(),'room_size':$("#room_type_size_"+i).val()})
      }

    }
    data.push({name:$('#add_more_room_sizes').attr('field-name'),value:room_sizes})
  }
  return data;
}

  $(document).on("click", "#add_more_room_sizes", function(e) {

    itemNo = parseInt($(e.target).attr("last-sr-no"))+1;

    $(e.target).attr("last-sr-no",itemNo);
 
    cloneElement = $("#room-type-for-size-item-1").html()

    html = '<div id="room-type-for-size-item-'+itemNo+'">';

    elements_html = cloneElement.replace(/1/g,itemNo);

    html +=elements_html;

    html +='</div>';
 
   $('#room-type-for-size-container div:last').before( html );
  });

 
   $(document).on("click", ".delete_room_type_size_item", function(e) {

      itemNo =  parseInt($(e.target).attr("item-no"));

      if(itemNo==1){

        alert("Not allowed to delete the first Item");
      }
      else{

        $("#room-type-for-size-item-"+itemNo).remove();

      }

  });
 
  }); 
