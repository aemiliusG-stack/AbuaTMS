<%@ Page Title="" Language="C#" MasterPageFile="~/CPD/CPD.master" AutoEventWireup="true" CodeFile="CPDClaimUpdation.aspx.cs" Inherits="CPD_CPDClaimUpdation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        function setView(viewIndex) {
            __doPostBack('<%= mvCPDTabs.UniqueID %>', viewIndex.toString());
        }
    </script>
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
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdRoleId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdAbuaId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPatientRegId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdHospitalId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPackageId" runat="server" Visible="false" />
            <asp:HiddenField ID="hfPDId" runat="server" Visible="false" />
            <asp:HiddenField ID="hfAdmissionId" runat="server" Visible="false" />
            <asp:HiddenField ID="hfInsurerApprovedAmount" runat="server" Visible="false" />
            <asp:HiddenField ID="hfTrustApprovedAmount" runat="server" Visible="false" />
            <asp:HiddenField ID="hfDeductedAmount" runat="server" Visible="false" />
            <asp:HiddenField ID="hfFinalAmount" runat="server" Visible="false" />
            <asp:MultiView ID="MultiViewMain" runat="server" ActiveViewIndex="0">
                <asp:View ID="viewMain" runat="server">
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
                                                            <asp:Label ID="lbCaseStatus" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">IP No:</span><br />
                                                            <asp:Label ID="lbIPNo" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">IP Registered Date:</span><br />
                                                            <asp:Label ID="lbIPRegDate" runat="server" Text="N/A"></asp:Label>

                                                        </div>

                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Actual Registration Date:</span><br />
                                                            <asp:Label ID="lbActualRegDate" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Contact No:</span><br />
                                                            <asp:Label ID="lbContactNo" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Hospital Type:</span><br />
                                                            <asp:Label ID="lbHospitalType" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Gender:</span><br />
                                                            <asp:Label ID="lbGender" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Family ID:</span><br />
                                                            <asp:Label ID="lbFamilyId" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Age:</span><br />
                                                            <asp:Label ID="lbAge" runat="server" Text="N/A"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Aadhar Verified:</span><br />
                                                            <asp:Label ID="lbAadharVerified" runat="server" Text="N/A"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Authentication at Reg/Dis:</span><br />
                                                            <asp:Label ID="lbAuthentication" runat="server" Text="N/A"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Patient District:</span><br />
                                                            <asp:Label ID="lbPatientDistrict" runat="server" Text="N/A"></asp:Label>

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
                                                        <asp:Image ID="imgPatientPhoto" runat="server" ImageUrl="../img/profile.jpg" CssClass="img-fluid mb-3" Style="max-width: 100px; height: 140px; object-fit: cover;" AlternateText="Patient Photo" />
                                                    </div>
                                                    <div class="col-lg-6 align-items-center">
                                                        <asp:Image ID="imgPatientPhotosecond" runat="server" ImageUrl="../img/profile.jpg" CssClass="img-fluid mb-3" Style="max-width: 100px; height: 140px; object-fit: cover;" AlternateText="Patient Photo" />
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <ul class="nav nav-tabs" id="mytabs" role="tablist">
                                <li class="nav-item ml-3">
                                    <asp:Button ID="btnPastHistory" runat="server" Text="Past History" OnClick="btnPastHistory_Click" Style="padding: 1rem;" class="nav-link d-flex flex-column align-items-center" />
                                </li>
                                <li class="nav-item ml-3">
                                    <asp:Button ID="btnPreauth" runat="server" Text="Preauthorization" OnClick="btnPreauth_Click" Style="padding: 1rem;" class="nav-link d-flex flex-column align-items-center" />
                                </li>
                                <li class="nav-item ml-3">
                                    <asp:Button ID="btnTreatment" runat="server" Text="Treatment And Discharge" OnClick="btnTreatment_Click" Style="padding: 1rem;" class="nav-link d-flex flex-column align-items-center" />
                                </li>
                                <li class="nav-item ml-3">
                                    <asp:Button ID="btnClaims" runat="server" Text="Claims" OnClick="btnClaims_Click" Style="padding: 1rem;" class="nav-link d-flex flex-column align-items-center" />
                                </li>
                                <li class="nav-item ml-3">
                                    <asp:Button ID="btnAttachments" runat="server" Text="Attachments" OnClick="btnAttachments_Click" Style="padding: 1rem;" class="nav-link d-flex flex-column align-items-center" />
                                </li>
                                <li class="nav-item ml-3">
                                    <asp:Button ID="btnQuestionnaire" runat="server" Text="Questionnaire" OnClick="btnQuestionnaire_Click" Style="padding: 1rem;" class="nav-link d-flex flex-column align-items-center" />
                                </li>
                            </ul>

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
                                                                <asp:TextBox ID="tbHospitalName" runat="server" Enabled="false" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Type</span>
                                                                <asp:TextBox ID="tbType" runat="server" Enabled="false" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Address</span>
                                                                <asp:TextBox ID="tbAddress" runat="server" Enabled="false" CssClass="form-control" value="Ranchi, Jharkhand" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
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
                                                                    <asp:Label ID="lbAmount" runat="server" Text='<%# Eval("ProcedureAmountFinal") %>'></asp:Label>
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
                                                                <span class="font-weight-bold text-dark">Admission Type<span class="text-danger">*</span></span>
                                                                <div class="d-flex">
                                                                    <div class="form-check form-check-inline me-2">
                                                                        <asp:RadioButton ID="RBPlanned" runat="server" GroupName="inlineRadioOptions" Checked="true" Enabled="false" CssClass="form-check-input" />
                                                                        <span class="font-weight-bold text-dark">Planned</span>
                                                                    </div>
                                                                    <div class="form-check form-check-inline">
                                                                        <asp:RadioButton ID="RBEmergency" runat="server" GroupName="inlineRadioOptions" Enabled="false" CssClass="form-check-input" />
                                                                        <span class="font-weight-bold text-dark">Emergency</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-8 mb-3">
                                                            <div class="form-group">
                                                                <span class="font-weight-bold text-dark">Admission Date<span class="text-danger">*</span></span><br />
                                                                <asp:Label ID="lbAdmissionDate_Preauth" runat="server" CssClass="border-bottom" Style="margin-bottom: 0; padding-bottom: 0;"></asp:Label>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4 mb-3">
                                                            <span class="font-weight-bold text-dark">Package Cost<span class="text-danger">*</span></span>
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
                                                            <span class="font-weight-bold text-dark">Incentive Amount<span class="text-danger">*</span></span>
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <asp:Label ID="lbIncentiveAmount" runat="server" CssClass="form-label" Style="margin-bottom: 0; padding-bottom: 0;"></asp:Label>
                                                            <hr style="margin-top: 0;" />
                                                        </div>
                                                        <div class="col-md-4 mb-3"></div>
                                                        <div class="col-md-4 mb-3">
                                                            <span class="font-weight-bold text-dark">Total Package Cost<span class="text-danger">*</span></span>
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <asp:Label ID="lbTotalPackageCost" runat="server" CssClass="form-label" Style="margin-bottom: 0; padding-bottom: 0;"></asp:Label>
                                                            <hr style="margin-top: 0;" />
                                                        </div>

                                                        <div class="col-md-4 mb-3"></div>
                                                        <div class="col-md-4 mb-3">
                                                            <%--                                                                    <span class="font-weight-bold text-dark">Total Amount Liable by Insurance is</span>--%>
                                                            <asp:Label ID="lbRoleStatusPre" runat="server" class="font-weight-bold text-dark" />
                                                            <span class="text-danger">*</span>

                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <asp:Label ID="lbAmountLiablePre" runat="server" CssClass="form-label" Text="100000" />
                                                            <hr style="margin-top: 0;" />
                                                        </div>
                                                        <%--<div class="col-md-4 mb-3">
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
                                                                </div>--%>
                                                    </div>
                                                    <div class="col-md-12 mb-3">
                                                        <div class="form-group">
                                                            <span class="font-weight-bold text-dark">Remarks</span>
                                                            <asp:TextBox ID="tbRemarks" runat="server" Enabled="false" TextMode="MultiLine" CssClass="form-control" Style="margin-bottom: 0;"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <span class="font-weight-bold text-danger">Note: Only ()?,./ special characters are allowed for Remarks</span>
                                                    </div>
                                                    <div class="col-lg-12 mt-4">
                                                        <asp:Button ID="btnTransactionDataReferences" runat="server" class="btn btn-primary rounded-pill" Text="Transaction Data References" OnClick="btnTransactionDataReferences_Click" />
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
                                                        <div class="table-responsive">
                                                            <asp:GridView ID="gvPreauthWorkFlow" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                <AlternatingRowStyle BackColor="Gainsboro" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="S.No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbSlNo" runat="server" Text='<%# Eval("SlNo") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Date And Time">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbPreActionDate" runat="server" Text='<%# Eval("ActionDate") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Acted By Role">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbPreRoleName" runat="server" Text='<%# Eval("RoleName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Action Taken">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbPreActionTaken" runat="server" Text='<%# Eval("ActionTaken") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Approved Amount(Rs.)">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbPreAmount" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Remarks">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbPreRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="PreAuth Query/Rejection Reasons">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbPreRejectionReason" runat="server" Text='<%# Eval("RejectionReason") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                    <div style="margin-top: 20px;">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                                                            <label class="form-check-label" for="flexCheckDefault">
                                                                I have reviewed the cases with the best of my knowledge and have validated all documents before making any decision
                                                            </label>
                                                        </div>
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
                                                                <asp:Label ID="lbDoctorType" runat="server" CssClass="d-block w-100 border-bottom p-1" Text="NA"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <div class="form-group">
                                                                <span class="font-weight-bold text-dark">Name</span><br />
                                                                <asp:Label ID="lbDoctorName" runat="server" CssClass="d-block w-100 border-bottom p-1" Text="NA"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <div class="form-group">
                                                                <span class="font-weight-bold text-dark">Regn No</span><br />
                                                                <asp:Label ID="lbDocRegnNo" runat="server" CssClass="d-block w-100 border-bottom p-1" Text="NA"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <div class="form-group">
                                                                <span class="font-weight-bold text-dark">Qualification</span><br />
                                                                <asp:Label ID="lbDocQualification" runat="server" CssClass="d-block w-100 border-bottom p-1" Text="NA"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <div class="form-group">
                                                                <span class="font-weight-bold text-dark">Contact No</span><br />
                                                                <asp:Label ID="lbDocContactNo" runat="server" CssClass="d-block w-50 border-bottom p-1" Text="NA"></asp:Label>
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
                                                                <asp:Label ID="lbAnaesthetistName" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
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
                                                                        <asp:RadioButton ID="rbOPPhotoYes" runat="server" GroupName="OPPhotoWebEx" Enabled="False" Text="Yes" CssClass="form-check-input p-2" />
                                                                    </div>
                                                                    <div class="form-check form-check-inline">
                                                                        <asp:RadioButton ID="rbOPPhotoNo" runat="server" GroupName="OPPhotoWebEx" Enabled="False" Text="No" CssClass="form-check-input p-2" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <div class="form-group">
                                                                <span class="font-weight-bold text-dark">Vedio Recording Done</span><br />
                                                                <div class="d-flex">
                                                                    <div class="form-check form-check-inline me-2">
                                                                        <asp:RadioButton ID="rbVedioRecDoneYes" runat="server" GroupName="VedioRecording" Enabled="False" Text="Yes" CssClass="form-check-input p-2" />
                                                                    </div>
                                                                    <div class="form-check form-check-inline">
                                                                        <asp:RadioButton ID="rbVedioRecDoneNo" runat="server" GroupName="VedioRecording" Enabled="False" Text="No" CssClass="form-check-input p-2" />
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
                                                                        <asp:RadioButton ID="rbSpecimenRemoveYes" runat="server" GroupName="SpecimenRemoved" Enabled="False" Text="Yes" CssClass="form-check-input p-2" />
                                                                    </div>
                                                                    <div class="form-check form-check-inline">
                                                                        <asp:RadioButton ID="rbSpecimenRemoveNo" runat="server" GroupName="SpecimenRemoved" Enabled="False" Text="No" CssClass="form-check-input p-2" />
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
                                                                        <asp:RadioButton ID="rbComplicationsYes" runat="server" GroupName="ComplicationIfAny" Enabled="False" Text="Yes" CssClass="form-check-input p-2" />
                                                                    </div>
                                                                    <div class="form-check form-check-inline">
                                                                        <asp:RadioButton ID="rbComplicationsNo" runat="server" GroupName="ComplicationIfAny" Enabled="False" Text="No" CssClass="form-check-input p-2" />
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
                                                                            <asp:RadioButton ID="rbIsSpecialCaseYes" runat="server" GroupName="IsSpecialCase" Enabled="False" Text="Yes" CssClass="form-check-input p-2" />
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <asp:RadioButton ID="rbIsSpecialCaseNo" runat="server" GroupName="IsSpecialCase" Enabled="False" Text="No" CssClass="form-check-input p-2" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <div class="form-group">
                                                                    <span class="font-weight-bold text-dark">Procedure Consent</span><br />
                                                                    <div class="d-flex">
                                                                        <div class="form-check form-check-inline me-2">
                                                                            <asp:RadioButton ID="rbConsentYes" runat="server" GroupName="ProceduralConsent" Enabled="False" Text="Yes" CssClass="form-check-input p-2" />
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <asp:RadioButton ID="rbConsentNo" runat="server" GroupName="ProceduralConsent" Enabled="False" Text="No" CssClass="form-check-input p-2" />
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
                                                            <div class="col-md-3 mb-3">
                                                                <sapn class="form-label fw-semibold font-weight-bold text-dark">Primary Diagnosis<span class="text-danger">*</span></sapn>
                                                                <asp:DropDownList ID="dropPrimaryDiagnosis" AutoPostBack="true" OnSelectedIndexChanged="dropPrimaryDiagnosis_SelectedIndexChanged" runat="server" CssClass="form-control">
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="col-md-3"></div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold font-weight-bold text-dark">Secondary Diagnosis<span class="text-danger">*</span></span>
                                                                <asp:DropDownList ID="dropSecondaryDiagnosis" AutoPostBack="true" OnSelectedIndexChanged="dropSecondaryDiagnosis_SelectedIndexChanged" runat="server" CssClass="form-control">
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-md-6">
                                                                    <asp:GridView ID="gridPrimaryDiagnosis" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Sl No.">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbPPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Diagnosis Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Cancel">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="lnkDeletePrimaryDiagnosis" runat="server" CssClass="text-danger" OnClick="lnkDeletePrimaryDiagnosis_Click" CommandArgument='<%# Eval("PDId") %>'>Remove</asp:LinkButton>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <asp:GridView ID="gridSecondaryDiagnosis" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" GridLines="Both" CellPadding="3" Width="100%">
                                                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Sl No.">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbSPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Diagnosis Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Cancel">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton
                                                                                        ID="lnkDeleteSecondaryDiagnosis"
                                                                                        runat="server"
                                                                                        CssClass="text-danger"
                                                                                        OnClick="lnkDeleteSecondaryDiagnosis_Click"
                                                                                        CommandArgument='<%# Eval("PDId") %>'>
                                                                                        Remove</asp:LinkButton>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
                                                                <div class="col-md-12 mt-2">
                                                                    <span class="text-danger">Note: User can select multiple options in Primary and Secondary diagnosis fields.</span>
                                                                </div>
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
                                                                <div class="col-md-3 mt-3">
                                                                    <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Penalty Amount:</span><br />
                                                                    <asp:Label ID="lbPenaltyAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                </div>
                                                                <div class="col-md-3 mt-3">
                                                                    <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Claim Amount:</span><br />
                                                                    <asp:Label ID="lbClaimAmount" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                </div>
                                                                <%--<div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Insurance Liable Amount:</span><br />
                                                                            <asp:Label ID="lbInsuranceLiableAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Trust Liable Amount:</span><br />
                                                                            <asp:Label ID="lbTrustLiableAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>--%>
                                                                <div class="col-md-3 mt-3">
                                                                    <asp:Label ID="lbRoleStatus" runat="server" class="form-label fw-semibold" Style="font-size: 14px; font-weight: 800;"></asp:Label>
                                                                    <br />
                                                                    <asp:Label ID="tbAmountLiable" Style="font-size: 12px;" runat="server"></asp:Label>
                                                                </div>
                                                                <div class="col-md-3 mt-3">
                                                                    <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Bill Amount:</span><br />
                                                                    <asp:Label ID="lbBillAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                </div>
                                                                <div class="col-md-3 mt-3">
                                                                    <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Final E-rupi Voucher Amount:</span><br />
                                                                    <asp:Label ID="lbFinalErupiAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                </div>
                                                                <div class="col-md-3 mt-3">
                                                                </div>
                                                                <div class="col-md-3 mt-3">
                                                                </div>
                                                                <div class="col-md-3 mt-3">
                                                                </div>
                                                                <div class="col-md-3 mt-3">
                                                                    <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Remarks:</span>
                                                                    <asp:Label ID="lbRemark" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                </div>
                                                                <div class="col-md-3 mt-3">
                                                                </div>
                                                                <div class="col-md-3 mt-3">
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
                                                                    <asp:TextBox runat="server" ID="tbTotalClaims" ReadOnly="true" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;" EnableViewState="true"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <span class="form-label fw-bold" style="font-weight: 800;">Insurance Approved Amount (Rs)<span class="text-danger">*</span>:</span><br />
                                                                    <asp:TextBox runat="server" ID="tbInsuranceApprovedAmt" ReadOnly="true" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <span class="form-label fw-bold" style="font-weight: 800;">Trust Approved Amount (Rs)<span class="text-danger">*</span>:</span><br />
                                                                    <asp:TextBox runat="server" ID="tbTrustApprovedAmt" ReadOnly="true" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row mb-3">
                                                                <div class="col-md-4">
                                                                    <span class="form-label fw-bold" style="font-weight: 800;">Special Case:</span><br />
                                                                    <asp:TextBox runat="server" ID="tbSpecialCase" ReadOnly="true" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
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
                                                            <div class="col-md-12 mb-3">
                                                                <div class="form-group">
                                                                    <span class="font-weight-bold text-dark">Remarks</span>
                                                                    <asp:TextBox ID="tbTechRemarks" runat="server" OnKeypress="return isAlphaNumeric(event);" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                                                </div>
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
                                                    <div class="ibox-content text-dark">
                                                        <div class="col-lg-12">
                                                            <div class="form-group row mb-3">
                                                                <div class="col-md-4">
                                                                    <span class="form-label fw-bold" style="font-weight: 800;">Type</span><br />
                                                                    <asp:DropDownList runat="server" ID="dropDeductionType" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;">
                                                                        <%--                                                                        <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>                                                                        --%>
                                                                    </asp:DropDownList>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <span class="form-label fw-bold" style="font-weight: 800;">Amount</span><br />
                                                                    <asp:TextBox runat="server" ID="tbAmount" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <span class="form-label fw-bold" style="font-weight: 800;">Remarks</span><br />
                                                                    <asp:TextBox runat="server" ID="tbDedRemarks" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                </div>
                                                                <div class="w-100 my-1"></div>
                                                                <div class="col-md-4"></div>
                                                                <div class="col-md-4">
                                                                    <div class="col-lg-12 text-start">
                                                                        <asp:Button runat="server" Text="Add Deduction" ID="btnAddDeduction" class="btn btn-primary rounded-pill mt-3" OnClick="AddDeduction_Click" />
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4"></div>
                                                                <div class="w-100 my-2"></div>
                                                                <div class="col-md-4">
                                                                    <span class="form-label fw-bold" style="font-weight: 800;">Total Deducted Amount:</span><br />
                                                                    <asp:TextBox runat="server" ID="tbTotalDeductedAmt" Enabled="false" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <span class="form-label fw-bold" style="font-weight: 800;">Total Claim Amount:</span><br />
                                                                    <asp:TextBox runat="server" ID="tbFinalAmt" Enabled="false" CssClass="border-bottom" Style="border-color: transparent; outline: none;"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <span class="form-label fw-bold" style="font-weight: 800;">Final Amount To Be Paid:</span><br />
                                                                    <asp:TextBox runat="server" ID="tbFinalAmtAfterDeduction" Enabled="false" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                </div>
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
                                                                    <asp:TemplateField HeaderText="Acted By Role">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="Label10" runat="server" Text='<%# Eval("RoleName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Action Taken">
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
                                                                    <asp:TemplateField HeaderText="Remarks">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="Label11" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
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
                                            <div class="ibox mt-4" id="PreauthActualUtilization">
                                                <div class="ibox-title text-center">
                                                    <h3 class="text-white">Preauth Actual Utilization</h3>
                                                </div>
                                                <div class="ibox-content table-responsive">
                                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999"
                                                        BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%"
                                                        CssClass="table table-bordered table-striped">
                                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Action Type">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbQueryDate" runat="server" Text='<%# Eval("QueryRaisedDate") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="From Date">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbMainReason" runat="server" Text='<%# Eval("ReasonName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="To Date">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbSubReason" runat="server" Text='<%# Eval("SubReasonName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Ward Type">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbPPDQuery" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="25%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Ward Rent Per Day">
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnViewAudit" runat="server" Text="Pending" class="btn btn-warning btn-sm rounded-pill" Style="font-size: 12px;" />
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="No Of Days">
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnViewAudit" runat="server" Text="Pending" class="btn btn-warning btn-sm rounded-pill" Style="font-size: 12px;" />
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Total Amount">
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnViewAudit" runat="server" Text="Pending" class="btn btn-warning btn-sm rounded-pill" Style="font-size: 12px;" />
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <div class="row mt-4 text-dark">
                                                        <div class="col-12 mb-3">
                                                            <span class="form-label fw-bold" style="font-weight: 800;">Sum Of Actual No Of Days</span>
                                                            <asp:TextBox runat="server" ID="tbSumActualDay" ReadOnly="true" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none; padding-left: 5px;"></asp:TextBox>
                                                        </div>
                                                        <div class="col-12">
                                                            <span class="form-label fw-bold" style="font-weight: 800;">Sum Of Actual Total Amount</span>
                                                            <asp:TextBox runat="server" ID="tbSumTotalAmt" ReadOnly="true" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none; padding-left: 5px;"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="ibox mt-4">
                                                <div class="ibox-title text-center">
                                                    <h3 class="text-white">Claim Query/ Rejection Reason</h3>
                                                </div>
                                                <div class="ibox-content table-responsive">
                                                    <asp:GridView ID="gridClaimQueryRejectionReason" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Sl. No.">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Query Date">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbQueryDate" runat="server" Text='<%# Eval("QueryRaisedDate") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Main Reason">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbMainReason" runat="server" Text='<%# Eval("ReasonName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Sub Reason">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbSubReason" runat="server" Text='<%# Eval("SubReasonName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="PPD Query">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbPPDQuery" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="25%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Audit">
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnViewAudit" runat="server" Text="Pending" class="btn btn-warning btn-sm rounded-pill" Style="font-size: 12px;" />
                                                                    <%--OnClick="btnViewAudit_Click"--%>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="ibox mt-4">
                                                <div class="ibox-content">
                                                    <div class="row mt-3">
                                                        <div class="col-md-12 form-check mb-3">
                                                            <asp:CheckBox ID="cbTerms" runat="server" CssClass="" Text="&nbsp;&nbsp;I have reviewed the case with best of my knowledge and have validated all documents before making any decision." />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold font-weight-bold text-dark">Action<span class="text-danger">*</span></span>
                                                            <asp:DropDownList ID="ddlActionType" runat="server" CssClass="form-control mt-2" AutoPostBack="True" OnSelectedIndexChanged="ddlActionType_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </div>
                                                        <asp:Panel ID="pUserRole" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Select User Role<span class="text-danger">*</span></span>
                                                            <asp:DropDownList ID="ddlUserRole" runat="server" CssClass="form-control mt-2" AutoPostBack="True">
                                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                                <asp:ListItem Text="CPD INSURER" Value="1"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </asp:Panel>
                                                        <asp:Panel ID="pUserToAssign" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Select User To Assign<span class="text-danger">*</span></span>
                                                            <asp:DropDownList ID="ddlUserToAssign" runat="server" CssClass="form-control mt-2" AutoPostBack="True">
                                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </asp:Panel>
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
                                                        <asp:Panel ID="pRemarks" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Remarks</span>
                                                            <asp:TextBox runat="server" ID="tbRejectRemarks" class="form-control mt-2"></asp:TextBox>
                                                        </asp:Panel>
                                                        <asp:Panel ID="pTriggerType" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Select Trigger Type<span class="text-danger">*</span></span>
                                                            <asp:DropDownList ID="ddTriggerType" runat="server" CssClass="form-control mt-2" AutoPostBack="True">
                                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </asp:Panel>
                                                    </div>

                                                    <div class="row mt-3">
                                                        <div class="col-lg-12 text-start">
                                                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary rounded-pill" Text="Submit" OnClick="btnSubmit_Click" AutoPostBack="True" />
                                                            <asp:Label ID="lblMessage" runat="server" CssClass="text-success" Style="margin-left: 10px;"></asp:Label>
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
                                    <asp:View ID="ViewAttachment" runat="server">
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
                                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
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
                                                        <div class="tab-pane fade show active" id="six" role="tabpanel">
                                                            <div class="ibox-title text-center">
                                                                <h3 class="text-white">Special Investigations</h3>
                                                            </div>
                                                            <div class="ibox-content table-responsive">
                                                                <asp:GridView ID="gridSpecialInvestigation" runat="server" AutoGenerateColumns="False" OnRowDataBound="gridSpecialInvestigation_RowDataBound" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
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
                                                                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
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
                                                                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
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
                                                    <asp:Button ID="btnDownloadPdf" runat="server" Text="Download As One PDF" class="btn btn-primary rounded-pill" OnClick="btnDownloadPdf_Click" />
                                                </div>
                                            </div>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="ViewQuestionnaire" runat="server">
                                        <div class="tab-pane fade show active" id="Questionnaire" role="tabpanel">
                                            <div class="ibox mt-4">
                                                <div class="ibox-title text-center">
                                                    <h3 class="text-white">Questionnaire</h3>
                                                </div>
                                                <div class="ibox-content table-responsive">
                                                    <asp:GridView ID="gvQuestionnaire" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped"
                                                        GridLines="None" Width="100%">
                                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                                        <Columns>

                                                            <asp:TemplateField HeaderText="S.No.">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Questions">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblQuestion" runat="server" Text='<%# Eval("Question") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60%" />
                                                            </asp:TemplateField>


                                                            <asp:TemplateField HeaderText="Options">
                                                                <ItemTemplate>
                                                                    <asp:RadioButton ID="rbYes" runat="server" GroupName='<%# "Option" + Container.DataItemIndex %>' Text="Yes" />
                                                                    <asp:RadioButton ID="rbNo" runat="server" GroupName='<%# "Option" + Container.DataItemIndex %>' Text="No" />
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>

                                        </div>
                                    </asp:View>
                                </asp:MultiView>
                                <div class="modal fade" id="contentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-xl">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <asp:Label ID="lbTitle" runat="server" Text="" class="modal-title fs-5 font-weight-bolder"></asp:Label>
                                                <button type="button" class="btn-close" onclick="hideModal();"></button>
                                            </div>
                                            <asp:MultiView ID="MultiView3" runat="server">

                                                <asp:View ID="viewPhoto" runat="server">
                                                    <div class="modal-body">
                                                        <div class="row table-responsive" style="max-height: 700px; overflow-y: scroll;">
                                                            <asp:Image ID="imgChildView" runat="server" class="img-fluid" AlternateText="Patient Document" />
                                                        </div>
                                                    </div>
                                                </asp:View>
                                            </asp:MultiView>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </asp:View>
                <asp:View ID="viewNoDataPending" runat="server">
                    <div class="d-flex align-items-center justify-content-center m-5">
                        <asp:Label ID="lbNodataPending" runat="server" CssClass="font-weight-bold text-danger fs-2" Font-Size="Larger" Text="There Is No Pending Case Right Now."></asp:Label>
                    </div>
                </asp:View>
            </asp:MultiView>

            <%--            <asp:MultiView ID="mvNoRecords" runat="server" ActiveViewIndex="0">--%>

            <%--            </asp:MultiView>--%>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnDownloadPdf" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
