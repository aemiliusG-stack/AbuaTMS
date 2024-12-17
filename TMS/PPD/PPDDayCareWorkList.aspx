<%@ Page Title="" Language="C#" MasterPageFile="~/PPD/PPD.master" AutoEventWireup="true" CodeFile="PPDDayCareWorkList.aspx.cs" Inherits="PPD_DayCareWorkList" %>

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
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title d-flex justify-content-between align-items-center">
                        <h3 class="text-white">Patient Details</h3>
                        <asp:Label ID="lbCaseNumber" class="text-white" runat="server" Text="Case No: CASE/PS7/HOSP20G12238/P2899407"></asp:Label>
                    </div>
                    <div class="ibox-content">
                        <div class="ibox-content text-dark">
                            <div class="row">
                                <div class="col-lg-9">
                                    <div class="form-group row">
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Name:</span><br />
                                            <asp:Label ID="lbPersonName" runat="server" Text="Person Name" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Beneficiary Card ID:</span><br />
                                            <asp:Label ID="lbBeneficiaryCardId" runat="server" Text="MMDSDJJD87" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Registration No:</span><br />
                                            <asp:Label ID="lbRegistrationNo" runat="server" Text="2225115" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Case No:</span><br />
                                            <asp:Label ID="lbCaseNo" runat="server" Text="CASE/PS7/HOSP20G12238/P2768528" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
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
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Actual Registration Date:</span><br />
                                            <asp:Label ID="lbActualRegistrationDate" runat="server" Text="06/04/2024 14:46:46" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Contact No:</span><br />
                                            <asp:Label ID="lbContactNo" runat="server" Text="9898989898" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Hospital Type:</span><br />
                                            <asp:Label ID="lbHospitalType" runat="server" Text="Public" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Gender:</span><br />
                                            <asp:Label ID="lbGender" runat="server" Text="Male" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Family ID:</span><br />
                                            <asp:Label ID="lbFamilyId" runat="server" Text="20P885da2cd-2434-11e8-8264" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Family ID:</span><br />
                                            <asp:Label ID="Label1" runat="server" Text="20P885da2cd-2434-11e8-8264" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Is New Born Baby Case:</span><br />
                                            <asp:Label ID="lbAge" runat="server" Text="Yes" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Aadhar Verified:</span><br />
                                            <asp:Label ID="lbAgeVerified" runat="server" Text="Yes" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Authentication Reg/Dis:</span><br />
                                            <asp:Label ID="lbAuthenticationAt" runat="server" Text="No/No" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Patient District:</span><br />
                                            <asp:Label ID="lbPatientDistrict" runat="server" Text="Ranchi" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Patient Schema:</span><br />
                                            <asp:Label ID="lbPatientSchema" runat="server" Text="MSBY(P)" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Child Name:</span><br />
                                            <asp:Label ID="lbChildName" runat="server" Text="NA" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Gender Of Child:</span><br />
                                            <asp:Label ID="lbGenderOfChild" runat="server" Text="NA" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Date of Birth:</span><br />
                                            <asp:Label ID="lbDob" runat="server" Text="16-08-2024" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Father Name:</span><br />
                                            <asp:Label ID="lbFatherName" runat="server" Text="John Deo" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <span class="form-label span-title">Mother Name:</span><br />
                                            <asp:Label ID="lbMotherName" runat="server" Text="John Deo" Style="font-size: 12px;"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <span class="form-label span-title">Child Photo:</span><br />
                                            <asp:LinkButton ID="lnkChildPhoto" runat="server" OnClick="lnkChildPhoto_Click">View Photo</asp:LinkButton>
                                            <%--<a href="#.">View Photo</a>--%>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <span class="form-label span-title">Birth Certificate/ Ration Card:</span><br />
                                            <asp:LinkButton ID="lnkBirthRationDocument" runat="server" OnClick="lnkBirthRationDocument_Click">View Document</asp:LinkButton>
                                            <%--<a href="#.">View Document</a>--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="text-center">
                                        <img src="../images/JSAS.png" alt="Patient Photo" class="img-fluid mb-3" style="max-width: 100px;">
                                        <img src="../images/JSAS.png" alt="Patient Photo" class="img-fluid mb-3" style="max-width: 100px;">
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
                                                    <asp:Button runat="server" ID="btnSearch" class="btn btn-success rounded-pill mt-2" Text="Search" />
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
                                                    <td><a href="PPDCaseDetails.aspx" class="text-decoration-underline text-black fw-semibold">CASE/PS7/HOSP20G12238/P2897102</a></td>
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
                                                    <span class="form-label fw-semibold">Type<span class="text-danger">*</span></span>
                                                    <asp:TextBox runat="server" ID="tbType" class="form-control mt-2" Text="Private" ReadOnly="true"></asp:TextBox>
                                                </div>
                                                <div class="col-md-3">
                                                    <span class="form-label fw-semibold">Address<span class="text-danger">*</span></span>
                                                    <asp:TextBox runat="server" ID="tbAddress" class="form-control mt-2" Text="Ranchi, Jharkhand" ReadOnly="true"></asp:TextBox>
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
                                                    <asp:TextBox runat="server" OnKeypress="return isAlphaNumeric(event)" ID="tbPrimaryDiagnosis" class="form-control mt-2"></asp:TextBox>
                                                </div>
                                                <div class="col-md-3"></div>
                                                <div class="col-md-3 mb-3">
                                                    <span class="form-label fw-semibold">Secondary Diagnosis<span class="text-danger">*</span></span>
                                                    <asp:TextBox runat="server" OnKeypress="return isAlphaNumeric(event)" ID="tbSecondaryDiagnosis" class="form-control mt-2"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-md-6 table-responsive">
                                                    <table class="table table-bordered table-striped">
                                                        <thead>
                                                            <tr class="table-primary">
                                                                <th scope="col" style="background-color: #007e72; color: white;">Primary ICD Values</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td>Lorem Ipsum is simply dummy text of the printing and typesetting industry. </td>
                                                                <td class="text-center"><a><span class="badge rounded-pill text-bg-danger"><i class="bi bi-x"></i></span></a></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Lorem Ipsum is simply dummy text of the printing and typesetting industry. </td>
                                                                <td class="text-center"><a><span class="badge rounded-pill text-bg-danger"><i class="bi bi-x"></i></span></a></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>

                                                    <%--<asp:GridView ID="gridPrimaryDiagnosis" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                            <alternatingrowstyle backcolor="Gainsboro" />
                                                            <columns>
                                                                <asp:TemplateField HeaderText="Primary ICD Values">
                                                                    <itemtemplate>
                                                                        <asp:Label ID="lbPrimaryIcdValues" runat="server" Text="Lorem Ipsum"></asp:Label>
                                                                    </itemtemplate>
                                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Action">
                                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                </asp:TemplateField>
                                                            </columns>
                                                        </asp:GridView>--%>
                                                </div>

                                                <div class="col-md-6 table-responsive">
                                                    <table class="table table-bordered table-striped">
                                                        <thead>
                                                            <tr class="table-primary">
                                                                <th scope="col" style="background-color: #007e72; color: white;">Secondary ICD Values</th>
                                                                <th scope="col" style="background-color: #007e72; color: white;">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td>Lorem Ipsum is simply dummy text of the printing and typesetting industry. </td>
                                                                <td class="text-center"><a><span class="badge rounded-pill text-bg-danger"><i class="bi bi-x"></i></span></a></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Lorem Ipsum is simply dummy text of the printing and typesetting industry. </td>
                                                                <td class="text-center"><a><span class="badge rounded-pill text-bg-danger"><i class="bi bi-x"></i></span></a></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>

                                                    <%--<asp:GridView ID="gridSecondaryDiagnosis" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                            <alternatingrowstyle backcolor="Gainsboro" />
                                                            <columns>
                                                                <asp:TemplateField HeaderText="Secondary ICD Values">
                                                                    <itemtemplate>
                                                                        <asp:Label ID="lbPrimaryIcdValues" runat="server" Text="Lorem Ipsum"></asp:Label>
                                                                    </itemtemplate>
                                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Action">
                                                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                                </asp:TemplateField>
                                                            </columns>
                                                        </asp:GridView>--%>
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
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr class="table-primary">
                                                    <th scope="col" style="background-color: #007e72; color: white;">S.No</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">ICD CODE</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">ICD DESCRIPTION</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">ACTED BY ROLE</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <th scope="row">1</th>
                                                    <td>1G40</td>
                                                    <td>Unspecified spesis(1G40)</td>
                                                    <td>MEDCO</td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">1</th>
                                                    <td>1G40</td>
                                                    <td>Unspecified spesis(1G40)</td>
                                                    <td>MEDCO</td>
                                                </tr>
                                            </tbody>
                                        </table>

                                        <%--<asp:GridView ID="gridPrimaryDiagnosisValues" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                    <alternatingrowstyle backcolor="Gainsboro" />
                                                    <columns>
                                                        <asp:TemplateField HeaderText="S.No.">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text="1"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ICD Code">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbIcdCode" runat="server" Text="1DAS"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="IDC Description">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbIcdDescription" runat="server" Text="Unspecified spesis(1G40)"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Acted By Role">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbActedByRole" runat="server" Text="MEDCO"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                    </columns>
                                                </asp:GridView>--%>
                                    </div>
                                </div>

                                <div class="ibox mt-4">
                                    <div class="ibox-title text-center">
                                        <h3 class="text-white">Secondary Diagnosis ICD Values</h3>
                                    </div>
                                    <div class="ibox-content table-responsive">
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr class="table-primary">
                                                    <th scope="col" style="background-color: #007e72; color: white;">S.No</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">ICD CODE</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">ICD DESCRIPTION</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">ACTED BY ROLE</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <th scope="row">1</th>
                                                    <td>1G40</td>
                                                    <td>Unspecified spesis(1G40)</td>
                                                    <td>MEDCO</td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">1</th>
                                                    <td>1G40</td>
                                                    <td>Unspecified spesis(1G40)</td>
                                                    <td>MEDCO</td>
                                                </tr>
                                            </tbody>
                                        </table>

                                        <%--<asp:GridView ID="gridPrimaryDiagnosisValues" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
    <alternatingrowstyle backcolor="Gainsboro" />
    <columns>
        <asp:TemplateField HeaderText="S.No.">
            <itemtemplate>
                <asp:Label ID="lbSlNo" runat="server" Text="1"></asp:Label>
            </itemtemplate>
            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="ICD Code">
            <itemtemplate>
                <asp:Label ID="lbIcdCode" runat="server" Text="1DAS"></asp:Label>
            </itemtemplate>
            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="IDC Description">
            <itemtemplate>
                <asp:Label ID="lbIcdDescription" runat="server" Text="Unspecified spesis(1G40)"></asp:Label>
            </itemtemplate>
            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Acted By Role">
            <itemtemplate>
                <asp:Label ID="lbActedByRole" runat="server" Text="MEDCO"></asp:Label>
            </itemtemplate>
            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
        </asp:TemplateField>
    </columns>
