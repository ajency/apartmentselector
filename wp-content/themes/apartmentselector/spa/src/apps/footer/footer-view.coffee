define [ 'marionette' ], ( Mariontte )->

    class FooterView extends Marionette.ItemView

        template : '<div class="text-center">
        				<div class="link small termsLink" >Terms &amp; Conditions</div> |
        				<div class="salesLink text-center small">Sales Login</div>
        			</div>'

        events:
        	'click .link':(e)->
        		win = window.open('http://manaslake.com/terms-conditions/', '_blank')

        	'click .salesLink':(e)->
        		win = window.open('http://homes.skyi.com/wp-admin/', '_self')
                
        		
       	