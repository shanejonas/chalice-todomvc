handleify = require 'handleify'
coffeeify = require 'coffeeify'
uglify = require 'uglify-js2'
shim = require 'browserify-shim'
path = require 'path'
fs = require 'fs'
handlebars = require 'handleify/node_modules/handlebars'
_ = require 'underscore'


module.exports = (grunt)->

  beforeHook = (bundle)->
    bundle.transform coffeeify
    bundle.transform handleify
    shim bundle,
      $: path: './vendor/zepto', exports: 'Zepto'

  generatePaths =
    collection:
      implementation:
        template: './templates/collection.hbs'
        dest: './src/collections/'
      spec:
        template: './templates/collection_spec.hbs'
        dest: './test/collections/'
    compositeview:
      implementation:
        template: './templates/compositeview.hbs'
        dest: './src/views/'
      spec:
        template: './templates/compositeview_spec.hbs'
        dest: './test/views/'
    model:
      implementation:
        template: './templates/model.hbs'
        dest: './src/models/'
      spec:
        template: './templates/model_spec.hbs'
        dest: './test/models/'
    view:
      template:
        template: './templates/view_template.hbs'
        dest: './src/views/'
      implementation:
        template: './templates/view.hbs'
        dest: './src/views/'
      spec:
        template: './templates/view_spec.hbs'
        dest: './test/views/'
    router:
      implementation:
        template: './templates/router.hbs'
        dest: './src/routers/'
      spec:
        template: './templates/router_spec.hbs'
        dest: './test/routers/'
  @initConfig
    delete: generatePaths
    generate: generatePaths
    regarde:
      styles:
        files: ['stylesheets/**/*']
        tasks: ['clean:styles', 'stylus:dev', 'livereload']
      app:
        files: ['src/**/*']
        tasks: ['clean:build', 'browserify2:dev', 'express:app', 'livereload']
    express:
      app: './server.coffee'
    clean:
      build: ['public/application.js']
      styles: ['public/style.css']
    browserify2:
      dev:
        expose:
          backbone: './node_modules/backbone/backbone.js'
        entry: './src/app/application.coffee'
        compile: './public/application.js'
        debug: yes
        beforeHook: beforeHook
      build:
        expose:
          backbone: './node_modules/backbone/backbone.js'
        entry: './src/app/application.coffee'
        compile: './public/application.js'
        beforeHook: beforeHook
        afterHook: (src)->
          result = uglify.minify src, fromString: true
          result.code
    stylus:
      dev:
        options:
          debug: yes
          use: ['nib']
          import: ['nib']
        files:
          'public/style.css': 'stylesheets/**/*.styl'
      build:
        options:
          debug: no
          use: ['nib']
          import: ['nib']
        files:
          'public/style.css': 'stylesheets/**/*.styl'
    watch:
      scripts:
        files: ['**/*.coffee'],
        tasks: ['default']

  @loadNpmTasks 'grunt-contrib-clean'
  @loadNpmTasks 'grunt-contrib-stylus'
  @loadNpmTasks 'grunt-contrib-livereload'
  @loadNpmTasks 'grunt-browserify2'
  @loadNpmTasks 'grunt-regarde'
  @loadNpmTasks 'grunt-devtools'
  @loadTasks 'tasks'

  @registerTask 'default', ['clean', 'stylus:dev', 'browserify2:dev', 'express:app', 'livereload-start', 'regarde']
  @registerTask 'build', ['clean', 'stylus:build', 'browserify2:build']
  @registerTask 'serve', ['express:app', 'express-keepalive']
  @registerTask 'dev', ['browserify2:dev', 'stylus:dev']

  # add support for handlebar templates on the server
  handlebarify = (module, filename) ->
    template = handlebars.compile fs.readFileSync filename, 'utf8'
    module.exports = (context) ->
      template context
  require.extensions['.hbs'] = handlebarify

  @registerMultiTask 'delete', 'a scaffolding task', ->
    config = grunt.config.get('generate')
    {implementation, spec, template} = config[@target]
    name = grunt.option('name')

    for templateObject in [implementation, spec, template]
      return if not templateObject
      if templateObject is template
        addTemplateToPath = yes
      else if templateObject is spec
        addSpecSuffix = yes

      extension = if addTemplateToPath then '.hbs' else '.coffee'

      suffix = if addSpecSuffix and extension isnt '.hbs' then '_spec' else ''
      templatePath = path.resolve templateObject.dest, name.toLowerCase()
      templatePath = templatePath + suffix + extension

      grunt.file.delete templatePath
      msg = "File deleted: #{grunt.log.wordlist [templatePath], color: 'cyan'}"
      grunt.log.writeln msg

  @registerMultiTask 'generate', 'a scaffolding task', ->
    config = grunt.config.get('generate')
    {implementation, spec, template} = config[@target]
    name = grunt.option('name')

    for templateObject in [implementation, spec, template]
      return if not templateObject
      if templateObject is template
        addTemplateToPath = yes
      else if templateObject is spec
        addSpecSuffix = yes

      extension = if addTemplateToPath then '.hbs' else '.coffee'

      suffix = if addSpecSuffix and extension isnt '.hbs' then '_spec' else ''
      templatePath = path.resolve templateObject.dest, name.toLowerCase()
      templatePath = templatePath + suffix + extension

      relativePath = './' + name.toLowerCase() + '.hbs'

      grunt.file.write templatePath, require(templateObject.template)({name, relativePath, nameLower: name.toLowerCase()})
      msg = "File written to: #{grunt.log.wordlist [templatePath], color: 'cyan'}"
      grunt.log.writeln msg
