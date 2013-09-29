module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      dist:
        files:
          'tmp/storage.js': 'src/storage.coffee'
        options:
          bare: true
      test:
        files:
          'tmp/storage.js': 'src/storage.coffee'
          'tmp/spec/test.js': 'test/spec/test.coffee'

    uglify:
      dist:
        options:
          report: 'min'
          preserveComments: 'some'
        src: 'tmp/storage.js'
        dest: 'storage.js'

    clean:
      test: ['tmp']

    mocha:
      test:
        src: ['test/index.html']
        options:
          bail: true
          log: true
          reporter: 'Nyan'
          run: true
          timeout: 10000
          mocha:
            ignoreLeaks: false

  # Load installed tasks
  grunt.file.glob
  .sync('./node_modules/grunt-*/tasks')
  .forEach(grunt.loadTasks)

  # Shortcuts
  grunt.registerTask 'test', ['clean', 'coffee:test', 'mocha']
  grunt.registerTask 'b', ['test', 'coffee:dist', 'uglify', 'clean']

  # Default task
  grunt.registerTask 'default', 'b'
