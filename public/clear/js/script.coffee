'use strict'
domain = 'http://192.241.138.60/'
App = angular.module 'iframe',[]

PAYMILL_PUBLIC_KEY = '958049063517bbb61ed07adf6a91a19f'


controller = ($scope, $http, $timeout) ->

  $scope.cards = {}
  $scope.transactions = {}
  $scope.stores = {}

  $scope.pay = {}
  $scope.tmp = {}

  $scope.cards.list = []
  $scope.transactions.list = []

  $scope.forms = {}
  $scope.forms.login = {}

  $scope.permissions =
    loggedIn: () ->
      $scope.token? && $scope.stores.show? && !$scope.just_registered?
    cards: () ->
      $scope.permissions.loggedIn() && !$scope.paid?
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
    paid: () ->
      $scope.permissions.loggedIn() && $scope.cards.show? && $scope.paid?



  $scope.set_page = (page) ->
    $scope.page = page

  $scope.login = () ->
    url = "#{domain}users/login?email=#{$scope.forms.login.email}&password=#{$scope.forms.login.password}&callback=JSON_CALLBACK"
    $http.jsonp(url).success (data) ->
      if !data.error
        $scope.error = false
        $scope.token = data.token
        $scope.me = data.me
        url = "#{domain}cards?token=#{$scope.token}&callback=JSON_CALLBACK"
        $http.jsonp(url).success((data) ->
          $scope.error = false
          $scope.cards.list = data.cards
        ).error(->
          $scope.error = true
        )
      else
        $scope.error = true
    .error ->
      $scope.error = true

  $scope.logout = () ->
    $scope.token = null

  $scope.register = () ->
    url = "#{domain}users/create?email=#{$scope.forms.login.email}&password=#{$scope.forms.login.password}&callback=JSON_CALLBACK"
    $http.jsonp(url).success (data) ->
      if !data.error
        $scope.error = false
        $scope.just_registered = true
        $scope.token = data.token
        obj = {
          stripe_token: '',
          last_four: '',
          type: '',
          expires: ''
        }
        url = "#{domain}cards/create?token=#{$scope.token}"
      else
        $scope.error = true
    .error ->
      $scope.error = true
    # gets email, password, creates user.
    # gets tmp.card details and creates card
    # sets $scope.cards.show as this card, not tmp.card, but what comes back from api
    # calls $scope.pay.authenciated()

  $scope.isSelected = (id) ->
    return false if !$scope.cards.show
    return $scope.cards.show.id == id

  $scope.cards.choose = (card) ->
    if $scope.cards.show?.id == card.id
      $scope.cards.show = null
    else
      $scope.cards.show = card

  $scope.cards.update = () ->


  $scope.cards.create = () ->
    #change
    expires = $scope.forms.card.expires.split('/')
    d = new Date('20 ' + expires[1],expires[0],'31')
    obj = 
      card:
        stripe_token: $scope.forms.card.stripe_token
        last_four: $scope.forms.card.card_number.replace(' ','').slice(-4)
        type: $scope.forms.card.card_type,
        expires: +d / 1000 #ruby timestamp

    url = "#{domain}cards/create?token=#{$scope.token}"
    $http.post(url,obj).success (data) ->
    # get details from $scope.forms.card
    # create card in api don't worry about creating a customer
    # set it as $scope.cards.show()
    
    
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
      store_id: 1,
      invoice: {
        amount: 2500,
        currency: 'EUR',
        description: 'Spotify'
      }
    }
    #figure out how to pass data into $http
    url = "#{domain}invoices/create?token=#{$scope.token}"
    console.log(url)
    $http.post(url,obj).success((data) -> 
      console.log('invoice', data)
      $scope.error = false
      obj = {
        card_id: $scope.cards.show.id,
        invoice_id: data.id
      }
      url = "#{domain}payments/create?token=#{$scope.token}"
      $http.post(url,obj).success((data) ->
        console.log('payment', data)
        # call callback function or callback url in url.
        $scope.paid = true
      ).error(->
        $scope.error = true
      )
    ).error(->
      $scope.error = true
    )



  $scope.init = () ->
    #get store_id from url
    store_id = 1
    url = "#{domain}stores/#{store_id}?callback=JSON_CALLBACK"
    $http.jsonp(url).success((data) -> # note - no auth
      console.log(data)
      $scope.error = false
      $scope.stores.show = data
    ).error(()->
      $scope.error = true
    )

  $scope.init()