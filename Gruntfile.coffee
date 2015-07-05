controllersForConcat = [
  'app/assets/coffee/app.coffee'
  'app/assets/coffee/services/*.coffee'
  'app/assets/coffee/controllers/*.coffee'
]

libsJs = [
  'bower_components/jquery/dist/jquery.min.js'
  'bower_components/angular/angular.min.js'
  'bower_components/angular-route/angular-route.min.js'
  'bower_components/angular-resource/angular-resource.min.js'
  'bower_components/moment/min/moment-with-locales.min.js'
  'bower_components/angular-moment/angular-moment.min.js'
]

libsCss = [
  'bower_components/fontawesome/css/font-awesome.min.css'
]

module.exports = (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    coffee:
      options:
        bare: true
      vacations:
        files:
          'app/assets/dist/vacations.js': 'app/assets/coffee/vacations.coffee'
    less:
      options:
        compress: true
      vacations:
        files:
          'app/assets/dist/vacations.min.css': 'app/assets/less/vacations.less'
    concat:
      controllers:
        files:
          'app/assets/coffee/vacations.coffee': controllersForConcat
      libs:
        files:
          'app/assets/dist/libs.min.css': libsCss
          'app/assets/dist/libs.min.js': libsJs
    uglify:
      options:
        compress: false
      scripts:
        files:
          'app/assets/dist/vacations.min.js': 'app/assets/dist/vacations.js'
    watch:
      controllers:
        files: controllersForConcat
        tasks: ['concat:controllers', 'coffee:vacations', 'uglify:scripts']
      less:
        files: ['app/assets/less/*.less']
        tasks: ['less:vacations']
    browserSync:
      bsFiles:
        src: ['app/assets/dist/vacations.min.css', 'app/assets/dist/vacations.min.js', 'index.html', 'app/partials/*.html']
      options:
        server: './'

  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-browser-sync')

  grunt.registerTask('run', ['browserSync'])
