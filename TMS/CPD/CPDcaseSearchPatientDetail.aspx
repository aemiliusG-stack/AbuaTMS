<%@ Page Title="" Language="C#" MasterPageFile="~/CPD/CPD.master" AutoEventWireup="true" CodeFile="CPDcaseSearchPatientDetail.aspx.cs" Inherits="CPD_CPDcaseSearchPatientDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .nav-tabs .nav-link {
            background-color: #1ab394;
            color: white;
            border: none;
        }


            .nav-tabs .nav-link.active {
                background-color: #c9b412;
                color: black;
            }



        .nav-tabs .nav-attach {
            background-color: #e1e1e1;
            color: white;
            border: none;
        }

            .nav-tabs .nav-attach.active {
                background-color: #ff9800;
                color: white;
                border: none;
            }

        .radio-button {
            font-family: Arial, sans-serif;
            margin-bottom: 15px;
        }

        .required {
            color: red;
        }

        .radio-options {
            display: flex;
            align-items: center;
            margin-top: 5px;
        }

            .radio-options label {
                margin-right: 20px;
                font-size: 14px;
                cursor: pointer;
            }

        input[type="radio"] {
            margin-right: 10px;
        }

        .button-group {
            display: flex; /* Arrange buttons in one line */
            gap: 10px; /* Optional: Space between buttons */
        }

            .button-group .nav-link {
                background-color: #1ab394; /* Button background color */
                color: white; /* Text color */
                border: none; /* Remove default border */
                border-radius: 5px; /* Optional: Rounded corners */
                padding: 10px 20px; /* Adjust padding to increase button size */
                cursor: pointer; /* Pointer cursor on hover */
                flex-grow: 1; /* Optional: Makes all buttons the same width */
                text-align: center; /* Center the text */
            }

                .button-group .nav-link:hover {
                    background-color: #18a085; /* Darker shade on hover */
                }
    </style>
    <script type="text/javascript">
        function setView(viewIndex) {
            __doPostBack('<%= mvCPDTabs.UniqueID %>', viewIndex.toString());
        }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:MultiView ID="multiViewRecords" runat="server" ActiveViewIndex="0">
                <asp:View ID="viewMain" runat="server">
                    <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdAbuaId" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdPatientRegId" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdHospitalId" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdPackageId" runat="server" Visible="false" />
                    <asp:HiddenField ID="hfPDId" runat="server" Visible="false" />
                    <asp:HiddenField ID="hfAdmissionId" runat="server" Visible="false" />
                    <asp:Label ID="lblMessage" runat="server" CssClass="text-success" Style="margin-left: 10px;"></asp:Label>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="ibox ">
                                <div role="form" id="PatientDetailForm">
                                    <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                        <div class="d-flex w-100 justify-content-center position-relative" style="margin-left: -20px;">
                                            <h3 class="m-0">Patient Details</h3>
                                        </div>
                                        <div class="text-white text-nowrap">
                                            <span>Case No: </span>
                                            <asp:Label ID="lbCaseNoHead" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="ibox-content">
                                        <div class="ibox-content text-dark">
                                            <div class="row">
                                                <div class="col-lg-9">
                                                    <div class="form-group row">
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Name:</span><br />
                                                            <asp:Label ID="lbName" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
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
                                                            <asp:Label ID="lbCaseNo" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Case Status:</span><br />
                                                            <asp:Label ID="lbCaseStatus" runat="server" Text="NA"></asp:Label>
                                                        </div>
                                                        <%--<div class="col-md-3">
                                                    <span class="form-label fw-semibold" style="font-weight: bold;">IP No:</span><br />
                                                    <asp:Label ID="lbIPNo" runat="server" Text="N/A"></asp:Label>
                                                </div>
                                                <div class="col-md-3">
                                                    <span class="form-label fw-semibold" style="font-weight: bold;">IP Registered Date:</span><br />
                                                    <asp:Label ID="lbIPRegDate" runat="server" Text="N/A"></asp:Label>
                                                </div>--%>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Actual Registration Date:</span><br />
                                                            <asp:Label ID="lbActualRegDate" runat="server" Text="NA"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Contact No:</span><br />
                                                            <asp:Label ID="lbContactNo" runat="server" Text="NA"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Hospital Type:</span><br />
                                                            <asp:Label ID="lbHospitalType" runat="server" Text="NA"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Gender:</span><br />
                                                            <asp:Label ID="lbGender" runat="server" Text="NA"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Family ID:</span><br />
                                                            <asp:Label ID="lbFamilyId" runat="server" Text="NA"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Claim Paid Date:</span><br />
                                                            <asp:Label ID="lbClaimPaidDate" runat="server" Text="NA"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">UTR Number:</span><br />
                                                            <asp:Label ID="lbUTRNo" runat="server" Text="NA"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Age:</span><br />
                                                            <asp:Label ID="lbAge" runat="server" Text="NA"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Aadhar Verified:</span><br />
                                                            <asp:Label ID="lbAadharVerified" runat="server" Text="NA"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Authentication at Reg/Dis:</span><br />
                                                            <asp:Label ID="lbAuthentication" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Patient District:</span><br />
                                                            <asp:Label ID="lbPatientDistrict" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Patient Scheme:</span><br />
                                                            <asp:Label ID="lbPatientScheme" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row col-lg-3">
                                                    <div class="col-lg-6 align-items-center">
                                                        <asp:Image ID="imgPatientPhoto" runat="server" ImageUrl="../images/user_img.jpeg" CssClass="img-fluid mb-3" Style="max-width: 100px; height: 140px; object-fit: cover;" AlternateText="Patient Photo" />
                                                    </div>
                                                    <div class="col-lg-6 align-items-center">
                                                        <asp:Image ID="imgPatientPhotosecond" runat="server" ImageUrl="../images/user_img.jpeg" CssClass="img-fluid mb-3" Style="max-width: 100px; height: 140px; object-fit: cover;" AlternateText="Patient Photo" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="button-group">
                                        <asp:Button ID="btnPastHistory" runat="server" Text="Past History" OnClick="btnPastHistory_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnPreauth" runat="server" Text="Preauthorization" OnClick="btnPreauth_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnTreatment" runat="server" Text="Treatment And Discharge" OnClick="btnTreatment_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnClaims" runat="server" Text="Claims" OnClick="btnClaims_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnAttachments" runat="server" Text="Attachments" OnClick="btnAttachments_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnCaseSheet" runat="server" Text="Case Sheet" OnClick="btnAttachments_Click" class="nav-link d-flex flex-column align-items-center" />
                                    </div>

                                    <div class="tab-content mt-4" id="myTabContent">
                                        <asp:MultiView ID="mvCPDTabs" runat="server">
                                            <asp:View ID="ViewPast" runat="server">
                                                <div class="tab-pane fade show active" id="past" role="tabpanel">
                                                    <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                        <div class="d-flex w-100 justify-content-center position-relative">
                                                            <h3 class="m-0">Past History</h3>
                                                        </div>
                                                    </div>
                                                    <div class="ibox-content">
                                                        <div class="ibox">
                                                            <div class="ibox-content text-dark">
                                                                <div class="row align-items-end">
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-semibold">Case ID</span><br />
                                                                        <asp:TextBox ID="tbCaseId" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>

                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-semibold">From Date</span><br />
                                                                        <asp:TextBox ID="tbFromDate" runat="server" CssClass="form-control" type="date" OnKeyPress="return isDate(event)"></asp:TextBox>

                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <label class="form-label fw-semibold">To Date</label>
                                                                        <input class="form-control" type="date" />
                                                                    </div>
                                                                    <div class="col-lg-3">
                                                                        <button type="button" class="btn btn-primary"><i class="bi bi-search"></i>Search</button>
                                                                        <button type="reset" class="btn btn-warning"><i class="bi bi-search"></i>Reset</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <asp:GridView ID="gridPastHistory" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                            <AlternatingRowStyle BackColor="Gainsboro" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Sl.No.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label1" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Case ID">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbCaseId" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Patient Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbPatientName" runat="server" Text='<%# Eval("email") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Hospital Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Case Status">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Registered Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbRegDate" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Preauth Amount">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbPreauthAmt" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Claim Amount">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbClaimAmt" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Procedure">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Admission Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbAdmissionDate" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Preauth Initiation Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbInitiationDate" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </asp:View>
                                            <asp:View ID="ViewPreauth" runat="server">
                                                <div class="tab-pane fade show active" id="preauth" role="tabpanel">
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <div class="d-flex w-100 justify-content-center position-relative">
                                                                <h3 class="m-0">Network Hospital Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="ibox-content text-dark">
                                                                <div class="row">
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Hospital Name</span>
                                                                        <asp:TextBox ID="tbHospitalName" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Type</span>
                                                                        <asp:TextBox ID="tbType" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Address</span>
                                                                        <asp:TextBox ID="tbAddress" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--   <div class="ibox mt-4">
                                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                    <div class="d-flex w-100 justify-content-center position-relative">
                                                        <h3 class="m-0">Diagnosis and Treatement</h3>
                                                    </div>
                                                </div>
                                                <div class="ibox-content">
                                                    <div class="ibox-content text-dark">
                                                        <div class="row">
                                                            <div class="col-md-3">
                                                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Primary Diagnosis</span><span class="text-danger">*</span><br />
                                                                <asp:TextBox ID="tbPrimaryDiagnosis" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Secondary Diagnosis</span><span class="text-danger">*</span><br />
                                                                <asp:TextBox ID="tbSecondaryDianosis" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-12 mt-2">
                                                                <span class="text-danger">Note: User can select multiple options in Primary and Secondary diagnosis fields.</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>--%>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <h3 class="m-0">ICD Details</h3>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="ibox mt-4">
                                                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                    <div class="d-flex w-100 justify-content-center position-relative">
                                                                        <h3 class="m-0">Primary Diagnosis ICD Values</h3>
                                                                    </div>
                                                                </div>
                                                                <div class="ibox-content">
                                                                    <asp:GridView ID="gvICDDetails_Preauth" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Sl.No." ControlStyle-Font-Size="Small">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="PreauthId" runat="server" Text="NA"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="ICD Code">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="PreauthICDCode" runat="server" Text="NA"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="ICD Description">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="PreauthICDDes" runat="server" Text="NA"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Acted By Role">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="PreauthActRole" runat="server" Text='<%# Eval("ActedByRole") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <div class="d-flex w-100 justify-content-center position-relative">
                                                                <h3 class="m-0">Treatement Protocol</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <asp:GridView ID="gvTreatmentProtocol" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                <AlternatingRowStyle BackColor="Gainsboro" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Speciality">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbSpeciality" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbProcedure" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Quantity">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Amount(₹)">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("ProcedureAmountFinal") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Stratification">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbStratification" runat="server" Text='<%# Eval("StratificationName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Implants">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbImplants" runat="server" Text='<%# Eval("ImplantName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <%-- <asp:TemplateField HeaderText="Update ICHI Details">
                                                                <itemtemplate>
                                                                    <asp:HyperLink ID="hlUpdateICHI" runat="server"
                                                                        NavigateUrl='<%# Eval("Id", "UpdateICHI.aspx?id={0}") %>'
                                                                        Text="Update ICHI Details">
                                                                    </asp:HyperLink>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" font-size="14px" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" font-size="12px" />
                                                            </asp:TemplateField>--%>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <div class="d-flex w-100 justify-content-center position-relative">
                                                                <h3 class="m-0">ICHI Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <asp:GridView ID="gvICHIDetails" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                <AlternatingRowStyle BackColor="Gainsboro" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Procedure Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbProcedureName" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by MEDCO">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHIMedco" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by PPD">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHIPPD" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by PPD Insurer">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHIPPDInsurer" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by CPD">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHICPD" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by CPD Insurer">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHICPDInsurer" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by SAFO">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHISAFO" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by NAFO">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHINAFO" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Admission Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row text-dark">
                                                                <div class="col-md-4 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Admission Type</span>
                                                                        <div class="d-flex">
                                                                            <div class="form-check form-check-inline me-2">
                                                                                <asp:RadioButton ID="RadioButton1" runat="server" GroupName="inlineRadioOptions" Checked="true" Enabled="false" CssClass="form-check-input" />
                                                                                <span class="font-weight-bold text-dark">Planned</span>
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="RadioButton2" runat="server" GroupName="inlineRadioOptions" Enabled="false" CssClass="form-check-input" />
                                                                                <span class="font-weight-bold text-dark">Emergency</span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-8 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Admission Date</span><br />
                                                                        <asp:Label ID="lbAdmissionDate_Preauth" runat="server" CssClass="border-bottom" Style="margin-bottom: 0; padding-bottom: 0;"></asp:Label>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Package Cost</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="lbPackageCost" runat="server" CssClass="form-label" Style="margin-bottom: 0; padding-bottom: 0;"></asp:Label>
                                                                    <hr style="margin-top: 0;" />
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Hospital Incentive:</span>
                                                                    <asp:Label ID="lbHospitalIncentive" runat="server" CssClass="form-label" Style="margin-bottom: 0; padding-bottom: 0;"></asp:Label>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Incentive Amount</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="lbIncentiveAmount" runat="server" CssClass="form-label" Style="margin-bottom: 0; padding-bottom: 0;"></asp:Label>
                                                                    <hr style="margin-top: 0;" />
                                                                </div>
                                                                <div class="col-md-4 mb-3"></div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Total Package Cost</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="lbTotalPackageCost" runat="server" CssClass="form-label" Style="margin-bottom: 0; padding-bottom: 0;"></asp:Label>
                                                                    <hr style="margin-top: 0;" />
                                                                </div>

                                                                <div class="col-md-4 mb-3"></div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Total Amount Liable by Insurance is</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="lbTotalAmtInsurance" runat="server" CssClass="form-label" Text="100000" />
                                                                    <hr style="margin-top: 0;" />
                                                                </div>
                                                                <div class="col-md-4 mb-3"></div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Total Amount Liable by Trust is</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="lbTotalAmtTrust" runat="server" CssClass="form-label" Text="13615" />
                                                                    <hr style="margin-top: 0;" />
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12 mb-3">
                                                                <div class="form-group">
                                                                    <span class="font-weight-bold text-dark">Remarks</span>
                                                                    <asp:TextBox ID="tbRemarks" runat="server" OnKeypress="return isAlphaNumeric(event);" TextMode="MultiLine" CssClass="form-control" Style="margin-bottom: 0;"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12">
                                                                <span class="font-weight-bold text-danger">Note: Only ()?,./ special characters are allowed for Remarks</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <div class="d-flex w-100 justify-content-center position-relative">
                                                                <h3 class="m-0">Work Flow</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row">
                                                                <asp:GridView ID="gvPreauthWorkFlow" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                                    <AlternatingRowStyle BackColor="Gainsboro" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Sl.No.">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="15px" />
                                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Date and Time">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lbDateTime" runat="server" Text='<%# Eval("DateAndTime") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="15px" />
                                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Role">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lbRole" runat="server" Text='<%# Eval("RoleName") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="15px" />
                                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Remarks">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lbRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="15px" />
                                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Action">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lbAction" runat="server" Text='<%# Eval("Actions") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="15px" />
                                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Amount(Rs.)">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lbAmount" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="15px" />
                                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Preauth Query Rejection Reason">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lbPreauthQuery" runat="server" Text='<%# Eval("PreauthQueryRejectionReason") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="15px" />
                                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                                                                <label class="form-check-label" for="flexCheckDefault">
                                                                    I have reviewed the cases with the best of my knowledge and have validated all documents before making any decision
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:View>
                                            <asp:View ID="ViewTreatmentDischarge" runat="server">
                                                <div class="tab-pane fade show active" id="treatmentdischarge" role="tabpanel">
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Surgeon Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row text-dark">
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Doctor Type</span><br />
                                                                        <asp:DropDownList ID="dropDocType" runat="server" CssClass="form-control">
                                                                            <asp:ListItem>Other</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Name</span><br />
                                                                        <asp:DropDownList ID="dropDocName" runat="server" CssClass="form-control">
                                                                            <asp:ListItem>Dr. Sanjeet Anand(1759)</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Regn No</span><br />
                                                                        <asp:Label ID="lbRegnNo" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="1759"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Qualification</span><br />
                                                                        <asp:Label ID="lbQualification" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Contact No</span><br />
                                                                        <asp:Label ID="Label2" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--Anaesthetist Details--%>
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Anaesthetist Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row text-dark">
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Anaesthetist Name</span><br />
                                                                        <asp:DropDownList ID="dropAnaesthetistName" runat="server" CssClass="form-control">
                                                                            <asp:ListItem>Select</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Regn No</span><br />
                                                                        <asp:Label ID="lbAnaesthetistRegNo" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="1759"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Contact No</span><br />
                                                                        <asp:Label ID="lbAnaesthetistContactNo" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Anaesthetist Type</span><br />
                                                                        <asp:DropDownList ID="dropAnaesthetistType" runat="server" CssClass="form-control">
                                                                            <asp:ListItem>Select</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--Procedure Details--%>
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Procedure Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row text-dark">
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Incision type</span><br />
                                                                        <asp:Label ID="lbIncisionType" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">OP Photos/WebEx Taken</span><br />
                                                                        <div class="d-flex">
                                                                            <div class="form-check form-check-inline me-2">
                                                                                <asp:RadioButton ID="rbOPPhotoYes" runat="server" GroupName="OPPhotoWebEx" Text="&nbsp;&nbsp;&nbsp;Yes" CssClass="form-check-input" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbOPPhotoNo" runat="server" GroupName="OPPhotoWebEx" Text="&nbsp;&nbsp;&nbsp;No" CssClass="form-check-input" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Vedio Recording Done</span><br />
                                                                        <div class="d-flex">
                                                                            <div class="form-check form-check-inline me-2">
                                                                                <asp:RadioButton ID="rbVedioRecDoneYes" runat="server" GroupName="VedioRecording" Text="&nbsp;&nbsp;&nbsp;Yes" CssClass="form-check-input" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbVedioRecDoneNo" runat="server" GroupName="VedioRecording" Text="&nbsp;&nbsp;&nbsp;No" CssClass="form-check-input" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Swab Count Instruments Count</span><br />
                                                                        <asp:Label ID="lbSwabCounts" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Sutures Ligatures</span><br />
                                                                        <asp:Label ID="lbSurutes" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Specimen Removed</span><br />
                                                                        <div class="d-flex">
                                                                            <div class="form-check form-check-inline me-2">
                                                                                <asp:RadioButton ID="rbSpecimenRemoveYes" runat="server" GroupName="SpecimenRemoved" Text="&nbsp;&nbsp;&nbsp;Yes" CssClass="form-check-input" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbSpecimenRemoveNo" runat="server" GroupName="SpecimenRemoved" Text="&nbsp;&nbsp;&nbsp;No" CssClass="form-check-input" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Drainage Count</span><br />
                                                                        <asp:Label ID="lbDranageCount" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Blood Loss</span><br />
                                                                        <asp:Label ID="lbBloodLoss" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Post Operative Instructions</span><br />
                                                                        <asp:Label ID="lbOperativeInstructions" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Patient Condition</span><br />
                                                                        <asp:Label ID="lbPatientCondition" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Complications If Any</span><br />
                                                                        <div class="d-flex">
                                                                            <div class="form-check form-check-inline me-2">
                                                                                <asp:RadioButton ID="rbComplicationsYes" runat="server" GroupName="ComplicationIfAny" Text="&nbsp;&nbsp;&nbsp;Yes" CssClass="form-check-input" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbComplicationsNo" runat="server" GroupName="ComplicationIfAny" Text="&nbsp;&nbsp;&nbsp;No" CssClass="form-check-input" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--Treatment and Surgery Date--%>
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Treatment/Surgery Date</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row text-dark">
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Traetment/Surgery Date</span><br />
                                                                        <asp:Label ID="lbTraetmentDate" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="14/08/2024"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Surgery Start Time</span><br />
                                                                        <asp:TextBox ID="tbSurgeryStartTime" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Surgery End Time</span><br />
                                                                        <asp:TextBox ID="tbSurgeryEndTime" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--Surgery/Treatment Start Date Details--%>
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Surgery/Treatment Start Date Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <asp:GridView ID="GridSurgeryDate" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false">
                                                                <Columns>
                                                                    <asp:BoundField DataField="Procedure Code" HeaderText="Procedure Code" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                                    <asp:BoundField DataField="Procedure Name" HeaderText="Procedure Name" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                                    <asp:BoundField DataField="Surgery Date/Treatment Start Date" HeaderText="Surgery Date/Treatment Start Date" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                                </Columns>
                                                            </asp:GridView>
                                                            <span class="font-weight-bold text-danger">Note:</span>
                                                            <span>Please select Treatment start date for Medical Procedure and Surgical Procedures</span>
                                                        </div>
                                                    </div>
                                                    <%--Treatment Summary--%>
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Treatment Summary</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row text-dark">
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Traetment Given</span><br />
                                                                        <asp:TextBox ID="ybTreatmentGiven" ReadOnly="true" runat="server" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Operative Findings</span><br />
                                                                        <asp:TextBox ID="tbOperativeFindings" ReadOnly="true" runat="server" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Post Operative Period</span><br />
                                                                        <asp:TextBox ID="tbPostOperativePeriod" ReadOnly="true" runat="server" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Post Surgery/Therapy Special Investigations Given</span><br />
                                                                        <asp:TextBox ID="tbSpecialInvestigationGiven" ReadOnly="true" runat="server" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Status at the time of Discharge</span><br />
                                                                        <asp:TextBox ID="tbStatusAtDischarge" runat="server" ReadOnly="true" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Review</span><br />
                                                                        <asp:TextBox ID="tbReview" runat="server" ReadOnly="true" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Advice</span><br />
                                                                        <asp:TextBox ID="tbAdvice" runat="server" ReadOnly="true" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3 d-flex justify-content-center">
                                                                    <div class="d-flex">
                                                                        <div class="form-check form-check-inline me-2">
                                                                            <asp:RadioButton ID="rbDischarge" runat="server" GroupName="DischargeOrDeath" Checked="true" Enabled="false" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">Discharge</span>
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <asp:RadioButton ID="rbDeath" runat="server" GroupName="DischargeOrDeath" Enabled="false" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">Death</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- Placeholder for dynamic content -->
                                                    <asp:Panel ID="pnlDischarge" runat="server" CssClass="ibox mt-4">
                                                        <div class="ibox">
                                                            <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                                <div class="w-100 text-center">
                                                                    <h3 class="m-0">Discharge</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <div class="row text-dark">
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Discharge Date</span><br />
                                                                            <asp:Label ID="lbDischargeDate" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="16/07/2024 11:30"></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Next Follow Up Date</span><br />
                                                                            <asp:Label ID="lbNextFollowUp" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="18/07/2024"></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Consult at Block Name</span><br />
                                                                            <asp:Label ID="lbConsultBlockName" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Floor</span><br />
                                                                            <asp:Label ID="lbFloor" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Room No</span><br />
                                                                            <asp:Label ID="lbRoomNo" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Is Special Case</span><br />
                                                                            <asp:Label ID="lbIsSpecialCase" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Final Diagnosis</span><br />
                                                                            <asp:DropDownList ID="dropFinalDiagnosis" runat="server" CssClass="form-control border-0 border-bottom">
                                                                                <asp:ListItem>Select</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Procedure Consent</span><br />
                                                                            <div class="d-flex">
                                                                                <div class="form-check form-check-inline me-2">
                                                                                    <asp:RadioButton ID="rbConsentYes" runat="server" GroupName="ProceduralConsent" Text="&nbsp;&nbsp;&nbsp;Yes" CssClass="form-check-input" />
                                                                                </div>
                                                                                <div class="form-check form-check-inline">
                                                                                    <asp:RadioButton ID="rbConsentNo" runat="server" GroupName="ProceduralConsent" Text="&nbsp;&nbsp;&nbsp;No" CssClass="form-check-input" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-12 mb-3">
                                                                        <asp:CheckBox ID="cbDischarge" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;&nbsp;I hereby declare that the discharge type selected is correct" runat="server" />
                                                                    </div>
                                                                    <span class="text-danger font-weight-bold">Note:</span>
                                                                    <ol class="text-danger font-weight-bold">
                                                                        <li>Once the Discharge date/Death Date is updated in the discharge summary, it can not be modified at any point of time.</li>
                                                                        <li>Please save surgery/discharge page before printing Discharge summary</li>
                                                                    </ol>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </asp:Panel>
                                                </div>
                                            </asp:View>

                                            <asp:View ID="ViewClaims" runat="server">
                                                <div class="tab-pane fade show active" id="claims" role="tabpanel">
                                                    <%--                                            <div class="ibox mt-4">
                                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                    <div class="d-flex w-100 justify-content-center position-relative">
                                                        <h3 class="m-0">Diagnosis and Treatement</h3>
                                                    </div>
                                                </div>
                                                <div class="ibox-content">
                                                    <div class="ibox-content text-dark">
                                                        <div class="row">
                                                            <div class="col-md-3">
                                                                <span class="form-label fw-semibold">Primary Diagnosis</span><span class="text-danger">*</span><br />
                                                                <asp:TextBox ID="tbClaimPrimaryDiagnosis" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span class="form-label fw-semibold">Secondary Diagnosis</span><span class="text-danger">*</span><br />
                                                                <asp:TextBox ID="tbClaimSecondaryDiagnosis" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-12 mt-2">
                                                                <span class="text-danger">Note: User can select multiple options in Primary and Secondary diagnosis fields.</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>--%>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <h3 class="m-0">ICD Details</h3>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="ibox mt-4">
                                                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                    <div class="d-flex w-100 justify-content-center position-relative">
                                                                        <h3 class="m-0">Primary Diagnosis ICD Values</h3>
                                                                    </div>
                                                                </div>
                                                                <div class="ibox-content">
                                                                    <asp:GridView ID="gvPICDDetails_Claim" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Sl.No." ControlStyle-Font-Size="Small">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimPICDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="ICD Code">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimPICDCode" runat="server" Text='<%# Eval("ICDCode") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="ICD Description">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimPICDDescription" runat="server" Text='<%# Eval("ICDDescription") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Acted By Role">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimPActRole" runat="server" Text='<%# Eval("ActedByRole") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="ibox mt-4">
                                                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                    <div class="d-flex w-100 justify-content-center position-relative">
                                                                        <h3 class="m-0">Secondary Diagnosis ICD Values</h3>
                                                                    </div>
                                                                </div>
                                                                <div class="ibox-content">
                                                                    <asp:GridView ID="gvSICDDetails_Claim" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Sl.No." ControlStyle-Font-Size="Small">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimSICDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="ICD Code">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimSICDCode" runat="server" Text='<%# Eval("ICDCode") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="ICD Description">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimSICDDescription" runat="server" Text='<%# Eval("ICDDescription") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Acted By Role">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimSActRole" runat="server" Text='<%# Eval("ActedByRole") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>

                                                                </div>
                                                            </div>
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
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Preauth Approved Amount(Rs):</span><br />
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
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Trust Liable Amount:</span><br />
                                                                            <asp:Label ID="lbTrustLiableAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Bill Amount:</span><br />
                                                                            <asp:Label ID="lbBillAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Final E-rupi Voucher Amount:</span><br />
                                                                            <asp:Label ID="lbFinalErupiAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Remarks:</span>
                                                                            <asp:Label ID="lbRemark" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                        </div>
                                                                        <div class="col-md-3">
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
                                                                        <asp:TextBox ID="tbNonTechFormRemark" runat="server" OnKeypress="return isAlphaNumeric(event);" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
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
                                                                            <asp:TextBox runat="server" ID="tbTotalClaims" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">Insurance Approved Amount (Rs)<span class="text-danger">*</span>:</span><br />
                                                                            <asp:TextBox runat="server" ID="tbInsuranceApprovedAmt" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">Trust Approved Amount (Rs)<span class="text-danger">*</span>:</span><br />
                                                                            <asp:TextBox runat="server" ID="tbTrustApprovedAmt" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row mb-3">
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">Special Case:</span><br />
                                                                            <asp:TextBox runat="server" ID="tbSpecialCase" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                        </div>
                                                                    </div>

                                                                    <div class="row align-items-center">
                                                                        <div class="col-auto">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">1) Diagnosis is Supported by Evidence</span><span class="text-danger">*</span><br />
                                                                        </div>
                                                                        <div class="col text-right">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbDiagnosisSupportedYes" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="DiagnosisSupported" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbDiagnosisSupportedNo" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="DiagnosisSupported" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row align-items-center">
                                                                        <div class="col-auto">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">2) Case Management Proven to be done as per the Standard Treatment Protocols</span><span class="text-danger">*</span><br />
                                                                        </div>
                                                                        <div class="col text-right">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbCaseManagementYes" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="CaseManagement" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbCaseManagementNo" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="CaseManagement" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row align-items-center">
                                                                        <div class="col-auto">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">3) Evidence of the Therapy being Conducted exists beyond Doubts</span><span class="text-danger">*</span><br />
                                                                        </div>
                                                                        <div class="col text-right">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbEvidenceTherapyYes" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="EvidenceTherapy" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbEvidenceTherapyNo" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="EvidenceTherapy" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row align-items-center">
                                                                        <div class="col-auto">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">4) Mandatory Reports are Attached</span><span class="text-danger">*</span><br />
                                                                        </div>
                                                                        <div class="col text-right">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbMandatoryReportsYes" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="MandatoryReports" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbMandatoryReportsNo" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="MandatoryReports" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-bold" style="font-weight: 800;">Remarks:</span><br />
                                                                        <p style="font-size: 12px;">Document Verified</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:View>
                                            <asp:View ID="ViewAttachment" runat="server">
                                                <div class="tab-pane fade show active" id="attachment" role="tabpanel">
                                                    <ul class="nav nav-tabs d-flex flex-row justify-content-around" id="attachTab" role="tablist">
                                                        <li class="nav-item mr-2 mt-1" id="preAuth">
                                                            <asp:LinkButton ID="lnkPreauthorization" runat="server" CssClass="nav-link active nav-attach" OnClick="lnkPreauthorization_Click"><i class="bi bi-card-text text-black m-auto"></i></asp:LinkButton>
                                                        </li>
                                                        <li class="nav-item mr-2 mt-1" id="discharge">
                                                            <asp:LinkButton ID="lnkDischarge" runat="server" CssClass="nav-link nav-attach" OnClick="lnkDischarge_Click"><i class="bi bi-building-add text-black m-auto"></i></asp:LinkButton>
                                                        </li>
                                                        <li class="nav-item mr-2 mt-1" id="death">
                                                            <asp:LinkButton ID="lnkDeath" runat="server" CssClass="nav-link nav-attach" OnClick="lnkDeath_Click"><i class="bi bi-clipboard-x text-black m-auto"></i></asp:LinkButton>
                                                        </li>
                                                        <li class="nav-item mr-2 mt-1" id="claim">
                                                            <asp:LinkButton ID="lnkClaim" runat="server" CssClass="nav-link nav-attach" OnClick="lnkClaim_Click"><i class="bi bi-clipboard2-data text-black m-auto"></i></asp:LinkButton>
                                                        </li>
                                                        <li class="nav-item mr-2 mt-1" id="generalInvestigation">
                                                            <asp:LinkButton ID="lnkGeneralInvestigation" runat="server" CssClass="nav-link nav-attach" OnClick="lnkGeneralInvestigation_Click"><i class="bi bi-zoom-in text-black m-auto"></i></asp:LinkButton>
                                                        </li>
                                                        <li class="nav-item mr-2 mt-1" id="specialInvestigation">
                                                            <asp:LinkButton ID="lnkSpecialInvestigation" runat="server" CssClass="nav-link nav-attach" OnClick="lnkSpecialInvestigation_Click"><i class="bi bi-zoom-in text-black m-auto"></i></asp:LinkButton>
                                                        </li>
                                                        <li class="nav-item mr-2 mt-1" id="fraud">
                                                            <asp:LinkButton ID="lnkFraudDocuments" runat="server" CssClass="nav-link nav-attach" OnClick="lnkFraudDocuments_Click"><i class="bi bi-card-text text-black m-auto"></i></asp:LinkButton>
                                                        </li>
                                                        <li class="nav-item mt-1" id="audit">
                                                            <asp:LinkButton ID="lnkAuditDocuments" runat="server" CssClass="nav-link nav-attach" OnClick="lnkAuditDocuments_Click"><i class="bi bi-card-text text-black m-auto"></i></asp:LinkButton>
                                                        </li>
                                                    </ul>

                                                    <%--<div class="col-md-12 p-3">
            <asp:Button ID="btnViewInactiveAttachment" runat="server" Text="View All Inactive Attachments" class="btn btn-success rounded-pill mt-1" />
            <asp:Button ID="btnViewAnamolyAttathment" runat="server" Text="View Data Anamoly Attachments" class="btn btn-success rounded-pill mt-1" />
        </div>--%>

                                                    <div class="tab-content" id="attachTabContent">
                                                        <asp:MultiView ID="MultiView2" runat="server" ActiveViewIndex="0">
                                                            <asp:View ID="viewPreauthorization" runat="server">
                                                                <div class="tab-pane fade show active" id="one" role="tabpanel">
                                                                    <div class="ibox-title text-center">
                                                                        <h3 class="text-white">Preauthorization</h3>
                                                                    </div>
                                                                    <div class="ibox-content table-responsive">
                                                                        <table class="table table-bordered table-striped">
                                                                            <thead>
                                                                                <tr class="table-primary">
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                        <%--<asp:GridView ID="gridPreauthorization" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                    <alternatingrowstyle backcolor="Gainsboro" />
                                    <columns>
                                        <asp:TemplateField HeaderText="Attachment Name">
                                            <itemtemplate>
                                                <asp:LinkButton ID="lbAttachmentName" runat="Attachment Name"></asp:LinkButton>
                                                <asp:Label ID="lbAttachmentName" runat="server" Text="Attachment Name"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Uploaded Date">
                                            <itemtemplate>
                                                <asp:Label ID="lbUploadedDate" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Beneficiary Options">
                                            <itemtemplate>
                                                <asp:Label ID="lbBeneficiaryOptions" runat="server" Text="NA"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                    </columns>
                                </asp:GridView>--%>
                                                                    </div>
                                                                </div>
                                                            </asp:View>
                                                            <asp:View ID="viewDischarge" runat="server">
                                                                <div class="tab-pane fade show active" id="two" role="tabpanel">
                                                                    <div class="ibox-title text-center">
                                                                        <h3 class="text-white">Discharge</h3>
                                                                    </div>
                                                                    <div class="ibox-content table-responsive">
                                                                        <table class="table table-bordered table-striped">
                                                                            <thead>
                                                                                <tr class="table-primary">
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                        <%--<asp:GridView ID="gridPreauthorization" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                    <alternatingrowstyle backcolor="Gainsboro" />
                                    <columns>
                                        <asp:TemplateField HeaderText="Attachment Name">
                                            <itemtemplate>
                                                <asp:LinkButton ID="lbAttachmentName" runat="Attachment Name"></asp:LinkButton>
                                                <asp:Label ID="lbAttachmentName" runat="server" Text="Attachment Name"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Uploaded Date">
                                            <itemtemplate>
                                                <asp:Label ID="lbUploadedDate" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Beneficiary Options">
                                            <itemtemplate>
                                                <asp:Label ID="lbBeneficiaryOptions" runat="server" Text="NA"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                    </columns>
                                </asp:GridView>--%>
                                                                    </div>
                                                                </div>
                                                            </asp:View>
                                                            <asp:View ID="viewDeath" runat="server">
                                                                <div class="tab-pane fade show active" id="three" role="tabpanel">
                                                                    <div class="ibox-title text-center">
                                                                        <h3 class="text-white">Death</h3>
                                                                    </div>
                                                                    <div class="ibox-content table-responsive">
                                                                        <table class="table table-bordered table-striped">
                                                                            <thead>
                                                                                <tr class="table-primary">
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                        <%--<asp:GridView ID="gridPreauthorization" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                    <alternatingrowstyle backcolor="Gainsboro" />
                                    <columns>
                                        <asp:TemplateField HeaderText="Attachment Name">
                                            <itemtemplate>
                                                <asp:LinkButton ID="lbAttachmentName" runat="Attachment Name"></asp:LinkButton>
                                                <asp:Label ID="lbAttachmentName" runat="server" Text="Attachment Name"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Uploaded Date">
                                            <itemtemplate>
                                                <asp:Label ID="lbUploadedDate" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Beneficiary Options">
                                            <itemtemplate>
                                                <asp:Label ID="lbBeneficiaryOptions" runat="server" Text="NA"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                    </columns>
                                </asp:GridView>--%>
                                                                    </div>
                                                                </div>
                                                            </asp:View>
                                                            <asp:View ID="view1" runat="server">
                                                                <div class="tab-pane fade show active" id="four" role="tabpanel">
                                                                    <div class="ibox-title text-center">
                                                                        <h3 class="text-white">Claims</h3>
                                                                    </div>
                                                                    <div class="ibox-content table-responsive">
                                                                        <table class="table table-bordered table-striped">
                                                                            <thead>
                                                                                <tr class="table-primary">
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                        <%--<asp:GridView ID="gridPreauthorization" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                    <alternatingrowstyle backcolor="Gainsboro" />
                                    <columns>
                                        <asp:TemplateField HeaderText="Attachment Name">
                                            <itemtemplate>
                                                <asp:LinkButton ID="lbAttachmentName" runat="Attachment Name"></asp:LinkButton>
                                                <asp:Label ID="lbAttachmentName" runat="server" Text="Attachment Name"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Uploaded Date">
                                            <itemtemplate>
                                                <asp:Label ID="lbUploadedDate" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Beneficiary Options">
                                            <itemtemplate>
                                                <asp:Label ID="lbBeneficiaryOptions" runat="server" Text="NA"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                    </columns>
                                </asp:GridView>--%>
                                                                    </div>
                                                                </div>
                                                            </asp:View>
                                                            <asp:View ID="viewGeneralInvestigation" runat="server">
                                                                <div class="tab-pane fade show active" id="five" role="tabpanel">
                                                                    <div class="ibox-title text-center">
                                                                        <h3 class="text-white">General Investigations</h3>
                                                                    </div>
                                                                    <div class="ibox-content table-responsive">
                                                                        <table class="table table-bordered table-striped">
                                                                            <thead>
                                                                                <tr class="table-primary">
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                        <%--<asp:GridView ID="gridPreauthorization" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                    <alternatingrowstyle backcolor="Gainsboro" />
                                    <columns>
                                        <asp:TemplateField HeaderText="Attachment Name">
                                            <itemtemplate>
                                                <asp:LinkButton ID="lbAttachmentName" runat="Attachment Name"></asp:LinkButton>
                                                <asp:Label ID="lbAttachmentName" runat="server" Text="Attachment Name"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Uploaded Date">
                                            <itemtemplate>
                                                <asp:Label ID="lbUploadedDate" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Beneficiary Options">
                                            <itemtemplate>
                                                <asp:Label ID="lbBeneficiaryOptions" runat="server" Text="NA"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                    </columns>
                                </asp:GridView>--%>
                                                                    </div>
                                                                </div>
                                                            </asp:View>
                                                            <asp:View ID="viewSpecialInvestigation" runat="server">
                                                                <div class="tab-pane fade show active" id="six" role="tabpanel">
                                                                    <div class="ibox-title text-center">
                                                                        <h3 class="text-white">Special Investigations</h3>
                                                                    </div>
                                                                    <div class="ibox-content table-responsive">
                                                                        <table class="table table-bordered table-striped">
                                                                            <thead>
                                                                                <tr class="table-primary">
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Pre or Post</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>PRE</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>PRE</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>PRE</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>PRE</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                        <%--<asp:GridView ID="gridPreauthorization" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                    <alternatingrowstyle backcolor="Gainsboro" />
                                    <columns>
                                        <asp:TemplateField HeaderText="Attachment Name">
                                            <itemtemplate>
                                                <asp:LinkButton ID="lbAttachmentName" runat="Attachment Name"></asp:LinkButton>
                                                <asp:Label ID="lbAttachmentName" runat="server" Text="Attachment Name"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Uploaded Date">
                                            <itemtemplate>
                                                <asp:Label ID="lbUploadedDate" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Pre Or Post">
                                            <itemtemplate>
                                                <asp:Label ID="lbPrePost" runat="server" Text="PRE"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Beneficiary Options">
                                            <itemtemplate>
                                                <asp:Label ID="lbBeneficiaryOptions" runat="server" Text="NA"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                    </columns>
                                </asp:GridView>--%>
                                                                    </div>
                                                                </div>
                                                            </asp:View>
                                                            <asp:View ID="viewFraudDocuments" runat="server">
                                                                <div class="tab-pane fade show active" id="seven" role="tabpanel">
                                                                    <div class="ibox-title text-center">
                                                                        <h3 class="text-white">Fraud Documents</h3>
                                                                    </div>
                                                                    <div class="ibox-content table-responsive">
                                                                        <table class="table table-bordered table-striped">
                                                                            <thead>
                                                                                <tr class="table-primary">
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                        <%--<asp:GridView ID="gridPreauthorization" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                    <alternatingrowstyle backcolor="Gainsboro" />
                                    <columns>
                                        <asp:TemplateField HeaderText="Attachment Name">
                                            <itemtemplate>
                                                <asp:LinkButton ID="lbAttachmentName" runat="Attachment Name"></asp:LinkButton>
                                                <asp:Label ID="lbAttachmentName" runat="server" Text="Attachment Name"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Uploaded Date">
                                            <itemtemplate>
                                                <asp:Label ID="lbUploadedDate" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Beneficiary Options">
                                            <itemtemplate>
                                                <asp:Label ID="lbBeneficiaryOptions" runat="server" Text="NA"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                    </columns>
                                </asp:GridView>--%>
                                                                    </div>
                                                                </div>
                                                            </asp:View>
                                                            <asp:View ID="viewAuditDocuments" runat="server">
                                                                <div class="tab-pane fade show active" id="eight" role="tabpanel">
                                                                    <div class="ibox-title text-center">
                                                                        <h3 class="text-white">Audit Documents</h3>
                                                                    </div>
                                                                    <div class="ibox-content table-responsive">
                                                                        <table class="table table-bordered table-striped">
                                                                            <thead>
                                                                                <tr class="table-primary">
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                                    <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                                    <td>17-08-2024 12:30:00</td>
                                                                                    <td>NA</td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                        <%--<asp:GridView ID="gridPreauthorization" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                    <alternatingrowstyle backcolor="Gainsboro" />
                                    <columns>
                                        <asp:TemplateField HeaderText="Attachment Name">
                                            <itemtemplate>
                                                <asp:LinkButton ID="lbAttachmentName" runat="Attachment Name"></asp:LinkButton>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Uploaded Date">
                                            <itemtemplate>
                                                <asp:Label ID="lbUploadedDate" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Beneficiary Options">
                                            <itemtemplate>
                                                <asp:Label ID="lbBeneficiaryOptions" runat="server" Text="NA"></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                    </columns>
                                </asp:GridView>--%>
                                                                    </div>
                                                                </div>
                                                            </asp:View>
                                                        </asp:MultiView>
                                                        <div class="col-md-12 mt-3">
                                                            <span class="text-danger font-weight-bold">Note:</span><br />
                                                            <span class="text-danger">1. File size should not exceed 500kb.</span><br />
                                                            <span class="text-danger">2. Attachment names with blue color are related to notification.</span><br />
                                                            <span class="text-danger">3. Discharge summary document quality and its notation.</span><br />
                                                            <span class="text-danger">4. Document of good quality.
                    <i class="bi bi-clipboard-check text-black"></i>
                                                            </span>
                                                            <br />
                                                            <span class="text-danger m-0">4. Document of bad quality.
                    <i class="bi bi-file-excel text-black"></i>
                                                            </span>
                                                            <br />
                                                            <span class="text-danger m-0">4. Document which is not valid.
                    <i class="bi bi-exclamation-square text-black"></i>
                                                            </span>
                                                            <br />
                                                            <span class="text-danger m-0">4. Document of bad quality.
                    <i class="bi bi-exclamation-triangle-fill text-black"></i>
                                                            </span>
                                                            <br />
                                                        </div>
                                                        <div class="col-md-12 mt-2 mb-2">
                                                            <asp:Button ID="btnDownloadPdf" runat="server" Text="Download as one PDF" class="btn btn-success rounded-pill" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:View>
                                        </asp:MultiView>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </asp:View>
            </asp:MultiView>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

