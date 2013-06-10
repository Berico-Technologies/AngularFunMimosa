###
  Ensures the parent object "controllers" is available
  to child objects that will register with the Angular app.
  
  Controllers in Angular bind models (objects) and 
  actions (functions) to views (templates/html). 
###
define (require) ->
  'use strict'

  angular = require('ang')

  angular.module 'controllers', []