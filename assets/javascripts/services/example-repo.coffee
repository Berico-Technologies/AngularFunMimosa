
class ExampleRepo
  
  constructor: (@$http) ->
    console.log "ExampleRepo instantiated"
    
  get: (id) =>
    @$http.get("/examples/#{id}")
  
  add: (example) =>
    url = if example.id? then "/examples/#{example.id}" else "/examples"
    @$http.put url, example
    
  update: (example) =>
    @$http.post "/examples/#{example.id}", example
    
  remove: (id) =>
    @$http.delete "/examples/#{id}"
    
  list: =>
    @$http.get("./examples")


define ['ang', 'services/services'], (angular, services) ->
	'use strict'
	
	services.service "exampleRepo", [ "$http", ($http) -> new ExampleRepo($http) ]