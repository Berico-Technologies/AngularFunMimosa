###
  Entry-point for the application: think "static void main(args...)".
###

# RequireJS Configuration.
requirejs.config
  urlArgs: "bust=" +  (new Date()).getTime()
  map:
    '*':
      'vendor/angularResource': 'vendor/angular-resource'
  # Aliases for files or folders
  paths:
    c:"controllers"
    d:"directives"
    s:"services"
    l18n:"vendor/l18n"
    jquery:"vendor/jquery"
    ang:"vendor/angular"
  # Scripts that are not RequireJS compliant are "shimmed"
  # (literally wrapped and forced to be RequireJS compliant).
  shim:
    'ang':
      deps: ['vendor/modernizr']
      exports: 'angular'
    'vendor/angular-resource': ['ang']
    'vendor/modernizr':
      exports: 'Modernizr'

# Initialize the application.
# First param (array) are the dependencies we want imported.
# These dependencies are injected into the second parameter (function)
# in order.  Remember, JavaScript does not require the function to 'collect'
# all of the parameters!  So, we are placing the imports we don't need 
# a reference to last.
requirejs ['app'
    'jquery'
    'bootstrap'
    'c/gitHub'
    'c/people'
    'c/personDetails'
    'c/searchHistory'
    'c/twitter'
    'd/ngController'
    'd/tab'
    'd/tabs'
    'filters/twitterfy'
    's/example-repo'
    'ang'
    'responseInterceptors/dispatcher'
], (app, $) ->
    
    # Register a set of routes with Angular's route
    # provider.  These will be routes will be 
    # relative to the current page and will serve
    # as major transitions between views.
    rp = ($routeProvider) ->
      $routeProvider
        .when '/github/:searchTerm',
          controller: 'gitHub'
          reloadOnSearch: true
          resolve:
            changeTab: ($rootScope) ->
              $rootScope.$broadcast 'changeTab#gitHub'
        .when '/people/details/:id',
          controller: 'personDetails'
          reloadOnSearch: true
          resolve:
            changeTab: ($rootScope) ->
              $rootScope.$broadcast 'changeTab#people'
        .when '/twitter/:searchTerm',
          controller: 'twitter'
          reloadOnSearch: true
          resolve:
            changeTab: ($rootScope) ->
              $rootScope.$broadcast 'changeTab#twitter'
        .otherwise
          redirectTo: '/github/dbashford'
    
    # This is where we actually register the init function
    # for routes.
    app.config ['$routeProvider', rp]
    app.run ['exampleRepo', (er) -> window.er = er ]
    # Here we are binding handlers to "global" events that
    # we will fire using Angular's PubSub mechanism.
    app.run ['$rootScope', '$log', ($rootScope, $log) ->
      $rootScope.$on 'error:unauthorized', (event, response) ->
        #$log.error 'unauthorized'

      $rootScope.$on 'error:forbidden', (event, response) ->
        #$log.error 'forbidden'

      $rootScope.$on 'error:403', (event, response) ->
        #$log.error '403'

      $rootScope.$on 'success:ok', (event, response) ->
        #$log.info 'success'

      # fire an event related to the current route
      $rootScope.$on '$routeChangeSuccess', (event, currentRoute, priorRoute) ->
        $rootScope.$broadcast "#{currentRoute.controller}$routeChangeSuccess", currentRoute, priorRoute
    ]