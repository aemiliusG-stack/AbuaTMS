var selected_blockId = '';
///////////////////////////MasterGovernmentSchemeType Start///////////////////////////////////
function MasterGovernmentSchemeTypeList() {
    var dt_url = "/api/MasterGovernmentSchemeType/GetList?IsActive=";
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url},
        success: function (response) {
            var data = JSON.parse(response);
            crt_dtTable.destroy();
            var rowHtml = '';
            $('.crt_List_datatable tbody').html(rowHtml);

            crt_dtTable = $('.crt_List_datatable').DataTable({
                data: data.Result,
                columns: [
                    { data: 'Code' },
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterGovernmentSchemeTypeEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterGovernmentSchemeType'));
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
function FillMasterGovernmentSchemeTypeEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterGovernmentSchemeType/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Code').val(data.Result.Code);
                $('#Title').val(data.Result.Title);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });

}
function DeleteMasterGovernmentSchemeType(id) {
    confirmDelete('/api/MasterGovernmentSchemeType/DeleteById', id);
}

///////////////////////////MasterGovernmentSchemeType End///////////////////////////////////

///////////////////////////District Start///////////////////////////////////
function MasterDistrictList() {
    var dt_url = "/api/MasterDistrict/GetList?IsActive=True";
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
                    { data: 'Code' },
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterDistrictEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterDistrict'));
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
function FillMasterDistrictEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterDistrict/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Title').val(data.Result.Title);
                $('#Code').val(data.Result.Code);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });

}
function DeleteMasterDistrict(id) {
    confirmDelete('/api/MasterDistrict/DeleteById', id);
}
function GetDistrictActiveList() {
    var dt_url = "/api/MasterDistrict/GetList?IsActive=True";
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            
            var data = JSON.parse(response);
            var rowHtml = '<option value="">Select District</option>';
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

///////////////////////////District End///////////////////////////////////

///////////////////////////Block Start///////////////////////////////////
function MasterBlockList() {
    var dt_url = "/api/MasterBlock/GetList?IsActive=True";
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
                    
                    { data: 'District' },
                    { data: 'Code' },
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterBlockEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterBlock'));
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
function FillMasterBlockEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterBlock/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Title').val(data.Result.Title);
                $('#Code').val(data.Result.Code);
                $('#DistrictId').val(data.Result.DistrictId);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });

}
function DeleteMasterBlock(id) {
    confirmDelete('/api/MasterBlock/DeleteById', id);
}

///////////////////////////Block End///////////////////////////////////

///////////////////////////MasterHospitalOwnershipType Start///////////////////////////////////
function MasterHospitalOwnershipTypeList() {
    var dt_url = "/api/MasterHospitalOwnershipType/GetList?IsActive=True";
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
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterHospitalOwnershipTypeEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterHospitalOwnershipType'));
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
function FillMasterHospitalOwnershipTypeEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterHospitalOwnershipType/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Title').val(data.Result.Title);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterHospitalOwnershipType(id) {
    confirmDelete('/api/MasterHospitalOwnershipType/DeleteById', id);
}

///////////////////////////MasterHospitalOwnershipType End///////////////////////////////////

///////////////////////////MasterEmpanelmentType Start///////////////////////////////////
function MasterEmpanelmentTypeList() {
    var dt_url = "/api/MasterEmpanelmentType/GetList?IsActive=True";
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
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterEmpanelmentTypeEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterEmpanelmentType'));
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
function FillMasterEmpanelmentTypeEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterEmpanelmentType/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Title').val(data.Result.Title);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterEmpanelmentType(id) {
    confirmDelete('/api/MasterEmpanelmentType/DeleteById', id);
}

///////////////////////////MasterEmpanelmentType End///////////////////////////////////

///////////////////////////MasterHospitalSpecialityOfferType Start///////////////////////////////////

