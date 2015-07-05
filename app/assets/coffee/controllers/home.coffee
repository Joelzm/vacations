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