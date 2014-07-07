
define [ 'underscore', 'spec/javascripts/fixtures/json/flats', 'jasminejquery' ], ( _ , flats )->

   describe 'apartment selectors filters', ->

      it 'must have 10 records', ->
         expect( _.size flats ).toBe 1