define ['app','text!apps/apartment/templates/apartment.html'], (App,memberTpl)->

    App.module "Member.Views", (Views, App)->


        class SingleView extends Marionette.ItemView

            tagName     : 'tr'

            className   : 'user_class'

            template 	: '<td class="v-align-middle width20 clickable"><div class="table_mob_hidden">Name</div>{{name}}</td>
                                      <td class="v-align-middle width20"><div class="table_mob_hidden">Date Joined</div>{{unitType}}</td>
                                      <td class="v-align-middle width20"><div class="table_mob_hidden">No Of Referrals</div>{{unitVariant}}</td>
                                      <td class="v-align-middle width20"><div class="table_mob_hidden">Points</div>{{building}}</td>
                                      <td class="v-align-middle width20 status"><div class="table_mob_hidden">Status</div>{{floor}}</td>
                                      <td class="v-align-middle width20"><div class="table_mob_hidden">Is a Customer</div>{{view}}</td>
                                      <td class="v-align-middle width20"><div class="table_mob_hidden">Is a Customer</div>{{status}}</td>'

            events  	:
                'click ': 'click'

            modelEvents	:
                'change:status': ->
                    @$el.find('.status').text @model.get "status"

            #click event to set the url
            click :->
                location.href = '#referrals/'+@model.get('user_login')+'/'+@model.get('ID')

            onShow:->
                @$el.find('.bolesemi').text @model.get "user_role"







        class Views.ProgramMember extends Marionette.CompositeView

            template 	: memberTpl

            className 	: ''

            itemView    : SingleView

            itemViewContainer : 'table#program-member-table tbody'


            #enable all the options
            onShow :->


                @$el.find("#program-member-table")
                .tablesorter({theme: 'blue',widthFixed: true,sortList: [ [0,1] ], widgets: ['zebra', 'filter']})
                .tablesorterPager({
                            container: $(".pager")
                            size: 25
                        })

            events      :


            #submit the form
                'click #submitform' :(e)->
                    console.log 'data'
                    e.preventDefault()
                    @$el.find('#hideshow').addClass 'collapsed'
                    @$el.find('#collapseOne').removeClass 'collapse in'
                    @$el.find('#collapseOne').addClass 'collapse'
                    @trigger "filter:member:info" , Backbone.Syphon.serialize @











