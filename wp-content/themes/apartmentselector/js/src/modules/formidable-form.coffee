define ['jquery'],(jQuery)->

    jQuery(document).ready ($) ->
        display_form_view = (form_id, entry_ids, element) ->
            $.post AJAXURL,
                action: "fetch_form_views"
                form_id: form_id
                entry_ids: entry_ids
                async: false
            , (response) ->
                store_entry_data = $(element).attr("store-entry-data")
                i = 0
                while i < response.length
                    $(element).parent().append "<div class='form-container bordered' store-entry-data='" + store_entry_data + "' >" + response[i] + "</div>"
                    ++i
                return

            return
        $(".frm_submit").remove()
        $(document).on "click", ".add-rooms",(e) ->
            form_id = $(this).attr("form-id")
            field_store_entry_data = $(this).attr("store-entry-data")
            $(e.target).parent().append "<div class='form-container bordered' store-entry-data='" + field_store_entry_data + "'   ><a href='javascript:void(0)'form-id='" + form_id + "' class='show-add-form' >Add Details</a></div>"
            return

        $(".show_sub_form").each (e) ->
            _this = this
            get_form_id = $("option:selected", $(this)).attr("form-id")
            form_id = (if (get_form_id is "" or get_form_id is `undefined`) then $(this).attr("form-id") else get_form_id)
            field_store_entry_data = $(this).attr("store-entry-data")
            entry_ids = $(this).parent().parent().find("." + field_store_entry_data).val()
            display_form_view form_id, entry_ids, _this  if entry_ids isnt "" and entry_ids isnt `undefined`
            return

        $(document).on "click", ".room_type",(e) ->
            form_id = ($("option:selected", $(this)).attr("form-id"))
            field_store_entry_data = $(this).attr("store-entry-data")
            selected_value = $(this).attr("selected-value")
            entry_id = $(this).parent().parent().find("." + field_store_entry_data).val()
            field_id = $(this).attr("field-id")
            if form_id is ""
                $(e.target).parent().find(".form-container").remove()
                return
            if form_id is selected_value
                display_form_view form_id, entry_id, $(e.target)
            else
                $(e.target).parent().find(".form-container").remove()
                $(e.target).parent().append "<div class='form-container bordered' store-entry-data='" + field_store_entry_data + "'  ><a href='javascript:void(0)'form-id='" + form_id + "' class='show-add-form' >Add Details</a></div>"
            return

        $(document).on "click", ".unit_type",(e) ->
            form_id = ($("option:selected", $(e.target)).attr("form-id"))
            field_store_entry_data = $(this).attr("store-entry-data")
            selected_value = $(this).attr("selected-value")
            entry_id = $("#" + field_store_entry_data).val()
            field_id = $(e.target).attr("field-id")
            no_of_floors = $("option:selected", $(e.target)).attr("no-of-floors")
            if form_id is ""
                $(e.target).parent().find(".form-container").remove()
                return
            if no_of_floors isnt "" and no_of_floors isnt `undefined`
                $(e.target).parent().find(".form-container").remove()
                i = 1
                while i <= no_of_floors
                    $(e.target).parent().append "<div class='form-container bordered' store-entry-data='" + field_store_entry_data + "' selected_value = " + selected_value + " form_id = " + form_id + "><a href='javascript:void(0)'form-id='" + form_id + "' class='show-add-form'  floor-no=" + i + "  >Add Details</a></div>"
                    i++
            return

        $(document).on "click", ".save-form",(e) ->
            _e = e
            data = $("#" + $(e.target).prev().attr("id") + "  :input").serializeArray()
            $.post AJAXURL,
                action: "save_entry"
                data: data
            , (response) ->
                prev_selected_value = $("#" + $(_e.target).parent().attr("selected_value")).val()
                form_id = $("#" + $(_e.target).parent().attr("form_id")).val()
                if $(_e.target).parent().find("input[name='id']").length is 0
                    unless form_id is prev_selected_value
                        $(_e.target).parent().parent().parent().find("." + $(_e.target).parent().attr("store-entry-data")).val ""
                    else
                        entries = $(_e.target).parent().parent().parent().find("." + $(_e.target).parent().attr("store-entry-data")).val()
                        if entries isnt "" and entries isnt `undefined`
                            entries = entries.split(",")
                        else
                            entries = []
                        entries.push response.entry_id
                        entries.join ","
                    $(_e.target).parent().parent().parent().find("." + $(_e.target).parent().attr("store-entry-data")).val entries
                $(_e.target).parent().html response.entry_html
                return

            return

        $(document).on "click", "#save-main-entry",(e) ->
            data = $("#frm_form_" + $("#save-main-entry").attr("form-id") + "_container form").serializeArray()
            $.post AJAXURL,
                action: "save_entry"
                data: data
            , (response) ->
                window.location.href = SITEURL + "/listing/"
                return

            return

        $(document).on "click", ".show-add-form", (e) ->
            console.log('sfdsf')
            _e = e
            form_id = $(e.target).attr("form-id")
            entry = $(e.target).attr("entry-id")
            $.post AJAXURL,
                action: "fetch_form"
                form_id: form_id
                async: false
            , (response) ->
                parent = $(_e.target).parent()
                $(_e.target).parent().html response
                $(".frm_submit").remove()
                return

            return
        $(document).on "click", ".edit-entry", (e) ->
            _e = e
            form_id = $(e.target).attr("form-id")
            entry = $(e.target).attr("entry-id")
            $.post AJAXURL,
                action: "fetch_form"
                form_id: form_id
                entry: entry
                frm_action: "edit"
                async: false
            , (response) ->
                parent = $(_e.target).parent()
                parent.html response
                $(".frm_submit").remove()
                parent.find(".show_sub_form").each (e) ->
                    _this = this
                    get_form_id = $("option:selected", $(this)).attr("form-id")
                    form_id = (if (get_form_id is "" or get_form_id is `undefined`) then $(this).attr("form-id") else get_form_id)
                    field_store_entry_data = $(this).attr("store-entry-data")
                    entry_ids = $(this).parent().parent().find("." + field_store_entry_data).val()
                    display_form_view form_id, entry_ids, _this  if entry_ids isnt "" and entry_ids isnt `undefined`
                    return

                return

            return

        return
