<%@ Page Title="" Language="C#" MasterPageFile="~/ACO/ACO.master" AutoEventWireup="true" CodeFile="CaseDetails.aspx.cs" Inherits="ACO_CaseDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <style>
    </style>
    <script type="text/javascript">
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div role="form" id="PatientDetailForm">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative" style="margin-left: -20px;">
                <h3 class="m-0">Patient Details</h3>
            </div>
            <div class="text-white text-nowrap">
                <span>Case No: </span>
                <asp:Label ID="lbCaseNoHead" runat="server"></asp:Label>
                <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="False"></asp:Label>
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
                            <asp:Image ID="Image1" runat="server"  CssClass="img-fluid mb-3" Style="max-width: 100px; height: 140px; object-fit: cover;" AlternateText="Patient Photo" />
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

    <div class="ibox ">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">ICD Details</h3>
            </div>
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
    <div class="ibox ">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">Claim Details</h3>
            </div>
        </div>
        <div class="col-lg-9">
            <div class="row">
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">PreAuth Amount Approved(Rs.):</span><br />
                    <asp:Label ID="Label1" runat="server" Text="77000"></asp:Label>
                </div>
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">PreAuth Date:</span><br />
                    <asp:Label ID="Label2" runat="server" Text="25/06/2025"></asp:Label>
                </div>
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">Claim Submitted Date:</span><br />
                    <asp:Label ID="Label3" runat="server" Text="2332330"></asp:Label>
                </div>
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">Last Claim Submitted Date:</span><br />
                    <asp:Label ID="Label4" runat="server" Text="25/06/2025"></asp:Label>
                </div>
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">Penalty Amount(Rs.):</span><br />
                    <asp:Label ID="Label5" runat="server" Text="0"></asp:Label>
                </div>
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">Claim Amount(Rs.):</span><br />
                    <asp:Label ID="Label6" runat="server" Text="77000"></asp:Label>
                </div>
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">Trust Liable Amount(Rs.):</span><br />
                    <asp:Label ID="Label7" runat="server" Text="77000"></asp:Label>
                </div>
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">Bill Amount(Rs.):</span><br />
                    <asp:Label ID="Label26" runat="server" Text="77000"></asp:Label>
                </div>
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">Final E-rupi voucher amount(Rs.):</span><br />
                    <asp:Label ID="Label27" runat="server" Text="null"></asp:Label>
                </div>
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">Final E-rupi voucher amount(Rs.):</span><br />
                    <asp:Label ID="Label28" runat="server" Text="null"></asp:Label>
                </div>
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">Remarks:</span><br />
                    <%--<asp:Label ID="Label27" runat="server" Text="null"></asp:Label>--%>
                    <textarea rows="4" cols="40" placeholder="Enter remarks here"></textarea>
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
                            <asp:RadioButton ID="rbYes" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="rbNo" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" />
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
                            <asp:RadioButton ID="RadioButton3" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="RadioButton4" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" />
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
                            <asp:RadioButton ID="RadioButton5" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="RadioButton6" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" />
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
                    <asp:Label ID="Label23" runat="server" CssClass="form-label" Text="14-06-2024" />
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Case Sheet</span>
                    <%--<asp:TextBox ID="TextBox4" runat="server" TextMode="Date" AutoPostBack="true" OnTextChanged="TextBox4_TextChanged" CssClass="form-control border-0 border-bottom"></asp:TextBox>--%>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="RadioButton7" runat="server" GroupName="inlineRadioOptions" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="RadioButton8" runat="server" GroupName="inlineRadioOptions" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Surgery/Therepy Date</span><span class="font-weight-bold text-danger">*</span>
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Online</span><br />
                    <asp:Label ID="Label24" runat="server" CssClass="form-label" Text="14-06-2024" />
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Case Sheet</span>
                    <%--<asp:TextBox ID="TextBox3" runat="server" TextMode="Date" AutoPostBack="true" OnTextChanged="TextBox3_TextChanged" CssClass="form-control border-0 border-bottom"></asp:TextBox>--%>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="RadioButton9" runat="server" GroupName="inlineRadioOptions" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="RadioButton10" runat="server" GroupName="inlineRadioOptions" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Discharge/Death Date</span><span class="font-weight-bold text-danger">*</span>
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Online</span><br />
                    <asp:Label ID="Label25" runat="server" CssClass="form-label" Text="14-06-2024" />
                </div>
                <div class="col-md-3 mb-3">
                    <span class="font-weight-bold text-dark">Case Sheet</span>
                    <%--<asp:TextBox ID="TextBox5" runat="server" TextMode="Date" AutoPostBack="true" OnTextChanged="TextBox2_TextChanged" CssClass="form-control border-0 border-bottom"></asp:TextBox>--%>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="RadioButton11" runat="server" GroupName="inlineRadioOptions" Enabled="false" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="RadioButton12" runat="server" GroupName="inlineRadioOptions" Enabled="false" CssClass="form-check-input" />
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
                            <asp:RadioButton ID="RadioButton13" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="RadioButton14" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" />
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
                            <asp:RadioButton ID="RadioButton15" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="RadioButton16" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" />
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
                            <asp:RadioButton ID="RadioButton17" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="RadioButton18" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 mb-3">
                    <div class="form-group">
                        <span class="font-weight-bold text-dark">Remarks</span>
                        <asp:TextBox ID="TextBox6" runat="server" OnKeypress="return isAlphaNumeric(event);" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--Technical Checklist--%>
    <div class="ibox ">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">Technical Checklist</h3>
            </div>
        </div>
        <div class="ibox-content">
            <div class="row text-dark">
                <!-- Additional Claims Information -->
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">Total Claims (Rs.):</span><br />
                    <asp:Label ID="lblTotalClaims" runat="server" Text="77000"></asp:Label>
                </div>
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">Final Approved Amount (Rs.):</span><br />
                    <asp:Label ID="lblApprovedAmount" runat="server" Text="55676"></asp:Label>
                </div>
                <div class="col-md-3 mt-3">
                    <span class="font-weight-bold">Special Cases:</span><br />
                    <asp:Label ID="lblSpecialCases" runat="server" Text="No"></asp:Label>
                </div>

                <div class="col-md-8 mb-3">
                    <div class="form-group">
                        <span class="font-weight-bold text-dark">1) Diagnosis is Supported by Evidence.</span><span class="font-weight-bold text-danger">*</span>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="rbYesTechnical1" runat="server" GroupName="techRadioOptions1" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="rbNoTechnical1" runat="server" GroupName="techRadioOptions1" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 mb-3">
                    <div class="form-group">
                        <span class="font-weight-bold text-dark">2) Case Management Proven to be done as per the Standard Treatment Protocols</span><span class="font-weight-bold text-danger">*</span>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="rbYesTechnical2" runat="server" GroupName="techRadioOptions2" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="rbNoTechnical2" runat="server" GroupName="techRadioOptions2" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 mb-3">
                    <div class="form-group">
                        <span class="font-weight-bold text-dark">3) Evidence of the Therapy being Conducted exists beyond Doubt</span><span class="font-weight-bold text-danger">*</span>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="rbYesTechnical3" runat="server" GroupName="techRadioOptions3" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="rbNoTechnical3" runat="server" GroupName="techRadioOptions3" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 mb-3">
                    <div class="form-group">
                        <span class="font-weight-bold text-dark">4) Mandatory Reports are Attached</span><span class="font-weight-bold text-danger">*</span>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="d-flex">
                        <div class="form-check form-check-inline me-2">
                            <asp:RadioButton ID="RadioButton1" runat="server" GroupName="techRadioOptions3" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">Yes</span>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton ID="RadioButton2" runat="server" GroupName="techRadioOptions3" CssClass="form-check-input" />
                            <span class="font-weight-bold text-dark">No</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 mb-3">
                    <span class="font-weight-bold text-dark">Additional Remarks</span>
                    <asp:TextBox ID="txtTechnicalRemarks" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                </div>
                <!-- Note -->
                <div class="text-end mt-2">
                    <strong>
                        <span style="color: red;">Note: Remarks are mandatory while assigning only()? special characters are allowed for Remarks</span>
                    </strong>
                </div>
            </div>
        </div>
    </div>
    <%--ACO Remarks--%>
    <div class="ibox ">
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
                            <span class="font-weight-bold">Total Claims(Rs.):</span><br />
                            <asp:Label ID="Label8" runat="server" Text="77000"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">trust Liable(Rs.):</span><br />
                            <asp:Label ID="Label9" runat="server" Text="77000"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Final Approved Amount(Rs.):</span><br />
                            <asp:Label ID="Label10" runat="server" Text="77000"></asp:Label>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <span class="font-weight-bold text-dark">Remarks</span>
                            <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <%--ACO Remarks--%>
    <div class="ibox ">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">Add Deduction</h3>
            </div>
        </div>
        <div class="ibox-content">
            <table class="table table-bordered" style="width: 100%;">
                <thead class="bg-light">
                    <tr>
                        <th>Deduction Type</th>
                        <th>Amount(₹)</th>
                        <th>Remarks</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Treatment Charges</td>
                        <td>19250</td>
                        <td>ONLY 15 FRACTIONS DONE...</td>
                        <td>
                            <!-- Action buttons can be placed here -->
                            <button class="btn btn-sm btn-danger">Remove</button>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- Total Deduction Amount -->
            <div class="text-end mt-2">
                <strong>Total Deduction Amount (₹):</strong> <span>19250</span>
            </div>
        </div>
    </div>
    <%--Work Flow--%>
    <div class="ibox ">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">Work Flow</h3>
            </div>
        </div>
        <div class="ibox-content">
            <table class="table table-bordered" style="width: 100%;">
                <thead class="bg-light">
                    <tr>
                        <th>S.No</th>
                        <th>Date & Time</th>
                        <th>Name</th>
                        <th>Remarks</th>
                        <th>Action</th>
                        <th>Approved Amount(₹)</th>
                        <th>Claim Query/Rejection Reasons</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>12/07/2024 12:25:22</td>
                        <td>MEDCO(MEDCO)</td>
                        <td>NA</td>
                        <td>Claim Initiated by MEDCO</td>
                        <td>77000</td>
                        <td>NA</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>12/07/2024 18:12:48</td>
                        <td>Raju Kumar Mahto CEX(CEX)</td>
                        <td>DOCUMENT REVIEW</td>
                        <td>Claim Forwarded by CEX</td>
                        <td>77000</td>
                        <td>NA</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>15/07/2024 11:23:15</td>
                        <td>Dr Raghav Rishi CPD(CPD)</td>
                        <td>ONLY 15 FRACTIONS DONE...</td>
                        <td>CPD Approved</td>
                        <td>57750.0</td>
                        <td>NA</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <%--  <div class="ibox ">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">Action Type</h3>
            </div>
        </div>
        <div class="panel-body">
            <div class="form-group">
                <div class="row">
                    <div class="col-md-3">
                        <label for="actionType">Select Action Type:</label>
                        <select id="actionType" class="form-control" name="actionType">
                            <option value="">-- Select Action Type --</option>
                            <option value="Type1">Approved</option>
                            <option value="Type2">Rejected</option>
                            <option value="Type3">Raise uery</option>
                            <!-- Add more options as needed -->
                        </select>
                    </div>
                </div>

            </div>
            <button id="submitButton" class="btn btn-primary">Submit</button>
        </div>
    </div>--%>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4>Action Type</h4>
        </div>
        <div class="panel-body">
            <div class="form-group">
                <div class="row">
                    <div class="col-md-3">
                        <label for="actionType">Select Action Type:</label>
                        <select id="actionType" class="form-control" name="actionType">
                            <option value="">-- Select Action Type --</option>
                            <option value="Type1">Approved</option>
                            <option value="Type2">Rejected</option>
                            <option value="Type3">Raise query</option>
                            <!-- Add more options as needed -->
                        </select>
                    </div>
                </div>

            </div>
            <button id="submitButton" class="btn btn-primary">Submit</button>
        </div>
    </div>
    <!-- Note -->
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

