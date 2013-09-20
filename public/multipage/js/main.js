var PAYMILL_PUBLIC_KEY = '958049063517bbb61ed07adf6a91a19f';
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
          if (paymill.validateCardNumber(str)) {
            $(this).addClass('valid')
          }
          else {
            $(this).addClass('error')
          }
        } 
      }
      else {
        if (str.length % 4 == 0 && str.length != 0 && str.length < 16) {
          $(this).val($(this).val().slice(0,-2))
        }
      }
    })

    $('input#card_number').blur(function () {
      str = $(this).val().replace(/ /g, '')
      if (paymill.validateCardNumber(str)) {
        $(this).addClass('valid')
      }
      else {
        $(this).addClass('error')
      }
    })

    $('#card_button').click(function () {
      $('#login_section').animate( { height:$('#card_section').height() }, { queue:false, duration:250 })
      $('#login_section').animate( { width:$('#card_section').width() }, { queue:false, duration:250 })
      //$('#login_section').height($('#card_section').height())
      //$('#login_section').width($('#card_section').width())
      $('#login_section').fadeOut('slow', function () {
        $('#card_section').fadeIn('slow')
      })
    })

    $('body').on('keyup','input#card_number.error, input#card_number.valid', function (e) {
      console.log('keyup')
      if (e.which == 8)
        $(this).removeClass('error').removeClass('valid')
    })

    $('input#expires').keyup(function (e) {
      if (e.which == 191)
        e.preventDefault()
      if ($(this).val().length == 2 && e.which != 8)
        $(this).val($(this).val() + '/')
      if ($(this).val().length == 3 || $(this).val().length == 4 || $(this).val().length == 6 ) {
        var arr = $(this).val().split('/')
        if (paymill.validateExpiry(arr[0],'20'+arr[1])) {
          $(this).addClass('valid')
        }
        else {
          $(this).addClass('error')
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
      if (paymill.validateExpiry(arr[0],'20'+arr[1])) {
        $(this).addClass('valid')
      }
      else {
        $(this).addClass('error')
      }
    })

    $('input#cvv').keyup(function (e) {
      str = $('input#card_number').val().replace(/ /g, '')
      if ($(this).val().length == 2 || $(this).val().length == 3) {
        if (paymill.validateCvc($(this).val(),str)) {
          $(this).addClass('valid')
        }
        else {
          $(this).addClass('error')
        }
      }
    })

    $('.signup h3').click(function () {
      $('#card_section').fadeOut('slow', function () {
        $('#login_section').fadeIn('slow')
      })
    })
});


// paymill



