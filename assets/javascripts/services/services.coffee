###
  Ensures the parent object "services" is available
  to child objects that will register with the Angular app.
  
  Angular services are simply JavaScript objects or functions
  you want "injected" into an Angular component (like a controller).
  
  Services are used to encapsulate business logic.  They encapsulate
  functionality, whose particulars should be unknown to the components
  they are injected into.  Services also promote reuse.
  
  A good Angular project will abstract REST calls to the server in the
  form of a service (think repository pattern).  It's also wise to 
  encapsulate groups of common pubsub functions as services as a notional
  "channel".
###
define ['ang'], (angular) ->
	'use strict'

	angular.module 'services', []