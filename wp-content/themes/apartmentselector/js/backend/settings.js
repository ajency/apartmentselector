

jQuery(document).ready(function($) {
  

//save apartment ajax call
    $(document).on("click", "#save_settings", function(e) {

        clearAlerts();

        if($('form').valid()){

            var data, _e;

            var _e = e;

            data = $("#form_edit_settings").serialize();

            $(e.target).hide().parent().append("<div class='loading-animator'></div>")


            $.post(AJAXURL, data, function(response) {

                resetForm(e,'1',response);
       
            });
        }
    });

    
 
 

     //validations 
    $('form').validate({
                focusInvalid: false, 
                ignore: "",
                rules: {
                    vat: { 
                        required: true,
                        number: true
                    },
                    sales_tax: { 
                        required: true,
                        number: true
                    },
                    infrastructure_charges: {
                        required: true,
                        number: true
                    },
                    membership_fees: {
                        required: true,
                        number: true
                    },
                    
                },

                invalidHandler: function (event, validator) {
                    //display error alert on form submit    
                },

                errorPlacement: function (label, element) { // render error placement for each input type   
                    $(element).parent().append('<span class="error"></span>').append(label)
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