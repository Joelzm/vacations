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
