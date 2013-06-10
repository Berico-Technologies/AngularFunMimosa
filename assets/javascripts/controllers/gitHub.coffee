###global define###

define ['c/controllers', 'services/gitHub'], (controllers) ->
	'use strict'

	controllers.controller 'gitHub', ['$scope', '$rootScope', '$location', 'gitHub', 'exampleRepo', ($scope, $rootScope, $location, service, exampleRepo) ->
		$scope.searchTerm = ''
		$scope.repos = service.repos
    
		exampleRepo.update({ id: "2", desc: "BlahBlah" }).success ->
			$scope.exs = exampleRepo.list().success (result) ->
			  $scope.exs = result

		$scope.search = (searchTerm) ->
			$location.path "/github/#{searchTerm}"

		$scope.onRouteChange = (routeParams) ->
			$scope.searchTerm = routeParams.searchTerm

			service.get $scope.searchTerm
	]