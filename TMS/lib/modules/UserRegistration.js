var edit_BlockId = '';
var edit_VillageId = '';
var edit_SpecialityTypeId = '';
var edit_HospitalOwnershipTypeId = '';
var edit_DistrictId = '';
var edit_HospitalTypeId = '';
var edit_PhoneNumber = '';

function GetDistrictActiveList() {
    var dt_url = "/api/MasterDistrict/GetList?IsActive=True";
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
            $('#DistrictId').html(rowHtml);
           
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}
function GetRolesActiveList() {
    var dt_url = "/api/MasterDistrict/GetRoles?IsActive=True";
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            var rowHtml = '<option value="">--Select--</option>';
            $(data).each(function (i, v) {

                rowHtml += '<option value="' + v.Name + '">' + v.Name + '</option>';
            });
            $('#RoleId').html(rowHtml);

        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}

function GetEmpanelmentActiveList() {
    var dt_url = "/api/MasterEmpanelmentType/GetList?IsActive=True";
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
            $('#EmpanelmentTypeId').html(rowHtml);
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}
function GetOwnershipActiveList() {

    var dt_url = "/api/MasterHospitalOwnershipType/GetList?IsActive=True";
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
            $('#HospitalOwnershipTypeId').html(rowHtml);
            if (edit_HospitalOwnershipTypeId != '') {
                $('#HospitalOwnershipTypeId').val(edit_HospitalOwnershipTypeId);
            }
            edit_HospitalOwnershipTypeId = '';
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }


    });

   
} 
function GetSpecialityActiveList() {

    var dt_url = "/api/MasterHospitalSpecialityType/GetList?IsActive=True";
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
            $('#SpecialityTypeId').html(rowHtml);
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}
function EditSpecialityActiveList() {

    var dt_url = "/api/MasterHospitalSpecialityType/GetList?IsActive=True";
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
            $('#SpecialityTypeId').html(rowHtml);
            if (edit_SpecialityTypeId != '') {
            
                $('#SpecialityTypeId').val(edit_SpecialityTypeId);
            }
            edit_SpecialityTypeId = '';
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
    
}

function GetHospitalTypeActiveList() {
    var dt_url = "/api/MasterHospitalType/GetList?IsActive=True";
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
            $('#HospitalTypeId').html(rowHtml);

        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}
function EditHospitalTypeActiveList() {

    var dt_url = "/api/MasterHospitalType/GetList?IsActive=True";
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
            $('#HospitalTypeId').html(rowHtml);
            if (edit_HospitalTypeId != '') {
            
                $('#HospitalTypeId').val(edit_HospitalTypeId);
            }
            edit_HospitalTypeId = '';
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
    
}

$('#HospitalTypeId').change(function () {

    var hospitalTypeId = $(this).val();
  
    var hospitalSubTypeDropDown = $('#HospitalSubTypeId');
    hospitalSubTypeDropDown.empty();
    hospitalSubTypeDropDown.append($('<option></option>').attr('value', '').text('--Select--'));
    if (hospitalTypeId) {
        var dt_url = "/api/MasterHospitalSubType/GetActiveSubType?IsActive=True&TypeId=" + hospitalTypeId + " ";
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
                $('#HospitalSubTypeId').html(rowHtml);
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
        $('#HospitalPan').val('');
    }
    else {
        $('#dvninrohiniid').css('display', 'block');
        $('#lblNinOrRhohiniId').html('Do you have a ROHINI ID ? ');
        $('#dvhospitalsubtype').css('display', 'none');
        var hospitalSubTypeDropDown = $('#HospitalSubTypeId');
        hospitalSubTypeDropDown.empty();
        hospitalSubTypeDropDown.append($('<option></option>').attr('value', '').text('--Select--'));
        $('#hospitalpan').css('display', 'block');

    }
});

$('#DistrictId').change(function () {

    var districtId = $(this).val();
    var DropDown = $('#BlockId');
    DropDown.empty();
    DropDown.append($('<option></option>').attr('value', '').text('--Select--'));
    var BlockDropDown = $('#VillageId');
    BlockDropDown.empty();
    BlockDropDown.append($('<option></option>').attr('value', '').text('--Select--'));

    if (districtId) {
        var dt_url = "/api/MasterBlock/GetDistrictBlock?IsActive=True&DistrictId=" + districtId + "";
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
                $('#BlockId').html(rowHtml);
                if (edit_BlockId != '') {
                    $('#BlockId').val(edit_BlockId);
                }
                edit_BlockId = '';
            },
            error: function (xhr) {
                WarningNotificationWithMessage('Error, loading in list.');
            }
        });
    }
});

