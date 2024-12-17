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
                rowHtml += '<td>' + v.Code + '</td>';
                rowHtml += '<td><label class="check"><input type="checkbox"><span class="checkmark"></span></label></td>';
                rowHtml += '<td>' + v.Title + '</td>';
                rowHtml += '<td>' + v.Code + '-' + v.Title + ' </td>';
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
SpecializationId
function GetExpertiseTypeActiveList() {
    var dt_url = "/api/MasterMedicalExpertiseType/GetList?IsActive=True";
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {

            var data = JSON.parse(response);
            var rowHtml = '<option value="">--Select--</option>';
            $(data.Result).each(function (i, v) {
                rowHtml += '<option value="' + v.Id + '">' + v.Title + '</option>';
            });
            $('#ExpertiseTypeId').html(rowHtml);

        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}

function GetSpecialsationActiveList() {
    var dt_url = "/api/MasterHospitalSpecialityOfferType/GetList?IsActive=True";
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            var rowHtml = '<option value="">--Select--</option>';
            $(data.Result).each(function (i, v) {
                rowHtml += '<option value="' + v.Id + '">' + v.Title + '</option>';
            });
            $('#SpecializationId').html(rowHtml);
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}

$('#ExpertiseTypeId').change(function () {

    var typeId = $(this).val();

    var hospitalSubTypeDropDown = $('#ExpertiseSubTypeId');
    hospitalSubTypeDropDown.empty();
    hospitalSubTypeDropDown.append($('<option></option>').attr('value', '').text('--Select--'));
    if (typeId) {
        var dt_url = "/api/MasterMedicalExpertiseSubType/GetExpertiseSubTypeList?TypeId=" + typeId + "&IsActive=True";
        $.ajax({
            url: globalGetUrl,
            type: "POST",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: { APIUrl: dt_url },
            success: function (response) {
                var data = JSON.parse(response);
                var rowHtml = '<option value="">--Select--</option>';
                $(data.Result).each(function (i, v) {
                    rowHtml += '<option value="' + v.Id + '">' + v.Title + '</option>';
                });
                $('#ExpertiseSubTypeId').html(rowHtml);
            },
            error: function (xhr) {
                WarningNotificationWithMessage('Error, loading in list.');
            }
        });
    }

    //working on show hide of elements
    var hospitalTypeTex = $("#HospitalTypeId option:selected").text();
    if (hospitalTypeId == '') {
        $('#dvninrohiniid').css('display', 'none');
        $('#dvhospitalsubtype').css('display', 'none');
        $('#hospitalpan').css('display', 'none');
    }
    else if (hospitalTypeTex == 'Public') {
        $('#dvninrohiniid').css('display', 'block');
        $('#dvhospitalsubtype').css('display', 'block');
        $('#lblNinOrRhohiniId').html('Do you have a NIN ID ?');
        $('#hospitalpan').css('display', 'none');
    }
    else {
        $('#dvninrohiniid').css('display', 'block');
        $('#lblNinOrRhohiniId').html('Do you have a ROHINI ID ? ');
        $('#dvhospitalsubtype').css('display', 'none');
        $('#hospitalpan').css('display', 'block');

    }
});

$('#ExpertiseSubTypeId').change(function () {

    var typeId = $(this).val();

    var hospitalSubTypeDropDown = $('#QualificationId');
    hospitalSubTypeDropDown.empty();
    hospitalSubTypeDropDown.append($('<option></option>').attr('value', '').text('--Select--'));
    if (typeId) {
        var dt_url = "/api/MasterQualification/GetQualificationByExpertiseSubTypeList?ExpertiseSubTypeId=" + typeId + "&IsActive=True";
        $.ajax({
            url: globalGetUrl,
            type: "POST",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: { APIUrl: dt_url },
            success: function (response) {

                var data = JSON.parse(response);
                var rowHtml = '<option value="">--Select--</option>';
                $(data.Result).each(function (i, v) {
                    rowHtml += '<option value="' + v.Id + '">' + v.Title + '</option>';
                });
                $('#QualificationId').html(rowHtml);
            },
            error: function (xhr) {
                WarningNotificationWithMessage('Error, loading in list.');
            }
        });
    }

});

function GetManPowersList() {
    var dt_url = "/api/Hospital/GetManPowersActiveList?IsActive=True";
    var rowHtml = '';

    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            console.log(data);
            $(data.Result.expertiseList).each(function (i, v) {

                rowHtml += '<div class="col-lg-12">';
                rowHtml += '<div class="ibox">';
                rowHtml += '<div class="ibox-title">';
                rowHtml += ' <h5>' + v.Title + '</h5>';
                rowHtml += '<div class="ibox-tools">';
                rowHtml += '<a class="collapse-link">';
                rowHtml += '<i class="fa fa-chevron-up"></i>';
                rowHtml += '</a></div></div>';
                //header starts here
                rowHtml += '<div class="ibox-content p-0"><div class="row"><div class="col-md-12"><div class="table-responsive">';
                rowHtml += '<table class="table table-striped specialities">';
                rowHtml += '<thead>';
                rowHtml += '<tr>';
                rowHtml += '<th>Name</th><th>Mobile Number</th><th>EmailId</th><th>Qualification</th><th>University</th><th>RegistrationNumber</th>';
                rowHtml += '</tr>';
                rowHtml += '</thead>';
                rowHtml += '<tbody id="tblbody' + v.Id + '">';
                $(data.Result.manPowerList).each(function (i, sv) {
                    //sub cat binding
                    if (v.QualificationId == sv.QualificationId) {
                        rowHtml += '<tr>';
                        rowHtml += '<td>' + sv.Name + '</td>';
                        rowHtml += '<td>' + sv.MobileNumber + '</td>';
                        rowHtml += '<td>' + sv.EmailId + '</td>';
                        rowHtml += '<td>' + sv.Qualification + '</td>';
                        rowHtml += '<td>' + sv.University + '</td>';
                        rowHtml += '<td>' + sv.RegistrationNumber + '</td>';
                        rowHtml += '</tr>';
                        //end
                    }

                });
               
                rowHtml += '</tbody>';
                rowHtml += '</table>';
                rowHtml += '</div>';
                rowHtml += '</div>';
                rowHtml += '</div>';
                rowHtml += '</div>';
                rowHtml += '</div>';
                rowHtml += '</div>';
            });
            $('#divviewmanpowerslist').empty().append(rowHtml);
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
