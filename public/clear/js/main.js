Stripe.setPublishableKey('pk_test_EoabQpqYyWvwkwhzWo3v5W9q')
$(function() {
    //caches a jQuery object containing the header element
    var animate = $("#progress");
    $(window).scroll(function() {
        var scroll = $(window).scrollTop();

        if (scroll >= 825) {
            animate.removeClass('display-none').addClass("display");
        } 
    });

    $('input#expires').on('focus', function () {
      $(this).attr('placeholder','MM/YY')
    })

    $('input#expires').blur(function () {
      $(this).attr('placeholder','Expires')
    })

    $('input#cvv').focus(function () {
      $(this).attr('placeholder','123')
    })

    $('input#cvv').blur(function () {
      $(this).attr('placeholder','CVV')
    })

    $('input#name').focus(function () {
      arr = ["Rachel Roberts","Darcy Brand","Lindsey Emmett","Jared Granville","Mario Prather","James Alford","Jay Lewis"]
      $(this).attr('placeholder','Something like, say, ' + arr[Math.floor(Math.random()*arr.length)] + '?')
    })

    $('input#name').blur(function () {
      $(this).attr('placeholder','Cardholder\'s Name')
    })

    $('input#card_number').keyup(function (e) {
      str = $(this).val().replace(/ /g, '')
      if (e.which != 8) {
        if (str.length % 4 == 0 && str.length != 0 && str.length < 16) {
          $(this).val($(this).val() + '  ')
        }
        if (str.length == 16) {
          //check is valid
          if (Stripe.card.validateCardNumber(str)) {
            $(this).addClass('valid').removeClass('error')
          }
          else {
            $(this).addClass('error').removeClass('valid')
            $('#card_pay').attr('disabled','disabled')
          }
        } 
      }
      else {
        if (str.length % 4 == 0 && str.length != 0 && str.length < 16) {
          $(this).val($(this).val().slice(0,-2))
        }
      }
      if ($('#cvv').val().length > 0) {
        if (Stripe.card.validateCVC($('#cvv').val(),str)) {
          $('#cvv').addClass('valid').removeClass('error')
        }
        else {
          $('#cvv').addClass('error').removeClass('valid')
          $('#card_pay').attr('disabled','disabled')
        }
      }
    })

    $('input#card_number').blur(function () {
      str = $(this).val().replace(/ /g, '')
      if (Stripe.card.validateCardNumber(str)) {
        $(this).addClass('valid').removeClass('error')
      }
      else {
        $(this).addClass('error').removeClass('valid')
        $('#card_pay').attr('disabled','disabled')
      }
    })

    $('#card_button').click(function () {
      $('#login').animate( { height:$('#card').height() }, { queue:false, duration:250 })
      $('#login').animate( { width:$('#card').width() }, { queue:false, duration:250 })
      //$('#login').height($('#card').height())
      //$('#login').width($('#card').width())
      $('#login').fadeOut('slow', function () {
        $('#card').fadeIn('slow')
      })
    })

    $('body').on('keyup','input#card_number.error, input#card_number.valid, input#expires.error, input#expires.valid, input#cvv.error, input#cvv.valid', function (e) {
      if (e.which == 8 || $(this).val().length == 0) {
        $(this).removeClass('error').removeClass('valid')
        if ($('.error').length == 0)
          $('#card_pay').removeAttr('disabled')
      }
    })

    $('input#expires').keyup(function (e) {
      if ($(this).val().match('//'))
        $(this).val($(this).val().replace('//','/'))
      if (e.which == 191)
        e.preventDefault()
      if (e.which != 8 && (($(this).val().length == 2 && $(this).val()[1] != '/') || ($(this).val().length == 1 && parseInt($(this).val()) > 1)))
        $(this).val($(this).val() + '/')
      if ($(this).val().length == 3 || $(this).val().length == 4 || $(this).val().length == 6 ) {
        var arr = $(this).val().split('/')
        if (Stripe.card.validateExpiry(arr[0],'20'+arr[1])) {
          $(this).addClass('valid').removeClass('error')
        }
        else {
          $(this).addClass('error').removeClass('valid')
          $('#card_pay').attr('disabled','disabled')
        }
      }
    })

    $('input#expires').blur(function (e) {
      if ($(this).val()[0] == '0')
        $(this).val($(this).val().substr(1))
      if ($(this).val().match(/(\d|\d{2})\/\d{4}/)) {
        str = $(this).val().replace('/20','/') //hack that'll work for the next 87 years. Yolo.
        $(this).val(str)
      }
      var arr = $(this).val().split('/')
      if (Stripe.card.validateExpiry(arr[0],'20'+arr[1])) {
        $(this).addClass('valid').removeClass('error')
      }
      else {
        $(this).addClass('error').removeClass('valid')
        $('#card_pay').attr('disabled','disabled')
      }
    })

    $('input#cvv').keyup(function (e) {
      str = $('input#card_number').val().replace(/ /g, '')
      if ($(this).val().length == 3 || $(this).val().length == 4) {
        if (Stripe.card.validateCVC($(this).val(),str)) {
          $(this).addClass('valid').removeClass('error')
        }
        else {
          $(this).addClass('error').removeClass('valid')
          $('#card_pay').attr('disabled','disabled')
        }
      }
    })

    $('.signup h3').click(function () {
      $('#card').fadeOut('slow', function () {
        $('#login').fadeIn('slow')
      })
    })

});

//$('#show_join_clear').click(function () {
  //$('#card').fadeOut('slow', function () {
    //$('#join_clear').fadeIn('slow')
  //})
//})


// stripe

$('#card-form').submit(function (e) {
  e.preventDefault()
  Stripe.card.createToken({
    number:         $('#card_number').val().replace(/ /g, ''),
    exp_month:      $('#expires').val().split('/')[0],
    exp_year:       $('#expires').val().split('/')[1],
    cvc:            $('#cvv').val(),
  }, function (error, result) {
    console.log('error', error)
    console.log('result', result)
    $('#stripe_token').val(result.id)
    $('#card_type').val(Stripe.card.cardType($('#card_number').val().replace(/ /g, '')))
    $(this).submit()
    // add token to form (#stripe_token) then submit the form.
  });
})


