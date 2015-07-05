var vacationsApp;

vacationsApp = angular.module('vacationsApp', ['ngRoute', 'angularMoment']);

vacationsApp.config([
  '$routeProvider', function($routeProvider) {
    $routeProvider.when('/', {
      templateUrl: 'app/partials/home.html',
      controller: 'homeCtrl'
    }).otherwise('/');
  }
]);

vacationsApp.run([
  'amMoment', function(amMoment) {
    return amMoment.changeLocale('es');
  }
]);

vacationsApp.directive('showDetails', [
  function() {
    return function(scope, element) {
      var $more;
      $more = element.find('.more');
      return $more.click(function() {
        var $details;
        $details = element.find('.details');
        $details.toggle('easeInOut');
        return $more.find('i').toggleClass('fa-chevron-down').toggleClass('fa-chevron-up');
      });
    };
  }
]);

vacationsApp.factory('VacationsRequest', [
  '$http', function($http) {
    var services;
    services = {
      getAll: function() {
        return $http.get('/app/data/inbox.json');
      },
      getRequestById: function(requestId) {
        return $http.get('/app/data/' + requestId + '.json');
      }
    };
    return services;
  }
]);

vacationsApp.controller('homeCtrl', [
  '$scope', 'VacationsRequest', '$filter', function($scope, VacationsRequest, $filter) {
    $scope.requests = [];
    $scope.filterCriteria = {
      approved: ""
    };
    VacationsRequest.getAll().success(function(data) {
      console.log(data);
      $scope.requests = data;
    }).error(function(error) {
      console.log(error);
    });
    $scope.changeState = function(requestId, state) {
      var request;
      request = $filter('filter')($scope.requests, {
        activityId: requestId
      });
      request = request[0];
      request.approved = request.approved !== state ? state : "pending";
    };
    $scope.changeFilter = function(criteria) {
      $scope.filterCriteria.approved = criteria;
    };
  }
]);
