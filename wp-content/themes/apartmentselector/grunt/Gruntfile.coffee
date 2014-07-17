module.exports = ( grunt ) ->
   require( 'time-grunt' )( grunt )

   grunt.initConfig

      pkg : grunt.file.readJSON "package.json"

      exec :
         themeJS :
            command : 'coffee -w -c -b ../js/'
         spaJS :
            command : 'coffee -w -c -b ../spa/'
         compileall :
            command : 'coffee -c -b ../../'

   # LESS lint.
   # Verifies if less file are proper. Checks for any unused variables
   # invalid/bad selectors
      lesslint :
         options :
            csslint :
               "known-properties" : false

         themeLess :
            src : [ "../css/*.less", "../css/**/*.less" ]

      githooks :
         all :
            'pre-commit' : 'themeJSOptimize'


   # JS Linting
   # JSHint is a program that flags suspicious usage in programs written in JavaScript.
   # Tracks unsed variables. JS common errors. Configuration files is .jshintrc
   # List of ignored files/folders is stored in .jshintignore
      jshint :
         options :
            jshintrc : '.jshintrc'
            jshintignore : '.jshintignore'
            reporter : require 'jshint-stylish'
         themeJS : []
         spaJS : []

   # CoffeeLint
      coffeelint :
         options :
            configFile : 'coffeelint.json'
         themeCoffee :
            files :
               src : [ "../js/*.coffee", "../js/**/*.coffee" ]
         spaCoffee :
            files :
               src : [ "../spa/*.coffee", "../spa/**/*.coffee" ]


   # PHP Code Sniffer
   # detects violations of a defined set of coding standards
   # It is an essential development tool that ensures your code remains clean and consistent.
   # It can also help prevent some common semantic errors made by developers.
      phpcs :
         options :
            standard : "Wordpress"
         theme :
            dir : [ "../*.php", "../**/*.php" ]
         plugins :
            dir : []


   # PHP Unit
   # PHPUnit is a programmer-oriented testing framework for PHP.
   # It is an instance of the xUnit architecture for unit testing frameworks.
      phpunit :
         options :
            bootstrap : "../../../../tests/includes/bootstrap.php"
            colors : true
         theme :
            classes :
               dir : [ "../tests" ]
         plugins :
            classes :
               dir : []


   # Karma js unit testing
   # Automatically builds and maintains your spec runner and runs your tests headlessly through PhantomJS.
      karma :
         options :
            browsers : [ 'PhantomJS' ]
            singleRun : true
         themeJS :
            configFile : "../js/spec/karma.conf.js"
         spaJS :
            configFile : "../spa/spec/karma.conf.js"


   # "TODO" list
   # Find TODO, FIXME and NOTE inside project files
   # Developers can add TODO comments in their code when they need to leave something behind
   # Running this grunt will give the full list of todo list item through out the project source code
      todo :
         options :
            marks : [
               (pattern : "TODO", color : "#F47605")
               (pattern : "FIXME", color : "red")
               (pattern : "NOTE", color : "blue")
            ]
         lessTODO :
            src : [ "../css/*.less", "../css/**/*.less" ]
         phpTODO :
            src : [ "../*.php", "../**/*.php" ]
         themeJSTODO :
            src : [ "../js/*.coffee", "../js/**/*.coffee" ]
         spaTODO :
            src : [ "../spa/*.coffee", "../spa/**/*.coffee" ]


   # Less => Css
   # Compiles all *.styles.less files to respective css files for production
   # Uses *.styles.less pattern to detect files to compile
      less :
         production :
            options :
               paths : [ "../css" ]
               cleancss : true
               compress : true
            files : [
               expand : true
               cwd : "../css"
               src : [ "../css/*.styles.less" ]
               dest : "../css"
               ext : ".styles.min.css"
            ]


   # Clean production folder before new files are copied over
      clean :
         prevBuilds :
            src : [ "../css/*.styles.min.css", "../js/src/*.scripts.min.js", "../spa/src/*.spa.min.js" ]
            options :
               force : true
         production :
            src : [ "../production/*" ]
            options :
               force : true


   # Copy all production resources to "production" folder
      copyto :

         production :
            files : [
               (
                  cwd : "../css"
                  src : [ "*.styles.min.css" ]
                  dest : "../production/"
               ),
               (
                  cwd : "../js/src"
                  src : [ "*.scripts.min.js" ]
                  dest : "../production/"
               ),
               (
                  cwd : "../spa/src"
                  src : [ "*.spa.min.js" ]
                  dest : "../production/"
               )
            ]


   # Cross OS notifier
      notify :
         readyToDeploy :
            options :
               title : "Code is ready to deploy"


   # Load NPM's via matchdep
   require( "matchdep" ).filterDev( "grunt-*" ).forEach grunt.loadNpmTasks

   # Requirejs Optimizer
   # Optimizes the requirejs modules with r.js
   grunt.registerTask "themeJSOptimize", "Optimize the theme JS files", ->
      files = grunt.file.expand "../js/src/*.scripts.js"

      if files.length is 0
         grunt.log.write "No files to optimize"
         return

      subTasks = getRequireJSTasks files, "scripts"

      # set the tasks
      grunt.config.set 'requirejs', subTasks
      grunt.task.run "requirejs"


   # Requirejs Optimizer
   # Optimizes the requirejs modules with r.js
   grunt.registerTask "themespaOptimize", "Optimize the spa JS files", ->
      files = grunt.file.expand "../spa/src/*.spa.js"

      if files.length is 0
         grunt.log.write "No files to optimize"
         return

      subTasks = getRequireJSTasks files, "spa"

      # set the tasks
      grunt.config.set 'requirejs', subTasks
      grunt.task.run "requirejs"


   # Custom task to create a git commit
   grunt.registerTask "gitCommit", "Commit production files", ->



      # create the subtasks for the require js optimizer
   getRequireJSTasks = ( files, pattern )->
      subTasks = {}

      folderPath = if pattern is 'scripts' then 'js' else 'spa'

      originalExtension = "#{pattern}.js"
      optimizedExtension = "#{pattern}.min.js"

      files.map ( file )->
         file = file.replace "../#{folderPath}/src/", ""

         config =
            baseUrl : "../#{folderPath}"
            mainConfigFile : "../#{folderPath}/src/require.config.js"
            name : "src/bower_components/almond/almond"
            include : [ "src/#{file}" ]
            out : "../#{folderPath}/src/#{file.replace originalExtension, optimizedExtension}"
            findNestedDependencies : true
            optimize : 'none' # uncomment for testing minified JS

         # get the module/page name
         name = file.replace ".#{pattern}.js", ""

         # set the task
         subTasks[name] = {}
         subTasks[name]["options"] = config

      subTasks

   grunt.registerTask "compile", "Compile coffee file watcher", ( args )->
      grunt.task.run "exec:#{args}"

   # helper commands to run series of tasks
   grunt.registerTask "validate", [ "lesslint", "coffeelint" , "jshint", "phpcs" ]
   grunt.registerTask "runtests", [ "karma", "phpunit" ]
   grunt.registerTask "optimize", [ "less", "themeJSOptimize", "themespaOptimize" ]
   grunt.registerTask "build",
     [ "themeJSOptimize","themespaOptimize", "less", "clean:production", "copyto", "clean:prevBuilds" ]
   grunt.registerTask "deploy", [ "validate", "runtests", "optimize", "clean", "copyto", "notify:readyToDeploy" ]