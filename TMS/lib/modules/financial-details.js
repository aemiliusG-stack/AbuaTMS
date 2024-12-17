function GetUpgFinanceDetails() {
    var dt_url = "/api/Hospital/GetUpgFinanceDetails";
   
    var rowHtml = '';
    $.ajax({
        url: globalGetUrl,
        type: "POST",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: { APIUrl: dt_url },
        success: function (response) {
            var data = JSON.parse(response);
            if (data.Result != null) {
               
                $('#BankName').val(data.Result.BankName);
                $('#BranchName').val(data.Result.BranchName);
                $('#AccountNumber').val(data.Result.AccountNumber);
                $('#IFSCCode').val(data.Result.IFSCCode);
                $('#AuthorizedSignatoryAccount').val(data.Result.AuthorizedSignatoryAccount);
                $('#HospitalPan').val(data.Result.HospitalPan);
                if (data.Result.TDSExemption == true) {
                    $('#TDSExemption').val('true');
                }
                else  {
                    $('#TDSExemption').val('false');
                }
            }
        },
        error: function (xhr) {
            WarningNotificationWithMessage('Error, loading in list.');
        }
    });
}

