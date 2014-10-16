define [ 'marionette' ], ( Mariontte )->

    class FooterView extends Marionette.ItemView

        template : '<label class="link" >Terms &amp; Conditions</label>'

        events:
        	'click .link':(e)->
        		win = window.open('http://manaslake.com/terms-conditions/', '_blank')
                
        		
       	