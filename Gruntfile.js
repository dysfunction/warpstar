module.exports = function(grunt) {
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-browserify');
	grunt.loadNpmTasks('grunt-contrib-uglify');

    grunt.initConfig({
		watch: {
			scripts: {
				files: ['src/**/*.coffee'],
				tasks: ['browserify:debug'],
				options: {
				}
			}
		},
		browserify: {
			debug: {
				src: ['src/**/*.coffee'],
				dest: 'build/app.debug.js',

				options: {
					transform: ['coffeeify'],
					debug: true
				}
			},
			prod: {
				src: ['src/**/*.coffee'],
				dest: 'build/app.js',

				options: {
					transform: ['coffeeify']
				}
			}
		},
		uglify: {
			prod: {
				options: {
					report: 'gzip'
				},
				files: {
					'build/app.min.js': ['build/app.js']
				}
			}
		}
	});

    grunt.registerTask('default', ['browserify:debug', 'browserify:prod', 'uglify:prod']);
    grunt.registerTask('build', ['browserify:debug', 'browserify:prod', 'uglify:prod']);
    grunt.registerTask('debug', ['browserify:debug']);
}
