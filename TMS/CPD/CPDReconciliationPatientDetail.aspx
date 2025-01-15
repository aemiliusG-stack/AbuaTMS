<%@ Page Title="" Language="C#" MasterPageFile="~/CPD/CPD.master" AutoEventWireup="true" CodeFile="CPDReconciliationPatientDetail.aspx.cs" Inherits="CPD_CPDReconciliationPatientDetail" %>

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
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Name:</span><br />
                                                            <asp:Label ID="lbName" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Beneficiary Card ID:</span><br />
                                                            <asp:Label ID="lbBeneficiaryId" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Registration No:</span><br />
                                                            <asp:Label ID="lbRegNo" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Case No:</span><br />
                                                            <asp:Label ID="lbCaseNo" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Case Status:</span><br />
                                                            <asp:Label ID="lbCaseStatus" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">IP No:</span><br />
                                                            <asp:Label ID="lbIPNo" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">IP Registered Date:</span><br />
                                                            <asp:Label ID="lbIPRegDate" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Actual Registration Date:</span><br />
                                                            <asp:Label ID="lbActualRegDate" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Contact No:</span><br />
                                                            <asp:Label ID="lbContactNo" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Hospital Type:</span><br />
                                                            <asp:Label ID="lbHospitalType" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Gender:</span><br />
                                                            <asp:Label ID="lbGender" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Family ID:</span><br />
                                                            <asp:Label ID="lbFamilyId" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Claim Paid Date:</span><br />
                                                            <asp:Label ID="lbClaimPaidDate" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">UTR Number:</span><br />
                                                            <asp:Label ID="lbUTRNo" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                        </div>
                                                        <div class="col-md-3">
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Age:</span><br />
                                                            <asp:Label ID="lbAge" runat="server" Text="N/A"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Aadhar Verified:</span><br />
                                                            <asp:Label ID="lbAadharVerified" runat="server" Text="N/A"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Authentication at Reg/Dis:</span><br />
                                                            <asp:Label ID="lbAuthentication" runat="server" Text="N/A"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Patient District:</span><br />
                                                            <asp:Label ID="lbPatientDistrict" runat="server" Text="N/A"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Patient Scheme:</span><br />
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
                                    <%--<ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                       <a class="nav-link d-flex flex-column align-items-center active" id="past_history-tab" data-toggle="tab" href="#ViewPast" role="tab" aria-controls="past" aria-selected="true">
                                <i class="bi bi-clock-history mt-1"></i>
                                Past History
                            </a> 
                           <i class="bi bi-clock-history mt-1"></i>

                        </li>
                        <li class="nav-item ml-2">
                            <a class="nav-link d-flex flex-column align-items-center" id="preauth-tab" data-toggle="tab" href="#preauth" role="tab" aria-controls="preauth" aria-selected="false">
                                <i class="bi bi-building-fill-check mt-1"></i>
                                Preauthorization
                            </a>
                        </li>
                        <li class="nav-item ml-2">
                            <a class="nav-link d-flex flex-column align-items-center" id="treatment-tab" data-toggle="tab" href="#treatment" role="tab" aria-controls="preauth" aria-selected="false">
                                <i class="bi bi-building-fill-check mt-1"></i>
                                Treatment And Discharge
                            </a>
                        </li>
                        <li class="nav-item ml-2">
                            <a class="nav-link d-flex flex-column align-items-center" id="laims-tab" data-toggle="tab" href="#claims" role="tab" aria-controls="preauth" aria-selected="false">
                                <i class="bi bi-building-fill-check mt-1"></i>
                                Claims
                            </a>
                        </li>
                        <li class="nav-item ml-2">
                            <a class="nav-link d-flex flex-column align-items-center" id="attachments-tab" data-toggle="tab" href="#attachment" role="tab" aria-controls="attachment" aria-selected="false">
                                <i class="bi bi-paperclip"></i>
                                Attachments
                            </a>
                        </li>

                    </ul>--%>


                                    <div class="button-group">
                                        <asp:Button ID="btnPastHistory" runat="server" Text="Past History" OnClick="btnPastHistory_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnPreauth" runat="server" Text="Preauthorization" OnClick="btnPreauth_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnTreatment" runat="server" Text="Treatment And Discharge" OnClick="btnTreatment_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnClaims" runat="server" Text="Claims" OnClick="btnClaims_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnAttachments" runat="server" Text="Attachments" OnClick="btnAttachments_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnCaseSheet" runat="server" Text="Case Sheet" OnClick="btnCasSheet_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnQuestionnaier" runat="server" Text="Questionnaier" OnClick="btnQuestionnaier_Click" class="nav-link d-flex flex-column align-items-center" />

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
                                                                        <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
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
                                                                        <asp:Label ID="lbCaseStatus" runat="server" Text='<%# Eval("address") %>'></asp:Label>
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
                                                                        <asp:Label ID="lbProcedure" runat="server" Text='<%# Eval("address") %>'></asp:Label>
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
                                                                        <asp:TextBox ID="tbHospitalName" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>

                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Type</span>
                                                                        <asp:TextBox ID="tbType" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>

                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Address</span>
                                                                        <asp:TextBox ID="tbAddress" runat="server" CssClass="form-control" value="Ranchi, Jharkhand" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="ibox mt-4">
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
                                                    </div>

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
                                                                        <asp:Label ID="Label4" runat="server" Text="24/08/2024" CssClass="border-bottom"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Package Cost</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="lbPackageCostshow" runat="server" CssClass="form-label" Text="96500" />
                                                                    <hr />
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Hospital Incentive:</span>
                                                                    <asp:Label ID="Label5" runat="server" CssClass="form-label" Text="110%" />
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Incentive Amount</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="lbIncentiveAmountShow" runat="server" CssClass="form-label" Text="17115" />
                                                                    <hr />
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Total Package Cost</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="lbTotalPackageCostShow" runat="server" CssClass="form-label" Text="113615" />
                                                                    <hr />
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Total Amount Liable by Insurance is</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="Label6" runat="server" CssClass="form-label" Text="100000" />
                                                                    <hr />
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Total Amount Liable by Trust is</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="Label1" runat="server" CssClass="form-label" Text="13615" />
                                                                    <hr />
                                                                </div>

                                                            </div>
                                                            <div class="col-md-12 mb-3">
                                                                <div class="form-group">
                                                                    <span class="font-weight-bold text-dark">Remarks</span>
                                                                    <asp:TextBox ID="tbRemarks" runat="server" OnKeypress="return isAlphaNumeric(event);" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
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
                                                                        <asp:Label ID="lbDoctorType" runat="server" CssClass="d-block w-100 border-bottom p-1" Text="1759"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Name</span><br />
                                                                        <asp:Label ID="lbDoctorName" runat="server" CssClass="d-block w-100 border-bottom p-1" Text="1759"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Regn No</span><br />
                                                                        <asp:Label ID="lbDocRegnNo" runat="server" CssClass="d-block w-100 border-bottom p-1" Text="1759"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Qualification</span><br />
                                                                        <asp:Label ID="lbDocQualification" runat="server" CssClass="d-block w-100 border-bottom p-1" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Contact No</span><br />
                                                                        <asp:Label ID="lbDocContactNo" runat="server" CssClass="d-block w-50 border-bottom p-1" Text="&nbsp;"></asp:Label>
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
                                                                        <asp:Label ID="lbAnaesthetistName" runat="server" CssClass="d-block w-50 border-bottom p-1" Text="&nbsp;"></asp:Label>
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
                                                                        <asp:Label ID="lbAnaesthetistType" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="NA"></asp:Label>
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
                                                                                <asp:RadioButton ID="rbOPPhotoYes" runat="server" GroupName="OPPhotoWebEx" Enabled="False" Text="Yes" CssClass="form-check-input" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbOPPhotoNo" runat="server" GroupName="OPPhotoWebEx" Enabled="False" Text="No" CssClass="form-check-input" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Vedio Recording Done</span><br />
                                                                        <div class="d-flex">
                                                                            <div class="form-check form-check-inline me-2">
                                                                                <asp:RadioButton ID="rbVedioRecDoneYes" runat="server" GroupName="VedioRecording" Enabled="False" Text="Yes" CssClass="form-check-input" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbVedioRecDoneNo" runat="server" GroupName="VedioRecording" Enabled="False" Text="No" CssClass="form-check-input" />
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
                                                                                <asp:RadioButton ID="rbSpecimenRemoveYes" runat="server" GroupName="SpecimenRemoved" Enabled="False" Text="Yes" CssClass="form-check-input" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbSpecimenRemoveNo" runat="server" GroupName="SpecimenRemoved" Enabled="False" Text="No" CssClass="form-check-input" />
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
                                                                                <asp:RadioButton ID="rbComplicationsYes" runat="server" GroupName="ComplicationIfAny" Enabled="False" Text="Yes" CssClass="form-check-input" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbComplicationsNo" runat="server" GroupName="ComplicationIfAny" Enabled="False" Text="No" CssClass="form-check-input" />
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
                                                                        <asp:TextBox ID="tbSurgeryStartTime" runat="server" Enabled="False" TextMode="Time" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Surgery End Time</span><br />
                                                                        <asp:TextBox ID="tbSurgeryEndTime" runat="server" Enabled="False" TextMode="Time" CssClass="form-control"></asp:TextBox>
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
                                                                        <asp:TextBox ID="tbTreatmentGiven" ReadOnly="true" runat="server" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
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
                                                                            <span class="font-weight-bold text-dark">Final Diagnosis</span><br />
                                                                            <asp:Label ID="lbFinalDiagnosis" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Is Special Case</span><br />
                                                                            <div class="d-flex">
                                                                                <div class="form-check form-check-inline me-2">
                                                                                    <asp:RadioButton ID="rbIsSpecialCaseYes" runat="server" GroupName="IsSpecialCase" Enabled="False" Text="Yes" CssClass="form-check-input" />
                                                                                </div>
                                                                                <div class="form-check form-check-inline">
                                                                                    <asp:RadioButton ID="rbIsSpecialCaseNo" runat="server" GroupName="IsSpecialCase" Enabled="False" Text="No" CssClass="form-check-input" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Procedure Consent</span><br />
                                                                            <div class="d-flex">
                                                                                <div class="form-check form-check-inline me-2">
                                                                                    <asp:RadioButton ID="rbConsentYes" runat="server" GroupName="ProceduralConsent" Enabled="False" Text="Yes" CssClass="form-check-input" />
                                                                                </div>
                                                                                <div class="form-check form-check-inline">
                                                                                    <asp:RadioButton ID="rbConsentNo" runat="server" GroupName="ProceduralConsent" Enabled="False" Text="No" CssClass="form-check-input" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <asp:Label ID="lbDischargeTypeRemarks" runat="server" class="font-weight-bold text-dark" Text="Discharge Type Remarks" Visible="false"></asp:Label><br />
                                                                            <asp:TextBox ID="tbDischargeTypeRemarks" runat="server" CssClass="form-control d-block border-bottom p-1 mt-1" Visible="false"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3 mt-4">
                                                                        <asp:Button ID="btnUpdateDischarge" runat="server" CssClass="btn btn-primary rounded-pill" Text="Update Discharge" OnClick="btnUpdateDischarge_Click" />
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
                                                    <div class="ibox mt-4">
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
                                                                            <label id="lbPreauthApprovedAmt" style="font-size: 12px;">11000</label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Preauth Date:</span><br />
                                                                            <label id="lbPreauthDate" style="font-size: 12px;">20/08/2024 11:46:50 AM</label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Claim Submitted Date:</span><br />
                                                                            <label id="lbClaimSubmittedDate" style="font-size: 12px;">20/08/2024 11:46:50 AM</label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Last Claim Updated Date:</span><br />
                                                                            <label id="lbLastClaimUpadted" style="font-size: 12px;">20/08/2024 11:46:50 AM</label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Penalty Amount(Rs):</span><br />
                                                                            <label id="lbPenaltyAmt" style="font-size: 12px;">0</label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Claim Amount:</span><br />
                                                                            <label id="lbClaimAmount" style="font-size: 12px;">11000</label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Insurance Liable Amount(Rs):</span><br />
                                                                            <label id="lbInsuranceLiableAmt" style="font-size: 12px;">11000</label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Bill Amount(Rs):</span><br />
                                                                            <label id="lbBillAmt" style="font-size: 12px;">11000</label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Final E-rupi Voucher Amount(Rs):</span><br />
                                                                            <label id="lbFinalErupiAmt" style="font-size: 12px;">0</label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Bill Date:</span><br />
                                                                            <label id="lbBillDate" style="font-size: 12px;">20/08/2024</label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Remarks:</span><br />
                                                                            <label id="lbRemark" style="font-size: 12px;">Ok Sir</label>
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

                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <div class="d-flex w-100 justify-content-center position-relative">
                                                                <h3 class="m-0">Non Technical Checklist</h3>
                                                            </div>
                                                        </div>

                                                        <div class="ibox-content">
                                                            <div class="ibox-content text-dark">
                                                                <div class="row align-items-center">
                                                                    <div class="col-auto">
                                                                        <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Remarks:</span><br />

                                                                        <label class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">1) Name in Case Sheet and Consent Form is Correct:</label>
                                                                    </div>
                                                                    <div class="col text-right">
                                                                        <div class="radio-button">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbNameYes" runat="server" class="form-check-label" GroupName="NameCaseConsent" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbNameNo" runat="server" class="form-check-label" GroupName="NameCaseConsent" Text="No" />
                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                                <div class="row align-items-center">
                                                                    <div class="col-auto">
                                                                        <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">2) Gender in Case Sheet and Consent Form is Correct:</span><br />
                                                                    </div>
                                                                    <div class="col text-right">
                                                                        <div class="radio-button">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbGenderYes" runat="server" class="form-check-label" GroupName="GenderCaseConsent" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbGenderNo" runat="server" class="form-check-label" GroupName="GenderCaseConsent" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row align-items-center">
                                                                    <div class="col-auto">
                                                                        <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">3) Is Beneficiary Card Photo is Matching with Discharge Photo and Onbed Photo:</span><br />
                                                                    </div>
                                                                    <div class="col text-right">
                                                                        <div class="radio-button">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbPhotoYes" runat="server" class="form-check-label" GroupName="CardPhotoMatching" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbPhotoNo" runat="server" class="form-check-label" GroupName="GenderCaseConsent" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-12">
                                                                    <div class="form-group row">
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Admission Date:</span><br />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Online:</span><br />
                                                                            <p style="font-size: 12px;">20/08/2024</p>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Case Sheet:</span><br />
                                                                            <p style="font-size: 12px;">20/08/2024</p>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <div class="radio-button">
                                                                                <div class="form-check form-check-inline mt-2">
                                                                                    <asp:RadioButton ID="rbAdmissionDateYes" runat="server" class="form-check-label" GroupName="AdmissionDate" Text="Yes" />
                                                                                </div>
                                                                                <div class="form-check form-check-inline">
                                                                                    <asp:RadioButton ID="rbAdmissionDateNo" runat="server" class="form-check-label" GroupName="AdmissionDate" Text="No" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Surgery/Theraphy Date:</span><br />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Online:</span><br />
                                                                            <p style="font-size: 12px;">20/08/2024</p>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Case Sheet:</span><br />
                                                                            <p style="font-size: 12px;">20/08/2024</p>
                                                                        </div>


                                                                        <div class="col-md-3">
                                                                            <div class="radio-button">
                                                                                <div class="form-check form-check-inline mt-2">
                                                                                    <asp:RadioButton ID="rbSurgeryDateYes" runat="server" class="form-check-label" GroupName="SurgeryTheraphyDate" Text="Yes" />
                                                                                </div>
                                                                                <div class="form-check form-check-inline">
                                                                                    <asp:RadioButton ID="rbSurgeryDateNo" runat="server" class="form-check-label" GroupName="SurgeryTheraphyDate" Text="No" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Discharge/Death Date:</span><br />

                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Online:</span><br />
                                                                            <p style="font-size: 12px;">20/08/2024</p>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Case Sheet:</span><br />
                                                                            <p style="font-size: 12px;">20/08/2024</p>
                                                                        </div>


                                                                        <div class="col-md-3">
                                                                            <div class="radio-button">
                                                                                <div class="form-check form-check-inline mt-2">
                                                                                    <asp:RadioButton ID="rbDischargeDateYes" runat="server" class="form-check-label" GroupName="DischargeDeathDate" Text="Yes" />
                                                                                </div>
                                                                                <div class="form-check form-check-inline">
                                                                                    <asp:RadioButton ID="rbDischargeDateNo" runat="server" class="form-check-label" GroupName="DischargeDeathDate" Text="No" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row align-items-center">
                                                                            <div class="col-auto">
                                                                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">1) Patient/Attendant Signature is Matching across two Forms (Counseling Form and Consent Form):</span><br />
                                                                            </div>
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbPatientSignatureYes" runat="server" class="form-check-label" GroupName="PatientSignature" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbPatientSignatureNo" runat="server" class="form-check-label" GroupName="PatientSignature" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                        <div class="row align-items-center">
                                                                            <div class="col-auto">
                                                                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">2) Reports are Signed by Doctors with Registration Number:</span><br />
                                                                            </div>
                                                                            <div class="col text-right">
                                                                                <div class="form-check form-check-inline mt-2">
                                                                                    <asp:RadioButton ID="rbReportSignedDoctorYes" runat="server" class="form-check-label" GroupName="ReportSignedDoctor" Text="Yes" />
                                                                                </div>
                                                                                <div class="form-check form-check-inline">
                                                                                    <asp:RadioButton ID="rbReportSignedDoctorNo" runat="server" class="form-check-label" GroupName="ReportSignedDoctor" Text="No" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row align-items-center">
                                                                            <div class="col-auto">
                                                                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">3) Dates and Patient Name are Correctly Stated on the Report:</span><br />
                                                                            </div>
                                                                            <div class="col text-right">
                                                                                <div class="form-check form-check-inline mt-2">
                                                                                    <asp:RadioButton ID="rbPatientNameReportYes" runat="server" class="form-check-label" GroupName="PatientNameReport" Text="Yes" />
                                                                                </div>
                                                                                <div class="form-check form-check-inline">
                                                                                    <asp:RadioButton ID="rbPatientNameReportNo" runat="server" class="form-check-label" GroupName="PatientNameReport" Text="No" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
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
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">Final Approved Amount(Rs):<span class="text-danger">*</span>:</span><br />
                                                                            <asp:TextBox runat="server" ID="tbInsuranceApprovedAmt" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4">
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
                                                                                <asp:RadioButton ID="rbDiagnosisSupportedYes" runat="server" class="form-check-label" GroupName="DiagnosisSupported" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbDiagnosisSupportedNo" runat="server" class="form-check-label" GroupName="DiagnosisSupported" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row align-items-center">
                                                                        <div class="col-auto">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">2) Case Management Proven to be done as per the Standard Treatment Protocols</span><span class="text-danger">*</span><br />
                                                                        </div>
                                                                        <div class="col text-right">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbCaseManagementYes" runat="server" class="form-check-label" GroupName="CaseManagement" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbCaseManagementNo" runat="server" class="form-check-label" GroupName="CaseManagement" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row align-items-center">
                                                                        <div class="col-auto">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">3) Evidence of the Therapy being Conducted exists beyond Doubts</span><span class="text-danger">*</span><br />
                                                                        </div>
                                                                        <div class="col text-right">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbEvidenceTherapyYes" runat="server" class="form-check-label" GroupName="EvidenceTherapy" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbEvidenceTherapyNo" runat="server" class="form-check-label" GroupName="EvidenceTherapy" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row align-items-center">
                                                                        <div class="col-auto">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">4) Mandatory Reports are Attached</span><span class="text-danger">*</span><br />
                                                                        </div>
                                                                        <div class="col text-right">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbMandatoryReportsYes" runat="server" class="form-check-label" GroupName="MandatoryReports" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbMandatoryReportsNo" runat="server" class="form-check-label" GroupName="MandatoryReports" Text="No" />
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


                                                        <div class="ibox mt-4">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">ACO Remarks</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <div class="col-lg-12">
                                                                    <div class="form-group row">
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Total Cliam(Rs):</span><br />
                                                                            <label id="lbACOTotalCliam" style="font-size: 12px; margin-top: 5px;">11000</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Insurance Liable Amount(Rs):</span><br />
                                                                            <label id="lbACOInsuranceLiableAmt" style="font-size: 12px; margin-top: 5px;">11000</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Final Approved Amount:</span><br />
                                                                            <label id="lbACOFinalApprovedAmt" style="font-size: 12px; margin-top: 5px;">9900.0</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Remarks:</span><br />
                                                                            <label id="lbACOSpecialCase" style="font-size: 12px; margin-top: 5px;">ACO Forwarded</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>
                                                                        <%--<div class="col-md-12 mt-2">
                                                                    <span class="text-danger">Note: Remarks are mandatory while assigning. Only ()?,./ special characters are allowed for Remarks.</span>
                                                                </div>--%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="ibox mt-4">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">SHA Remarks</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <div class="col-lg-12">
                                                                    <div class="form-group row">
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Insurance Liable Amount(Rs):</span><br />
                                                                            <label id="lbSHAInsuranceLiableAmt" style="font-size: 12px; margin-top: 5px;">11000</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Total Cliam(Rs):</span><br />
                                                                            <label id="lbSHATotalClaim" style="font-size: 12px; margin-top: 5px;">11000</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Final Approved Amount:</span><br />
                                                                            <label id="lbSHAFinalApprovedAmt" style="font-size: 12px; margin-top: 5px;">11000</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Remarks:</span><span class="text-danger">*</span><br />
                                                                            <label id="lbSHARemarks" style="font-size: 12px; margin-top: 5px;">SHA Approved</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>
                                                                        <div class="col-md-12 mt-2">
                                                                            <span class="text-danger">Note: Only ()?,./ special characters are allowed for Remarks.</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="ibox mt-4">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Erroneous Claim Detalis</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <div class="col-lg-12">
                                                                    <div class="form-group row">
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Claim Initiated Amount(Rs):</span><span class="text-danger">*</span><br />
                                                                            <label id="lbClaimInitiatedAmt" style="font-size: 12px; margin-top: 5px;">NA</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Cliam Paid Amount(Rs):</span><span class="text-danger">*</span><br />
                                                                            <label id="lbCliamPaidAmt" style="font-size: 12px; margin-top: 5px;">NA</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Erroneous Amount:</span><span class="text-danger">*</span><br />
                                                                            <label id="lbErroneousAmt" style="font-size: 12px; margin-top: 5px;">NA</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Erroneous Intiated Amount:</span><span class="text-danger">*</span><br />
                                                                            <label id="lbErroneousIntiatedAmt" style="font-size: 12px; margin-top: 5px;">NA</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Erroneous Approved Amount:</span><span class="text-danger">*</span><br />
                                                                            <label id="lbErroneousApprovedAmt" style="font-size: 12px; margin-top: 5px;">NA</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Remarks:</span><span class="text-danger">*</span><br />
                                                                            <label id="lbErroneousRemarks" style="font-size: 12px; margin-top: 5px;">NA</label>
                                                                            <hr style="margin-top: 1px;" />
                                                                        </div>
                                                                        <div class="col-md-12 mt-2">
                                                                            <span class="text-danger">Note: Only ()?,./ special characters are allowed for Remarks.</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="ibox mt-4">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Add Deduction</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <div class="col-lg-12">
                                                                    <div class="form-group row">

                                                                        <div class="col-md-3">
                                                                            <label class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Total Deduction Amount(Rs):</label>
                                                                            <p style="font-size: 12px;">0</p>
                                                                        </div>

                                                                    </div>
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
                                                                    <table class="table table-bordered table-striped">
                                                                        <thead>
                                                                            <tr class="table-primary">
                                                                                <th scope="col" style="background-color: #007e72; color: white;">S.No</th>
                                                                                <th scope="col" style="background-color: #007e72; color: white;">Date and Time</th>
                                                                                <th scope="col" style="background-color: #007e72; color: white;">Name</th>
                                                                                <th scope="col" style="background-color: #007e72; color: white;">Remarks</th>
                                                                                <th scope="col" style="background-color: #007e72; color: white;">Action</th>
                                                                                <th scope="col" style="background-color: #007e72; color: white;">Approved Amount(Rs.)</th>
                                                                                <th scope="col" style="background-color: #007e72; color: white;">Claim Query/Rejection Reason</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <tr>
                                                                                <td>1</td>
                                                                                <td>16-08-2024</td>
                                                                                <td>MEDCO(MEDCO)</td>
                                                                                <td>Patient requires further stay for treatement plesae.</td>
                                                                                <td>Procedure auto approved by insurance(Insurance)</td>
                                                                                <td>2323</td>
                                                                                <td>NA</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>1</td>
                                                                                <td>16-08-2024</td>
                                                                                <td>MEDCO(MEDCO)</td>
                                                                                <td>Patient requires further stay for treatement plesae.</td>
                                                                                <td>Procedure auto approved by insurance(Insurance)</td>
                                                                                <td>2323</td>
                                                                                <td>NA</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>1</td>
                                                                                <td>16-08-2024</td>
                                                                                <td>MEDCO(MEDCO)</td>
                                                                                <td>Patient requires further stay for treatement plesae.</td>
                                                                                <td>Procedure auto approved by insurance(Insurance)</td>
                                                                                <td>2323</td>
                                                                                <td>NA</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>1</td>
                                                                                <td>16-08-2024</td>
                                                                                <td>MEDCO(MEDCO)</td>
                                                                                <td>Patient requires further stay for treatement plesae.</td>
                                                                                <td>Procedure auto approved by insurance(Insurance)</td>
                                                                                <td>2323</td>
                                                                                <td>NA</td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="ibox mt-4">
                                                            <div class="ibox-content">
                                                                <div class="row">
                                                                    <div class="col-md-3">
                                                                        <asp:Label ID="lblActionType" runat="server" CssClass="form-label fw-semibold" Text="Action Type" Style="font-weight: 700;"></asp:Label>
                                                                        <span class="text-danger">*</span>
                                                                        <asp:DropDownList ID="ddlActionType" runat="server" CssClass="form-control" Style="border: none; border-bottom: 1px solid #D3D3D3; border-radius: 0;">
                                                                            <asp:ListItem Text="Select" Value="" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
                                                                            <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                                                                            <asp:ListItem Text="Send To Medical Audit" Value="SendToMedicalAudit"></asp:ListItem>
                                                                            <asp:ListItem Text="Raise Query to HCO" Value="RaiseQueryToHCO"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                                <div class="row mt-3">
                                                                    <div class="form-check">
                                                                        <asp:CheckBox ID="chkAgree" runat="server" CssClass="form-check-input" />
                                                                        <asp:Label ID="lblAgree" runat="server" CssClass="form-check-label" AssociatedControlID="chkAgree" Text="I have reviewed the cases with best of my knowledge and have validated all documents before making any decision"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="row mt-3">
                                                                    <div class="col-lg-12 text-start">
                                                                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary rounded-pill" Text="Submit" />
                                                                        <asp:Label ID="lblMessage" runat="server" CssClass="text-success" Style="margin-left: 10px;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-12 mt-3">
                                                                    <p class="text-danger m-0">Insurance Wallet Amount:  0.00</p>
                                                                    <p class="text-danger m-0">Scheme Wallet Amount:  0.00</p>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                            </asp:View>
                                            <asp:View ID="ViewAttachment" runat="server">
                                                <div class="tab-pane fade" id="attachment" role="tabpanel">
                                                    <ul class="nav nav-tabs d-flex flex-row justify-content-around" id="attachTab" role="tablist">
                                                        <li class="nav-item">
                                                            <a class="nav-link active nav-attach" id="one-tab"
                                                                data-toggle="tab" href="#one" role="tab" aria-controls="one" aria-selected="true">
                                                                <img src="~/images/notes-notepad-svgrepo-com.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="two-tab" data-toggle="tab" href="#two" role="tab" aria-controls="two" aria-selected="false">
                                                                <img src="~/images/bed-svgrepo-com.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="three-tab" data-toggle="tab" href="#three" role="tab" aria-controls="three" aria-selected="false">
                                                                <img src="~/images/foot-svgrepo-com.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="three-tab" data-toggle="tab" href="#four" role="tab" aria-controls="four" aria-selected="false">
                                                                <img src="~/images/rupee-sign-solid-svgrepo-com.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="three-tab" data-toggle="tab" href="#five" role="tab" aria-controls="five" aria-selected="false">
                                                                <img src="~/images/search.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="three-tab" data-toggle="tab" href="#six" role="tab" aria-controls="six" aria-selected="false">
                                                                <img src="~/images/search.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="three-tab" data-toggle="tab" href="#seven" role="tab" aria-controls="seven" aria-selected="false">
                                                                <img src="~/images/notes-tick-svgrepo-com.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="three-tab" data-toggle="tab" href="#eight" role="tab" aria-controls="eight" aria-selected="false">
                                                                <img src="~/images/laptop.svg" width="20" />
                                                            </a>
                                                        </li>
                                                    </ul>

                                                    <div class="col-md-12 p-3">
                                                        <button class="btn btn-success rounded-pill">View All Inactive Attachments</button>
                                                        <button class="btn btn-success rounded-pill">View Data Anamoly Attachments</button>
                                                    </div>

                                                    <div class="tab-content" id="attachTabContent">
                                                        <div class="tab-pane fade show active" id="one" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Preauthorization</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
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
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="two" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Discharge</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
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
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="three" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Death</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
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
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="four" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Claims</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
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
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="five" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">General Investigations</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
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
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="six" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Special Investigations</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
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
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="seven" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Fraud Documents</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
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
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="eight" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Audit Documents</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
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
                                                            </div>
                                                        </div>
                                                        <div class="col-md-12 mt-3">
                                                            <p class="text-danger m-0">Note:</p>
                                                            <p class="text-danger m-0">1. File size should not exceed 500kb.</p>
                                                            <p class="text-danger m-0">2. Attachment names with blue color are related to notification.</p>
                                                            <p class="text-danger m-0">3. Discharge summary document quality and its notation.</p>
                                                            <p class="text-danger m-0">
                                                                4. Document of good quality.
                           
                                        <img src="~/images/file-check.svg" width="20" />
                                                            </p>
                                                            <p class="text-danger m-0">
                                                                4. Document of bad quality.
                           
                                        <img src="~/images/file-error.svg" width="15" />
                                                            </p>
                                                            <p class="text-danger m-0">
                                                                4. Document which is not valid.
                           
                                        <img src="~/images/invalid.svg" width="15" />
                                                            </p>
                                                            <p class="text-danger m-0">
                                                                4. Document of bad quality.
                           
                                        <img src="~/images/error.svg" width="15" />
                                                            </p>
                                                        </div>
                                                        <div class="col-md-12 mt-2 mb-2">
                                                            <button class="btn btn-success rounded-pill" type="button">Download as one PDF<img src="~/images/pdf.svg" width="15" class="ml-2" /></button>
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

