# load all the scripts required for SPA
requirejs.config
    urlArgs : "ver=#{Math.random()}"
    baseUrl : '../wp-content/themes/apartmentselector/spa'
    paths :
        jquery : 'src/bower_components/jquery/dist/jquery'
        modernizr : 'src/bower_components/preload/modernizr.custom'
        classie : 'src/bower_components/preload/classie'
        backbone : 'src/bower_components/backbone/backbone'
        underscore : 'src/bower_components/underscore/underscore'
        marionette : 'src/bower_components/marionette/lib/core/backbone.marionette'
        mustache : 'src/bower_components/mustache/mustache'
        text : 'src/bower_components/requirejs-text/text'
        backbonesyphon : 'src/bower_components/backbone.syphon/lib/amd/backbone.syphon'
        'backbone.wreqr' : 'src/bower_components/backbone.wreqr/lib/backbone.wreqr'
        'backbone.babysitter' : 'src/bower_components/backbone.babysitter/lib/backbone.babysitter'
        plupload : 'src/bower_components/plupload/js/plupload.full.min'
        jasmineajax : 'src/bower_components/jasmine-ajax/lib/mock-ajax'
        jasminejquery : 'src/bower_components/jasmine-jquery/lib/jasmine-jquery'
        jqueryvalidate : 'src/bower_components/jquery.validation/dist/jquery.validate'
        async : 'src/bower_components/async/lib/async'
        bootstraptour : 'src/bower_components/bootstrap-tour/build/js/bootstrap-tour.js'
        underscorestring : 'src/bower_components/underscore.string/lib/underscore.string'
        extm : 'src/bower_components/extm/lib/extm.amd'
        hammer : 'src/bower_components/preload/hammer.min'
        slick : 'src/bower_components/bower_components/slick.js/slick/slick.min'
        selectFx : 'src/bower_components/preload/selectFx'
        jqueryeasing : 'src/bower_components/preload/jquery.easing'
        jquerymousewheel : 'src/bower_components/preload/jquery.mousewheel'
        mapplic : 'src/bower_components/preload/mapplic'
        mapplicAdmin : 'src/bower_components/preload/mapplic-admin'




    shim :
        jquery : [ 'underscore' ]
        underscorestring : [ 'underscore' ]
        backbone : [ 'jquery', 'underscore' ]
        marionette :
            deps : [ 'backbone', 'backbone.wreqr', 'backbone.babysitter' ]
        backbonesyphon : [ 'backbone' ]
        backboneassociations : [ 'backbone' ]
        jqueryvalidate : [ 'jquery' ]
        bootstrap : [ 'jquery' ]
        bootstraptour : [ 'bootstrap' ]
        jasminejquery : [ 'jquery' ]
        jasmineajax : [ 'jquery' ]
        plupload :
            deps : [ 'jquery' ]
            exports : 'plupload'

        preload : [ 'jquery' ]
        slick : [ 'jquery' ]
        jqueryeasing : [ 'jquery' ]
        jquerymousewheel : [ 'jquery' ]
        modernizr : ['jquery']
        mapplic : [ 'jquery' ]
        classie : [ 'jquery' ]
        selectFx : ['jquery']
        mapplicAdmin : ['jquery']



