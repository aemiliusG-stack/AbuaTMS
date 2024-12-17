<%@ Page Title="" Language="C#" MasterPageFile="~/CEX/CEX.master" AutoEventWireup="true" CodeFile="CEXClaimUpdation.aspx.cs" Inherits="CEX_CEXClaimUpdation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
            if (count > 10) {
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
            PageMethods.NotifyInactivity((result) => {
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

        window.onbeforeunload = function () {
            sendDataToServer();
        };
        function sendDataToServer() {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "CEXClaimUpdation.aspx/NotifyInactivity", true);
            xhr.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
            xhr.send(JSON.stringify({ message: "User closed the tab/window." }));
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">

        <ContentTemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdRoleId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdAbuaId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPatientRegId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdCaseNo" runat="server" Visible="false" />
            <asp:HiddenField ID="hdClaimId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdAdmissionId" runat="server" Visible="false" />
            <asp:MultiView ID="MultiView1" runat="server">
                <asp:View ID="ViewClaimupdationpage" runat="server">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="ibox ">
                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                    <div class="d-flex w-100 justify-content-center position-relative">
                                        <h3 class="m-0">Patient Details</h3>
                                    </div>
                                    <div class="text-white text-nowrap">
                                        <span class="font-weight-bold">Case No:</span>
                                        <asp:Label ID="lbCaseNo" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="ibox-content text-dark">
                                    <div class="row">
                                        <div class="col-lg-9">
                                            <div class="row">
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Name:</span><br />
                                                    <asp:Label ID="lbName" runat="server"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Beneficiary Card ID:</span><br>
                                                    <asp:Label ID="lbBenCardId" runat="server"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Registration No:</span><br>
                                                    <asp:Label ID="lbRegistrationNo" runat="server"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Case No:</span><br>
                                                    <asp:Label ID="lbCaseNumber" runat="server"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Case Status:</span><br>
                                                    <asp:Label ID="lbCAseStatus" runat="server" Text="N/A"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">IP No:</span><br>
                                                    <asp:Label ID="lbIPNo" runat="server" Text="N/A"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">IP Registered Date:</span><br>
                                                    <asp:Label ID="lbRegDate" runat="server"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Actual Registeration Date:</span><br>
                                                    <asp:Label ID="lbActualRegDate" runat="server" Text="N/A"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Communication Contact No:</span><br>
                                                    <asp:Label ID="lbComContactNo" runat="server"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Hospital Type:</span><br>
                                                    <asp:Label ID="lbHospitalType" runat="server" Text="N/A"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Gender:</span><br>
                                                    <asp:Label ID="lbGender" runat="server"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Family ID:</span><br>
                                                    <asp:Label ID="lbFamilyID" runat="server"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Age:</span><br>
                                                    <asp:Label ID="lbAge" runat="server" Text="N/A"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Aadhar Verified:</span><br>
                                                    <asp:Label ID="lbAadharVerified" runat="server"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Authentication at Reg/Dis:</span><br>
                                                    <asp:Label ID="lbAuthenticationAtRegDis" runat="server" Text="N/A" CssClass="font-weight-bold text-danger"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Patient District:</span><br>
                                                    <asp:Label ID="lbPatientDistrict" runat="server"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Patient Scheme:</span><br>
                                                    <asp:Label ID="lbPatientSchene" runat="server" Text="MMASSY"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row col-lg-3">
                                            <div class="col-lg-6 align-items-center">
                                                <asp:Image ID="imgPatientPhoto" runat="server" ImageUrl="../images/user_img.jpeg" CssClass="img-fluid mb-3" Style="max-width: 100px; height: 140px;" AlternateText="Patient Photo" />
                                            </div>
                                            <div class="col-lg-6 align-items-center">
                                                <asp:Image ID="imgPatientPhotosecond" runat="server" ImageUrl="../images/user_img.jpeg" CssClass="img-fluid mb-3" Style="max-width: 100px; height: 140px;" AlternateText="Patient Photo" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <li class="nav-item ml-3">
                                    <asp:Button ID="btnPastHistory" runat="server" Text="Past History" OnClick="btnPastHistory_Click" class="nav-link d-flex flex-column align-items-center" />
                                </li>
                                <li class="nav-item ml-3">
                                    <asp:Button ID="btnPreauth" runat="server" Text="Preauthorization" OnClick="btnPreauth_Click" class="nav-link d-flex flex-column align-items-center" />
                                </li>
                                <li class="nav-item ml-3">
                                    <asp:Button ID="btnTreatment" runat="server" Text="Treatment And Discharge" OnClick="btnTreatment_Click" class="nav-link d-flex flex-column align-items-center" />
                                </li>
                                <li class="nav-item ml-3">
                                    <asp:Button ID="btnClaims" runat="server" Text="Claims" OnClick="btnClaims_Click" class="nav-link d-flex flex-column align-items-center" />
                                </li>
                                <li class="nav-item ml-3">
                                    <asp:Button ID="btnAttachments" runat="server" Text="Attachments" OnClick="btnAttachments_Click" class="nav-link d-flex flex-column align-items-center" />
                                </li>
                            </ul>
                            <div class="tab-content mt-4" id="myTabContent">
                                <asp:MultiView ID="mvCEXTabs" runat="server">
                                    <%--Past History--%>
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
                                                                <asp:Label ID="lbRegisterdDate" runat="server" Text='<%# Eval("address") %>'></asp:Label>
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
                                    <%-- Preauthorization--%>
                                    <asp:View ID="ViewPreauth" runat="server">
                                        <div class="tab-pane fade show active" id="Preauth" role="tabpanel" aria-labelledby="profile-tab">
                                            <%--Network Hospital Details--%>
                                            <div class="ibox mt-4">
                                                <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                    <div class="w-100 text-center">
                                                        <h3 class="m-0">Network Hospital Details</h3>
                                                    </div>
                                                </div>
                                                <div class="ibox-content">
                                                    <div class="row text-dark">
                                                        <div class="form-group col-md-4 mb-3">
                                                            <span class="font-weight-bold text-dark">Name:</span><br />
                                                            <asp:Label ID="lbHosName" runat="server" Text="CHC Sneha" CssClass="small-text"></asp:Label>
                                                        </div>
                                                        <div class="form-group col-md-4 mb-3">
                                                            <span class="font-weight-bold text-dark">Type:</span><br />
                                                            <asp:Label ID="lbHosType" runat="server" Text="Public" CssClass="small-text"></asp:Label>
                                                        </div>
                                                        <div class="form-group col-md-4 mb-3">
                                                            <span class="font-weight-bold text-dark">Address:</span><br />
                                                            <asp:Label ID="lbHosAddress" runat="server" Text="LOHARDAGA, JHARKHAND" CssClass="small-text"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <%--ICD Details--%>

                                            <div class="ibox">
                                                <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                    <div class="w-100 text-center">
                                                        <h3 class="m-0">Primary Diagnosis ICD Values</h3>
                                                    </div>
                                                </div>
                                                <div class="ibox-content">
                                                    <asp:GridView ID="GridPrimaryDiagnosis" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false">
                                                        <Columns>
                                                            <asp:BoundField DataField="S No" HeaderText="S No" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="ICD Code" HeaderText="ICD Code" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="ICD Description" HeaderText="ICD Description" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Acted By Role" HeaderText="Acted By Role" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <%-- Treatment Protocol--%>
                                            <div class="ibox mt-4">
                                                <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                    <div class="w-100 text-center">
                                                        <h3 class="m-0">Treatment Protocol</h3>
                                                    </div>
                                                </div>
                                                <div class="ibox-content">
                                                    <asp:GridView ID="GridTreatmentProtocol" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false">
                                                        <Columns>
                                                            <asp:BoundField DataField="SpecialityName" HeaderText="Speciality" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="ProcedureName" HeaderText="Procedure" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="ProcedureAmountFinal" HeaderText="Amount(Rs)" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="StratificationName" HeaderText="Stratification" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="ImplantName" HeaderText="Implants" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField HeaderText="Update ICHI Details" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <%--ICHI Details--%>
                                            <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                <div class="w-100 text-center">
                                                    <h3 class="m-0">ICHI Details</h3>
                                                </div>
                                            </div>
                                            <div class="ibox-content">
                                                <asp:GridView ID="GridICHIDetail" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false">
                                                    <Columns>
                                                        <asp:BoundField DataField="Procedure Name" HeaderText="Procedure Name" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                        <asp:BoundField DataField="ICHI Code given By Medco" HeaderText="ICHI Code given By Medco" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                        <asp:BoundField DataField="ICHI Code given By PPD Insurer" HeaderText="ICHI Code given By PPD Insurer" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                        <asp:BoundField DataField="ICHI Code given By CPD Insurer" HeaderText="ICHI Code given By CPD Insurer" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                        <asp:BoundField DataField="ICHI Code given By SAFO" HeaderText="ICHI Code given By SAFO" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                        <asp:BoundField DataField="ICHI Code given By NAFO" HeaderText="ICHI Code given By NAFO" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <%--Addmission Details--%>
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
                                                                        <asp:RadioButton ID="rbAdmissionTypePlanned" runat="server" GroupName="AdmissionType" Enabled="false" CssClass="form-check-input" />
                                                                        <span class="font-weight-bold text-dark">Planned</span>
                                                                    </div>
                                                                    <div class="form-check form-check-inline">
                                                                        <asp:RadioButton ID="rbAdmissionTypeEmergency" runat="server" GroupName="AdmissionType" Enabled="false" CssClass="form-check-input" />
                                                                        <span class="font-weight-bold text-dark">Emergency</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8 mb-3">
                                                            <div class="form-group">
                                                                <span class="font-weight-bold text-dark">Admission Date</span><br />
                                                                <asp:Label ID="lbAdmissionDate" runat="server" CssClass="border-bottom"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <span class="font-weight-bold text-dark">Package Cost</span>
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <asp:Label ID="lbPackageCostshow" runat="server" CssClass="form-label" Text="64748" />
                                                            <hr />
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <span class="font-weight-bold text-dark">Hospital Incentive:</span>
                                                            <asp:Label ID="lbHospitalIncentive" runat="server" CssClass="form-label" Text="110%" />
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <span class="font-weight-bold text-dark">Incentive Amount</span>
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <asp:Label ID="lbIncentiveAmountShow" runat="server" CssClass="form-label" Text="2750" />
                                                            <hr />
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <span class="font-weight-bold text-dark">Total Package Cost</span>
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <asp:Label ID="lbTotalPackageCostShow" runat="server" CssClass="form-label" Text="64748" />
                                                            <hr />
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                        </div>

                                                        <asp:Panel ID="PanelTotLiableInsurance" Visible="false" runat="server" CssClass="form-group col-md-4 mb-3">
                                                            <span class="font-weight-bold text-dark">Total Amount Liable by Insurance is:</span><br />
                                                        </asp:Panel>
                                                        <asp:Panel ID="PanelTotLiableInsuranceIs" Visible="false" runat="server" CssClass="form-group col-md-4 mb-3">
                                                            <asp:Label ID="lbTotalLiableAmountByInsurer" runat="server" CssClass="small-text"></asp:Label>
                                                            <hr />
                                                        </asp:Panel>
                                                        <div class="col-md-4 mb-3">
                                                        </div>
                                                        <asp:Panel ID="PanelTotLiableTrust" Visible="false" runat="server" CssClass="form-group col-md-4 mb-3">
                                                            <span class="font-weight-bold text-dark">Total Amount Liable by Trust is:</span><br />
                                                        </asp:Panel>
                                                        <asp:Panel ID="PanelTotLiableTrustIs" Visible="false" runat="server" CssClass="form-group col-md-4 mb-3">
                                                            <asp:Label ID="lbTotalLiableAmountByTrust" runat="server" CssClass="small-text"></asp:Label>
                                                            <hr />
                                                        </asp:Panel>
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
                                            <%--work Flow--%>
                                            <div class="ibox">
                                                <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                    <div class="w-100 text-center">
                                                        <h3 class="m-0">Work Flow</h3>
                                                    </div>
                                                </div>
                                                <div class="ibox-content">
                                                    <asp:GridView ID="GridWorkflow" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false">
                                                        <Columns>
                                                            <asp:BoundField DataField="S No" HeaderText="S No" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Date and Time" HeaderText="Date and Time" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Role" HeaderText="Role" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Action" HeaderText="Action" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Amount" HeaderText="Amount(Rs)" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Preauth Querry Rejection" HeaderText="Preauth Querry Rejection" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="form-group mb-0 d-flex align-items-center">
                                                <asp:CheckBox ID="cbPreauth" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;I have reviewed the cases with best of my knowledge and have validated all documents before making any decision" runat="server" />
                                            </div>
                                        </div>
                                    </asp:View>
                                    <%-- Treatment and Discharge--%>
                                    <asp:View ID="ViewTreatmentDischarge" runat="server">
                                        <div class="tab-pane fade show active" id="TretDischarge" role="tabpanel" aria-labelledby="contact-tab">
                                            <%--Surgeon Details--%>
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
                                                                <asp:Label ID="lbContactNo" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
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
                                                                        <asp:RadioButton ID="rbOPPhotoYes" runat="server" GroupName="OPPhotoWebEx" Enabled="False" Text="&nbsp;&nbsp;&nbsp;Yes" CssClass="form-check-input" />
                                                                    </div>
                                                                    <div class="form-check form-check-inline">
                                                                        <asp:RadioButton ID="rbOPPhotoNo" runat="server" GroupName="OPPhotoWebEx" Enabled="False" Text="&nbsp;&nbsp;&nbsp;No" CssClass="form-check-input" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <div class="form-group">
                                                                <span class="font-weight-bold text-dark">Vedio Recording Done</span><br />
                                                                <div class="d-flex">
                                                                    <div class="form-check form-check-inline me-2">
                                                                        <asp:RadioButton ID="rbVedioRecDoneYes" runat="server" GroupName="VedioRecording" Enabled="False" Text="&nbsp;&nbsp;&nbsp;Yes" CssClass="form-check-input" />
                                                                    </div>
                                                                    <div class="form-check form-check-inline">
                                                                        <asp:RadioButton ID="rbVedioRecDoneNo" runat="server" GroupName="VedioRecording" Enabled="False" Text="&nbsp;&nbsp;&nbsp;No" CssClass="form-check-input" />
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
                                                                        <asp:RadioButton ID="rbSpecimenRemoveYes" runat="server" GroupName="SpecimenRemoved" Enabled="False" Text="&nbsp;&nbsp;&nbsp;Yes" CssClass="form-check-input" />
                                                                    </div>
                                                                    <div class="form-check form-check-inline">
                                                                        <asp:RadioButton ID="rbSpecimenRemoveNo" runat="server" GroupName="SpecimenRemoved" Enabled="False" Text="&nbsp;&nbsp;&nbsp;No" CssClass="form-check-input" />
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
                                                                    <span class="font-weight-bold text-dark">Procedural Consent</span><br />
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
                                    <%--Claim--%>
                                    <asp:View ID="ViewClaim" runat="server">
                                        <div class="tab-pane fade show active" id="Claim" role="tabpanel" aria-labelledby="contact-tab">
                                            <%--ICD Details--%>

                                            <div class="ibox">
                                                <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                    <div class="w-100 text-center">
                                                        <h3 class="m-0">Primary Diagnosis ICD Values</h3>
                                                    </div>
                                                </div>
                                                <div class="ibox-content">
                                                    <asp:GridView ID="GridPrimaryICDValue" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false">
                                                        <Columns>
                                                            <asp:BoundField DataField="S No" HeaderText="S No" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="ICD Code" HeaderText="ICD Code" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="ICD Description" HeaderText="ICD Description" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Acted By Role" HeaderText="Acted By Role" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <%--Claim Details--%>
                                            <div class="ibox mt-4">
                                                <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                    <div class="w-100 text-center">
                                                        <h3 class="m-0">Claim Details</h3>
                                                    </div>
                                                </div>
                                                <div class="ibox-content">
                                                    <div class="row text-dark">
                                                        <div class="form-group col-md-3 mb-3">
                                                            <span class="font-weight-bold text-dark">Preauth Approved Amount(Rs.):</span><br />
                                                            <asp:Label ID="lbPreauthApprAmount" runat="server" CssClass="small-text"></asp:Label>
                                                        </div>
                                                        <div class="form-group col-md-3 mb-3">
                                                            <span class="font-weight-bold text-dark">Preauth Date:</span><br />
                                                            <asp:Label ID="lbPreauthDate" runat="server" CssClass="small-text"></asp:Label>
                                                        </div>
                                                        <div class="form-group col-md-3 mb-3">
                                                            <span class="font-weight-bold text-dark">Claim Submitted Date:</span><br />
                                                            <asp:Label ID="lbClaimSubmittedDate" runat="server" CssClass="small-text"></asp:Label>
                                                        </div>
                                                        <div class="form-group col-md-3 mb-3">
                                                            <span class="font-weight-bold text-dark">Last Claim Updated Date:</span><br />
                                                            <asp:Label ID="lbLastClaimUpdatedDate" runat="server" CssClass="small-text"></asp:Label>
                                                        </div>
                                                        <div class="form-group col-md-3 mb-3">
                                                            <span class="font-weight-bold text-dark">Penalty Amount(Rs.):</span><br />
                                                            <asp:Label ID="lbPenaltyAmount" runat="server" Text="N/A" CssClass="small-text"></asp:Label>
                                                        </div>
                                                        <div class="form-group col-md-3 mb-3">
                                                            <span class="font-weight-bold text-dark">Claim Amount(Rs.):</span><br />
                                                            <asp:Label ID="lbClaimAmount" runat="server" CssClass="small-text"></asp:Label>
                                                        </div>
                                                        <asp:Panel ID="pnlInsuranceamount" Visible="false" runat="server" CssClass="form-group col-md-3 mb-3">
                                                            <span class="font-weight-bold text-dark">Insurance liable Amount(Rs.):</span><br />
                                                            <asp:Label ID="lbpnlInsuranceAmount" runat="server" CssClass="small-text"></asp:Label>
                                                        </asp:Panel>
                                                        <asp:Panel ID="pnlTrustAmount" Visible="false" runat="server" CssClass="form-group col-md-3 mb-3">
                                                            <span class="font-weight-bold text-dark">Trust liable Amount(Rs.):</span><br />
                                                            <asp:Label ID="lbpnlTrustAmount" runat="server" CssClass="small-text"></asp:Label>
                                                        </asp:Panel>
                                                        <%--<div class="form-group col-md-3 mb-3">
                                                    <span class="font-weight-bold text-dark">Insurance liable Amount(Rs.):</span><br />
                                                    <asp:Label ID="lbInsuranceliableAmount" runat="server" CssClass="small-text"></asp:Label>
                                                </div>
                                                <div class="form-group col-md-3 mb-3">
                                                    <span class="font-weight-bold text-dark">Trust liable Amount(Rs.):</span><br />
                                                    <asp:Label ID="lbTrustLiableAmount" runat="server" CssClass="small-text"></asp:Label>
                                                </div>--%>
                                                        <div class="form-group col-md-3 mb-3">
                                                            <span class="font-weight-bold text-dark">Bill Amount(Rs):</span><br />
                                                            <asp:Label ID="lbBillAmount" runat="server" CssClass="small-text"></asp:Label>
                                                        </div>
                                                        <div class="form-group col-md-3 mb-3">
                                                            <span class="font-weight-bold text-dark">Final E-rupi voucher amount(Rs):</span><br />
                                                            <asp:Label ID="lbFinalERupiVoucherAmount" runat="server" Text="N/A" CssClass="small-text"></asp:Label>
                                                        </div>
                                                        <div class="form-group col-md-12 mb-3">
                                                            <span class="font-weight-bold text-dark">Remarks:</span><br />
                                                            <asp:TextBox ID="tbRemark" CssClass="form-control" ReadOnly="true" TextMode="MultiLine" OnKeypress="return isAlphaNumeric(event);" runat="server"></asp:TextBox>
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
                                                                    <asp:RadioButton ID="rbIsNameCorrectYes" runat="server" GroupName="IsNameCorrect" CssClass="form-check-input" />
                                                                    <span class="font-weight-bold text-dark">Yes</span>
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbIsNameCorrectNo" runat="server" GroupName="IsNameCorrect" CssClass="form-check-input" />
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
                                                                    <asp:RadioButton ID="rbIsGenderCorrectYes" runat="server" GroupName="IsGenderCorrect" CssClass="form-check-input" />
                                                                    <span class="font-weight-bold text-dark">Yes</span>
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbIsGenderCorrectNo" runat="server" GroupName="IsGenderCorrect" CssClass="form-check-input" />
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
                                                                    <asp:RadioButton ID="rbIsPhotoVerifiedYes" runat="server" GroupName="IsPhotoVerified" CssClass="form-check-input" />
                                                                    <span class="font-weight-bold text-dark">Yes</span>
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbIsPhotoVerifiedNo" runat="server" GroupName="IsPhotoVerified" CssClass="form-check-input" />
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
                                                            <span class="font-weight-bold text-dark">Case Sheet</span>
                                                            <asp:TextBox ID="tbCSAdmissionDate" runat="server" TextMode="Date" AutoPostBack="true" OnTextChanged="tbCSAdmissionDate_TextChanged" CssClass="form-control border-0 border-bottom"></asp:TextBox>
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
                                                            <span class="font-weight-bold text-dark">Case Sheet</span>
                                                            <asp:TextBox ID="tbCSTherepyDate" runat="server" TextMode="Date" AutoPostBack="true" OnTextChanged="tbCSTherepyDate_TextChanged" CssClass="form-control border-0 border-bottom"></asp:TextBox>
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
                                                            <span class="font-weight-bold text-dark">Case Sheet</span>
                                                            <asp:TextBox ID="tbCSDischargeDate" runat="server" TextMode="Date" AutoPostBack="true" OnTextChanged="tbCSDischargeDate_TextChanged" CssClass="form-control border-0 border-bottom"></asp:TextBox>
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
                                                                    <asp:RadioButton ID="rbIsSignVerifiedYes" runat="server" GroupName="IsSignVerified" CssClass="form-check-input" />
                                                                    <span class="font-weight-bold text-dark">Yes</span>
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbIsSignVerifiedNo" runat="server" GroupName="IsSignVerified" CssClass="form-check-input" />
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
                                                                    <asp:RadioButton ID="rbIsReportCorrectYes" runat="server" GroupName="IsReportCorrect" CssClass="form-check-input" />
                                                                    <span class="font-weight-bold text-dark">Yes</span>
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbIsReportCorrectNo" runat="server" GroupName="IsReportCorrect" CssClass="form-check-input" />
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
                                                                    <asp:RadioButton ID="rbIsReportVerifiedYes" runat="server" GroupName="IsReportVerified" CssClass="form-check-input" />
                                                                    <span class="font-weight-bold text-dark">Yes</span>
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbIsReportVerifiedNo" runat="server" GroupName="IsReportVerified" CssClass="form-check-input" />
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
                                            <%--WorkFlow--%>
                                            <div class="ibox">
                                                <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                    <div class="w-100 text-center">
                                                        <h3 class="m-0">Work Flow</h3>
                                                    </div>
                                                </div>
                                                <div class="ibox-content">
                                                    <asp:GridView ID="GridWorkFlowClaim" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false">
                                                        <Columns>
                                                            <asp:BoundField DataField="S No" HeaderText="S No" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Date and Time" HeaderText="Date and Time" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Name" HeaderText="Name" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Action" HeaderText="Action" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Approved Amount" HeaderText="Approved Amount(Rs)" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                            <asp:BoundField DataField="Claim Querry Rejection" HeaderText="Claim Querry Rejection" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="col-md-3 mb-3">
                                                    <div class="form-group">
                                                        <asp:Label ID="ibActionType" runat="server" CssClass="form-label font-weight-bold text-dark" Text="Action Type"></asp:Label>
                                                        <asp:DropDownList ID="dropActionType" runat="server" CssClass="form-control" AutoPostBack="true">
                                                            <asp:ListItem Value="0">Select</asp:ListItem>
                                                            <asp:ListItem Value="1">Forward</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="form-group mb-0 d-flex align-items-center">
                                                    <asp:CheckBox ID="cbcheckbox" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;I have reviewed the cases with best of my knowledge and have validated all documents before making any decision" runat="server" />
                                                </div>
                                                <div class="col-lg-12 text-center mt-3">
                                                    <asp:Button ID="btnSubmitNonTechChecklist" runat="server" CssClass="btn btn-success rounded-pill" Text="Submit" OnClick="btnSubmitNonTechChecklist_Click" />
                                                </div>
                                            </div>
                                            <div class="col-md-12 mb-3">
                                                <div class="form-group">
                                                    <span class="text-danger font-weight-bold">Insurance Wallet Amount Rs 100,000</span><br />
                                                    <span class="text-danger font-weight-bold">Scheme Wallet Amount Rs 500,000</span>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:View>
                                    <%--Attachments--%>
                                    <asp:View ID="ViewAttachment" runat="server">
                                        <div class="tab-pane fade show active" id="Attachments" role="tabpanel" aria-labelledby="contact-tab">
                                            <div class="tab-pane fade show active" id="attachment" role="tabpanel">
                                                <ul class="nav nav-tabs d-flex flex-row justify-content-around" id="attachTab" role="tablist">
                                                    <li class="nav-item">
                                                        <asp:LinkButton ID="lnkPreauthorization" ToolTip="Preauthorization" runat="server" OnClick="lnkPreauthorization_Click" CssClass="nav-link active nav-attach"><i class="bi bi-card-text text-black" ></i></asp:LinkButton>
                                                    </li>
                                                    <li class="nav-item ml-2">
                                                        <asp:LinkButton ID="lnkDischarge" ToolTip="Discharge" runat="server" OnClick="lnkDischarge_Click" CssClass="nav-link nav-attach"><i class="bi bi-building-add text-black"></i></asp:LinkButton>
                                                    </li>
                                                    <li class="nav-item ml-2">
                                                        <asp:LinkButton ID="lnkDeath" ToolTip="Death" runat="server" OnClick="lnkDeath_Click" CssClass="nav-link nav-attach"><i class="bi bi-clipboard-x text-black"></i></asp:LinkButton>
                                                    </li>
                                                    <li class="nav-item ml-2">
                                                        <asp:LinkButton ID="lnkClaim" ToolTip="Claim" runat="server" OnClick="lnkClaim_Click" CssClass="nav-link nav-attach"><i class="bi bi-clipboard2-data text-black"></i></asp:LinkButton>
                                                    </li>
                                                    <li class="nav-item ml-2">
                                                        <asp:LinkButton ID="lnkGeneralInvestigation" ToolTip="General Investigation" runat="server" OnClick="lnkGeneralInvestigation_Click" CssClass="nav-link nav-attach"><i class="bi bi-zoom-in text-black"></i></asp:LinkButton>
                                                    </li>
                                                    <li class="nav-item ml-2">
                                                        <asp:LinkButton ID="lnkSpecialInvestigation" ToolTip="Special Investigation" runat="server" OnClick="lnkSpecialInvestigation_Click" CssClass="nav-link nav-attach"><i class="bi bi-zoom-in text-black"></i></asp:LinkButton>
                                                    </li>
                                                    <li class="nav-item ml-2">
                                                        <asp:LinkButton ID="lnkFraudDocuments" ToolTip="Fraud Documents" runat="server" OnClick="lnkFraudDocuments_Click" CssClass="nav-link nav-attach"><i class="bi bi-card-text text-black"></i></asp:LinkButton>
                                                    </li>
                                                    <li class="nav-item ml-2">
                                                        <asp:LinkButton ID="lnkAuditDocuments" ToolTip="Audit Documents" runat="server" OnClick="lnkAuditDocuments_Click" CssClass="nav-link nav-attach"><i class="bi bi-card-text text-black"></i></asp:LinkButton>
                                                    </li>
                                                </ul>
                                                <div class="col-md-12 p-3">
                                                    <asp:Button ID="btnViewInactiveAttachment" runat="server" Text="View All Inactive Attachments" class="btn btn-success rounded-pill" />
                                                    <asp:Button ID="btnViewAnamolyAttathment" runat="server" Text="View Data Anamoly Attachments" class="btn btn-success rounded-pill" />
                                                </div>
                                                <div class="tab-content" id="attachTabContent">
                                                    <asp:MultiView ID="MultiView2" runat="server" ActiveViewIndex="0">
                                                        <asp:View ID="viewPreauthorization" runat="server">
                                                            <div class="tab-pane fade show active" id="one" role="tabpanel">
                                                                <div class="ibox-title text-center">
                                                                    <h3 class="text-white">Preauthorization</h3>
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
                                                                                <%--<td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>--%>
                                                                                <td> <asp:LinkButton ID="LinkButton1"  runat="server"  CssClass="text-decoration-none" OnClick="LinkButton1_Click"><span>Patient Photo</span></asp:LinkButton></td>
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
                                                        </asp:View>
                                                        <asp:View ID="viewDischarge" runat="server">
                                                            <div class="tab-pane fade show active" id="two" role="tabpanel">
                                                                <div class="ibox-title text-center">
                                                                    <h3 class="text-white">Discharge</h3>
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
                                                        </asp:View>
                                                        <asp:View ID="viewDeath" runat="server">
                                                            <div class="tab-pane fade show active" id="three" role="tabpanel">
                                                                <div class="ibox-title text-center">
                                                                    <h3 class="text-white">Death</h3>
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
                                                        </asp:View>
                                                        <asp:View ID="viewClaims" runat="server">
                                                            <div class="tab-pane fade show active" id="four" role="tabpanel">
                                                                <div class="ibox-title text-center">
                                                                    <h3 class="text-white">Claims</h3>
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
                                                        </asp:View>
                                                        <asp:View ID="viewGeneralInvestigation" runat="server">
                                                            <div class="tab-pane fade show active" id="five" role="tabpanel">
                                                                <div class="ibox-title text-center">
                                                                    <h3 class="text-white">General Investigations</h3>
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
                                                        </asp:View>
                                                        <asp:View ID="viewSpecialInvestigation" runat="server">
                                                            <div class="tab-pane fade show active" id="six" role="tabpanel">
                                                                <div class="ibox-title text-center">
                                                                    <h3 class="text-white">Special Investigations</h3>
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
                                                        </asp:View>
                                                        <asp:View ID="viewFraudDocuments" runat="server">
                                                            <div class="tab-pane fade show active" id="seven" role="tabpanel">
                                                                <div class="ibox-title text-center">
                                                                    <h3 class="text-white">Fraud Documents</h3>
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
                                                        </asp:View>
                                                        <asp:View ID="viewAuditDocuments" runat="server">
                                                            <div class="tab-pane fade show active" id="eight" role="tabpanel">
                                                                <div class="ibox-title text-center">
                                                                    <h3 class="text-white">Audit Documents</h3>
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
                                                        <asp:Button ID="btnDownloadPdf" runat="server" Text="Download as one PDF" class="btn btn-success rounded-pill" OnClick="btnDownloadPdf_Click1" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:View>
                                </asp:MultiView>
                            </div>
                        </div>
                    </div>
                    <div class="modal fade" id="contentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-m">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <asp:Label ID="lbTitle" runat="server" Text="" class="modal-title fs-5 font-weight-bolder"></asp:Label>
                                    <button type="button" class="btn-close" onclick="hideModal();"></button>
                                </div>
                                <asp:MultiView ID="MultiView3" runat="server">
                                    <asp:View ID="viewPhoto" runat="server">
                                        <div class="modal-body">
                                            <div class="row table-responsive">
                                                <asp:Image ID="imgChildView" runat="server" class="img-fluid" ImageUrl="https://plus.unsplash.com/premium_photo-1664304370934-b21ea9e0b1f5?q=80&w=1883&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" AlternateText="Child Document" />
                                            </div>
                                        </div>
                                    </asp:View>
                                </asp:MultiView>
                            </div>
                        </div>
                    </div>
                </asp:View>
                <asp:View ID="ViewNoPendingDataPage" runat="server">
                    <div class="d-flex align-items-center justify-content-center m-5">
                        <asp:Label ID="lbNodataPending" runat="server" CssClass="font-weight-bold text-danger fs-2" Font-Size="Larger"></asp:Label>
                    </div>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

