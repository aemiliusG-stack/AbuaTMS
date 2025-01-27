<%@ Page Title="" Language="C#" MasterPageFile="~/SHA/SHA.master" AutoEventWireup="true" CodeFile="CaseDetails.aspx.cs" Inherits="SHA_CaseDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <style>
    </style>
    <script type="text/javascript">
        function toggleRemarks() {
            debugger;
            var actionTypeDropdown = document.getElementById('<%= actionType.ClientID %>');
             var remarksSection = document.getElementById('remarksSection');

             if (actionTypeDropdown.value === '2') { // Assuming 1 is the value for "Approve"
                 remarksSection.style.display = 'block'; // Show the remarks section
             } else {
                 remarksSection.style.display = 'none'; // Hide the remarks section
             }
         }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div role="form" id="PatientDetailForm">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative" style="margin-left: -20px;">
                <h3 class="m-0">Patient Details</h3>
            </div>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdRoleId" runat="server" Visible="false" />
            <asp:HiddenField ID="hfInsurerApprovedAmount" runat="server" Visible="false" />
            <asp:HiddenField ID="hfTrustApprovedAmount" runat="server" Visible="false" />
            <asp:HiddenField ID="hfDeductedAmount" runat="server" Visible="false" />
            <asp:HiddenField ID="hfFinalAmount" runat="server" Visible="false" />
            <div class="text-white text-nowrap">
                <span>Case No: </span>
                <asp:Label ID="lbCaseNoHead" runat="server"></asp:Label>
                <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="False"></asp:Label>
                <asp:Label ID="lblSuccess" runat="server" CssClass="text-success" Text=""></asp:Label>
            </div>
        </div>
        <div class="ibox-content">

            <div class="ibox-content text-dark">
                <div class="row">
                    <div class="col-lg-9">
                        <div class="form-group row">
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Name:</span><br />
                                <asp:Label ID="Label11" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Beneficiary Card ID:</span><br />
                                <asp:Label ID="lbBeneficiaryId" runat="server" Text="N/A"></asp:Label>

                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Registration No:</span><br />
                                <asp:Label ID="lbRegNo" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>

                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Case No:</span><br />
                                <asp:Label ID="Label12" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Case Status:</span><br />
                                <asp:Label ID="Label13" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">IP No:</span><br />
                                <asp:Label ID="Label14" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">IP Registered Date:</span><br />
                                <asp:Label ID="lbIPRegDate" runat="server" Text="N/A"></asp:Label>

                            </div>

                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Actual Registration Date:</span><br />
                                <asp:Label ID="Label15" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Communication Contact No:</span><br />
                                <asp:Label ID="lbContactNo" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Hospital Type:</span><br />
                                <asp:Label ID="Label16" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Gender:</span><br />
                                <asp:Label ID="Label17" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Family ID:</span><br />
                                <asp:Label ID="Label18" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Age:</span><br />
                                <asp:Label ID="Label19" runat="server" Text="N/A"></asp:Label>

                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Aadhar Verified:</span><br />
                                <asp:Label ID="Label20" runat="server" Text="N/A"></asp:Label>

                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Authentication at Reg/Dis:</span><br />
                                <asp:Label ID="lbAuthentication" runat="server" Text="N/A"></asp:Label>

                            </div>
                            <div class="col-md-3">
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Patient District:</span><br />
                                <asp:Label ID="Label21" runat="server" Text="N/A"></asp:Label>

                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-weight: bold;">Patient Scheme:</span><br />
                                <asp:Label ID="lbPatientScheme" runat="server" Text="MMASSY"></asp:Label>

                            </div>
                            <div class="col-md-3">
                            </div>

                        </div>
                    </div>
                    <div class="row col-lg-3">
                        <div class="col-lg-6 align-items-center">
                            <asp:Image ID="Image1" runat="server" CssClass="img-fluid mb-3" Style="max-width: 100px; height: 140px; object-fit: cover;" AlternateText="Patient Photo" />
                            <%--<asp:Image ID="Image2" runat="server" class="img-fluid mb-3" Style="max-width: 150px;" />--%>
                        </div>
                        <div class="col-lg-6 align-items-center">
                            <%--<asp:Image ID="imgPatientPhotosecond" runat="server" ImageUrl="../images/user_img.jpeg" CssClass="img-fluid mb-3" Style="max-width: 100px; height: 140px; object-fit: cover;" AlternateText="Patient Photo" />--%>
                            <asp:Image ID="Image2" runat="server" class="img-fluid mb-3" Style="max-width: 150px;" />
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
    <asp:Panel ID="pnlTabs" runat="server" CssClass="tabs-panel">
        <div class="btn-group">
            <asp:LinkButton ID="btnPastHistory" runat="server" CssClass="btn btn-info ml-2">
            <i class="fas fa-history"></i> Past History
            </asp:LinkButton>

            <asp:LinkButton ID="btnPreauth" runat="server" CssClass="btn btn-info ml-2">
            <i class="fas fa-file-medical"></i> Preauthorization
            </asp:LinkButton>

            <asp:LinkButton ID="btnTreatandDischaarge" runat="server" CssClass="btn btn-info ml-2">
            <i class="fas fa-procedures"></i> Treatment/Discharge
            </asp:LinkButton>

            <asp:LinkButton ID="btnClaims" runat="server" CssClass="btn btn-warning ml-2">
            <i class="fas fa-file-invoice-dollar"></i> Claims
            </asp:LinkButton>

            <asp:LinkButton ID="btnAttachments" runat="server" CssClass="btn btn-info ml-2">
            <i class="fas fa-paperclip"></i> Attachments
            </asp:LinkButton>

            <asp:LinkButton ID="btnACaseSheet" runat="server" CssClass="btn btn-info ml-2">
            <i class="fas fa-notes-medical"></i> Case Sheet
            </asp:LinkButton>

            <asp:LinkButton ID="btnOncology" runat="server" CssClass="btn btn-info ml-2">
            <i class="fas fa-dna"></i> Oncology Related Data
            </asp:LinkButton>
        </div>
    </asp:Panel>

    <div class="ibox">
        <!-- ICD Details Header -->
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">ICD Details</h3>
            </div>
        </div>

        <!-- Primary Diagnosis ICD Values -->
        <div class="ibox-content">
            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                <h4 class="m-0">Primary Diagnosis ICD Values</h4>
            </div>
            <asp:GridView ID="gvICDDetails" runat="server" AutoGenerateColumns="false" CssClass="table table-striped">
                <Columns>
                    <asp:BoundField DataField="SNo" HeaderText="S No" />
                    <asp:BoundField DataField="ICDCode" HeaderText="ICD CODE" />
                    <asp:BoundField DataField="ICDDescription" HeaderText="ICD DESCRIPTION" />
                    <asp:BoundField DataField="ActedByRole" HeaderText="Acted By Role" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
    <div class="ibox ">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">Claim Details</h3>
            </div>
        </div>
        <div class="ibox mt-4">
            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                <div class="d-flex w-100 justify-content-center position-relative">
                    <h3 class="m-0">Claims Details</h3>
                </div>
            </div>
            <div class="ibox-content">
                <div class="ibox-content text-dark">
                    <div class="col-lg-12">
                        <div class="form-group row">
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Preauth Approved Amount (Rs):</span><br />
                                <asp:Label ID="lbPreauthApprovedAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Preauth Date:</span><br />
                                <asp:Label ID="lbPreauthDate" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Claim Submitted Date:</span><br />
                                <asp:Label ID="lbClaimSubmittedDate" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Last Claim Updated Date:</span><br />
                                <asp:Label ID="lbLastClaimUpadted" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Penalty Amount:</span><br />
                                <asp:Label ID="lbPenaltyAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Claim Amount:</span><br />
                                <asp:Label ID="lbClaimAmount" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Insurance Liable Amount:</span><br />
                                <asp:Label ID="lbInsuranceLiableAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Trust Liable Amount (Rs):</span><br />
                                <asp:Label ID="lbTrustLiableAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Bill Amount:</span><br />
                                <asp:Label ID="lbBillAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Final E-rupi Voucher Amount (Rs):</span><br />
                                <asp:Label ID="lbFinalErupiAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                            </div>
                            <div class="col-md-3">
                            </div>
                            <div class="col-md-3">
                            </div>
                            <div class="col-md-3 mt-3">
                                <%--<span class="font-weight-bold">Remarks:</span><br />
                    <textarea rows="4" cols="40" placeholder="Enter remarks here" class="form-control"></textarea>--%>
                                <span class="font-weight-bold text-dark">Remarks</span>
                                <asp:TextBox ID="TextBox2" runat="server" OnKeypress="return isAlphaNumeric(event);" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--Non Technical Checklist--%>
    <div class="ibox mt-4">
        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
            <div class="w-100 text-center">
                <h3 class="m-0">Non Technical Checklist</h3>
            </div>
        </div>
        <div class="ibox-content">
            <div class="row text-dark">
                <div class="col-md-8 mb-3">
                    <div class="form-group">
                        <span class="font-weight-bold text-dark">1) Name in Case Sheet and Consent Forms is Correct</span><span class="font-weight-bold text-danger">*</span>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="rbIsNameCorrectYes" runat="server" GroupName="IsNameCorrect" Enabled="false" CssClass="form-check-input" />
                            <span class="form-check-label font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="rbIsNameCorrectNo" runat="server" GroupName="IsNameCorrect" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 mb-3">
                    <div class="form-group">
                        <span class="font-weight-bold text-dark">2) Gender in Cse Sheet and Consent Forms is Correct</span><span class="font-weight-bold text-danger">*</span>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="rbIsGenderCorrectYes" runat="server" GroupName="IsGenderCorrect" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="rbIsGenderCorrectNo" runat="server" GroupName="IsGenderCorrect" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 mb-3">
                    <div class="form-group">
                        <span class="font-weight-bold text-dark">3) Is Beneficiary Card Photo is Matching with Discharge Photo and Onbed Photo</span><span class="font-weight-bold text-danger">*</span>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="rbIsPhotoVerifiedYes" runat="server" GroupName="IsPhotoVerified" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="rbIsPhotoVerifiedNo" runat="server" GroupName="IsPhotoVerified" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 mb-4">
                    <span class="font-weight-bold text-dark">Date Verification</span>
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Addmision Date</span><span class="font-weight-bold text-danger">*</span>
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Online</span><br />
                    <asp:Label ID="lbNonTechAdmissionDate" runat="server" CssClass="form-label" />
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Case Sheet</span><br />
                    <%--                                                                    <asp:TextBox ID="tbCSAdmissionDate" runat="server" TextMode="Date" AutoPostBack="true" CssClass="form-control border-0 border-bottom"></asp:TextBox>--%>
                    <asp:Label ID="lbCSAdmissionDate" runat="server" CssClass="form-label" />

                </div>
                <div class="col-md-3 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="rbIsAdmissionDateVerifiedYes" runat="server" GroupName="IsAdmissionDateVerified" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="rbIsAdmissionDateVerifiedNo" runat="server" GroupName="IsAdmissionDateVerified" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Surgery/Therepy Date</span><span class="font-weight-bold text-danger">*</span>
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Online</span><br />
                    <asp:Label ID="lbNonTechSurgeryDate" runat="server" CssClass="form-label" />
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Case Sheet</span><br />
                    <%--                                                                    <asp:TextBox ID="tbCSTherepyDate" runat="server" TextMode="Date" AutoPostBack="true" CssClass="form-control border-0 border-bottom"></asp:TextBox>--%>
                    <asp:Label ID="lbCSTherepyDate" runat="server" CssClass="form-label" />
                </div>
                <div class="col-md-3 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="rbIsSurgeryDateVerifiedYes" runat="server" GroupName="IsSurgeryDateCSVerified" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="rbIsSurgeryDateVerifiedNo" runat="server" GroupName="IsSurgeryDateCSVerified" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Discharge/Death Date</span><span class="font-weight-bold text-danger">*</span>
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Online</span><br />
                    <asp:Label ID="lbNonTechDeathDate" runat="server" CssClass="form-label" />
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Case Sheet</span><br />
                    <%--                                                                    <asp:TextBox ID="tbCSDischargeDate" runat="server" TextMode="Date" AutoPostBack="true" CssClass="form-control border-0 border-bottom"></asp:TextBox>--%>
                    <asp:Label ID="lbCSDischargeDate" runat="server" CssClass="form-label" />

                </div>
                <div class="col-md-3 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="rbIsDischargeDateCSVerifiedYes" runat="server" GroupName="IsDischargeDateCSVerified" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="rbIsDischargeDateCSVerifiedNo" runat="server" GroupName="IsDischargeDateCSVerified" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 mb-4">
                    <span class="font-weight-bold text-dark">Document Verification</span>
                </div>
                <div class="col-md-8 mb-3">
                    <div class="form-group">
                        <span class="font-weight-bold text-dark">1) Patient/Attendant Signature is Matching across two Forms(Counselling Form and Consent Letter)</span><span class="font-weight-bold text-danger">*</span>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="rbIsSignVerifiedYes" runat="server" GroupName="IsSignVerified" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="rbIsSignVerifiedNo" runat="server" GroupName="IsSignVerified" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 mb-3">
                    <div class="form-group">
                        <span class="font-weight-bold text-dark">2) Reports are Signed by Doctors with Registration Number</span><span class="font-weight-bold text-danger">*</span>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="rbIsReportCorrectYes" runat="server" GroupName="IsReportCorrect" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="rbIsReportCorrectNo" runat="server" GroupName="IsReportCorrect" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 mb-3">
                    <div class="form-group">
                        <span class="font-weight-bold text-dark">3) Dates and Patient Name are Correctly Stated on the Reports</span><span class="font-weight-bold text-danger">*</span>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="rbIsReportVerifiedYes" runat="server" GroupName="IsReportVerified" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="rbIsReportVerifiedNo" runat="server" GroupName="IsReportVerified" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 mb-3">
                    <div class="form-group">
                        <span class="font-weight-bold text-dark">Remarks</span>
                        <asp:TextBox ID="tbNonTechFormRemark" runat="server" Enabled="false" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--Technical Checklist--%>
    <div class="ibox mt-4">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">Technical Checklist</h3>
            </div>
        </div>
        <div class="ibox-content">
            <div class="ibox-content text-dark">
                <div class="col-lg-12">
                    <div class="form-group row mb-3">
                        <div class="col-md-4">
                            <span class="form-label fw-bold" style="font-weight: 800;">Total Claims (Rs):</span><br />
                            <asp:TextBox runat="server" Enabled="false" ID="tbTotalClaims" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;" EnableViewState="true"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <span class="form-label fw-bold" style="font-weight: 800;">Insurance Approved Amount (Rs)<span class="text-danger">*</span>:</span><br />
                            <asp:TextBox runat="server" Enabled="false" ID="tbInsuranceApprovedAmt" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <span class="form-label fw-bold" style="font-weight: 800;">Trust Approved Amount (Rs)<span class="text-danger">*</span>:</span><br />
                            <asp:TextBox runat="server" Enabled="false" ID="tbTrustApprovedAmt" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row mb-3">
                        <div class="col-md-4">
                            <span class="form-label fw-bold" style="font-weight: 800;">Special Case:</span><br />
                            <asp:TextBox runat="server" Enabled="false" ID="tbSpecialCase" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                        </div>
                        <div class="col-md-4">
                        </div>
                    </div>

                    <div class="row align-items-center">
                        <div class="col-auto">
                            <span class="form-label fw-bold" enabled="false" style="font-weight: 800;">1) Diagnosis is Supported by Evidence</span><span class="text-danger">*</span><br />
                        </div>
                        <div class="col text-right">
                            <div class="form-check form-check-inline mt-2">
                                <asp:RadioButton ID="rbDiagnosisSupportedYes" runat="server" Enabled="false" class="form-check-label font-weight-bold text-dark" GroupName="DiagnosisSupported" Text="Yes" />
                            </div>
                            <div class="form-check form-check-inline">
                                <asp:RadioButton ID="rbDiagnosisSupportedNo" runat="server" Enabled="false" class="form-check-label font-weight-bold text-dark" GroupName="DiagnosisSupported" Text="No" />
                            </div>
                        </div>
                    </div>
                    <div class="row align-items-center">
                        <div class="col-auto">
                            <span class="form-label fw-bold" style="font-weight: 800;">2) Case Management Proven to be done as per the Standard Treatment Protocols</span><span class="text-danger">*</span><br />
                        </div>
                        <div class="col text-right">
                            <div class="form-check form-check-inline mt-2">
                                <asp:RadioButton ID="rbCaseManagementYes" runat="server" Enabled="false" class="form-check-label font-weight-bold text-dark" GroupName="CaseManagement" Text="Yes" />
                            </div>
                            <div class="form-check form-check-inline">
                                <asp:RadioButton ID="rbCaseManagementNo" runat="server" Enabled="false" class="form-check-label font-weight-bold text-dark" GroupName="CaseManagement" Text="No" />
                            </div>
                        </div>
                    </div>
                    <div class="row align-items-center">
                        <div class="col-auto">
                            <span class="form-label fw-bold" style="font-weight: 800;">3) Evidence of the Therapy being Conducted exists beyond Doubts</span><span class="text-danger">*</span><br />
                        </div>
                        <div class="col text-right">
                            <div class="form-check form-check-inline mt-2">
                                <asp:RadioButton ID="rbEvidenceTherapyYes" runat="server" Enabled="false" class="form-check-label font-weight-bold text-dark" GroupName="EvidenceTherapy" Text="Yes" />
                            </div>
                            <div class="form-check form-check-inline">
                                <asp:RadioButton ID="rbEvidenceTherapyNo" runat="server" Enabled="false" class="form-check-label font-weight-bold text-dark" GroupName="EvidenceTherapy" Text="No" />
                            </div>
                        </div>
                    </div>
                    <div class="row align-items-center">
                        <div class="col-auto">
                            <span class="form-label fw-bold" style="font-weight: 800;">4) Mandatory Reports are Attached</span><span class="text-danger">*</span><br />
                        </div>
                        <div class="col text-right">
                            <div class="form-check form-check-inline mt-2">
                                <asp:RadioButton ID="rbMandatoryReportsYes" runat="server" Enabled="false" class="form-check-label font-weight-bold text-dark" GroupName="MandatoryReports" Text="Yes" />
                            </div>
                            <div class="form-check form-check-inline">
                                <asp:RadioButton ID="rbMandatoryReportsNo" runat="server" Enabled="false" class="form-check-label font-weight-bold text-dark" GroupName="MandatoryReports" Text="No" />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-group">
                            <span class="font-weight-bold text-dark">Remarks</span>
                            <asp:TextBox ID="tbTechRemarks" runat="server" Enabled="false" OnKeypress="return isAlphaNumeric(event);" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- ACO Remarks --%>
    <div class="ibox">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">ACO Remarks</h3>
            </div>
        </div>
        <div class="ibox-content">
            <div class="row text-dark">
                <div class="col-lg-9">
                    <div class="row">
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Total Claims (Rs):</span><br />
                            <asp:Label ID="Label8" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Trust Liable (Rs):</span><br />
                            <asp:Label ID="Label9" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Final Approved Amount (Rs):</span><br />
                            <%--<asp:TextBox ID="TextBoxFinalApprovedAmount" runat="server" CssClass="form-control" AutoPostBack="True" OnTextChanged="TextBoxFinalApprovedAmount_TextChanged"></asp:TextBox>--%>
                            <asp:TextBox ID="tbFinalAmountByAco" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <%--<asp:Label ID="lbFinalApprovedAmount" runat="server"></asp:Label>--%>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <span class="font-weight-bold text-dark">Remarks</span>
                            <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                            <asp:Button ID="btnAddDeduction" OnClick="btnAddDeduction_Click" CssClass="btn btn-primary rounded-pill mt-2" runat="server" Text="Add Deduction" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- SHA Remarks Section -->
    <div class="ibox">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">SHA Remarks</h3>
            </div>
        </div>
        <div class="ibox-content">
            <div class="row text-dark">
                <div class="col-lg-9">
                    <div class="row">
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Total Claims (Rs):</span><br />
                            <asp:Label ID="lbTotalClaims" runat="server" CssClass="form-control text-muted"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Trust Liable (Rs):</span><br />
                            <asp:Label ID="lbTrustLiable" runat="server" CssClass="form-control text-muted"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Final Approved Amount (Rs):</span><br />
                            <asp:TextBox ID="tbFinalAmountBySha" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <span class="font-weight-bold text-dark">Remarks:</span>
                            <asp:TextBox ID="tbSHARemarks" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                            <asp:Button ID="Button1" OnClick="btnAddDeduction_Click" CssClass="btn btn-primary rounded-pill mt-2" runat="server" Text="Add Deduction" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- SHA Deduction Section -->
    <div class="ibox">
        <div class="ibox-title">
            <h3 class="text-white">SHA Deduction</h3>
        </div>
        <div class="ibox-content">
            <div class="row text-dark">
                <div class="col-lg-9">
                    <div class="row">
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Deduction Amount (Rs):</span><br />
                            <asp:TextBox ID="tbDeductionAmount" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <%--Work Flow--%>
    <div class="ibox mt-4">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">Work Flow</h3>
            </div>
        </div>
        <div class="ibox-content">
            <div class="row">
                <div class="table-responsive">
                    <asp:GridView ID="gvClaimWorkFlow" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                        <AlternatingRowStyle BackColor="Gainsboro" />
                        <Columns>
                            <asp:TemplateField HeaderText="S.No.">
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Eval("SerialNo") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date And Time">
                                <ItemTemplate>
                                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("ActionDate") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Name">
                                <ItemTemplate>
                                    <asp:Label ID="Label10" runat="server" Text='<%# Eval("RoleName") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    <asp:Label ID="Label11" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:Label ID="Label13" runat="server" Text='<%# Eval("ActionTaken") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Approved Amount(Rs.)">
                                <ItemTemplate>
                                    <asp:Label ID="Label15" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Claim Query/Rejection Reasons">
                                <ItemTemplate>
                                    <asp:Label ID="Label16" runat="server" Text='<%# Eval("RejectionReason") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    <!-- Action Type -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4>Action Type</h4>
        </div>
        <div class="panel-body">
            <div class="form-group">
                <div class="row">
                    <div class="col-md-3">
                        <label for="actionType">Select Action Type:</label>
                        <asp:DropDownList ID="actionType" runat="server" CssClass="form-control" name="actionType" AutoPostBack="True" OnSelectedIndexChanged="ActionType_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <asp:Panel ID="pReason" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                        <span class="form-label fw-semibold">Reason<span class="text-danger">*</span></span>
                        <asp:DropDownList ID="ddlReason" runat="server" CssClass="form-control mt-2" AutoPostBack="true" OnSelectedIndexChanged="ddlReason_SelectedIndexChanged">
                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </asp:Panel>
                    <asp:Panel ID="pSubReason" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                        <span class="form-label fw-semibold">Sub Reason<span class="text-danger">*</span></span>
                        <asp:DropDownList ID="ddlSubReason" runat="server" CssClass="form-control mt-2">
                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </asp:Panel>
                    <div class="form-group">
                        <label for="txtRemarks">Remarks:</label>
                        <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
                    </div>
                </div>
            </div>
            <asp:Button ID="submitButton" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click" AutoPostBack="True" />
        </div>
    </div>
   <%-- <asp:Button ID="btnApproveAndPay" runat="server" Text="Approve and Initiate Payment" CssClass="btn btn-primary" OnClick="btnApproveAndPay_Click" />
<asp:Label ID="Label1" runat="server" Visible="false"></asp:Label>
<asp:Label ID="Label2" runat="server" Visible="false"></asp:Label>
    <!-- Note -->--%>
    <div class="text-end mt-2">
        <strong style="color: red;">Insurance Wallet Amount Rs.
            <span style="color: red;">0</span>
        </strong>
    </div>
    <!-- Note -->
    <div class="text-end mt-2">
        <strong style="color: red;">Scheme Wallet Amount Rs.
            <span style="color: red;">344,878</span>
        </strong>
    </div>
</asp:Content>

