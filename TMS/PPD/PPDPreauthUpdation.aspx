<%@ Page Title="" Language="C#" MasterPageFile="~/PPD/PPD.master" AutoEventWireup="true" CodeFile="PPDPreauthUpdation.aspx.cs" Inherits="PPD_PPDPreauthUpdation" %>

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
        var inactivityTimeout;
        var activityInterval;
        let count = 0;

        function startActivityTimer() {
            activityInterval = setInterval(function () {
                count += 1;
                console.log(`Counting: ${count}`);
            }, 1000);
        }

        function resetInactivityTimer() {
            if (count > 180) {
                callServerMethod();
            }
            clearTimeout(inactivityTimeout);
            clearInterval(activityInterval);
            count = 0;
            inactivityTimeout = setTimeout(function () {
                startActivityTimer();
            }, 3000);
        }

        function callServerMethod() {
            PageMethods.NotifyInactivity("", (result) => {
                window.location.href = result;
            }, (error) => {
                console.error("Error calling server method: " + error);
            });
        }

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

        window.onmousemove = resetInactivityTimer;
        window.onkeypress = resetInactivityTimer;
        resetInactivityTimer();

        //window.onbeforeunload = function () {
        //    sendDataToServer();
        //};

        //function sendDataToServer() {
        //    var xhr = new XMLHttpRequest();
        //    xhr.open("POST", "PPDPreauthUpdation.aspx/NotifyInactivity", true);
        //    xhr.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
        //    xhr.send(JSON.stringify({ message: "User closed the tab/window." }));
        //}
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <contenttemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdAbuaId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdInsurerAmount" runat="server" Visible="false" />
            <asp:HiddenField ID="hdTrustAmount" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPatientRegId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdHospitalId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdCaseId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdAdmissionId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdEnhancementId" runat="server" Visible="false" />

            <asp:MultiView ID="MultiViewMain" runat="server">
                <asp:View ID="viewNoContent" runat="server">
                    <section class="d-flex justify-content-center align-items-center bg-white" style="height: 100vh">
                        <div class="container">
                            <div class="row">
                                <div class="col-12">
                                    <div class="text-center">
                                        <h3 class="h2 m-0">No Pending Cases</h3>
                                        <p class="mb-4">We’re sorry, but there is no pending cases available at this time.</p>
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
                                                <asp:Panel ID="panelChild" runat="server" Visible="false" Style="padding-left: 0px !important; padding-right: 0px !important; width: 100%;">
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
                                                        <div class="col-md-4 mb-3">
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
                                                            <asp:DropDownList ID="dropPrimaryDiagnosis" AutoPostBack="true" OnSelectedIndexChanged="dropPrimaryDiagnosis_SelectedIndexChanged" runat="server" CssClass="form-control">
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Secondary Diagnosis<span class="text-danger">*</span></span>
                                                            <asp:DropDownList ID="dropSecondaryDiagnosis" AutoPostBack="true" OnSelectedIndexChanged="dropSecondaryDiagnosis_SelectedIndexChanged" runat="server" CssClass="form-control">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-md-6 table-responsive">
                                                            <asp:GridView ID="gridPrimaryDiagnosis" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                                <columns>
                                                                    <asp:TemplateField HeaderText="Sl. No.">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbPPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="0%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Diagnosis Name">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="50%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Acted By Role">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbActedBy" runat="server" Text='<%# getRegisteredByText(Eval("RegisteredBy")) %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="20%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-center">
                                                                        <itemtemplate>
                                                                            <asp:LinkButton ID="lnkDeletePrimaryDiagnosis" runat="server" CssClass="text-danger" OnClick="lnkDeletePrimaryDiagnosis_Click">Remove</asp:LinkButton>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                </columns>
                                                            </asp:GridView>
                                                        </div>

                                                        <div class="col-md-6 table-responsive">
                                                            <asp:GridView ID="gridSecondaryDiagnosis" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                                <alternatingrowstyle backcolor="Gainsboro" />
                                                                <columns>
                                                                    <asp:TemplateField HeaderText="Sl. No.">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbSPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="0%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Diagnosis Name">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="50%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Acted By Role">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbActedBy" runat="server" Text='<%# getRegisteredByText(Eval("RegisteredBy")) %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="20%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-center">
                                                                        <itemtemplate>
                                                                            <asp:LinkButton ID="lnkDeleteSecondaryDiagnosis" runat="server" CssClass="text-danger" OnClick="lnkDeleteSecondaryDiagnosis_Click">Remove</asp:LinkButton>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                </columns>
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
                                                    <columns>
                                                        <asp:TemplateField HeaderText="Sl. No.">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbPPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="0%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ICD Value">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbIcd" runat="server" Text='<%# Eval("ICDValue") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Diagnosis Name">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="50%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Acted By Role">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbActedBy" runat="server" Text='<%# getRegisteredByText(Eval("RegisteredBy")) %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="20%" />
                                                        </asp:TemplateField>
                                                    </columns>
                                                </asp:GridView>

                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Secondary Diagnosis ICD Values</h3>
                                            </div>
                                            <div class="ibox-content table-responsive">
                                                <asp:GridView ID="gridSecondaryDiagnosisValues" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                    <alternatingrowstyle backcolor="Gainsboro" />
                                                    <columns>
                                                        <asp:TemplateField HeaderText="Sl. No.">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbSPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="0%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ICD Value">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbIcd" runat="server" Text='<%# Eval("ICDValue") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Diagnosis Name">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="50%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Acted By Role">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbActedBy" runat="server" Text='<%# getRegisteredByText(Eval("RegisteredBy")) %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="20%" />
                                                        </asp:TemplateField>
                                                    </columns>
                                                </asp:GridView>

                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Treatement Protocol</h3>
                                            </div>
                                            <div class="ibox-content table-responsive">
                                                <asp:GridView ID="gridTreatementProtocol" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                    <rowstyle backcolor="White" height="20px" />
                                                    <columns>
                                                        <asp:TemplateField HeaderText="Sl. No.">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Speciality Name">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbAddedSpeciality" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Procedure Name">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbAddedProcedure" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="30%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Procedure Cost">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbAddedAmount" runat="server" Text='<%# Eval("ProcedureAmountFinal") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Stratification Name">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbAddedStratification" runat="server" Text='<%# Eval("StratificationName") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Implant Name">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbAddedImplants" runat="server" Text='<%# Eval("ImplantName") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Implant Quantity">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbAddedQuantity" runat="server" Text='<%# Eval("ImplantCount") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Implant Cost">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbImplantAmount" runat="server" Text='<%# Eval("ImplantAmount") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Total Cost">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbAddedAmount" runat="server" Text='<%# Eval("TotalPackageCost") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                    </columns>
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
                                                                <i class="fa fa-inr"></i>
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
                                                                <i class="fa fa-inr"></i>
                                                            </div>
                                                            <asp:TextBox runat="server" ReadOnly="true" OnKeypress="return isNumeric(event)" ID="tbIncentiveCost" class="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 mb-3"></div>
                                                    <asp:Panel ID="panelImplant" runat="server" CssClass="row p-0 w-100" Visible="true">
                                                        <div class="col-md-4 mb-3">
                                                            <span class="form-label fw-semibold">Implant Cost<span class="text-danger">*</span></span>
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <div class="input-group">
                                                                <div class="input-group-text">
                                                                    <i class="fa fa-inr"></i>
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
                                                                <i class="fa fa-inr"></i>
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
                                                            <asp:Label ID="lbInsurance" runat="server" Text="The amount liable by Insurance is"></asp:Label>
                                                            <span class="text-danger">*</span>
                                                        </span>
                                                    </div>
                                                    <div class="col-md-4 mb-3">
                                                        <div class="input-group">
                                                            <div class="input-group-text">
                                                                <i class="fa fa-inr"></i>
                                                            </div>
                                                            <asp:TextBox runat="server" ReadOnly="true" OnKeypress="return isNumeric(event)" ID="tbAmountLiableInsurance" class="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 mb-3"></div>
                                                    <div class="col-md-4 mb-3">
                                                        <span class="form-label fw-semibold">
                                                            <asp:Label ID="lbTrust" runat="server" Text="The amount liable by Trust is"></asp:Label>
                                                            <span class="text-danger">*</span>
                                                        </span>
                                                    </div>
                                                    <div class="col-md-4 mb-3">
                                                        <div class="input-group">
                                                            <div class="input-group-text">
                                                                <i class="fa fa-inr"></i>
                                                            </div>
                                                            <asp:TextBox runat="server" ReadOnly="true" OnKeypress="return isNumeric(event)" ID="tbAmountLiableTrust" class="form-control"></asp:TextBox>
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
                                                    <alternatingrowstyle backcolor="Gainsboro" />
                                                    <columns>
                                                        <asp:TemplateField HeaderText="Sl. No.">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Date and Time">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbDateTime" runat="server" Text='<%# Eval("ActionDate") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Acted By Role">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbRole" runat="server" Text='<%# Eval("Role") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="15%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Action Taken">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbAction" runat="server" Text='<%# Eval("Action") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Amount(Rs.)">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbAmount" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Remarks">
                                                            <itemtemplate>
                                                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Rejection Reason">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbPreauthQueryRejection" runat="server" Text='<%# Eval("RejectedReason") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="20%" />
                                                        </asp:TemplateField>
                                                    </columns>
                                                </asp:GridView>
                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Preauth Query/ Rejection Reason</h3>
                                            </div>
                                            <div class="ibox-content table-responsive">
                                                <asp:GridView ID="gridPreauthQueryRejectionReason" OnRowDataBound="gridPreauthQueryRejectionReason_RowDataBound" runat="server" AutoGenerateColumns="false" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                    <alternatingrowstyle backcolor="gainsboro" />
                                                    <columns>
                                                        <asp:TemplateField HeaderText="Sl. No.">
                                                            <itemtemplate>
                                                                <asp:Label ID="label1" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1e8c86" font-bold="true" forecolor="white" />
                                                            <itemstyle horizontalalign="left" verticalalign="middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Query Date">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbQueryDate" runat="server" Text='<%# Eval("QueryRaisedDate") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1e8c86" font-bold="true" forecolor="white" />
                                                            <itemstyle horizontalalign="left" verticalalign="middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Main Reason">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbMainReason" runat="server" Text='<%# Eval("ReasonName") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1e8c86" font-bold="true" forecolor="white" />
                                                            <itemstyle horizontalalign="left" verticalalign="middle" width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Sub Reason">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbSubReason" runat="server" Text='<%# Eval("SubReasonName") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1e8c86" font-bold="true" forecolor="white" />
                                                            <itemstyle horizontalalign="left" verticalalign="middle" width="30%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PPD Query">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbPpdQuery" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1e8c86" font-bold="true" forecolor="white" />
                                                            <itemstyle horizontalalign="left" verticalalign="middle" width="25%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Audit">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbIsQueryReplied" Visible="false" runat="server" Text='<%# Eval("IsQueryReplied") %>'></asp:Label>
                                                                <asp:Label ID="lbQueryFolderName" Visible="false" runat="server" Text='<%# Eval("QueryFolderName") %>'></asp:Label>
                                                                <asp:Label ID="lbQueryUploadedFileName" Visible="false" runat="server" Text='<%# Eval("QueryUploadedFileName") %>'></asp:Label>
                                                                <asp:Button ID="btnViewAudit" runat="server" Text="Pending" class="btn btn-warning btn-sm rounded-pill" Style="font-size: 12px;" OnClick="btnViewAudit_Click" />
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1e8c86" font-bold="true" forecolor="white" />
                                                            <itemstyle horizontalalign="left" verticalalign="middle" width="10%" />
                                                        </asp:TemplateField>
                                                    </columns>
                                                </asp:GridView>
                                            </div>
                                        </div>

                                        <div class="ibox mt-4">
                                            <div class="ibox-content">
                                                <div class="row">
                                                    <div class="col-md-12 form-check mb-3">
                                                        <asp:CheckBox ID="cbTerms" runat="server" CssClass="" Text="&nbsp;&nbsp;I have received the case with best of my knowledge and have validated all documents before making any decision." />
                                                    </div>
                                                    <div class="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Action</span>
                                                        <asp:DropDownList ID="dlAction" runat="server" class="form-control mt-2" AutoPostBack="True" OnSelectedIndexChanged="dlAction_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </div>
                                                    <asp:Panel ID="pUserRole" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Select User To Assign</span>
                                                        <asp:DropDownList ID="dlUserRole" runat="server" class="form-control mt-2" AutoPostBack="True">
                                                        </asp:DropDownList>
                                                    </asp:Panel>
                                                    <asp:Panel ID="pReason" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Reason<span class="text-danger">*</span></span>
                                                        <asp:DropDownList ID="dlReason" runat="server" class="form-control mt-2" AutoPostBack="True" OnSelectedIndexChanged="dlReason_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </asp:Panel>
                                                    <asp:Panel ID="pSubReason" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Sub Reason<span class="text-danger">*</span></span>
                                                        <asp:DropDownList ID="dlSubReason" runat="server" class="form-control mt-2" AutoPostBack="True">
                                                        </asp:DropDownList>
                                                    </asp:Panel>
                                                    <asp:Panel ID="pRemarks" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                        <span class="form-label fw-semibold">Remarks</span>
                                                        <asp:TextBox runat="server" ID="tbRemark" class="form-control mt-2"></asp:TextBox>
                                                    </asp:Panel>
                                                </div>
                                                <asp:Panel ID="pAddReason" runat="server" Visible="false" CssClass="col-md-12 text-center">
                                                    <asp:Button ID="btnRaiseQuery" runat="server" class="btn btn-primary rounded-pill" Text="Add Reason" OnClick="btnRaiseQuery_Click" />
                                                </asp:Panel>
                                                <div class="col-lg-12 text-start">
                                                    <asp:Button ID="btnSubmit" runat="server" class="btn btn-primary rounded-pill" Text="Submit" OnClick="btnSubmit_Click" />
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
                                        <ul class="nav nav-tabs d-flex flex-row" id="attachTab" role="tablist">
                                            <li class="nav-item mr-2 mt-1" id="preAuth">
                                                <asp:LinkButton ID="lnkPreauthorization" runat="server" CssClass="nav-link active nav-attach" OnClick="lnkPreauthorization_Click">Preauthorization</asp:LinkButton>
                                            </li>
                                            <li class="nav-item mr-2 mt-1" id="specialInvestigation">
                                                <asp:LinkButton ID="lnkSpecialInvestigation" runat="server" CssClass="nav-link nav-attach" OnClick="lnkSpecialInvestigation_Click">Special Investigation</asp:LinkButton>
                                            </li>
                                        </ul>

                                        <div class="tab-content" id="attachTabContent">
                                            <asp:MultiView ID="MultiView2" runat="server" ActiveViewIndex="0">
                                                <asp:View ID="viewPreauthorization" runat="server">
                                                    <div class="tab-pane fade show active" id="one" role="tabpanel">
                                                        <div class="ibox-title text-center">
                                                            <h3 class="text-white">Preauthorization</h3>
                                                        </div>
                                                        <div class="ibox-content table-responsive">
                                                            <asp:GridView ID="gridManditoryDocument" runat="server" OnRowDataBound="gridManditoryDocument_RowDataBound" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                                <alternatingrowstyle backcolor="Gainsboro" />
                                                                <columns>
                                                                    <asp:TemplateField HeaderText="Sl. No.">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="Label3" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Uploaded Date">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbUploadedOn" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Document Name">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbDocumentName" runat="server" Text='<%# Eval("DocumentName") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="20%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Patient Name">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbPatientName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Hospital Name">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbHospital" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Hospital Address">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbHospitalAddress" runat="server" Text='<%# Eval("HospitalAddress") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Card Number">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbCardNumber" runat="server" Text='<%# Eval("CardNumber") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Investigation Stage">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbDocumentFor" runat="server" Text='<%# Eval("DocumentFor") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Uploaded Documents">
                                                                        <itemtemplate>
                                                                            <asp:Label Visible="false" ID="lbFolder" runat="server" Text='<%# Eval("FolderName") %>'></asp:Label>
                                                                            <asp:Label Visible="false" ID="lbUploadedFileName" runat="server" Text='<%# Eval("UploadedFileName") %>'></asp:Label>
                                                                            <asp:Button ID="btnViewMandateDocument" runat="server" Text="View Document" class="btn btn-success btn-sm rounded-pill" Style="font-size: 12px;" OnClick="btnViewMandateDocument_Click" />
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                </columns>
                                                            </asp:GridView>
                                                            <asp:Panel ID="panelNoManditoryDocument" runat="server" Visible="false">
                                                                <div class="row ibox-content" style="background-color: #f0f0f0;">
                                                                    <div class="col-md-12 d-flex flex-column justify-content-center align-items-center" style="height: 200px;">
                                                                        <img src="../images/search.svg" />
                                                                        <span class="mt-2">No Record Found</span>
                                                                        <span class="text-body-tertiary">Currently, no document available at this moment.</span>
                                                                    </div>
                                                                </div>
                                                            </asp:Panel>
                                                        </div>
                                                    </div>
                                                </asp:View>
                                                <asp:View ID="viewSpecialInvestigation" runat="server">
                                                    <div class="tab-pane fade show active" id="six" role="tabpanel">
                                                        <div class="ibox-title text-center">
                                                            <h3 class="text-white">Special Investigations</h3>
                                                        </div>
                                                        <div class="ibox-content table-responsive">
                                                            <asp:GridView ID="gridSpecialInvestigation" runat="server" AutoGenerateColumns="False" OnRowDataBound="gridSpecialInvestigation_RowDataBound" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                                <alternatingrowstyle backcolor="Gainsboro" />
                                                                <columns>
                                                                    <asp:TemplateField HeaderText="Sl. No.">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="Label2" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Uploaded Date">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbCreatedOn" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Hospital Name">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Speciality Name">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbPackageName" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure Code">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbProcedureCode" runat="server" Text='<%# Eval("ProcedureCode") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure Name">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbProcedureName" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="25%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Investigation Code">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbInvestigationCode" runat="server" Text='<%# Eval("InvestigationCode") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Investigation Name">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbInvestigationName" runat="server" Text='<%# Eval("InvestigationName") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Investigation Stage">
                                                                        <itemtemplate>
                                                                            <asp:Label ID="lbInvestigationStage" runat="server" Text='<%# Eval("InvestigationStage") %>'></asp:Label>
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Uploaded Documents">
                                                                        <itemtemplate>
                                                                            <asp:Label Visible="false" ID="lbFolderName" runat="server" Text='<%# Eval("FolderName") %>'></asp:Label>
                                                                            <asp:Label Visible="false" ID="lbFileName" runat="server" Text='<%# Eval("UploadedFileName") %>'></asp:Label>
                                                                            <asp:Button ID="btnViewDocument" runat="server" Text="View Document" class="btn btn-success btn-sm rounded-pill" Style="font-size: 12px;" OnClick="btnViewDocument_Click" />
                                                                        </itemtemplate>
                                                                        <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                                    </asp:TemplateField>
                                                                </columns>
                                                            </asp:GridView>
                                                            <asp:Panel ID="panelNoSpecialInvestigation" runat="server" Visible="false">
                                                                <div class="row ibox-content" style="background-color: #f0f0f0;">
                                                                    <div class="col-md-12 d-flex flex-column justify-content-center align-items-center" style="height: 200px;">
                                                                        <img src="../images/search.svg" />
                                                                        <span class="mt-2">No Record Found</span>
                                                                        <span class="text-body-tertiary">Currently, no document available at this moment.</span>
                                                                    </div>
                                                                </div>
                                                            </asp:Panel>
                                                        </div>
                                                    </div>
                                                </asp:View>
                                            </asp:MultiView>
                                            <%--<div class="col-md-12 mt-3">
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
                                            </div>--%>
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
                                        <button type="button" class="btn" onclick="hideModal();">
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                    <asp:MultiView ID="MultiView3" runat="server">
                                        <asp:View ID="viewEnhancement" runat="server">
                                            <div class="modal-body">
                                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                    <h3 class="m-0">Enhancement</h3>
                                                </div>
                                                <div class="ibox-content table-responsive">
                                                    <asp:GridView ID="gridTransactionDataReferences" runat="server" AutoGenerateColumns="False" OnRowDataBound="gridTransactionDataReferences_RowDataBound" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="150%" CssClass="table table-bordered table-striped">
                                                        <alternatingrowstyle backcolor="Gainsboro" />
                                                        <columns>
                                                            <asp:TemplateField HeaderText="Enhancement Initiate Date">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbEnhancementInitiateDate" runat="server" Text='<%# Eval("EnhancementInitiateDate") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Enhancement From Date">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbEnhancementFromDate" runat="server" Text='<%# Eval("EnhancementFrom") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Enhancement To Date">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbEnhancementToDate" runat="server" Text='<%# Eval("EnhancementTo") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Admission Unit">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbAdmissionUnit" runat="server" Text="NA"></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="15%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="No Of Days">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbNoOfDays" runat="server" Text='<%# Eval("EnhancementDays") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Enhancement Amount(Rs.)">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbEnhancementAmount" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Remarks">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" cssclass="text-center" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="15%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Enhancement Status">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbEnhancementStatus" runat="server" Text='<%# Eval("EnhancementStatus") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Enhancement Approved/Rejected Date">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbEnhancementApprovedDate" Visible="false" runat="server" Text='<%# Eval("ApprovedDate") %>'></asp:Label>
                                                                    <asp:Label ID="lbEnhancementRejectedDate" Visible="false" runat="server" Text='<%# Eval("RejectedDate") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Attachments">
                                                                <itemtemplate>
                                                                    <asp:Label Visible="false" ID="lbPatientFolderName" runat="server" Text='<%# Eval("PatientFolderName") %>'></asp:Label>
                                                                    <asp:Label Visible="false" ID="lbPatientUploadedFileName" runat="server" Text='<%# Eval("PatientUploadedFileName") %>'></asp:Label>
                                                                    <asp:Label Visible="false" ID="lbJustificationFolderName" runat="server" Text='<%# Eval("JustificationFolderName") %>'></asp:Label>
                                                                    <asp:Label Visible="false" ID="lbJustificationUploadedFileName" runat="server" Text='<%# Eval("JustificationFileName") %>'></asp:Label>
                                                                    <asp:Label Visible="false" ID="lbIcpFolderName" runat="server" Text='<%# Eval("IcpFolderName") %>'></asp:Label>
                                                                    <asp:Label Visible="false" ID="lbIcpUploadedFileName" runat="server" Text='<%# Eval("IcpUploadedFileName") %>'></asp:Label>
                                                                    <asp:LinkButton ID="lnkPhoto" runat="server" OnClick="lnkPhoto_Click" Enabled="true">Patient Photo</asp:LinkButton><br />
                                                                    <asp:LinkButton ID="lnkDocument" runat="server" OnClick="lnkDocument_Click" Enabled="true">Enhancement Justification</asp:LinkButton><br />
                                                                    <asp:LinkButton ID="lnkIcp" runat="server" OnClick="lnkIcp_Click" Enabled="true">ICP</asp:LinkButton>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Enhancement Rejected Reason">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbEnhancementRejectedReason" runat="server" Text='<%# Eval("RejectedReason") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Rejected Remarks">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbEnhancemenRemarks" runat="server" Text='<%# Eval("RejectedRemarks") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                            </asp:TemplateField>
                                                        </columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </asp:View>
                                        <asp:View ID="viewPhoto" runat="server">
                                            <div class="modal-body">
                                                <div class="row table-responsive" style="max-height: 700px; overflow-y: scroll;">
                                                    <asp:Image ID="imgChildView" runat="server" class="img-fluid" AlternateText="Patient Document" ImageUrl="https://plus.unsplash.com/premium_photo-1664304370934-b21ea9e0b1f5?q=80&w=1883&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" />
                                                </div>
                                            </div>
                                        </asp:View>
                                        <asp:View ID="viewJustification" runat="server">
                                            <div class="modal-body">
                                                <div class="row table-responsive" style="height: 700px; overflow-y: scroll;">
                                                    <asp:Image ID="imgJustification" runat="server" class="img-fluid" ImageUrl="https://plus.unsplash.com/premium_photo-1664304370934-b21ea9e0b1f5?q=80&w=1883&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" AlternateText="Justification Document" />
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
                                                                                                <asp:Label ID="lbDateQuery" runat="server" Text="17-08-2024 12:30:00"></asp:Label>
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
        </contenttemplate>
        <triggers>
            <asp:PostBackTrigger ControlID="btnDownloadPdf" />
        </triggers>
    </asp:UpdatePanel>
</asp:Content>