function MasterHospitalSpecialityOfferTypeList() {
    var dt_url = "/api/MasterHospitalSpecialityOfferType/GetList?IsActive=True";
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
                    { data: 'Code' },
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterHospitalSpecialityOfferTypeEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterHospitalSpecialityOfferType'));
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
function FillMasterHospitalSpecialityOfferTypeEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterHospitalSpecialityOfferType/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Title').val(data.Result.Title);
                $('#Code').val(data.Result.Code);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterHospitalSpecialityOfferType(id) {
    confirmDelete('/api/MasterHospitalSpecialityOfferType/DeleteById', id);
}

///////////////////////////MasterHospitalSpecialityOfferType End///////////////////////////////////

///////////////////////////MasterHospitalSpecialityType Start///////////////////////////////////

function MasterHospitalSpecialityTypeList() {
    var dt_url = "/api/MasterHospitalSpecialityType/GetList?IsActive=True";
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
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterHospitalSpecialityTypeEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterHospitalSpecialityType'));
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
function FillMasterHospitalSpecialityTypeEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterHospitalSpecialityType/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Title').val(data.Result.Title);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterHospitalSpecialityType(id) {
    confirmDelete('/api/MasterHospitalSpecialityType/DeleteById', id);
}


///////////////////////////MasterHospitalSpecialityOfferType End///////////////////////////////////

///////////////////////////MasterHospitalType Start///////////////////////////////////

function MasterHospitalTypeList() {
    var dt_url = "/api/MasterHospitalType/GetList?IsActive=True";
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
                    { data: 'Title' },
                    { data: 'Code' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterHospitalTypeEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterHospitalType'));
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
function FillMasterHospitalTypeEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterHospitalType/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Title').val(data.Result.Title);
                $('#Code').val(data.Result.Code);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterHospitalType(id) {
    confirmDelete('/api/MasterHospitalType/DeleteById', id);
}

///////////////////////////MasterHospitalType End///////////////////////////////////

///////////////////////////MasterHospitalSubType Start///////////////////////////////////
function GetHospitalTypeActiveList() {
    var dt_url = "/api/MasterHospitalType/GetList?IsActive=True";
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            
            var data = JSON.parse(response);
            var rowHtml = '<option value="">Select</option>';
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
function MasterHospitalSubTypeList() {
    var dt_url = "/api/MasterHospitalSubType/GetList?IsActive=True";
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
                    { data: 'HospitalType' },
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterHospitalSubTypeEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterHospitalSubType'));
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
function FillMasterHospitalSubTypeEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterHospitalSubType/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Title').val(data.Result.Title);
                $('#HospitalTypeId').val(data.Result.MasterHospitaltTpeId);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterHospitalSubType(id) {
    confirmDelete('/api/MasterHospitalSubType/DeleteById', id);
}


///////////////////////////MasterHospitalSubType End///////////////////////////////////


///////////////////////////MasterInfrastructureCategory Start///////////////////////////////////

function MasterInfrastructureCategoryList() {
    var dt_url = "/api/MasterInfrastructureCategory/GetList?IsActive=True";
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
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterInfrastructureCategoryEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterInfrastructureCategory'));
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
function FillMasterInfrastructureCategoryEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterInfrastructureCategory/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Title').val(data.Result.Title);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterInfrastructureCategory(id) {
    confirmDelete('/api/MasterInfrastructureCategory/DeleteById', id);
}

///////////////////////////MasterInfrastructureCategory End///////////////////////////////////

///////////////////////////MasterInfrastructure Start///////////////////////////////////
function GetInfrastructureCategoriesActiveList() {
    var dt_url = "/api/MasterInfrastructureCategory/GetList?IsActive=True";
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            
            var data = JSON.parse(response);
            var rowHtml = '<option value="">Select</option>';
            $(data.Result).each(function (i, v) {
                rowHtml += '<option value="' + v.Id + '">' + v.Title + '</option>';
            });
            $('#InfrastructureCategoryId').html(rowHtml);

        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}
function MasterInfrastructureList() {
    var dt_url = "/api/MasterInfrastructure/GetList?IsActive=True";
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
                    { data: 'Category' },
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterInfrastructureEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterInfrastructure'));
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
function FillMasterInfrastructureEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterInfrastructure/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#InfrastructureCategoryId').val(data.Result.InfrastructureCategoryId);
                $('#Title').val(data.Result.Title);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterInfrastructure(id) {
    confirmDelete('/api/MasterInfrastructure/DeleteById', id);
}

///////////////////////////MasterInfrastructure End///////////////////////////////////

///////////////////////////MasterLicenceCategory Start///////////////////////////////////

function MasterLicenceCategoryList() {
    var dt_url = "/api/MasterLicenceCategory/GetList?IsActive=True";
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
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterLicenceCategoryEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterLicenceCategory'));
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
function FillMasterLicenceCategoryEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterLicenceCategory/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Title').val(data.Result.Title);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterLicenceCategory(id) {
    confirmDelete('/api/MasterLicenceCategory/DeleteById', id);
}

///////////////////////////MasterLicenceCategory End///////////////////////////////////

///////////////////////////MasterLicenceSubCategory Start///////////////////////////////////
function GetLicenceCategoriesActiveList() {
    var dt_url = "/api/MasterLicenceCategory/GetList?IsActive=True";
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            
            var data = JSON.parse(response);
            var rowHtml = '<option value="">Select</option>';
            $(data.Result).each(function (i, v) {
                rowHtml += '<option value="' + v.Id + '">' + v.Title + '</option>';
            });
            $('#LicenceCategoryId').html(rowHtml);

        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}
function MasterLicenceSubCategoryList() {
    var dt_url = "/api/MasterLicenceSubCategory/GetList?IsActive=True";
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
                    { data: 'Category' },
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterLicenceSubCategoryEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterLicenceSubCategory'));
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
function FillMasterLicenceSubCategoryEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterLicenceSubCategory/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#LicenceCategoryId').val(data.Result.LicenceCategoryId);
                $('#Title').val(data.Result.Title);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterLicenceSubCategory(id) {
    confirmDelete('/api/MasterLicenceSubCategory/DeleteById', id);
}

///////////////////////////MasterLicenceSubCategory End///////////////////////////////////

///////////////////////////MasterMedicalExpertiseType Start///////////////////////////////////

function MasterMedicalExpertiseTypeList() {
    var dt_url = "/api/MasterMedicalExpertiseType/GetList?IsActive=True";
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
                    { data: 'Code' },
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterMedicalExpertiseTypeEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterMedicalExpertiseType'));
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
function FillMasterMedicalExpertiseTypeEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterMedicalExpertiseType/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Code').val(data.Result.Code);
                $('#Title').val(data.Result.Title);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterMedicalExpertiseType(id) {
    confirmDelete('/api/MasterMedicalExpertiseType/DeleteById', id);
}


///////////////////////////MasterMedicalExpertiseType End///////////////////////////////////

///////////////////////////MasterMedicalExpertiseSubType Start///////////////////////////////////
function GetExpertiseTypeActiveList() {
    var dt_url = "/api/MasterMedicalExpertiseType/GetList?IsActive=True";
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            
            var data = JSON.parse(response);
            var rowHtml = '<option value="">Select</option>';
            $(data.Result).each(function (i, v) {
                rowHtml += '<option value="' + v.Id + '">' + v.Title + '</option>';
            });
            $('#MedicalExpertiseTypeId').html(rowHtml);

        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}
function MasterMedicalExpertiseSubTypeList() {
    var dt_url = "/api/MasterMedicalExpertiseSubType/GetList?IsActive=True";
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
                    { data: 'Code' }, 
                    { data: 'ExpertiseType' },
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterMedicalExpertiseSubTypeEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterMedicalExpertiseSubType'));
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
function FillMasterMedicalExpertiseSubTypeEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterMedicalExpertiseSubType/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Title').val(data.Result.Title);
                $('#MedicalExpertiseTypeId').val(data.Result.MasterMedicalExpertiseTypesId);
                $('#Code').val(data.Result.Code);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterMedicalExpertiseSubType(id) {
    confirmDelete('/api/MasterMedicalExpertiseSubType/DeleteById', id);
}

///////////////////////////MasterMedicalExpertiseType End///////////////////////////////////

///////////////////////////MasterQualification Start///////////////////////////////////
function GetQualificationExpertiseSubTypeActiveList() {
    var dt_url = "/api/MasterMedicalExpertiseSubType/GetExpertiseSubList?IsActive=True";
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {

            var data = JSON.parse(response);
            var rowHtml = '<option value="">Select</option>';
            $(data.Result).each(function (i, v) {
                rowHtml += '<option value="' + v.Id + '">' + v.Title + '</option>';
            });
            $('#QualificationMasterMedicalExpertiseSubTypeId').html(rowHtml);

        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}
function MasterQualificationList() {
    var dt_url = "/api/MasterQualification/GetList?IsActive=True";
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
                    { data: 'Title' },
                    { data: 'Expertise' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterQualificationEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterQualification'));
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
function FillMasterQualificationEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterQualification/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Title').val(data.Result.Title);
                $('#IsActive').prop('checked', data.Result.IsActive);
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterQualification(id) {
    confirmDelete('/api/MasterQualification/DeleteById', id);
}

///////////////////////////MasterQualification End///////////////////////////////////

///////////////////////////MasterVillage Start///////////////////////////////////

function MasterVillageList() {
    var dt_url = "/api/MasterVillage/GetList?IsActive=True";
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
                   
                    { data: 'District' },
                    { data: 'Code' },
                    { data: 'Block' },
                    { data: 'Title' },
                    {
                        data: 'IsActive',
                        render: function (data, type, row) {
                            return ActiveLabelHtml(data);
                        }
                    },
                    {
                        data: 'CreatedOn',
                        render: function (data, type, row) {
                            return GetIndiaFormatDateOnly(data, true);
                        }
                    },
                    {
                        data: 'Id',
                        render: function (data, type, row) {
                            return (EditListActionHtml(data, 'FillMasterVillageEditForm') + ' ' + DeleteListActionHtml(data, 'DeleteMasterVillage'));
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
function FillMasterVillageEditForm(id) {
    $('.crt_heading-title').html('Edit');
    $('#myModal').modal('show');
    var dt_url = "/api/MasterVillage/GetSingle?Id=" + id;
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
                $('#Id').val(data.Result.Id);
                $('#Title').val(data.Result.Title);
                $('#Code').val(data.Result.Code);
                $('#VillageDistrictId').val(data.Result.DistrictId).trigger('change');
                $('#IsActive').prop('checked', data.Result.IsActive);
                selected_blockId = data.Result.BlockId;
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in data.');
        }
    });
}
function DeleteMasterVillage(id) {
    confirmDelete('/api/MasterVillage/DeleteById', id);
}
function GetVillageDistrictActiveList() {
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
            $('#VillageDistrictId').html(rowHtml);

        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}
function GetVillageBlockActiveList() {
    var dt_url = "/api/MasterBlock/GetDistrictBlock?IsActive=True";
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
            $('#VillageBlockId').html(rowHtml);
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}

$('#VillageDistrictId').change(function () {
    
    var districtId = $(this).val();
    var stateDropdown = $('#VillageBlockId');
    stateDropdown.empty();
    stateDropdown.append($('<option></option>').attr('value', '').text('--Select--'));
    if (districtId) {
        var dt_url = "/api/MasterBlock/GetDistrictBlock?IsActive=True&DistrictId=" + districtId + " ";
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
                $('#VillageBlockId').html(rowHtml);
                if (selected_blockId != '') {
                    $('#VillageBlockId').val(selected_blockId);
                }
                selected_blockId = '';
            },
            error: function (xhr) {
                WarningNotificationWithMessage('Error, loading in list.');
            }
        });
    }
});

///////////////////////////MasterVillage End///////////////////////////////////


