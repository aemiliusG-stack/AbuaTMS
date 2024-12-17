$(function () {
    function disableBack() {
        window.history.forward()
    }
    window.onload = disableBack();
    window.onpageshow = function (e) {
        if (e.persisted)
            disableBack();
    }
   // Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
    //Response.Cache.SetNoStore();
});
$('form.crt_loginform').on('submit', function (e) {
    e.preventDefault();
    var dt_url = $(this).attr('data-ajax-url');
    var dt_begin = $(this).attr('data-ajax-begin');
    var dt_success = $(this).attr('data-ajax-success');
    var dt_complete = $(this).attr('data-ajax-complete');
    var dt_failure = $(this).attr('data-ajax-failure');
    var data = $(this).serialize();
    if ($(this).valid()) {
        $.ajax({
            url: dt_url,
            type: 'POST',
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: data,
            beforeSend: function () {
                $('#login_error').html('');
                if (dt_begin != '' && dt_begin != null && typeof window[dt_begin] === 'function') {
                    formok = window[dt_begin]();
                    //e.preventDefault();
                }
            },
            success: function (response) {
                var responsedata = JSON.parse(response);
                if (dt_success != '' && dt_success != null && typeof window[dt_success] === 'function') {
                    formok = window[dt_success](responsedata);
                    //e.preventDefault();
                }
            },
            error: function (xhr) {
                if (dt_failure != '' && dt_failure != null && typeof window[dt_failure] === 'function') {
                    formok = window[dt_failure](xhr);
                    //e.preventDefault();
                }
            },
            complete: function () {
                if (dt_complete != '' && dt_complete != null && typeof window[dt_complete] === 'function') {
                    formok = window[dt_complete]();
                    //e.preventDefault();
                }
            }
        });
    }
});

function ForceLoginSubmit() {
    $('#ForceLogin').val('true');
    $('#loginbutton').click();
}
function onAjaxRequestLoginSuccess(result) {
    $('#dnt_CaptchaRefreshButton').click();
    if (result.IsSuccess == true) {
        if ($('form.crt_loginform').length > 0) {
            $('form.crt_loginform').get(0).reset();
        }
        window.location = "/AdminHome/Index";//result.returnUrl;
    }
    else {
        if (result.Message == "Force Login") {
            swal.close();
            $('#login_error').html('You have already logged into the application!');
            $('#loginbutton').addClass('hide-elm');
            $('#forceloginpanel').css('display', 'inline');
        }
        else {
            $('#login_error').html('');
            WarningNotificationWithMessage(result.Message);
        }
    }
}
function onAjaxRequestSuccessWithMessage(result) {
    $('#dnt_CaptchaRefreshButton').click();
    if (result.IsSuccess == true) {
        if ($('form.crt_loginform').length > 0) {
            $('form.crt_loginform').get(0).reset();
        }
        SuccessNotificationWithMessage(result.Message);
    }
    else {
        $('#login_error').html('');
        WarningNotificationWithMessage(result.Message);
    }
}