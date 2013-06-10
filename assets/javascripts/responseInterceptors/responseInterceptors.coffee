###
  Ensures the parent object "responseInterceptors" is available
  to child objects that will register with the Angular app.
###
define ['ang'], (angular) ->
	'use strict'

	angular.module 'responseInterceptors', []