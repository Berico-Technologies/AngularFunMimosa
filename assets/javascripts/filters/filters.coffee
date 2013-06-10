###
  Ensures the parent object "filters" is available
  to child objects that will register with the Angular app.
  
  Filters are Angular's mechanism for filtering list items
  in Angular expressions.
###
define ['ang'], (angular) ->
	'use strict'

	angular.module 'filters', []