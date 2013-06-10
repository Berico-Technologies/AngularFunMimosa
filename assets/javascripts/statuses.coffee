###
  A set of possible statuses from AJAX calls using the Angular
  resource provider.  This is more of a configuration file to the
  resource interceptor than anything else.
###
define ->
	'use strict'

	200: 'ok'
	401: 'unauthorized'
	403: 'forbidden'
	404: 'foo'