</asp:GridView>--%>
                                    </div>
                                </div>

                                <div class="ibox mt-4">
                                    <div class="ibox-title text-center">
                                        <h3 class="text-white">Treatement Protocol</h3>
                                    </div>
                                    <div class="ibox-content table-responsive">
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr class="table-primary">
                                                    <th scope="col" style="background-color: #007e72; color: white;">Speciality</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Procedure</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Quantity</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Amount(₹)</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Stratification</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Implants</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Update ICHI Details</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td scope="row">Paediatric Medical Management(MP)</td>
                                                    <td>Serve sepsis - Severe sepsis(MP - MG002A)-M100055</td>
                                                    <td>1</td>
                                                    <td>323</td>
                                                    <td>Bed Category - HDU</td>
                                                    <td>-</td>
                                                    <td>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="fw-semibold">Update ICHI Details</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>

                                        <%--<asp:GridView ID="gridTreatementProtocol" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                    <alternatingrowstyle backcolor="Gainsboro" />
                                                    <columns>
                                                        <asp:TemplateField HeaderText="Speciality">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbSpeciality" runat="server" Text="Speciality"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Procedure">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbProcedure" runat="server" Text="Procedure"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Quantity	">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbQuantity" runat="server" Text="Quantity"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Amount(₹)">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbAmount" runat="server" Text="0.00"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Stratification">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbStratification" runat="server" Text="Stratification"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Implants">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbImplants" runat="server" Text="Implants"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Update ICHI Details">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbUpdateIchiDetails" runat="server" Text="Update ICHI Details"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                    </columns>
                                                </asp:GridView>--%>
                                    </div>
                                </div>

                                <div class="ibox mt-4">
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
                                                    <td>Serve sepsis - Severe sepsis(MP - MG002A)-M100055</td>
                                                    <td>None</td>
                                                    <td>None</td>
                                                    <td>NA</td>
                                                    <td>NA</td>
                                                    <td>NA</td>
                                                </tr>
                                            </tbody>
                                        </table>

                                        <%--<asp:GridView ID="gridIchiDetails" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                    <alternatingrowstyle backcolor="Gainsboro" />
                                                    <columns>
                                                        <asp:TemplateField HeaderText="Procedure Name">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbProcedureName" runat="server" Text="Procedure Name"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ICHI code given by MEDCO">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbIchiCodeMedco" runat="server" Text="ICHI code given by MEDCO"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ICHI code given by PPD Insurer">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbIchiCodePpd" runat="server" Text="Quantity"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ICHI code given by CPD Insurer">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbIchiCodeCpd" runat="server" Text="0.00"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ICHI code given by SAFO">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbIchiCodeSafo" runat="server" Text="ICHI code given by SAFO"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ICHI code given by NAFO">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbIchiCodeNafo" runat="server" Text="ICHI code given by NAFO"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                    </columns>
                                                </asp:GridView>--%>
                                    </div>
                                </div>

                                <div class="ibox mt-4">
                                    <div class="ibox-title text-center">
                                        <h3 class="text-white">Admission Details</h3>
                                    </div>
                                    <div class="ibox-content">
                                        <div class="row">
                                            <div class="col-md-4 mb-3">
                                                <span class="form-label fw-semibold">Admission Type<span class="text-danger">*</span></span><br />
                                                <div class="form-check form-check-inline mt-2">
                                                    <asp:RadioButton ID="rbPlanned" runat="server" class="form-check-label" GroupName="AdmissionType" Text="&nbsp;&nbsp;Planned" />
                                                    <asp:RadioButton ID="rbEmergency" runat="server" class="form-check-label ml-3" GroupName="AdmissionType" Text="&nbsp;&nbsp;Emergency" />
                                                </div>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <span class="form-label fw-semibold">Admission Date<span class="text-danger">*</span></span>
                                                <asp:TextBox runat="server" OnKeypress="return isDate(event)" ID="tbAdmissionDate" class="form-control mt-2" TextMode="date"></asp:TextBox>
                                            </div>
                                            <div class="col-md-4 mb-3"></div>
                                            <div class="col-md-4 mb-3">
                                                <span class="form-label fw-semibold">Package Cost<span class="text-danger">*</span></span>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <div class="input-group">
                                                    <div class="input-group-text">₹</div>
                                                    <asp:TextBox runat="server" OnKeypress="return isNumeric(event)" ID="tbPackageCost" class="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <span class="text-black"><span class="font-weight-bold">Hospital Incentive: </span>0.00%.</span>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <span class="form-label fw-semibold">Incentive Amount<span class="text-danger">*</span></span>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <div class="input-group">
                                                    <div class="input-group-text">₹</div>
                                                    <asp:TextBox runat="server" OnKeypress="return isNumeric(event)" ID="tbIncentiveAmount" class="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mb-3"></div>
                                            <div class="col-md-4 mb-3">
                                                <span class="form-label fw-semibold">Total Package Cost<span class="text-danger">*</span></span>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <div class="input-group">
                                                    <div class="input-group-text">₹</div>
                                                    <asp:TextBox runat="server" OnKeypress="return isNumeric(event)" ID="tbTotalPackageCost" class="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mb-3"></div>
                                            <div class="col-md-4 mb-3">
                                                <span class="form-label fw-semibold">The amount liable by insurance is<span class="text-danger">*</span></span>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <div class="input-group">
                                                    <div class="input-group-text">₹</div>
                                                    <asp:TextBox runat="server" OnKeypress="return isNumeric(event)" ID="tbAmountLiable" class="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mb-3"></div>
                                            <div class="col-md-12">
                                                <span class="form-label fw-semibold">Remarks</span><br />
                                                <asp:TextBox runat="server" OnKeypress="return isAlphaNumeric(event)" ID="tbRemarks" class="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                            </div>
                                            <div class="col-md-12 mt-2">
                                                <span class="text-danger"><span class="font-weight-bold">Note:</span> Only ()?,./ special characters are allowed for Remarks and remarks are mandatory while assigning.</span>
                                            </div>
                                            <div class="col-lg-12 mt-4">
                                                <asp:Button ID="btnTransactionDataReferences" runat="server" class="btn btn-success rounded-pill" Text="Transaction Data References" OnClick="btnTransactionDataReferences_Click" />
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="ibox mt-4">
                                    <div class="ibox-title text-center">
                                        <h3 class="text-white">Work Flow</h3>
                                    </div>
                                    <div class="ibox-content table-responsive">
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr class="table-primary">
                                                    <th scope="col" style="background-color: #007e72; color: white;">S.No</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Date and Time</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Role</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Remarks</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Action</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Amount(Rs.)</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Preauth Query Rejection Reason</th>
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
                                            </tbody>
                                        </table>

                                        <%--<asp:GridView ID="gridWorkFlow" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                    <alternatingrowstyle backcolor="Gainsboro" />
                                                    <columns>
                                                        <asp:TemplateField HeaderText="S.No.">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text="1"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Date and Time">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbDateTime" runat="server" Text="16-08-2024"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Role">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbRole" runat="server" Text="MEDCO"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Remarks">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbRemarks" runat="server" Text="Patient requires further stay for treatement plesae."></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Action">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbAction" runat="server" Text="Procedure auto approved by insurance(Insurance)"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Amount(₹)">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbAmount" runat="server" Text="0.00"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Preauth Query Rejection Reason">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbPreauthQueryRejection" runat="server" Text="NA"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                    </columns>
                                                </asp:GridView>--%>
                                    </div>
                                </div>

                                <div class="ibox mt-4">
                                    <div class="ibox-title text-center">
                                        <h3 class="text-white">Preauth Query/ Rejection Reason</h3>
                                    </div>
                                    <div class="ibox-content table-responsive">
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr class="table-primary">
                                                    <th scope="col" style="background-color: #007e72; color: white;">S.No</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Main Reason</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Sub Reason</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">PPD Query</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Action</th>
                                                    <th scope="col" style="background-color: #007e72; color: white;">Audit</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Package Selection: Mismatch of package and diseases/diagnosis/treatement/gender/age</td>
                                                    <td></td>
                                                    <td>Kindly raise enhancement for 3 days in hdu</td>
                                                    <td class="text-center"><a><span class="badge rounded-pill text-bg-warning p-2"><i class="bi bi-x"></i></span></a></td>
                                                    <td class="text-center">
                                                        <asp:Button ID="btnViewAudit" runat="server" Text="View Audit" class="btn btn-success btn-sm rounded-pill" Style="font-size: 12px;" OnClick="btnViewAudit_Click" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>

                                        <%--<asp:GridView ID="gridPreauthQueryRejectionReason" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                    <alternatingrowstyle backcolor="Gainsboro" />
                                                    <columns>
                                                        <asp:TemplateField HeaderText="S.No.">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text="1"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Main Reason">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbMainReason" runat="server" Text="Package Selection:"></asp:Label>
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
                                                        <asp:TemplateField HeaderText="PPD Query">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbPPDQuery" runat="server" Text="Kindly raise enhancement for 3 days in hdu"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Action">
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Audit">
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                    </columns>
                                                </asp:GridView>--%>
                                    </div>
                                </div>

                                <div class="ibox mt-4">
                                    <div class="ibox-content">
                                        <div class="row">
                                            <div class="col-md-12 form-check mb-3">
                                                <asp:CheckBox ID="cbTerms" runat="server" CssClass="" Text="&nbsp;&nbsp;I have received the cases with best of my knowledge and have validated all documents before making any decision." />
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <span class="form-label fw-semibold">Action</span>
                                                <asp:DropDownList ID="dlAction" runat="server" class="form-control mt-2" AutoPostBack="True" OnSelectedIndexChanged="dlAction_SelectedIndexChanged">
                                                    <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                    <asp:ListItem Value="1">Approve</asp:ListItem>
                                                    <asp:ListItem Value="2">Reject</asp:ListItem>
                                                    <asp:ListItem Value="3">Raise Query</asp:ListItem>
                                                    <asp:ListItem Value="4">Assign</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <asp:Panel ID="pUserRole" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                <span class="form-label fw-semibold">Select User Role</span>
                                                <asp:DropDownList ID="dlUserRole" runat="server" class="form-control mt-2" AutoPostBack="True" OnSelectedIndexChanged="dlUserRole_SelectedIndexChanged">
                                                    <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                    <asp:ListItem Value="1">PPD Insurer</asp:ListItem>
                                                </asp:DropDownList>
                                            </asp:Panel>
                                            <asp:Panel ID="pUser" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                <div>
                                                    <span class="form-label fw-semibold">Select User To Assign</span>
                                                    <asp:DropDownList ID="dlUserToAssign" runat="server" class="form-control mt-2" AutoPostBack="True" OnSelectedIndexChanged="dlUserToAssign_SelectedIndexChanged">
                                                        <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                        <asp:ListItem Value="1">User One</asp:ListItem>
                                                        <asp:ListItem Value="2">User Two</asp:ListItem>
                                                        <asp:ListItem Value="3">User Three</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </asp:Panel>
                                            <asp:Panel ID="pReason" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                <span class="form-label fw-semibold">Reason<span class="text-danger">*</span></span>
                                                <asp:DropDownList ID="DropDownList1" runat="server" class="form-control mt-2">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                            </asp:Panel>
                                            <asp:Panel ID="pSubReason" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                <span class="form-label fw-semibold">Sub Reason<span class="text-danger">*</span></span>
                                                <asp:DropDownList ID="DropDownList2" runat="server" class="form-control mt-2">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                            </asp:Panel>
                                            <asp:Panel ID="pRemarks" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                <span class="form-label fw-semibold">Remarks</span>
                                                <asp:TextBox runat="server" OnKeypress="return isAlphaNumeric(event)" ID="tbRemarksTwo" class="form-control mt-2"></asp:TextBox>
                                            </asp:Panel>
                                        </div>
                                        <asp:Panel ID="pAddReason" runat="server" Visible="false" CssClass="col-md-12 text-center">
                                            <asp:Button ID="Button1" runat="server" class="btn btn-success rounded-pill" Text="Add Reason" />
                                        </asp:Panel>
                                        <div class="col-lg-12 text-start">
                                            <asp:Button ID="Button2" runat="server" class="btn btn-success rounded-pill" Text="Submit" />
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
                        <asp:View ID="viewAttachment" runat="server">
                            <div class="tab-pane fade show active" id="attachment" role="tabpanel">
                                <ul class="nav nav-tabs d-flex flex-row justify-content-around" id="attachTab" role="tablist">
                                    <li class="nav-item mr-2 mt-1" id="preAuth">
                                        <asp:LinkButton ID="lnkPreauthorization" runat="server" CssClass="nav-link active nav-attach" OnClick="lnkPreauthorization_Click">Preauthorization</asp:LinkButton>
                                    </li>
                                    <li class="nav-item mr-2 mt-1" id="discharge">
                                        <asp:LinkButton ID="lnkDischarge" runat="server" CssClass="nav-link nav-attach" OnClick="lnkDischarge_Click">Discharge</asp:LinkButton>
                                    </li>
                                    <li class="nav-item mr-2 mt-1" id="death">
                                        <asp:LinkButton ID="lnkDeath" runat="server" CssClass="nav-link nav-attach" OnClick="lnkDeath_Click">Death</i></asp:LinkButton>
                                    </li>
                                    <li class="nav-item mr-2 mt-1" id="claim">
                                        <asp:LinkButton ID="lnkClaim" runat="server" CssClass="nav-link nav-attach" OnClick="lnkClaim_Click">Claim</asp:LinkButton>
                                    </li>
                                    <li class="nav-item mr-2 mt-1" id="generalInvestigation">
                                        <asp:LinkButton ID="lnkGeneralInvestigation" runat="server" CssClass="nav-link nav-attach" OnClick="lnkGeneralInvestigation_Click">General Investigation</asp:LinkButton>
                                    </li>
                                    <li class="nav-item mr-2 mt-1" id="specialInvestigation">
                                        <asp:LinkButton ID="lnkSpecialInvestigation" runat="server" CssClass="nav-link nav-attach" OnClick="lnkSpecialInvestigation_Click">Special Investigation</asp:LinkButton>
                                    </li>
                                    <li class="nav-item mr-2 mt-1" id="fraud">
                                        <asp:LinkButton ID="lnkFraudDocuments" runat="server" CssClass="nav-link nav-attach" OnClick="lnkFraudDocuments_Click">Fraud Documents</asp:LinkButton>
                                    </li>
                                    <li class="nav-item mt-1" id="audit">
                                        <asp:LinkButton ID="lnkAuditDocuments" runat="server" CssClass="nav-link nav-attach" OnClick="lnkAuditDocuments_Click">Audit Documents</asp:LinkButton>
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
                                        <asp:View ID="viewClaims" runat="server">
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

                <div class="modal fade" id="contentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-xl">
                        <div class="modal-content">
                            <div class="modal-header">
                                <asp:Label ID="lbTitle" runat="server" Text="Transaction Data References" class="modal-title fs-5 font-weight-bolder"></asp:Label>
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
                                        <div class="row table-responsive">
                                            <asp:Image ID="imgPatientPhoto" runat="server" class="img-fluid" ImageUrl="https://plus.unsplash.com/premium_photo-1664304370934-b21ea9e0b1f5?q=80&w=1883&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" AlternateText="Patient Photo" />
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
        </ContentTemplate>
        <%--<triggers>
            <asp:PostBackTrigger ControlID="btnAttachmanet" />
            <asp:PostBackTrigger ControlID="lnkPreauthorization" />
            <asp:PostBackTrigger ControlID="lnkDischarge" />
            <asp:PostBackTrigger ControlID="lnkDeath" />
            <asp:PostBackTrigger ControlID="lnkClaim" />
            <asp:PostBackTrigger ControlID="lnkGeneralInvestigation" />
            <asp:PostBackTrigger ControlID="lnkSpecialInvestigation" />
            <asp:PostBackTrigger ControlID="lnkFraudDocuments" />
            <asp:PostBackTrigger ControlID="lnkAuditDocuments" />
        </triggers>--%>
    </asp:UpdatePanel>
</asp:Content>

