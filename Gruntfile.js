module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    nodemon: {
      dev: {
        options: {
          file: 'server.js',
          args: ['dev'],
          nodeArgs: ['--debug'],
          ignoredFiles: ['node_modules/**'],
          delayTime: 1,
          legacyWatch: true,
          env: {
            PORT: '8080'
          },
          cwd: __dirname
        }
      },
    }
  });

  // Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks('grunt-nodemon');

  // Default task(s).
  grunt.registerTask('default', ['nodemon']);
};
