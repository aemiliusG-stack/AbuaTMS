function GetSpecialityOffered() {
    var dt_url = "/api/MasterHospitalSpecialityOfferType/GetList?IsActive=true";
    var rowHtml = '';
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            $(data.Result).each(function (i, v) {
                i += 1;
                rowHtml += '<tr>';
                rowHtml += '<td>' + i + '</td>';
                rowHtml += '<td>'+v.Code+'</td>';
                rowHtml += '<td><label class="check"><input type="checkbox"><span class="checkmark"></span></label></td>';
                rowHtml += '<td>' + v.Title + '</td>';
                rowHtml += '<td>' + v.Code + '-'+v.Title+' </td>';
                rowHtml += '<td><input type="text" class="form-control" /></td>';
                rowHtml += '<td><input type="text" class="form-control" /></td>';
                rowHtml += '</tr>';
            });
            $("#specilityoffereditem tbody").append(rowHtml); 
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}

function GetSpecialityOfferedRemoval() {
    var dt_url = "/api/MasterHospitalSpecialityOfferType/GetList?IsActive=true";
    var rowHtml = '';
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            $(data.Result).each(function (i, v) {
                i += 1;
                rowHtml += '<tr>';
                rowHtml += '<td>' + i + '</td>';
                rowHtml += '<td>' + v.Code + '</td>';
                rowHtml += '<td>' + v.Title + '</td>';
                rowHtml += '<td><label class="check"><input type="checkbox"><span class="checkmark"></span></label></td>';
                rowHtml += '<td><input type="text" class="form-control" /></td>';
                rowHtml += '</tr>';
            });
            $("#tblspecialityremoval tbody").append(rowHtml);
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}


