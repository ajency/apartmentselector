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
        mapplic_new : 'src/bower_components/preload/mapplic_new'
        mapplicAdmin : 'src/bower_components/preload/mapplic-admin'
        jqueryRemodal:'src/bower_components/preload/jquery.remodal'
        jqueryEasingmin :'src/bower_components/preload/jquery.easing.min'
        jqueryliquidslider :'src/bower_components/preload/jquery.liquid-slider.min'
        jquerytouchswipe :'src/bower_components/preload/jquery.touchSwipe.min'
        scroller : 'src/bower_components/preload/scroller'
        bjqs :'src/bower_components/preload/bjqs-1.3.min'
        jquerySecret :'src/bower_components/preload/jquery.secret-source.min'
        sudoSlider :'src/bower_components/preload/jquery.sudoSlider.min'
        jqueryCookie :'src/bower_components/jquery-cookie/jquery.cookie'
        jbox :'src/bower_components/jbox/Source/jBox.min'
        fancybox :'src/bower_components/fancybox/source/jquery.fancybox'
        jReject :'src/bower_components/jReject/js/jquery.reject'
        slimscroll :'src/bower_components/slimscroll/jquery.slimscroll.min'
        fullPage :'src/bower_components/fullpage.js/jquery.fullPage.min'
        JqueryPriceFormat: 'src/bower_components/Jquery-Price-Format/jquery.price_format.min'
        buggyFill: 'src/bower_components/viewport-units-buggyfill/viewport-units-buggyfill'
        autoNumeric: 'src/bower_components/autoNumeric/autoNumeric'






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
        mapplic_new : [ 'jquery' ]
        classie : [ 'jquery' ]
        selectFx : ['jquery']
        mapplicAdmin : ['jquery']
        jqueryRemodal : ['jquery']
        jqueryEasingmin : ['jquery']
        jqueryliquidslider : ['jquery']
        jquerytouchswipe : ['jquery']
        scroller : ['jquery']
        jqueryCookie : ['jquery']
        bjqs : ['jquery']
        jquerySecret: ['jquery']
        sudoSlider: ['jquery']
        jbox: ['jquery']
        fancybox: ['jquery']
        jReject: ['jquery']
        slimscroll: ['jquery']
        fullPage: ['jquery']
        JqueryPriceFormat :['jquery']
        autoNumeric : ['jquery']




