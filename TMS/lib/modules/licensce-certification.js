function GetLicensceCategoryAndSubCategories() {
    var dt_url = "/api/MasterLicenceCategory/GetCategoryList?IsActive=true";
    var headerHtml = '';
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            $(data.Result).each(function (i, v) {
                headerHtml += '<div class="col-lg-12">';
                headerHtml += '<div class="ibox">';
                headerHtml += '<div class="ibox-title">';
                headerHtml += ' <h5>' + v.Title + '</h5>';
                headerHtml += '<div class="ibox-tools">';
                headerHtml += '<a class="collapse-link">';
                headerHtml += '<i class="fa fa-chevron-up"></i>';
                headerHtml += '</a></div></div>';
                //header starts here
                headerHtml += '<div class="ibox-content p-0"><div class="row"><div class="col-md-12"><div class="table-responsive">';
                headerHtml += '<table class="table table-striped specialities">';
                headerHtml += '<thead>';
                headerHtml += '<tr>';
                headerHtml += '<th>Approval Name</th><th>Certificate No</th><th>Issue Date</th><th>Expiry Date</th><th>Action</th>';
                headerHtml += '</tr>';
                headerHtml += '</thead>';
                headerHtml += '<tbody id="tblbody' + v.Id + '">';
                $(v.SubCategories).each(function (i, sv) {
                    //sub cat binding
                    headerHtml += '<tr>';
                    headerHtml += '<td>' + sv.SubCatTitle + '</td>';
                    headerHtml += '<td> <input type="text" placeholder="" class="form-control" /></td>';
                    headerHtml += '<td><input type="date" class="form-control" /></td>';
                    headerHtml += '<td><input type="date" class="form-control" placeholder="" /></td>';
                    headerHtml += '<td>';
                    headerHtml += '<div class="d-flex justify-content-around">';
                    headerHtml += '<a href="" class="icon-btn "><i class="fa fa-paperclip"></i></a>';
                    headerHtml += '<a href="" class="icon-btn "><i class="fa fa-file-image-o"></i></a>';
                    headerHtml += '</div>';
                    headerHtml += '</td>';
                    headerHtml += '</tr>';
                    //end
                });
                headerHtml += '</tbody>';
                headerHtml += '</table>';
                headerHtml += '</div>';
                headerHtml += '</div>';
                headerHtml += '</div>';
                headerHtml += '</div>';
                headerHtml += '</div>';
                headerHtml += '</div>';
            });
            $('#divynamiccontent').empty().append(headerHtml);

        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}

