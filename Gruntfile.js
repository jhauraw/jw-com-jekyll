/*global module:false*/
module.exports = function(grunt) {

  grunt.initConfig({

    pkg: grunt.file.readJSON('package.json'),

    banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> -' +
    ' <%= grunt.template.today("yyyy-mm-dd") %> -' +
    '<%= pkg.homepage ? " " + pkg.homepage + " -" : "" %>' +
    ' Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %> -' +
    ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */',

    vendor_js_banner: '/*! foundation.js v4.1.5 | MIT License | foundation.zurb.com */',

    vendor_css_banner: '/*! Normalize v2.1.0 | MIT License | git.io/normalize *//*! Zurb Foundation v4.1.5 | MIT License | foundation.zurb.com *//*! Font Awesome 3.0.2 | OFL, MIT, CC BY | fortawesome.github.io/Font-Awesome *//*! pygments.css v1.6 | BSD License | pygments.org */',

    yaml_banner: '---\nlayout: nil\n---\n',

    compass: {
      all: {
        options: {
          /* require: 'zurb-foundation', */
          sassDir: '_assets/sass',
          importPath: ['bower_components/foundation/scss', 'bower_components/font-awesome/sass'],
          cssDir: 'assets',
          outputStyle: 'expanded',
          noLineComments: false,
          environment: 'development'
        }
      }
    },
    cssmin: {
      options: {
        keepSpecialComments: 0,
        report: 'min'
      },
      vendor: {
        options: {
          /* Because cssmin won't keepSpecialComments :( */
          banner: '<%= yaml_banner %>' + '<%= vendor_css_banner %>'
        },
        files: {
          'assets/vendor.css': ['assets/vendor.css']
        }
      },
      app: {
        options: {
          banner: '<%= yaml_banner %>' + '<%= banner %>'
        },
        files: {
          'assets/app.css': ['assets/app.css']
        }
      }
    },
    copy: {
      main: {
        files: [
          {src: ['bower_components/foundation/js/vendor/custom.modernizr.js'], dest: 'assets/modernizr.js'},

          /* Issue with 'mouse' events on 1.0.0rc1
             Rolled back to 1.0, maybe bower is getting too hot of a version

             Custom build, not supported in Bower, so build with this, then
             copy into Bower :-(
             $ cd /tmp
             $ git clone https://github.com/madrobby/zepto.git
             $ cd zepto
             $ coffee make dist
             $ MODULES="polyfill zepto detect event ajax form fx touch" ./make dist
          */
          {src: ['bower_components/zepto/zepto.min.js'], dest: 'assets/zepto.js'},

          {src: ['bower_components/jquery/jquery.min.js'], dest: 'assets/jquery.js'},
          {src: ['_assets/js/app/app.js'], dest: 'assets/app.js'},
          {expand: true, flatten: true, src: ['bower_components/font-awesome/font/*-webfont*'], dest: 'assets/'}
        ]
      }
    },
    concat: {
      vendor_js: {
        src: [
          'bower_components/foundation/js/foundation/foundation.js',
          'bower_components/foundation/js/foundation/foundation.alerts.js',
          'bower_components/foundation/js/foundation/foundation.clearing.js',
          'bower_components/foundation/js/foundation/foundation.cookie.js',
          'bower_components/foundation/js/foundation/foundation.dropdown.js',
          'bower_components/foundation/js/foundation/foundation.forms.js',
          'bower_components/foundation/js/foundation/foundation.joyride.js',
          'bower_components/foundation/js/foundation/foundation.magellan.js',
          'bower_components/foundation/js/foundation/foundation.orbit.js',
          'bower_components/foundation/js/foundation/foundation.placeholder.js',
          'bower_components/foundation/js/foundation/foundation.reveal.js',
          'bower_components/foundation/js/foundation/foundation.section.js',
          'bower_components/foundation/js/foundation/foundation.tooltips.js'
          /* 'bower_components/foundation/js/foundation/foundation.topbar.js', */
        ],
        dest: 'assets/vendor.js'
      }
      /*
      app_js: {
        src: ['_assets/js/app/app.js'],
        dest: 'js/app.js',
        options: {
          banner: '<%= banner %>',
          stripBanners: true
        }
      }
      */
    },
    'jshint': {
      all: ['_assets/js/app/*.js', '!_assets/js/vendor/**/*.js'],
      options: {
        browser: true,
        curly: false,
        eqeqeq: false,
        eqnull: true,
        expr: true,
        immed: true,
        newcap: true,
        noarg: true,
        smarttabs: true,
        sub: true,
        undef: false
      }
    },
    uglify: {
      options: {
        report: 'min'
      },
      foundation: {
        src: 'assets/vendor.js',
        dest: 'assets/vendor.js',
        options: {
          banner: '<%= vendor_js_banner %>'
        }
      },
      app: {
        src: 'assets/app.js',
        dest: 'assets/app.js',
        options: {
          banner: '<%= banner %>'
        }
      }
    },
    shell: {
      jekyll_build: {
        command: 'jekyll build --trace',
        options: {
          stdout: true
        }
      },
      jekyll_serve: {
        command: 'jekyll serve --trace',
        options: {
          stdout: true
        }
      }
    },
    clean: { // CAUTION! DELETES with NO TRASH (Recovory)
      pre: ['.sass-cache', 'assets/**/*'],
      post: ['_tmp/**/*']
    },
    watch: {
      options: {
        livereload: true
      },
      js: {
        files: '_assets/js/**/*.js',
        tasks: ['jshint', 'concat', 'copy', 'clean', 'shell:jekyll_serve'],
        options: {
          nospawn: true,
          interrupt: true
        }
      },
      css: {
        files: '_assets/sass/**/*.scss',
        tasks: ['compass', 'clean', 'shell:jekyll_serve'],
        options: {
          nospawn: true,
          interrupt: true
        }
      },
      ext: {
        files: ['!_site/**/*', '!_assets/**/*', '!node_modules/**/*', '!bower_components/**/*', '**/*.md', '**/*.html', '**/*.yml', '**/*.txt', '**/*.xml'],
        tasks: ['shell:jekyll_serve'],
        options: {
          nospawn: true,
          interrupt: true
        }
      }
    },

    gruntfile: {
      src: 'Gruntfile.js'
    }
  });

  grunt.registerTask('default', ['shell:jekyll_serve', 'watch']);

  // DEV Mode: Run this first one time to build out the _assets into /css and /js
  grunt.registerTask('build-dev', ['clean:pre', 'compass', 'jshint', 'concat', 'copy', 'clean:post', 'shell:jekyll_build']);

   /*
    PROD Mode: Run this when you are ready to DEPLOY.
    Be sure to change your site.url option in _config.yml
    from your DEV to your PROD url.
  */
  grunt.registerTask('build-prod', ['clean:pre', 'compass', 'jshint', 'concat', 'copy', 'cssmin', 'uglify', 'clean:post', 'shell:jekyll_build']);

  grunt.loadNpmTasks('grunt-shell');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-clean');

  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-cssmin');

  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-uglify');
};
