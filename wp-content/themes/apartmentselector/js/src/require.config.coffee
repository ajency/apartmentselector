requirejs.config
    urlArgs : "?ver=#{Math.random()}"
    baseUrl : '../wp-content/themes/apartmentselector/js/'
    paths :
        jquery : 'bower_components/jquery/dist/jquery'
        jqueryvalidate : 'bower_components/jquery.validation/dist/jquery.validate'
        bootstrap : 'bower_components/bootstrap/dist/js/bootstrap.min'
    shim :
        jqueryvalidate : [ 'jquery' ]
        bootstrap : [ 'jquery' ]