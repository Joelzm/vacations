vacationsApp = angular.module 'vacationsApp', ['ngRoute', 'angularMoment']

vacationsApp.config ['$routeProvider', ($routeProvider)->
  $routeProvider
    .when '/',
      templateUrl: 'app/partials/home.html'
      controller: 'homeCtrl'
    .otherwise '/'

  return
]

vacationsApp.run ['amMoment', (amMoment)->
  amMoment.changeLocale 'es'
]

vacationsApp.directive 'showDetails', [->
  return (scope, element)->
    $more = element.find '.more'

    $more.click ->
      $details = element.find '.details'
      $details.toggle 'easeInOut'
      $more.find 'i'
        .toggleClass 'fa-chevron-down'
        .toggleClass 'fa-chevron-up'
]

vacationsApp.factory 'VacationsRequest', ['$http', ($http)->
  services =
    getAll: ->
      return $http.get('/app/data/inbox.json')

    getRequestById: (requestId)->
      return $http.get('/app/data/'+requestId+'.json')

  return services
]
vacationsApp.controller 'homeCtrl', ['$scope', 'VacationsRequest', '$filter', ($scope, VacationsRequest, $filter)->
  $scope.requests = []
  $scope.filterCriteria =
    approved: ""

  VacationsRequest.getAll()
    .success (data)->
      console.log data
      $scope.requests = data
      return
    .error (error)->
      console.log(error)
      return

  $scope.changeState = (requestId, state)->
    request = $filter('filter') $scope.requests, activityId:requestId
    request = request[0]
    request.approved = if request.approved isnt state then state else "pending"
    return

  $scope.changeFilter = (criteria)->
    $scope.filterCriteria.approved = criteria
    return

  return
]