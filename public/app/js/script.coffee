'use strict'
domain = 'http://localhost:3000/'
App = angular.module 'app',[]

PAYMILL_PUBLIC_KEY = '...'

# extra - <span style="color: {{transaction.status == 'refunded' ? 'red' : 'white'}}">

controller = ($scope, $http, $timeout) ->

  # config
    $scope.cards = {}
    $scope.invoices = {}
    $scope.payments = {}

    $scope.cards.list = []
    $scope.invoices.list = []
    $scope.payments.list = []

  # permissions

    $scope.permissions = 
      loggedIn: () ->
        $scope.token?
      cards: () ->
        #url
        $scope.permissions.loggedIn() && !$scope.page || $scope.page == 'cards'
      invoices: () ->
        #url
        $scope.permissions.loggedIn() && $scope.page == 'invoices'
      payments: () ->
        $scope.permissions.loggedIn() && window.location.hash == '#payments'
      delete: () ->
        $scope.permissions.loggedIn() && window.location.hash == '#delete'
      add: () ->
        $scope.permissions.loggedIn() && window.location.hash == '#add'

    $scope.set_page = (page) ->
      console.log page
      $scope.page = page


  # auth

    $scope.login = () ->
      $http.post("#{domain}users/sign_in.json?email=#{$scope.forms.login.email}&password=#{$scope.forms.login.password}").success((data) ->
        $scope.error = false
        $scope.token = data.token
        $scope.me = data.me
      ).error(->
        $scope.error = true
      )

    $scope.logout = () ->
      $scope.token = null

    $scope.register = () ->
      $http.post("#{domain}users?email=#{scope.forms.register.email}&password=#{$scope.forms.register.password}").success((data) ->
        $scope.error = false
        $scope.token = data.token
        $scope.me = data.me
      ).error(->
        $scope.error = true
      )



  # add/delete

    $scope.cards.destroy = () ->
      $http.get("#{domain}cards/destroy/#{$scope.cards.show.id}?token=#{$scope.token}").success(->
        $scope.error = false
        $scope.success = 'Deleted.'
      ).error(->
        $scope.error = true
      )

    $scope.cards.create = () ->
      ### so need to do all these in javascript
          $('.submit-button').attr("disabled", "disabled");

          if (false == paymill.validateCardNumber($('.card-number').val())) {
              $(".payment-errors").text("Ungueltige Kartennummer");
              $(".submit-button").removeAttr("disabled");
              return false;
          }

          if (false == paymill.validateExpiry($('.card-expiry-month').val(), $('.card-expiry-year').val())) {
              $(".payment-errors").text("Ungueltiges Gueltigkeitsdatum");
              $(".submit-button").removeAttr("disabled");
              return false;
          }

          paymill.createToken({
              number:$('.card-number').val(),
              exp_month:$('.card-expiry-month').val(),
              exp_year:$('.card-expiry-year').val(),
              cvc:$('.card-cvc').val(),
              cardholdername:$('.card-holdername').val(),
              amount:10000,
              currency:'EUR'
          }, PaymillResponseHandler);

          return false;
      });
      ###


      $scope.cards.update false



  # updates

    $scope.cards.update = (recurring = true) ->
      if $scope.token
        $http.get("#{domain}cards?token=#{$scope.token}").success((data) ->
          $scope.error = false
          $scope.cards.list = data.cards  
        ).error(->
          $scope.error = true
        )
      if recurring
        $timeout($scope.cards.update, 1000)


    $scope.invoices.update = (recurring = true) ->
      if $scope.token
        $http.get("#{domain}invoices?token=#{$scope.token}").success((data) ->
          $scope.error = false
          $scope.invoices.list = data.invoices
        ).error(->
          $scope.error = true
        )
      if recurring
        $timeout($scope.invoices.update, 1000)

    $scope.payments.update = (recurring = true) ->
      if $scope.token
        $http.get("#{domain}payments?token=#{$scope.token}").success((data) ->
          $scope.error = false
          $scope.payments.list = data.payments
        ).error(->
          $scope.error = true
        )
      if recurring
        $timeout($scope.payments.update, 1000)

    $scope.cards.update()
    $scope.invoices.update()
    $scope.payments.update()
