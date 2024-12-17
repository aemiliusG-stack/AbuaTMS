<%@ Page Title="" Language="C#" MasterPageFile="~/PPD/PPD.master" AutoEventWireup="true" CodeFile="PPDCaseDetails.aspx.cs" Inherits="PPD_PPDCaseDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .span-title {
            font-weight: 700;
            font-size: 14px;
        }

        /* Override Bootstrap tab background color */
        .nav-tabs .nav-link {
            background-color: #1ab394;
            color: white; /* White text color for all tabs */
            border: none; /* Remove borders */
        }

            .nav-tabs .nav-link.active {
                background-color: #c9b412; /* Yellow background for the active tab */
                color: black; /* Change text color to black when active */
            }

        .nav-tabs .nav-attach {
            background-color: #e1e1e1;
            color: black !important; /* White text color for all tabs */
            border: none; /* Remove borders */
        }

            .nav-tabs .nav-attach.active {
                background-color: #ff9800;
                color: white !important; /* White text color for all tabs */
                border: none; /* Remove borders */
            }
    </style>
    <script type="text/javascript">
        function showModal() {
            $('#contentModal').modal('hide');
            $('.modal-backdrop').remove();
            $('#contentModal').modal('show');
        }
        function hideModal() {
            $('#contentModal').modal('hide');
            $('.modal-backdrop').remove();
            $('#contentModal').modal('hide');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdAbuaId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPatientRegId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdHospitalId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdCaseId" runat="server" Visible="false" />

            <asp:MultiView ID="MultiViewMain" runat="server">
                <asp:View ID="viewNoContent" runat="server">
                    <section class="d-flex justify-content-center align-items-center bg-white" style="height: 100vh">
                        <div class="container">
                            <div class="row">
                                <div class="col-12">
                                    <div class="text-center">
                                        <h2 class="d-flex justify-content-center align-items-center gap-2 m-0">
                                            <span class="display-1 fw-bold">4</span>
                                            <span class="display-1 fw-bold">0</span>
                                            <span class="display-1 fw-bold">4</span>
                                        </h2>
                                        <h3 class="h2 m-0">No Assigned Cases</h3>
                                        <p class="mb-4">We’re sorry, but there is no assigned cases available at this time.</p>
                                        <asp:LinkButton ID="lnkBackToHome" runat="server" CssClass="btn bsb-btn-5xl btn-primary rounded-pill px-5 fs-6 m-0" OnClientClick="location.href='/PPD/PPDPreauthUpdation.aspx'">New Case</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </asp:View>
                <asp:View ID="viewContent" runat="server">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="ibox-title d-flex justify-content-between align-items-center">
                                <h3 class="text-white">Patient Details</h3>
                                <asp:Label ID="lbCaseNumber" class="text-white" runat="server" Text="Case No: "></asp:Label>
                            </div>
                            <div class="ibox-content">
                                <div class="ibox-content text-dark">
                                    <div class="row">
                                        <div class="col-lg-8">
                                            <div class="form-group row">
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Name:</span><br />
                                                    <asp:Label ID="lbPersonName" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Beneficiary Card ID:</span><br />
                                                    <asp:Label ID="lbBeneficiaryCardId" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Registration No:</span><br />
                                                    <asp:Label ID="lbRegistrationNo" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Case No:</span><br />
                                                    <asp:Label ID="lbCaseNo" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <%--<div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Case Status:</span><br />
                                            <asp:Label ID="lbCaseStatus" runat="server" Text="Procedure Insurance" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">IP No:</span><br />
                                            <asp:Label ID="lbIpNo" runat="server" Text="NA" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">IP Registered Date:</span><br />
                                            <asp:Label ID="lbIpRegisteredDate" runat="server" Text="06/04/2024" Style="font-size: 12px;"></asp:Label>
                                        </div>--%>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Actual Registration Date:</span><br />
                                                    <asp:Label ID="lbActualRegistrationDate" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Contact No:</span><br />
                                                    <asp:Label ID="lbContactNo" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Hospital Type:</span><br />
                                                    <asp:Label ID="lbHospitalType" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Gender:</span><br />
                                                    <asp:Label ID="lbGender" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Family ID:</span><br />
                                                    <asp:Label ID="lbFamilyId" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">New Born Baby Case:</span><br />
                                                    <asp:Label ID="lbIsChild" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Aadhar Verified:</span><br />
                                                    <asp:Label ID="lbAadharVerified" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Biometric Verified:</span><br />
                                                    <asp:Label ID="lbBiometricVerified" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Patient District:</span><br />
                                                    <asp:Label ID="lbPatientDistrict" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Patient Schema:</span><br />
                                                    <asp:Label ID="lbPatientSchema" runat="server" Text="ABUA-JHARKHAND" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label span-title">Age:</span><br />
                                                    <asp:Label ID="lbAge" runat="server" Text="06/04/2024" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <asp:Panel ID="panelChild" runat="server" Visible="false" Style="padding-left: 0px !important; padding-right: 0px !important;">
                                                    <div class="row">
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label span-title">Child Name:</span><br />
                                                            <asp:Label ID="lbChildName" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label span-title">Gender Of Child:</span><br />
                                                            <asp:Label ID="lbChildGender" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label span-title">Child DOB:</span><br />
                                                            <asp:Label ID="lbChildDob" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label span-title">Father Name:</span><br />
                                                            <asp:Label ID="lbFatherName" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label span-title">Mother Name:</span><br />
                                                            <asp:Label ID="lbMotherName" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label span-title">Child Photo/ Document:</span><br />
                                                            <asp:LinkButton ID="lnkChildPhoto" runat="server" OnClick="lnkChildPhoto_Click">View Document</asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="text-center">
                                                <asp:Image ID="imgPatient" runat="server" alt="Patient Photo" class="img-fluid mb-3" Style="max-width: 120px; height: 150px; object-fit: cover;" />
                                                <asp:Image ID="imgChild" runat="server" alt="Patient Photo" class="img-fluid mb-3" Style="max-width: 120px; height: 150px; object-fit: cover;" Visible="false" />
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-12 mt-3">
                            <ul class="nav" id="myTab" role="tablist">
                                <li class="nav-item mr-2 mt-1">
                                    <asp:Button ID="btnPastHistory" runat="server" Text="Past History" CssClass="btn btn-primary p-3" OnClick="btnPastHistory_Click" />
                                </li>
                                <li class="nav-item mr-2 mt-1">
                                    <asp:Button ID="btnPreauth" runat="server" Text="Preauthorization" CssClass="btn btn-primary p-3" OnClick="btnPreauth_Click" />
                                </li>
                                <li class="nav-item mr-2 mt-1">
                                    <asp:Button ID="btnTreatmentDischarge" runat="server" Text="Treatment/ Discharge" CssClass="btn btn-primary p-3" OnClick="btnTreatmentDischarge_Click" />
                                </li>
                                <li class="nav-item mt-1">
                                    <asp:Button ID="btnAttachmanet" runat="server" Text="Attachment" CssClass="btn btn-primary p-3" OnClick="btnAttachmanet_Click" />
                                </li>
                            </ul>
                        </div>
                        <div class="col-lg-12 mt-3">
                            <asp:MultiView ID="MultiView1" runat="server">
                                <asp:View ID="viewPastHistory" runat="server">
                                    <div class="tab-pane fade show active" id="past" role="tabpanel">
                                        <div class="ibox-title text-center">
                                            <h3 class="text-white">Past History</h3>
                                        </div>
                                        <div class="ibox-content">
                                            <div class="ibox">
                                                <div class="ibox-content text-dark">
                                                    <div class="row align-items-end">
                                                        <div class="col-md-3 mb-2">
                                                            <span class="form-label fw-semibold">Case ID</span>
                                                            <asp:TextBox runat="server" ID="tbCaseId" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-2">
                                                            <span class="form-label fw-semibold">From Date</span>
                                                            <asp:TextBox ID="tbFromDate" runat="server" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-2">
                                                            <span class="form-label fw-semibold">To Date</span>
                                                            <asp:TextBox ID="tbToDate" runat="server" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <asp:Button runat="server" ID="btnSearch" class="btn btn-primary rounded-pill mt-2" Text="Search" />
                                                            <asp:Button runat="server" ID="btnReset" class="btn btn-warning rounded-pill mt-2" Text="Reset" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="ibox-content table-responsive">
                                                <table class="table table-bordered table-striped">
                                                    <thead>
                                                        <tr class="table-primary">
                                                            <th scope="col" style="background-color: #007e72; color: white;">S.No</th>
                                                            <th scope="col" style="background-color: #007e72; color: white;">Case Id</th>
                                                            <th scope="col" style="background-color: #007e72; color: white;">Patient Name</th>
                                                            <th scope="col" style="background-color: #007e72; color: white;">Hospital Name</th>
                                                            <th scope="col" style="background-color: #007e72; color: white;">Case Status</th>
                                                            <th scope="col" style="background-color: #007e72; color: white;">Registered Date</th>
                                                            <th scope="col" style="background-color: #007e72; color: white;">Preauth Amount</th>
                                                            <th scope="col" style="background-color: #007e72; color: white;">Claim Amount</th>
                                                            <th scope="col" style="background-color: #007e72; color: white;">Procedure</th>
                                                            <th scope="col" style="background-color: #007e72; color: white;">Admission Date</th>
                                                            <th scope="col" style="background-color: #007e72; color: white;">Preauth Initiation Date</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <th scope="row">1</th>
                                                            <td><a href="#" class="text-decoration-underline text-black fw-semibold">CASE/PS7/HOSP20G12238/P2897102</a></td>
                                                            <td>Demo User</td>
                                                            <td>Demo Hospital</td>
                                                            <td>Claim Forwarded by CEX(Insurance)</td>
                                                            <td>16-08-2024</td>
                                                            <td>0.00</td>
                                                            <td>NA</td>
                                                            <td>High end radiological diagnostic (CT, MRI, Imaging including nuclear imaging)(MG075A)
                                                            </td>
                                                            <td>16-08-2024</td>
                                                            <td>16-08-2024</td>
                                                        </tr>
                                                    </tbody>
                                                </table>

                                                <%--<asp:GridView ID="gridPastHistory" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                            <alternatingrowstyle backcolor="Gainsboro" />
                                            <columns>
                                                <asp:TemplateField HeaderText="Sl No.">
                                                    <itemtemplate>
                                                        <asp:Label ID="lbSlNo" runat="server" Text="1"></asp:Label>
                                                    </itemtemplate>
                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Case Id">
                                                    <itemtemplate>
                                                        <asp:LinkButton ID="lnkCaseId" runat="server">CASE/00001</asp:LinkButton>
                                                    </itemtemplate>
                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Patient Name">
                                                    <itemtemplate>
                                                        <asp:Label ID="lbPatientName" runat="server" Text="Demo Name"></asp:Label>
                                                    </itemtemplate>
                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Hospital Name">
                                                    <itemtemplate>
                                                        <asp:Label ID="lbHospitalName" runat="server" Text="Demo Hospital"></asp:Label>
                                                    </itemtemplate>
                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Case Status">
                                                    <itemtemplate>
                                                        <asp:Label ID="lbCaseStat" runat="server" Text="Claim Forwarded by CEX(Insurance)"></asp:Label>
                                                    </itemtemplate>
                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Registered Date">
                                                    <itemtemplate>
                                                        <asp:Label ID="lbRegisteredDate" runat="server" Text="16-08-2024"></asp:Label>
                                                    </itemtemplate>
                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Preauth Amount">
                                                    <itemtemplate>
                                                        <asp:Label ID="lbPreauthAmount" runat="server" Text="0.00"></asp:Label>
                                                    </itemtemplate>
                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="15%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Claim Amount">
                                                    <itemtemplate>
                                                        <asp:Label ID="lbClaimAmount" runat="server" Text="0.00"></asp:Label>
                                                    </itemtemplate>
                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Procedure">
                                                    <itemtemplate>
                                                        <asp:Label ID="lbProcedure" runat="server" Text="High end radiological"></asp:Label>
                                                    </itemtemplate>
                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Admission Date">
                                                    <itemtemplate>
                                                        <asp:Label ID="lbAdmissionDate" runat="server" Text="16-08-2024"></asp:Label>
                                                    </itemtemplate>
                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Preauth Initiation Date">
                                                    <itemtemplate>
                                                        <asp:Label ID="lbPreauthInitiateDate" runat="server" Text="16-08-2024"></asp:Label>
                                                    </itemtemplate>
                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                </asp:TemplateField>
                                            </columns>
                                        </asp:GridView>--%>
                                            </div>
                                        </div>
                                    </div>
                                </asp:View>
                                <asp:View ID="viewPreauth" runat="server">
                                    <div class="tab-pane fade show active" id="preauth" role="tabpanel">
                                        <div class="ibox">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Network Hospital Details</h3>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="ibox-content text-dark">
                                                    <div class="row">
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold">Hospital Name<span class="text-danger">*</span></span>
                                                            <asp:TextBox runat="server" ID="tbHospitalName" class="form-control mt-2" Text="Demo Hospital" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold">Hospital Type<span class="text-danger">*</span></span>
                                                            <asp:TextBox runat="server" ID="tbHospitalType" class="form-control mt-2" Text="Private" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold">Hospital Address<span class="text-danger">*</span></span>
                                                            <asp:TextBox runat="server" ID="tbHospitalAddress" class="form-control mt-2" Text="Ranchi, Jharkhand" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Diagnosis and Treatement</h3>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="ibox-content text-dark">
                                                    <div class="row">
                                                        <div class="col-md-3 mb-3">
                                                            <sapn class="form-label fw-semibold">Primary Diagnosis<span class="text-danger">*</span></sapn>
                                                            <asp:DropDownList ID="dropPrimaryDiagnosis" AutoPostBack="true" runat="server" CssClass="form-control" Enabled="false">
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Secondary Diagnosis<span class="text-danger">*</span></span>
                                                            <asp:DropDownList ID="dropSecondaryDiagnosis" AutoPostBack="true" runat="server" CssClass="form-control" Enabled="false">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-md-6 table-responsive">
                                                            <asp:GridView ID="gridPrimaryDiagnosis" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sl No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbPPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="0%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Diagnosis Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Acted By Role">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbActedBy" runat="server" Text='<%# getRegisteredByText(Eval("RegisteredBy")) %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-center">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkDeletePrimaryDiagnosis" runat="server" CssClass="text-danger">Remove</asp:LinkButton>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>

                                                        <div class="col-md-6 table-responsive">
                                                            <asp:GridView ID="gridSecondaryDiagnosis" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                                <AlternatingRowStyle BackColor="Gainsboro" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sl No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbSPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="0%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Diagnosis Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Acted By Role">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbActedBy" runat="server" Text='<%# getRegisteredByText(Eval("RegisteredBy")) %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-center">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkDeleteSecondaryDiagnosis" runat="server" CssClass="text-danger">Remove</asp:LinkButton>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>

                                                        <div class="col-md-12">
                                                            <span class="text-danger"><span class="font-weight-bold">Note:</span> User can select multiple options in Primary and Secondary diagnosis fields.</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Primary Diagnosis ICD Values</h3>
                                            </div>
                                            <div class="ibox-content table-responsive">
                                                <asp:GridView ID="gridPrimaryDiagnosisValues" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Sl No.">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbPPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="0%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ICD Value">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIcd" runat="server" Text='<%# Eval("ICDValue") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Diagnosis Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Acted By Role">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbActedBy" runat="server" Text='<%# getRegisteredByText(Eval("RegisteredBy")) %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>

                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Secondary Diagnosis ICD Values</h3>
                                            </div>
                                            <div class="ibox-content table-responsive">
                                                <asp:GridView ID="gridSecondaryDiagnosisValues" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                    <AlternatingRowStyle BackColor="Gainsboro" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Sl No.">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbSPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="0%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ICD Value">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIcd" runat="server" Text='<%# Eval("ICDValue") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Diagnosis Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Acted By Role">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbActedBy" runat="server" Text='<%# getRegisteredByText(Eval("RegisteredBy")) %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>

                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Treatement Protocol</h3>
                                            </div>
                                            <div class="ibox-content table-responsive">
                                                <asp:GridView ID="gridTreatementProtocol" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                    <RowStyle BackColor="White" Height="20px" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Sl. No.">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Speciality Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbAddedSpeciality" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Procedure Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbAddedProcedure" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Procedure Cost">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbAddedAmount" runat="server" Text='<%# Eval("ProcedureAmountFinal") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Stratification Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbAddedStratification" runat="server" Text='<%# Eval("StratificationName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Implant Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbAddedImplants" runat="server" Text='<%# Eval("ImplantName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Implant Quantity">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbAddedQuantity" runat="server" Text='<%# Eval("ImplantCount") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Implant Cost">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbImplantAmount" runat="server" Text='<%# Eval("ImplantAmount") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Total Cost">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbAddedAmount" runat="server" Text='<%# Eval("TotalPackageCost") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>

                                        <%--<div class="ibox mt-4">
                                    <div class="ibox-title text-center">
                                        <h3 class="text-white">ICHI Details</h3>
                                    </div>
                                    <div class="ibox-content table-responsive">
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr class="table-primary">
                                                    <th scope="col" style="background-color: #007e72; color: white;">Procedure Name</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">ICHI code given by MEDCO</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">ICHI code given by PPD Insurer</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">ICHI code given by CPD Insurer</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">ICHI code given by SAFO</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">ICHI code given by NAFO</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>NA</td>
                                                    <td>NA</td>
                                                    <td>NA</td>
                                                    <td>NA</td>
                                                    <td>NA</td>
                                                    <td>NA</td>
                                                </tr>
                                            </tbody>
                                        </table>

                                        <asp:GridView ID="gridIchiDetails" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                            <AlternatingRowStyle BackColor="Gainsboro" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Procedure Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbProcedureName" runat="server" Text="Procedure Name"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ICHI code given by MEDCO">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbIchiCodeMedco" runat="server" Text="ICHI code given by MEDCO"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ICHI code given by PPD Insurer">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbIchiCodePpd" runat="server" Text="Quantity"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ICHI code given by CPD Insurer">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbIchiCodeCpd" runat="server" Text="0.00"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ICHI code given by SAFO">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbIchiCodeSafo" runat="server" Text="ICHI code given by SAFO"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ICHI code given by NAFO">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbIchiCodeNafo" runat="server" Text="ICHI code given by NAFO"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>--%>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Admission Details</h3>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="row">
                                                    <div class="col-md-4 mb-3">
                                                        <span class="form-label fw-semibold">Admission Type<span class="text-danger">*</span></span><br />
                                                        <div class="form-check form-check-inline mt-2">
                                                            <asp:RadioButton ID="rbPlanned" runat="server" class="form-check-label" GroupName="AdmissionType" Text="&nbsp;&nbsp;Planned" Enabled="false" />
                                                            &nbsp;&nbsp;
                                                    <asp:RadioButton ID="rbEmergency" runat="server" class="form-check-label" GroupName="AdmissionType" Text="&nbsp;&nbsp;Emergency" Enabled="false" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 mb-3">
                                                        <span class="form-label fw-semibold">Admission Date<span class="text-danger">*</span></span>
                                                        <asp:TextBox runat="server" ReadOnly="true" ID="tbAdmissionDate" class="form-control mt-2"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-4 mb-3"></div>
                                                    <div class="col-md-4 mb-3">
                                                        <span class="form-label fw-semibold">Package Cost<span class="text-danger">*</span></span>
                                                    </div>
                                                    <div class="col-md-4 mb-3">
                                                        <div class="input-group">
                                                            <div class="input-group-text">
                                                                <img src="../images/rupee.svg" />
                                                            </div>
                                                            <asp:TextBox runat="server" ReadOnly="true" OnKeypress="return isNumeric(event)" ID="tbPackageCost" class="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 mb-3"></div>
                                                    <div class="col-md-4 mb-3">
                                                        <span class="form-label fw-semibold">Incentive Cost<span class="text-danger">*</span></span>
                                                    </div>
                                                    <div class="col-md-4 mb-3">
                                                        <div class="input-group">
                                                            <div class="input-group-text">
                                                                <img src="../images/rupee.svg" />
                                                            </div>
                                                            <asp:TextBox runat="server" ReadOnly="true" OnKeypress="return isNumeric(event)" ID="tbIncentiveCost" class="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 mb-3"></div>
                                                    <asp:Panel ID="panelImplant" runat="server" CssClass="row p-0" Visible="true">
                                                        <div class="col-md-4 mb-3">
                                                            <span class="form-label fw-semibold">Implant Cost<span class="text-danger">*</span></span>
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <div class="input-group">
                                                                <div class="input-group-text">
                                                                    <img src="../images/rupee.svg" />
                                                                </div>
                                                                <asp:TextBox runat="server" ReadOnly="true" OnKeypress="return isNumeric(event)" ID="tbImplantCost" class="form-control"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4 mb-3"></div>
                                                    </asp:Panel>
                                                    <div class="col-md-4 mb-3">
                                                        <span class="form-label fw-semibold">Total Package Cost<span class="text-danger">*</span></span><br />
                                                        <span class="text-danger"><span class="font-weight-bold">(Note:</span> Incentive Applicable)</span>
                                                    </div>
                                                    <div class="col-md-4 mb-3">
                                                        <div class="input-group">
                                                            <div class="input-group-text">
                                                                <img src="../images/rupee.svg" />
                                                            </div>
                                                            <asp:TextBox runat="server" ReadOnly="true" OnKeypress="return isNumeric(event)" ID="tbTotalPackageCost" class="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 mb-3 align-content-center">
                                                        <span class="text-black"><span class="font-weight-bold">Hospital Incentive: </span>
                                                            <asp:Label ID="lbIncentivePercentage" runat="server" Text="0.00%"></asp:Label>
                                                        </span>
                                                    </div>
                                                    <div class="col-md-4 mb-3">
                                                        <span class="form-label fw-semibold">
                                                            <asp:Label ID="lbRoleStatus" runat="server" Text="The amount liable is"></asp:Label>
                                                            <span class="text-danger">*</span>
                                                        </span>
                                                    </div>
                                                    <div class="col-md-4 mb-3">
                                                        <div class="input-group">
                                                            <div class="input-group-text">
                                                                <img src="../images/rupee.svg" />
                                                            </div>
                                                            <asp:TextBox runat="server" ReadOnly="true" OnKeypress="return isNumeric(event)" ID="tbAmountLiable" class="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 mb-3"></div>
                                                    <div class="col-md-12">
                                                        <span class="form-label fw-semibold">Remarks</span><br />
                                                        <asp:TextBox runat="server" ReadOnly="true" OnKeypress="return isAlphaNumeric(event)" ID="tbRemarks" class="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-12 mt-2">
                                                        <span class="text-danger"><span class="font-weight-bold">Note:</span> Only ()?,./ special characters are allowed for Remarks and remarks are mandatory while assigning.</span>
                                                    </div>
                                                    <div class="col-lg-12 mt-4">
                                                        <asp:Button ID="btnTransactionDataReferences" runat="server" class="btn btn-primary rounded-pill" Text="Transaction Data References" OnClick="btnTransactionDataReferences_Click" />
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Work Flow</h3>
                                            </div>
                                            <div class="ibox-content table-responsive">
                                                <asp:GridView ID="gridWorkFlow" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                    <AlternatingRowStyle BackColor="Gainsboro" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Sl No.">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Date and Time">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbDateTime" runat="server" Text='<%# Eval("ActionDate") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Role">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbRole" runat="server" Text='<%# Eval("Role") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Remarks">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Action">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbAction" runat="server" Text='<%# Eval("Action") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Amount(Rs.)">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbAmount" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Preauth Query/ Rejection Reason">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbPreauthQueryRejection" runat="server" Text='<%# Eval("RejectionReason") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Preauth Query/ Rejection Reason</h3>
                                            </div>
                                            <div class="ibox-content table-responsive">
                                                <asp:GridView ID="gridPreauthQueryRejectionReason" runat="server" AutoGenerateColumns="false" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                    <AlternatingRowStyle BackColor="gainsboro" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Sl. No.">
                                                            <ItemTemplate>
                                                                <asp:Label ID="label1" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1e8c86" Font-Bold="true" ForeColor="white" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="middle" Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Query Date">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbquerydate" runat="server" Text='<%# Eval("QueryRaisedDate") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1e8c86" Font-Bold="true" ForeColor="white" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="middle" Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Main Reason">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbmainreason" runat="server" Text='<%# Eval("ReasonName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1e8c86" Font-Bold="true" ForeColor="white" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="middle" Width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Sub Reason">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbsubreason" runat="server" Text='<%# Eval("SubReasonName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1e8c86" Font-Bold="true" ForeColor="white" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="middle" Width="30%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PPD Query">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbppdquery" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1e8c86" Font-Bold="true" ForeColor="white" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="middle" Width="25%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Audit">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnviewaudit" runat="server" Text="Pending" class="btn btn-warning btn-sm rounded-pill" Style="font-size: 12px;" />
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1e8c86" Font-Bold="true" ForeColor="white" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="middle" Width="10%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-content">
                                                <div class="row">
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Action Taken</span>
                                                        <asp:TextBox runat="server" ID="tbAction" CssClass="form-control mt-2" Enabled="false"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-md-12 mt-3">
                                                    <asp:Label ID="lbInsuranceWalletAmount" class="text-danger m-0" runat="server" Text="Insurance Wallet Amount:  0.00"></asp:Label>
                                                    <br />
                                                    <asp:Label ID="lbSchemeWalletAmount" class="text-danger m-0" runat="server" Text="Scheme Wallet Amount:  0.00"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </asp:View>
                                <asp:View ID="viewTreatmentDischarge" runat="server">
                                    <div class="tab-pane fade show active" id="treatement" role="tabpanel">
                                        <div class="ibox">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Surgeon Details</h3>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="ibox-content text-dark">
                                                    <div class="row">
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Doctor Type<span class="text-danger">*</span></span>
                                                            <asp:TextBox runat="server" ID="TextBox1" class="form-control mt-2" Text="Specialist" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Name<span class="text-danger">*</span></span>
                                                            <asp:TextBox runat="server" ID="TextBox2" class="form-control mt-2" Text="Demo Doctor" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Registration No<span class="text-danger">*</span></span>
                                                            <asp:TextBox runat="server" ID="TextBox3" class="form-control mt-2" Text="DCM/R/0087" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Qualification<span class="text-danger">*</span></span>
                                                            <asp:TextBox runat="server" ID="TextBox4" class="form-control mt-2" Text="MS (Master Of Surgery)" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Contact No<span class="text-danger">*</span></span>
                                                            <asp:TextBox runat="server" ID="TextBox5" class="form-control mt-2" Text="9999999999" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Anaethetist Details</h3>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="ibox-content text-dark">
                                                    <div class="row">
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Anaethetist Name</span>
                                                            <asp:TextBox runat="server" ID="TextBox6" class="form-control mt-2" Text="Specialist" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Registration No</span>
                                                            <asp:TextBox runat="server" ID="TextBox8" class="form-control mt-2" Text="DCM/R/0087" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Contact No</span>
                                                            <asp:TextBox runat="server" ID="TextBox10" class="form-control mt-2" Text="9999999999" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Anaethetist Type</span>
                                                            <asp:TextBox runat="server" ID="TextBox7" class="form-control mt-2" Text="Anaethetist" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Procedure Details</h3>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="ibox-content text-dark">
                                                    <div class="row">
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Incision Type</span>
                                                            <asp:TextBox runat="server" ID="TextBox9" class="form-control mt-2" Text="Specialist" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">OP Photos/WebEx Taken</span><br />
                                                            <div class="form-check form-check-inline mt-2">
                                                                <asp:RadioButton Checked="true" ID="RadioButton1" runat="server" class="form-check-label" GroupName="OpPhotos" Text="&nbsp;&nbsp;Yes" Enabled="false" />
                                                                <asp:RadioButton ID="RadioButton2" runat="server" class="form-check-label" GroupName="OpPhotos" Text="&nbsp;&nbsp;No" Enabled="false" Style="margin-left: 16px;" />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">View Recording Done</span><br />
                                                            <div class="form-check form-check-inline mt-2">
                                                                <asp:RadioButton ID="RadioButton3" runat="server" class="form-check-label" GroupName="VideoRecording" Text="&nbsp;&nbsp;Yes" Enabled="false" />
                                                                <asp:RadioButton ID="RadioButton4" Checked="true" runat="server" class="form-check-label" GroupName="VideoRecording" Text="&nbsp;&nbsp;No" Enabled="false" Style="margin-left: 16px;" />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Swab Count Instruments Count</span>
                                                            <asp:TextBox runat="server" ID="TextBox13" class="form-control mt-2" Text="Anaethetist" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Sutures Ligature</span>
                                                            <asp:TextBox runat="server" ID="TextBox14" class="form-control mt-2" Text="Specialist" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Specimen Removed</span><br />
                                                            <div class="form-check form-check-inline mt-2">
                                                                <asp:RadioButton Enabled="false" ID="RadioButton5" runat="server" class="form-check-label" GroupName="Specimen" Text="&nbsp;&nbsp;Yes" />
                                                                <asp:RadioButton Enabled="false" ID="RadioButton6" Checked="true" runat="server" class="form-check-label" GroupName="Specimen" Text="&nbsp;&nbsp;No" Style="margin-left: 16px;" />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Drainage Count</span>
                                                            <asp:TextBox runat="server" ID="TextBox16" class="form-control mt-2" Text="9999999999" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Blood Loss</span>
                                                            <asp:TextBox runat="server" ID="TextBox17" class="form-control mt-2" Text="Anaethetist" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Post Operative Instructions</span>
                                                            <asp:TextBox runat="server" ID="TextBox18" class="form-control mt-2" Text="Specialist" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Patient Condition</span>
                                                            <asp:TextBox runat="server" ID="TextBox19" class="form-control mt-2" Text="DCM/R/0087" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Complication If Any</span><br />
                                                            <div class="form-check form-check-inline mt-2">
                                                                <asp:RadioButton Enabled="false" ID="RadioButton7" Checked="true" runat="server" class="form-check-label" GroupName="Complication" Text="&nbsp;&nbsp;Yes" />
                                                                <asp:RadioButton Enabled="false" ID="RadioButton8" runat="server" class="form-check-label" GroupName="Complication" Text="&nbsp;&nbsp;No" Style="margin-left: 16px;" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Treatement/ Surgery Date</h3>
                                            </div>
                                            <div class="ibox-content text-dark">
                                                <div class="row">
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Treatement/ Surgery Date</span>
                                                        <asp:TextBox runat="server" ID="TextBox11" class="form-control mt-2" Text="06/09/2024" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Surgery Start Time</span>
                                                        <asp:TextBox runat="server" ID="TextBox12" class="form-control mt-2" Text="08:30 PM" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Surgery End Time</span>
                                                        <asp:TextBox runat="server" ID="TextBox15" class="form-control mt-2" Text="10:30 PM" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Surgery/ Treatement Start Date Details</h3>
                                            </div>
                                            <div class="ibox-content table-responsive">
                                                <table class="table table-bordered table-striped">
                                                    <thead>
                                                        <tr class="table-primary">
                                                            <th scope="col" style="background-color: #007e72; color: white;" class="col-1">Procedure Code</th>
                                                            <th scope="col" style="background-color: #007e72; color: white;" class="col-2">Procedure Name</th>
                                                            <th scope="col" style="background-color: #007e72; color: white;" class="col-1">Surgery Date/ Treatement Start Date</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td class="align-middle">SN003A</td>
                                                            <td class="align-middle">Spine Deformity Correction</td>
                                                            <td class="align-middle">
                                                                <asp:Label runat="server" ID="Label2" class="form-control" Text="06/09/2024" Style="background-color: white; border: 1px solid slategray; border-radius: 2px;"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="align-middle">
                                                            <td class="align-middle">SN003A</td>
                                                            <td class="align-middle">Spine Deformity Correction</td>
                                                            <td class="align-middle">
                                                                <asp:Label runat="server" ID="TextBox21" class="form-control" Text="06/09/2024" Style="background-color: white; border: 1px solid slategray; border-radius: 2px;"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <%--<asp:GridView ID="gridTreatementDetails" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                        <alternatingrowstyle backcolor="Gainsboro" />
                        <columns>
                            <asp:TemplateField HeaderText="Procedure Code">
                                <itemtemplate>
                                    <asp:Label ID="lbProcedureCode" runat="server" Text="Procedure Code"></asp:Label>
                                </itemtemplate>
                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Procedure Name">
                                <itemtemplate>
                                    <asp:Label ID="lbProcedureName" runat="server" Text="Procedure Name"></asp:Label>
                                </itemtemplate>
                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Surgery Date/ Treatement Start Date">
                                <itemtemplate>
                                     <asp:Label runat="server" ID="lbTreatementDate" class="form-control" Text="06/09/2024" Style="background-color: white; border: 1px solid slategray; border-radius: 2px;"></asp:Label>
                                </itemtemplate>
                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                            </asp:TemplateField>
                        </columns>
                    </asp:GridView>--%>
                                                <span class="text-black"><span class="font-weight-bold text-danger">Note:</span> Please select treatement date for medical procedures and surgery date for surgical procedures.</span>
                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Treatement Summary</h3>
                                            </div>
                                            <div class="ibox-content text-dark">
                                                <div class="row">
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Treatement Given</span>
                                                        <asp:TextBox runat="server" ID="TextBox20" class="form-control mt-2" Text="06/09/2024" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Operative Finding</span>
                                                        <asp:TextBox runat="server" ID="TextBox22" class="form-control mt-2" Text="08:30 PM" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Post Operative Period</span>
                                                        <asp:TextBox runat="server" ID="TextBox23" class="form-control mt-2" Text="10:30 PM" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Post Surgery/ Therapy Given</span>
                                                        <asp:TextBox runat="server" ID="TextBox24" class="form-control mt-2" Text="10:30 PM" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Status at the time of Discharge</span>
                                                        <asp:TextBox runat="server" ID="TextBox25" class="form-control mt-2" Text="06/09/2024" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Review</span>
                                                        <asp:TextBox runat="server" ID="TextBox26" class="form-control mt-2" Text="08:30 PM" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Advice</span>
                                                        <asp:TextBox runat="server" ID="TextBox27" class="form-control mt-2" Text="10:30 PM" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <br />
                                                        <div class="form-check form-check-inline mt-2">
                                                            <asp:RadioButton Checked="true" ID="RadioButton9" runat="server" class="form-check-label" GroupName="OpPhotos" Text="&nbsp;&nbsp;Discharge" Enabled="false" />
                                                            <asp:RadioButton ID="RadioButton10" runat="server" class="form-check-label" GroupName="OpPhotos" Text="&nbsp;&nbsp;Death" Enabled="false" Style="margin-left: 16px; color: red; font-weight: 600;" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Discharge</h3>
                                            </div>
                                            <div class="ibox-content text-dark">
                                                <div class="row">
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Discharge Date<span class="text-danger">*</span></span>
                                                        <asp:TextBox runat="server" ID="TextBox28" class="form-control mt-2" Text="06/09/2024" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Next Follow Up Date<span class="text-danger">*</span></span>
                                                        <asp:TextBox runat="server" ID="TextBox29" class="form-control mt-2" Text="08:30 PM" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Consult at block name</span>
                                                        <asp:TextBox runat="server" ID="TextBox30" class="form-control mt-2" Text="10:30 PM" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Floor</span>
                                                        <asp:TextBox runat="server" ID="TextBox31" class="form-control mt-2" Text="10:30 PM" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Room No</span>
                                                        <asp:TextBox runat="server" ID="TextBox32" class="form-control mt-2" Text="06/09/2024" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Is Special Case<span class="text-danger">*</span></span>
                                                        <asp:TextBox runat="server" ID="TextBox33" class="form-control mt-2" Text="08:30 PM" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Final Diagnosis</span>
                                                        <asp:TextBox runat="server" ID="TextBox34" class="form-control mt-2" Text="10:30 PM" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span>Procedure Consent<span class="text-danger">*</span></span><br />
                                                        <div class="form-check form-check-inline mt-2">
                                                            <asp:RadioButton Checked="true" ID="RadioButton11" runat="server" class="form-check-label" GroupName="OpPhotos" Text="&nbsp;&nbsp;Yes" Enabled="false" />
                                                            <asp:RadioButton ID="RadioButton12" runat="server" class="form-check-label" GroupName="OpPhotos" Text="&nbsp;&nbsp;No" Enabled="false" Style="margin-left: 16px;" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </asp:View>
                                <asp:View ID="viewAttachment" runat="server">
                                    <div class="tab-pane fade show active" id="attachment" role="tabpanel">
                                        <ul class="nav nav-tabs d-flex flex-row" id="attachTab" role="tablist">
                                            <li class="nav-item mr-2 mt-1" id="preAuth">
                                                <asp:LinkButton ID="lnkPreauthorization" runat="server" CssClass="nav-link active nav-attach" OnClick="lnkPreauthorization_Click">Preauthorization</asp:LinkButton>
                                            </li>
                                            <li class="nav-item mr-2 mt-1" id="specialInvestigation">
                                                <asp:LinkButton ID="lnkSpecialInvestigation" runat="server" CssClass="nav-link nav-attach" OnClick="lnkSpecialInvestigation_Click">Special Investigation</asp:LinkButton>
                                            </li>
                                            <li class="nav-item mr-2 mt-1" id="discharge">
                                                <asp:LinkButton ID="lnkDischarge" runat="server" CssClass="nav-link nav-attach" OnClick="lnkDischarge_Click">Discharge Document</asp:LinkButton>
                                            </li>
                                        </ul>

                                        <div class="tab-content" id="attachTabContent">
                                            <asp:MultiView ID="MultiView2" runat="server" ActiveViewIndex="0">
                                                <asp:View ID="viewPreauthorization" runat="server">
                                                    <div class="tab-pane fade show active" role="tabpanel">
                                                        <div class="ibox-title text-center">
                                                            <h3 class="text-white">Preauthorization</h3>
                                                        </div>
                                                        <div class="ibox-content table-responsive">
                                                            <asp:GridView ID="gridManditoryDocument" runat="server" OnRowDataBound="gridManditoryDocument_RowDataBound" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                                <AlternatingRowStyle BackColor="Gainsboro" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sl. No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="Label3" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Uploaded Date">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbUploadedOn" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Document Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbDocumentName" runat="server" Text='<%# Eval("DocumentName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Patient Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbPatientName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Hospital Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbHospital" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Hospital Address">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbHospitalAddress" runat="server" Text='<%# Eval("HospitalAddress") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Card Number">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbCardNumber" runat="server" Text='<%# Eval("CardNumber") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Investigation Stage">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbDocumentFor" runat="server" Text='<%# Eval("DocumentFor") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Uploaded Documents">
                                                                        <ItemTemplate>
                                                                            <asp:Label Visible="false" ID="lbFolder" runat="server" Text='<%# Eval("FolderName") %>'></asp:Label>
                                                                            <asp:Label Visible="false" ID="lbUploadedFileName" runat="server" Text='<%# Eval("UploadedFileName") %>'></asp:Label>
                                                                            <asp:Button ID="btnViewMandateDocument" runat="server" Text="View Document" class="btn btn-success btn-sm rounded-pill" Style="font-size: 12px;" OnClick="btnViewMandateDocument_Click" />
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:Panel ID="panelNoManditoryDocument" runat="server" Visible="false">
                                                                <div class="row ibox-content" style="background-color: #f0f0f0;">
                                                                    <div class="col-md-12 d-flex flex-column justify-content-center align-items-center" style="height: 200px;">
                                                                        <img src="../images/search.svg" />
                                                                        <span class="fs-6 mt-2">No Record Found</span>
                                                                        <span class="text-body-tertiary">Currently, no document available at this moment.</span>
                                                                    </div>
                                                                </div>
                                                            </asp:Panel>
                                                        </div>
                                                    </div>
                                                </asp:View>
                                                <asp:View ID="viewSpecialInvestigation" runat="server">
                                                    <div class="tab-pane fade show active" role="tabpanel">
                                                        <div class="ibox-title text-center">
                                                            <h3 class="text-white">Special Investigations</h3>
                                                        </div>
                                                        <div class="ibox-content table-responsive">
                                                            <asp:GridView ID="gridSpecialInvestigation" runat="server" OnRowDataBound="gridSpecialInvestigation_RowDataBound" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                                <AlternatingRowStyle BackColor="Gainsboro" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sl. No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="Label2" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Uploaded Date">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbCreatedOn" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Hospital Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Speciality Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbPackageName" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure Code">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbProcedureCode" runat="server" Text='<%# Eval("ProcedureCode") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbProcedureName" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="25%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Investigation Code">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbInvestigationCode" runat="server" Text='<%# Eval("InvestigationCode") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Investigation Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbInvestigationName" runat="server" Text='<%# Eval("InvestigationName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Investigation Stage">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbInvestigationStage" runat="server" Text='<%# Eval("InvestigationStage") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Uploaded Documents">
                                                                        <ItemTemplate>
                                                                            <asp:Label Visible="false" ID="lbFolderName" runat="server" Text='<%# Eval("FolderName") %>'></asp:Label>
                                                                            <asp:Label Visible="false" ID="lbFileName" runat="server" Text='<%# Eval("UploadedFileName") %>'></asp:Label>
                                                                            <asp:Button ID="btnViewDocument" runat="server" Text="View Document" class="btn btn-success btn-sm rounded-pill" Style="font-size: 12px;" OnClick="btnViewDocument_Click" />
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:Panel ID="panelNoSpecialInvestigation" runat="server" Visible="false">
                                                                <div class="row ibox-content" style="background-color: #f0f0f0;">
                                                                    <div class="col-md-12 d-flex flex-column justify-content-center align-items-center" style="height: 200px;">
                                                                        <img src="../images/search.svg" />
                                                                        <span class="fs-6 mt-2">No Record Found</span>
                                                                        <span class="text-body-tertiary">Currently, no document available at this moment.</span>
                                                                    </div>
                                                                </div>
                                                            </asp:Panel>
                                                        </div>
                                                    </div>
                                                </asp:View>
                                                <asp:View ID="viewDischarge" runat="server">
                                                    <div class="tab-pane fade show active" role="tabpanel">
                                                        <div class="ibox-title text-center">
                                                            <h3 class="text-white">Discharge Document</h3>
                                                        </div>
                                                        <div class="ibox-content table-responsive">
                                                            <%--<asp:GridView ID="GridView1" runat="server" OnRowDataBound="gridSpecialInvestigation_RowDataBound" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                                <alternatingrowstyle backcolor="Gainsboro" />
                                                                <columns>
                                                                    <asp:TemplateField HeaderText="Sl. No.">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="Label4" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Uploaded Date">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Hospital Name">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Speciality Name">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure Code">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="Label8" runat="server" Text='<%# Eval("ProcedureCode") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure Name">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="Label9" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="25%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Investigation Code">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="Label10" runat="server" Text='<%# Eval("InvestigationCode") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Investigation Name">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="Label11" runat="server" Text='<%# Eval("InvestigationName") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Investigation Stage">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="Label12" runat="server" Text='<%# Eval("InvestigationStage") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Uploaded Documents">
                                                                        <itemtemplate>
                                                                            <asp:Label Visible="false" ID="Label13" runat="server" Text='<%# Eval("FolderName") %>'></asp:Label>
                                                                            <asp:Label Visible="false" ID="Label14" runat="server" Text='<%# Eval("UploadedFileName") %>'></asp:Label>
                                                                            <asp:Button ID="Button1" runat="server" Text="View Document" class="btn btn-success btn-sm rounded-pill" Style="font-size: 12px;" OnClick="btnViewDocument_Click" />
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                </columns>
                                                            </asp:GridView>--%>
                                                            <asp:Panel ID="panelNoDischrage" runat="server" Visible="true">
                                                                <div class="row ibox-content" style="background-color: #f0f0f0;">
                                                                    <div class="col-md-12 d-flex flex-column justify-content-center align-items-center" style="height: 200px;">
                                                                        <img src="../images/search.svg" />
                                                                        <span class="fs-6 mt-2">No Record Found</span>
                                                                        <span class="text-body-tertiary">Currently, no document available at this moment.</span>
                                                                    </div>
                                                                </div>
                                                            </asp:Panel>
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
                                                <asp:Button ID="btnDownloadPdf" runat="server" Text="Download as one PDF" class="btn btn-primary rounded-pill" OnClick="btnDownloadPdf_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </asp:View>
                            </asp:MultiView>
                        </div>

                        <div class="modal fade" id="contentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-xl">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <asp:Label ID="lbTitle" runat="server" Text="" class="modal-title fs-5 font-weight-bolder"></asp:Label>
                                        <button type="button" class="btn-close" onclick="hideModal();"></button>
                                    </div>
                                    <asp:MultiView ID="MultiView3" runat="server">
                                        <asp:View ID="viewEnhancement" runat="server">
                                            <div class="modal-body">
                                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                    <h3 class="m-0">Enhancement</h3>
                                                </div>
                                                <div class="ibox-content table-responsive">
                                                    <table class="table table-bordered table-striped">
                                                        <thead>
                                                            <tr class="table-primary">
                                                                <th scope="col" style="background-color: #007e72; color: white;">Enhancement Initiate Date</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Enhancement From Date</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Enhancement To Date</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Admission Unit</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">No Of Days</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Enhancement Amount(Rs.)</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Remarks</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Enhancement Rejected</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Enhancement Approved/Rejected Date</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Attachments</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Enhancement Rejected Reason</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td>17-08-2024 12:30:00</td>
                                                                <td>17-08-2024</td>
                                                                <td>17-08-2024</td>
                                                                <td>HDU</td>
                                                                <td>5</td>
                                                                <td>23123</td>
                                                                <td>Patient require further stay for treatement please find attached request for enhancement along with the indoor...</td>
                                                                <td>YES</td>
                                                                <td>17-08-2024 12:30:00</td>
                                                                <td>
                                                                    <asp:LinkButton ID="lnkPhoto" runat="server" OnClick="lnkPhoto_Click">Patient Photo</asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkDocument" runat="server" OnClick="lnkDocument_Click">Enhancement Justification</asp:LinkButton>
                                                                </td>
                                                                <td>NA</td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                    <%--<asp:GridView ID="gridTransactionDataReferences" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                                                  <alternatingrowstyle backcolor="Gainsboro" />
                                                                                  <columns>
                                                                                      <asp:TemplateField HeaderText="Enhancement Initiate Date">
                                                                                          <itemtemplate>
                                                                                              <asp:Label ID="lbEnhancementInitiateDate" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
                                                                                          </itemtemplate>
                                                                                          <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                          <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                      </asp:TemplateField>
                                                                                      <asp:TemplateField HeaderText="Enhancement From Date">
                                                                                          <itemtemplate>
                                                                                              <asp:Label ID="lbEnhancementFromDate" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
                                                                                          </itemtemplate>
                                                                                          <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                          <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                      </asp:TemplateField>
                                                                                      <asp:TemplateField HeaderText="Enhancement To Date">
                                                                                          <itemtemplate>
                                                                                              <asp:Label ID="lbEnhancementToDate" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
                                                                                          </itemtemplate>
                                                                                          <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                          <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                      </asp:TemplateField>
                                                                                      <asp:TemplateField HeaderText="Admission Unit">
                                                                                          <itemtemplate>
                                                                                              <asp:Label ID="lbAdmissionUnit" runat="server" Text="HDU"></asp:Label>
                                                                                          </itemtemplate>
                                                                                          <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                          <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                      </asp:TemplateField>
                                                                                      <asp:TemplateField HeaderText="No Of Days">
                                                                                          <itemtemplate>
                                                                                              <asp:Label ID="lbNoOfDays" runat="server" Text="5"></asp:Label>
                                                                                          </itemtemplate>
                                                                                          <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                          <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                      </asp:TemplateField>
                                                                                      <asp:TemplateField HeaderText="Enhancement Amount(₹)">
                                                                                          <itemtemplate>
                                                                                              <asp:Label ID="lbEnhancementAmount" runat="server" Text="0.00"></asp:Label>
                                                                                          </itemtemplate>
                                                                                          <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                          <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                      </asp:TemplateField>
                                                                                      <asp:TemplateField HeaderText="Remarks">
                                                                                          <itemtemplate>
                                                                                              <asp:Label ID="lbRemarks" runat="server" Text="Patient require further stay for treatement"></asp:Label>
                                                                                          </itemtemplate>
                                                                                          <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                          <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                      </asp:TemplateField>
                                                                                      <asp:TemplateField HeaderText="Enhancement Rejected">
                                                                                          <itemtemplate>
                                                                                              <asp:Label ID="lbEnhancementRejected" runat="server" Text="YES"></asp:Label>
                                                                                          </itemtemplate>
                                                                                          <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                          <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                      </asp:TemplateField>
                                                                                      <asp:TemplateField HeaderText="Enhancement Approved/Rejected Date">
                                                                                          <itemtemplate>
                                                                                              <asp:Label ID="lbEnhancementApprovedRejectedDate" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
                                                                                          </itemtemplate>
                                                                                          <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                          <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                      </asp:TemplateField>
                                                                                      <asp:TemplateField HeaderText="Attachments">
                                                                                          <asp:LinkButton ID="lnkPatientPhoto" runat="server">Patient Photo
                                                                                          </asp:LinkButton>
                                                                                          <asp:LinkButton ID="lnkEnhancementJustification" runat="server">Enhancement Justification
                                                                                          </asp:LinkButton>
                                                                                          <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                          <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                      </asp:TemplateField>
                                                                                      <asp:TemplateField HeaderText="Enhancement Rejected Reason">
                                                                                          <itemtemplate>
                                                                                              <asp:Label ID="lbEnhancementRejectedReason" runat="server" Text="NA"></asp:Label>
                                                                                          </itemtemplate>
                                                                                          <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                          <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                      </asp:TemplateField>
                                                                                   </columns>
                                                                            </asp:GridView>--%>
                                                </div>
                                            </div>
                                        </asp:View>
                                        <asp:View ID="viewPhoto" runat="server">
                                            <div class="modal-body">
                                                <div class="row table-responsive" style="max-height: 700px; overflow-y: scroll;">
                                                    <asp:Image ID="imgChildView" runat="server" class="img-fluid" ImageUrl="https://plus.unsplash.com/premium_photo-1664304370934-b21ea9e0b1f5?q=80&w=1883&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" AlternateText="Child Document" />
                                                </div>
                                            </div>
                                        </asp:View>
                                        <asp:View ID="viewJustification" runat="server">
                                            <div class="modal-body">
                                                <div class="ratio ratio-16x9">
                                                    <iframe src="https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf" title="Justification Document"></iframe>
                                                </div>
                                            </div>
                                        </asp:View>
                                        <asp:View ID="viewAudit" runat="server">
                                            <div class="modal-body">
                                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                    <h3 class="m-0">Query/ Rejection Reasons</h3>
                                                </div>
                                                <div class="ibox-content table-responsive">
                                                    <table class="table table-bordered table-striped">
                                                        <thead>
                                                            <tr class="table-primary">
                                                                <th scope="col" style="background-color: #007e72; color: white;">S.No</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Parent Reason</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Sub Reason</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Remarks</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Date</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td>1</td>
                                                                <td>Package Selection : Mismatch of package and disease/diagnosis/treatement/gender/age</td>
                                                                <td></td>
                                                                <td>Kindly raise enhancement for 3 days in hdu</td>
                                                                <td>17-08-2024 12:30:00</td>
                                                            </tr>
                                                            <tr>
                                                                <td>1</td>
                                                                <td>Package Selection : Mismatch of package and disease/diagnosis/treatement/gender/age</td>
                                                                <td></td>
                                                                <td>Kindly raise enhancement for 3 days in hdu</td>
                                                                <td>17-08-2024 12:30:00</td>
                                                            </tr>
                                                        </tbody>
                                                    </table>

                                                    <%--<asp:GridView ID="gridRaiseQueryAudit" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                                                    <alternatingrowstyle backcolor="Gainsboro" />
                                                                                    <columns>
                                                                                        <asp:TemplateField HeaderText="S.No.">
                                                                                            <itemtemplate>
                                                                                                <asp:Label ID="lbSlNo" runat="server" Text="1"></asp:Label>
                                                                                            </itemtemplate>
                                                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Parent Reason">
                                                                                            <itemtemplate>
                                                                                                <asp:Label ID="lbParentReason" runat="server" Text="Package Selection:"></asp:Label>
                                                                                            </itemtemplate>
                                                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Sub Reason">
                                                                                            <itemtemplate>
                                                                                                <asp:Label ID="lbSubReason" runat="server" Text="Sub Reason"></asp:Label>
                                                                                            </itemtemplate>
                                                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Remarks">
                                                                                            <itemtemplate>
                                                                                                <asp:Label ID="lbRemarks" runat="server" Text="Kindly raise enhancement for 3 days in hdu"></asp:Label>
                                                                                            </itemtemplate>
                                                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Date">
                                                                                            <itemtemplate>
                                                                                                <asp:Label ID="lbDate" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
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
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnDownloadPdf" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

