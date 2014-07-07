define ['app' , 'backbone'], (App) ->
    App.module "Entities.Unit", (Unit, App)->

        #define Unit Model
        class Unit extends Backbone.Model

            idAttribute: 'ID'

            defaults:
                name: ''
                unitType: ''
                unitVariant: ''
                building: ''
                floor: ''
                view: ''
                status: ''

                
               




            name: 'unit'


        #define Unit Collection
        class UnitMemberCollection extends Backbone.Collection

            model: Unit

            filterbyname:(data)->
                console.log data
                object = @
                events = ""
                $.each(data,(val,key)->
                    console.log val
                    events = object.filter (model)->
                        if val
                            console.log 'ref'
                            ref = data.unitvar1 == model.get 'unitVariant'



                        ref


                )
                events






            url: -> #ajax call to return a list of all the Units from the databse
                AJAXURL


        # declare a Unit collection instance

        unitCollection = new UnitCollection




        # API
        API =
            getUnits: -> #returns a collection of Units
                buildingArray  = Array()
                floorArray  = Array()
                viewArray  = Array()
                statusArray  = Array()
                unittypeArray = Array()
                unitvariantArray = Array()
                jsondata = JSON.parse(UNIT)
                unitCollection.add jsondata
                buildingCollection = App.request "get:building:collection"
                unittypeCollection = App.request "get:unittype:collection"
                unitvariantCollection = App.request "get:unitvariant:collection"
                viewCollection = App.request "get:view:collection"

                noofbuildings = unitCollection.pluck 'building'
                console.log uniqbuildings = _.uniq(noofbuildings)
                for element , index in uniqbuildings
                    buildingModel = buildingCollection.get element
                    buildingArray.push({'id': element,'name': buildingModel.get 'name'})


                nooffloors = unitCollection.pluck 'floor'
                console.log uniqnooffloors = _.uniq(nooffloors)
                for element , index in uniqnooffloors
                    floorArray.push({'id': element,'name': element})


                noofviews = unitCollection.pluck 'view'
                console.log uniqviews = _.uniq(noofviews)
                for element , index in uniqviews
                    viewModel = viewCollection.get element
                    viewArray.push({'id': element,'name': viewModel.get 'name'})
                noofstatus = unitCollection.pluck 'status'
                console.log uniqstatus = _.uniq(noofstatus)
                for element , index in uniqstatus
                    statusArray.push({'id': index,'name': element})

                noofunitType = unitCollection.pluck 'unitType'
                console.log uniqunitType = _.uniq(noofunitType)
                for element , index in uniqunitType
                    unitModel = unittypeCollection.get element
                    unittypeArray.push({'id': element,'name': unitModel.get 'name'})


                noofunitVariant = unitCollection.pluck 'unitVariant'
                console.log uniqunitVariant = _.uniq(noofunitVariant)
                for element , index in uniqunitVariant
                    unitVariantModel = unitvariantCollection.get element
                    unitvariantArray.push({'id': element,'name': unitVariantModel.get 'name'})




                unitCollection.each (logdata)->
                    building = buildingCollection.get logdata.get 'building'
                    unittype = unittypeCollection.get logdata.get 'unitType'
                    unitvariant = unitvariantCollection.get logdata.get 'unitVariant'
                    view = viewCollection.get logdata.get 'view'
                    logdata.set 'building' , building.get 'name'
                    logdata.set 'unitType' , unittype.get 'name'
                    logdata.set 'unitVariant' , unitvariant.get 'name'
                    logdata.set 'view' , view.get 'name'

                unitval = {'collection' :unitCollection,'building' : buildingArray ,'floor' : floorArray
                          ,'view':viewArray , 'status' : statusArray,'unittype' : unittypeArray, 'unitVariant' : unitvariantArray}
                unitval


            filterUnits: (data)->#filter collection
                memberArray = unitCollection.filterbyname(data)
                memberArray










        # Handlers
        App.reqres.setHandler "get:member:collection", ->
            API.getUnits()

        App.reqres.setHandler "filter:member:model", (data) ->
            API.filterUnits data




		



