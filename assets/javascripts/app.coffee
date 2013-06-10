###
  Think of this as the "constructor" or "init method"
  for an Angular application.
  
  Here we are including the core modules we need injected
  into the Angular app, as well as, ensuring templates are
  made available from the templates.js file and not via AJAX.
###
define [
	'ang'
	'templates'
	'c/controllers'
	'd/directives'
	'filters/filters'
	'vendor/angularResource'
	'responseInterceptors/responseInterceptors'
	'services/services'
	], (angular, templates) ->
	'use strict'

	app = angular.module 'app', [
		'controllers'
		'directives'
		'filters'
		'ngResource'
		'responseInterceptors'
		'services'
	]
	
	# This is a hack to ensure that templates are loaded
	# by Angular from Required dependency (compiled by 
	# Mimosa) rather than having Angular make AJAX calls
	# for each template.
	app.run ["$templateCache", ($templateCache) ->
		for name, template of templates
			$templateCache.put name, template
	]
  
	# Yes David, I could have left this out, but sometimes,
	# I find it important for people to understand what is
	# actually happening!
	return app
