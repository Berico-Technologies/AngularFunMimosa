###
  Ensures the parent object "directives" is available
  to child objects that will register with the Angular app.
  
  Directives allow developers to extend the DOM with their
  own XML attributes or elements;  If you ever feel the need
  to dynamically "inject" HTML into an element within a controller,
  that is a clear sign you should be using a directive.
###
define ['ang'], (angular) ->
	'use strict'

	angular.module 'directives', []