define [ 'marionette' ], ( Mariontte )->

    class FooterView extends Marionette.ItemView

        template : '<div class="link text-center small termsLink" >Terms &amp; Conditions</div>'

        events:
        	'click .link':(e)->
        		win = window.open('http://manaslake.com/terms-conditions/', '_blank')
                
        		
       	