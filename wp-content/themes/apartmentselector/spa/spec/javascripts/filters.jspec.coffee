define ['underscore','jasminejquery'], ( _ )->

   describe 'apartment selectors filters', ->

      fixtures = loadJSONFixtures 'flats.json'
      alert fixtures['flats.json']
      data = fixtures['flats.json']
      it 'must have 10 records', ->
         expect(_.size data.flats).toBe 10