$('#BlockId').change(function () {
    var blockId = $(this).val();
    var DropDown = $('#VillageId');
    DropDown.empty();
    DropDown.append($('<option></option>').attr('value', '').text('--Select--'));
    if (blockId) {
        var dt_url = "/api/MasterVillage/GetBlockVillage?IsActive=True&BlockId=" + blockId + " ";
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
                $('#VillageId').html(rowHtml);
                if (edit_VillageId != '') {
                
                    $('#VillageId').val(edit_VillageId);
                }
                edit_VillageId = '';
            },
            error: function (xhr) {
                WarningNotificationWithMessage('Error, loading in list.');
            }
        });
    }
});
function GetHospitalBasicInfo() {

    var dt_url = "/api/Hospital/GetBasicInfo";
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
            
                $('#lblHospitalName').text(data.Result.HospitalName);
                $('#lblHospitalParentType').text(data.Result.HospitalParentType);
                $('#lblHospitalTypeId').text(data.Result.HospitalType);
                $('#lblEmpanelmentType').text(data.Result.EmpanelmentType);
                $('#lblStatusId').text(data.Result.StatusId);
                if (data.Result.NinOrRhohiniId == true) {
                    $('#lblNinOrRhohiniId').text('Yes');
                }
                else {

                    $('#lblNinOrRhohiniId').text('No');
                }
                $('#lblHospitalPan').text(data.Result.HospitalPan);

                $('#Address').val(data.Result.Address);
                $('#City').val(data.Result.City);
                $('#PinCode').val(data.Result.PinCode);
                $('#Longitude').val(data.Result.Longitude);
                $('#Latitude').val(data.Result.Latitude);
                $('#EstablishmentYear').val(data.Result.EstablishmentYear);
                $('#PanHolderName').val(data.Result.PanHolderName);
                $('#AuthorityRegisteredWith').val(data.Result.AuthorityRegisteredWith);
                $('#LegalEntityName').val(data.Result.LegalEntityName);
                $('#LegalEntityRegistrationNumber').val(data.Result.LegalEntityRegistrationNumber);
                $('#LegalEntityRegistrationDate').val(data.Result.LegalEntityRegistrationDate);
                $('#OrganisationHeadName').val(data.Result.OrganisationHeadName);
                $('#IdProofType').val(data.Result.IdProofType);
                $('#OrganisationHeadIDProofNumber').val(data.Result.OrganisationHeadIDProofNumber);
                $('#OrganisationHeadFaxNumber').val(data.Result.OrganisationHeadFaxNumber);
                $('#OrganisationHeadEmailId').val(data.Result.OrganisationHeadEmailId);
                $('#OrganisationHeadContactNumber').val(data.Result.OrganisationHeadContactNumber);
                $('#LandLineNumber').val(data.Result.LandLineNumber);
                $('#NameofAccreditationBoard').val(data.Result.NameofAccreditationBoard);
                $('#ValidUpTo').val(data.Result.ValidUpTo);
                $('#AccreditationLevel').val(data.Result.AccreditationLevel);
                $('#NameofOthersAccreditationBoard').val(data.Result.NameofOthersAccreditationBoard);
                $('#AccreditationIdentificationNumber').val(data.Result.AccreditationIdentificationNumber);
                $('#DelistedFromGovHealthSchemes').val(data.Result.DelistedFromGovHealthSchemes);
                $('#ReasonforDeEmpanelment').val(data.Result.ReasonforDeEmpanelment);
                $('#EmpanelledwithotherGovernmentSchemes').val(data.Result.EmpanelledwithotherGovernmentSchemes);
                $('#RSBYRegistrationNumber').val(data.Result.RSBYRegistrationNumber);
                edit_BlockId = data.Result.BlockId;
                edit_VillageId = data.Result.VillageId;
                edit_SpecialityTypeId = data.Result.SpecialityTypeId;
                edit_HospitalOwnershipTypeId = data.Result.HospitalOwnershipTypeId;
                edit_DistrictId = data.Result.DistrictId;
                edit_HospitalTypeId = data.Result.HospitalTypeId;
                $('#DistrictId').val(data.Result.DistrictId).trigger('change');
                $('#BlockId').val(data.Result.BlockId).trigger('change');
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}


