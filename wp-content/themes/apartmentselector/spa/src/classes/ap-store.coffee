define [ 'underscore', 'extm', 'async' ], ( _, Extm, async ) ->
    _.extend Extm.Store::,


        getUnitTypes : ( available = true )->
            unitCollection = ""
            unitTypeModel = ""
            NewUnitCollection = ""
            modelArray = Array()
            #get all the 'available' units in the form of collection
            App.store.find( 'unit', { status : "Available" } ).then( ( result )->
                unitCollection = result
                #loop through collection
                #loop through collection
                unitCollection.each ( item )->
                    #get unit type model for each unit model
                    App.store.find( 'unit_type', item.get( 'unitType' ) ).then( ( result )->

                        unitTypeModel = result
                        modelArray.push unitTypeModel





                    )
                    # get all the units to which this unit type is assignd
                    App.store.find( 'unit', { unitType : unitTypeModel.get( 'id' ) } ).then( (result)->
                        NewUnitCollection = result
                        max_coll = Array()



                    #loop through New units Collection to get all unit variants
                        NewUnitCollection.each ( unit )->

                            variantModel = ""
                            #get unit varaint assignedto the unit type
                            App.store.find( 'unit_variant', unit.get( 'unitVariant' ) ).then( ( result )->
                                variantModel = result

                                #find the sellablearea of the unit variant and add it
                                max_coll.push variantModel.get 'sellablearea'

                            )

                        max_val = Math.max.apply(Math,max_coll)
                        min_val = Math.min.apply(Math,max_coll)
                        #set max and min attribute to the unit type model
                        unitTypeModel.set( { 'max_value' : max_val, 'min_value' : min_val } )
                        modelArray.push unitTypeModel

                    )




                unitCollection.reset modelArray
                unitCollection

            )
























        getBuildingModel : ( buildingId )->