vacationsApp.factory 'VacationsRequest', ['$http', ($http)->
  services =
    getAll: ->
      return $http.get('app/data/inbox.json')
      
  return services
]