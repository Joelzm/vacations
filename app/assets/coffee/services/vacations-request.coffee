vacationsApp.factory 'VacationsRequest', ['$http', ($http)->
  services =
    getAll: ->
      return $http.get('/app/data/inbox.json')

    getRequestById: (requestId)->
      return $http.get('/app/data/'+requestId+'.json')

  return services
]