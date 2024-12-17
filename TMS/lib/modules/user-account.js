function GetMyProfileInfo() {
    var dt_url = "/api/Account/UserInfo";
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            console.log(data);
            if (data.IsSuccess) {
                $('#lblCreatedDate').html(GetTextBoxFormatDateOnly(data.Result.CreatedDate, true));
                $('#lblUpdatedDate').html(GetTextBoxFormatDateOnly(data.Result.UpdatedDate, true));
                $('#FullName').val(data.Result.FullName);
                $('#Email').val(data.Result.Email);
                var imgUrl = "";
                if (data.Result.ImageUrl != "" && data.Result.ImageUrl != null) {
                    imgUrl = crt_APIBaseUrl + data.Result.ImageUrl;
                }
                else {
                    imgUrl = crt_APIBaseUrl + "/img/profile_small.jpg";
                }
                $('#ImageUrl').val(data.Result.ImageUrl);
            }

        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, getting user info.');
        }
    });
}
function GetMyLoginHistory() {
    var dt_url = "/api/Account/UserLoginHistory";
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            crt_dtTable.destroy();
            var rowHtml = '';
            $('.crt_List_datatable tbody').html(rowHtml);

            crt_dtTable = $('.crt_List_datatable').DataTable({
                data: data.Result,
                columns: [
                    { data: 'IpAddress' },
                    {
                        data: 'LoginDatetime',
                        render: function (data, type, row) {
                            return GetFullDateTime(data, true);
                        }
                    },
                    {
                        data: 'LogoutDateTime',
                        render: function (data, type, row) {
                            return GetFullDateTime(data, true);
                        }
                    },

                ],
                "order": []
            });

        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}