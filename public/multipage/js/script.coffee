'use strict'
domain = 'http://localhost:3000/'
App = angular.module 'iframe',[]

PAYMILL_PUBLIC_KEY = '...'


controller = ($scope, $http, $timeout) ->

  $scope.cards = {}
  $scope.transactions = {}
  $scope.stores = {}

  $scope.pay = {}
  $scope.tmp = {}

  $scope.cards.list = []
  $scope.transactions.list = []

  $scope.permissions =
    loggedIn: () ->
      $scope.token? && $scope.stores.show?
    cards: () ->
      $scope.permissions.loggedIn() && !$scope.permissions.pay()
    pay: () ->
      $scope.permissions.loggedIn() && $scope.cards.show?
    choice: () ->
      !$scope.permissions.loggedIn() && !$scope.page
    login: () ->
      !$scope.permissions.loggedIn() && $scope.page == 'login'
    card: () ->
      !$scope.permissions.loggedIn() && $scope.page == 'card' 
    join_clear: () ->
      !$scope.permissions.loggedIn() && $scope.tmp.card.token?


  $scope.set_page = (page) ->
    $scope.page = page

  $scope.login = () ->
    $http.post("#{domain}users/sign_in.json?email=#{$scope.forms.login.email}&password=#{$scope.forms.login.password}").success((data) ->
      $scope.error = false
      $scope.token = data.token
      $scope.me = data.me
      $http.get("#{domain}cards?token=#{$scope.token}").success((data) ->
        $scope.error = false
        $scope.cards.list = data.cards  
      ).error(->
        $scope.error = true
      )
    ).error(->
      $scope.error = true
    )

  $scope.logout = () ->
    $scope.token = null

  $scope.register = () ->
    # gets email, password, creates user.
    # gets tmp.card details and creates card
    # sets $scope.cards.show as this card, not tmp.card, but what comes back from api
    # calls $scope.pay.authenciated()

  $scope.cards.choose = (card) ->
    $scope.cards.show = card

  $scope.cards.update = () ->
    
    
  $scope.get_token_for_tmp_card = () ->
    # this is called when pay button on card form is pressed
    # store email in $scope.tmp.email
    # store last_four, expiry etc in $scope.tmp.card
    # gets token

  $scope.store_tmp_card = () ->
    # callback func from paymill
    # saves token in $scope.tmp.card.token

  $scope.pay.unauthenciated = () ->
    # 


  $scope.pay.authenciated = () ->
    obj = {
      store_id: $scope.cards.show.id
    } # add store_id, invoice['amount'], invoice['currency'], invoice['description']

    #figure out how to pass data into $http
    $http.get("#{domain}invoices/create?token=#{$scope.token}").success((data) -> # note - no auth
      $scope.error = false
      obj = {
        card_id: $scope.cards.show.id,
        invoice_id: data.id
      }
      $http.get("#{domain}payments/create?token=#{$scope.token}").success((data) ->
        # call callback function or callback url in url.
      ).error(->
        $scope.error = true
      )
    ).error(->
      $scope.error = true
    )




  $scope.init = () ->
    #get store_id from url
    store_id = 1
    $http.get("#{domain}stores/#{store_id}").success((data) -> # note - no auth
      $scope.error = false
      $scope.stores.show = data.store
    ).error(()->
      $scope.error = true
    )

  $scope.init()