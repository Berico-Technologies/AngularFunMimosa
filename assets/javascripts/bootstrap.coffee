###
  A way to "bootstrap" Angular when the document is 
  loaded: 
  
  <body onload="init()" /> 
  
  or 
  
  $(function(){ init(); }).
  
  This is an alternative to Angular's automatic initialization:
  
  <html ng-app="app" />
###
define ['require', 'ang', 'app'], (require, angular) ->
	'use strict'
	require ['vendor/domReady!'], (document) ->
		angular.bootstrap document, ['app']


