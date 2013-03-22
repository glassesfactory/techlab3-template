module.exports = (grunt) ->
  
  "use strict"

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    coffee:
      product:
        options:
          bare: true
        expand: true
        cwd: 'src/coffee'
        src: '*.coffee'
        dest: 'assets/js/'
        ext: '.js'

    sass:
      product:
        options:
          style: 'expanded'
        files:
          'assets/css/main.css':'src/sass/main.sass'

    concat:
      options:
        separator: ";"
      product:
        src: ['assets/js/*.js']
        dest: 'assets/js/main.js'

    uglify:
      product:
        files:
          'assets/js/main.js': ['assets/js/main.js']

    watch:
      product:
        files: ["src/coffee/*.coffee", "src/sass/*.sass"]
        tasks: ["coffee:product", "sass:product", "concat:product", "uglify:product"]

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-watch"

  
  grunt.registerTask "default", ["coffee", "sass"]
