define ['app'

        'apps/apartment/apartmentController'
], (App)->

    App.module "ProgramMember", (ProgramMember, App)->

        # define routers
        class ProgramMemberRouter extends Marionette.AppRouter

            appRoutes:
                'apartment' 		 : 'list'
                'referrals/:id/:userid'	 : 'show'



        RouterAPI =
        #Start Sub App
            list : ->
                console.log "ssssssssssssss"
                App.execute "show:program:members" , region : App.mainContentRegion

            show :(id,userid) ->
                App.execute "show:main:App" ,
                    region : App.mainContentRegion
                    ID : id
                    userid : userid




        #Start Program Member App
        ProgramMember.on 'start',->
            new ProgramMemberRouter
                controller : RouterAPI