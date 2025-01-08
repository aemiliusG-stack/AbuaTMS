<%@ Page Title="" Language="C#" MasterPageFile="~/MEDCO/MEDCO.master" AutoEventWireup="true" CodeFile="PatientDischarge.aspx.cs" Inherits="MEDCO_PatientDischarge" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        function activateTab(tabId) {
            // Activate the tab by adding the required classes
            $('.tab-pane').removeClass('active show');
            $(tabId).addClass('active show');
            return false; // Prevent postback if only client-side activation is needed
        }
    </script>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdAbuaId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPatientRegId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdHospitalId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdAdmissionId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdClaimId" runat="server" Visible="false" />
            <div class="modal fade" id="modalDocumentUpload" tabindex="-1" role="dialog" aria-labelledby="modal2Label" aria-hidden="true">
                <div class="modal-dialog modal-xl" role="document">
                    <div class="modal-content">
                        <div class="modal-header round" style="background-color: #007e72;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Rv
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="Button6" CssClass="btn btn-secondary" Text="Close" runat="server" />
                        </div>

                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Patient For Treatment/Discharge</h3>
                    </div>
                    <asp:MultiView ID="MultiView1" runat="server">
                        <asp:View ID="viewPatientList" runat="server">
                            <div class="ibox-content">
                                <div class="ibox">
                                    <div class="ibox-content text-dark">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <asp:Label runat="server" AssociatedControlID="tbRegno" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Registration No." />
                                                <asp:TextBox ID="tbRegno" runat="server" OnKeypress="return isNumeric(event)" CssClass="form-control" />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" AssociatedControlID="tbBeneficiaryCardNo" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Beneficiary Card No." />
                                                <asp:TextBox ID="tbBeneficiaryCardNo" runat="server" OnKeypress="return isNumeric(event)" CssClass="form-control" />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" AssociatedControlID="tbRegisteredFromDate" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Registered From Date" />
                                                <asp:TextBox ID="tbRegisteredFromDate" runat="server" OnKeypress="return isDate(event)" CssClass="form-control" TextMode="Date" />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" AssociatedControlID="tbRegisteredToDate" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Registered To Date" />
                                                <asp:TextBox ID="tbRegisteredToDate" runat="server" OnKeypress="return isDate(event)" CssClass="form-control" TextMode="Date" />
                                            </div>
                                            <div class="col-lg-12 text-center mt-3">
                                                <asp:Button runat="server" CssClass="btn btn-success rounded-pill" Text="Search" />
                                                <asp:Button runat="server" CssClass="btn btn-warning rounded-pill" Text="Reset" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mt-3">
                                <div class="card-body table-responsive">
                                    <asp:GridView ID="gridPatientForDischarge" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                        <Columns>
                                            <%--                                            <asp:BoundField DataField="PatientRegId" HeaderText="PatientRegId" Visible="false" />
                                            <asp:BoundField DataField="AdmissionId" HeaderText="AdmissionId" Visible="false" />--%>
                                            <asp:TemplateField HeaderText="Sl No." Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbPatientRegId" runat="server" Text='<%# Eval("PatientRegId") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Admission Id" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbAdmissionId" runat="server" Text='<%# Eval("AdmissionId") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Claim Id" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbClaimId" runat="server" Text='<%# Eval("ClaimId") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Sl No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Case No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbCaseNo" runat="server" Text='<%# Eval("CaseNumber") %>' Font-Bold="True" Visible="false"></asp:Label>
                                                    <asp:LinkButton ID="lnkCaseNo" runat="server" OnClick="lnkCaseNo_Click" Font-Bold="True"><%# Eval("CaseNumber") %></asp:LinkButton>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="18%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Claim No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbClaimNo" runat="server" Text='<%# Eval("ClaimNumber") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="18%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Patient Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbPatientName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Beneficiary Card No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbCardNo" runat="server" Text='<%# Eval("CardNumber") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Case Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbCaseStatus" runat="server" Text='<%# Eval("CaseStatus") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Hospital Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Registration Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbRegDate" runat="server" Text='<%# Eval("RegDate") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </asp:View>
                        <asp:View ID="viewDischarge" runat="server">
                            <div class="ibox-content">
                                <div class="ibox-content text-dark">
                                    <div class="row">
                                        <div class="col-lg-8">
                                            <div class="form-group row">
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Name:</span><br />
                                                    <asp:Label ID="lbPersonName" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Beneficiary Card ID:</span><br />
                                                    <asp:Label ID="lbBeneficiaryCardId" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Registration No:</span><br />
                                                    <asp:Label ID="lbRegistrationNo" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Case No:</span><br />
                                                    <asp:Label ID="lbCaseNo" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Registration Date:</span><br />
                                                    <asp:Label ID="lbActualRegistrationDate" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Contact No:</span><br />
                                                    <asp:Label ID="lbContactNo" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Hospital Type:</span><br />
                                                    <asp:Label ID="lbHospitalType" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Gender:</span><br />
                                                    <asp:Label ID="lbGender" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Family ID:</span><br />
                                                    <asp:Label ID="lbFamilyId" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">New Born Baby Case:</span><br />
                                                    <asp:Label ID="lbIsChild" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Aadhar Verified:</span><br />
                                                    <asp:Label ID="lbAadharVerified" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Biometric Verified:</span><br />
                                                    <asp:Label ID="lbBiometricVerified" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Patient District:</span><br />
                                                    <asp:Label ID="lbPatientDistrict" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Patient Schema:</span><br />
                                                    <asp:Label ID="lbPatientSchema" runat="server" Text="ABUA-JHARKHAND" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <div class="col-lg-4 mb-3">
                                                    <span style="font-weight: 600!important;">Age:</span><br />
                                                    <asp:Label ID="lbAge" runat="server" Text="06/04/2024" Style="font-size: 12px;"></asp:Label>
                                                </div>
                                                <asp:Panel ID="panelChild" runat="server" Visible="false" Style="padding-left: 0px !important; padding-right: 0px !important;">
                                                    <div class="row">
                                                        <div class="col-lg-4 mb-3">
                                                            <span style="font-weight: 600!important;">Child Name:</span><br />
                                                            <asp:Label ID="lbChildName" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                        </div>
                                                        <div class="col-lg-4 mb-3">
                                                            <span style="font-weight: 600!important;">Gender Of Child:</span><br />
                                                            <asp:Label ID="lbChildGender" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                        </div>
                                                        <div class="col-lg-4 mb-3">
                                                            <span style="font-weight: 600!important;">Child DOB:</span><br />
                                                            <asp:Label ID="lbChildDob" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                        </div>
                                                        <div class="col-lg-4 mb-3">
                                                            <span style="font-weight: 600!important;">Father Name:</span><br />
                                                            <asp:Label ID="lbFatherName" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                        </div>
                                                        <div class="col-lg-4 mb-3">
                                                            <span style="font-weight: 600!important;">Mother Name:</span><br />
                                                            <asp:Label ID="lbMotherName" runat="server" Text="" Style="font-size: 12px;"></asp:Label>
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <span style="font-weight: 600!important;">Child Photo/ Document:</span><br />
                                                            <%--<asp:LinkButton ID="lnkChildPhoto" runat="server" OnClick="lnkChildPhoto_Click">View Document</asp:LinkButton>--%>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="text-center">
                                                <asp:Image ID="imgPatient" runat="server" alt="Patient Photo" class="img-fluid mb-3" Style="max-width: 120px; height: 150px; object-fit: cover;" />
                                                <asp:Image ID="imgChild" runat="server" alt="Child Photo" class="img-fluid mb-3" Style="max-width: 120px; height: 150px; object-fit: cover;" Visible="false" />
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="tabs-container mb-2">
                                    <ul class="nav" id="myTab" role="tablist">
                                        <li class="nav-item mr-2 mt-1">
                                            <asp:Button ID="btnInitialAssessment" runat="server" Text="Initial Assessment" CssClass="btn btn-primary p-3" OnClick="btnInitialAssessment_Click" />
                                        </li>
                                        <li class="nav-item mr-2 mt-1">
                                            <asp:Button ID="btnPastHistory" runat="server" Text="Past History" CssClass="btn btn-primary p-3" OnClick="btnPastHistory_Click" />
                                        </li>
                                        <li class="nav-item mr-2 mt-1">
                                            <asp:Button ID="btnPreAutoriztion" runat="server" Text="Pre-Autoriztion" CssClass="btn btn-primary p-3" OnClick="btnPreAutoriztion_Click" />
                                        </li>
                                        <li class="nav-item mr-2 mt-1">
                                            <asp:Button ID="btnTreatment" runat="server" Text="Treatment/Discharge" CssClass="btn btn-primary p-3" OnClick="btnTreatment_Click" />
                                        </li>
                                        <li class="nav-item mr-2 mt-1">
                                            <asp:Button ID="btnAttachments" runat="server" Text="Attachments" CssClass="btn btn-primary p-3" OnClick="btnAttachments_Click" />
                                        </li>
                                    </ul>
                                </div>
                                <asp:MultiView ID="MultiView2" runat="server">
                                    <asp:View ID="viewInitialAssessment" runat="server">
                                        tab-1
                                    </asp:View>
                                    <asp:View ID="viewPasthistory" runat="server">
                                        tab-2
                                    </asp:View>
                                    <asp:View ID="viewPreAuth" runat="server">
                                        <div class="ibox-title">
                                            <h5>Network Hospital Details</h5>
                                        </div>
                                        <div class="ibox-content">
                                            <div class="mt-3">
                                                <div class="form-group row m-b">
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Name:<span class="text-danger">*</span></span><br />
                                                        <asp:Label ID="t3lbHospitalName" runat="server" Text="" Style="padding: 8px 0px 0px 0px;" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Type:<span class="text-danger">*</span></span><br />
                                                        <asp:Label ID="t3lbHospitalType" runat="server" Text="" Style="padding: 8px 0px 0px 0px;" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Address:</span><br />
                                                        <asp:Label ID="t3lbHospitalAddress" runat="server" Text="" Style="padding: 8px 0px 0px 0px;" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="ibox-title">
                                            <h5>Treatment Protocol</h5>
                                        </div>
                                        <div class="ibox-content">
                                            <div class="mt-3">
                                                <div class="form-group row m-b">
                                                    <div class="col-lg-12">
                                                        <asp:GridView ID="t3gridAddedpackageProcedure" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                            <RowStyle BackColor="White" Height="20px" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Package Id" Visible="false">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbPackageId" runat="server" Text='<%# Eval("PackageId") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="35%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Procedure Id" Visible="false">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbProcedureId" runat="server" Text='<%# Eval("ProcedureId") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="35%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Sl No.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Speciality">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbAddedSpeciality" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Procedure">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbAddedProcedure" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="35%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Package Cost">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbAddedAmount" runat="server" Text='<%# Eval("ProcedureAmountFinal") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Stratification">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbAddedStratification" runat="server" Text='<%# Eval("StratificationName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Implants">
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
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Implant Cost">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbImplantAmount" runat="server" Text='<%# Eval("ImplantAmount") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="ibox-title">
                                            <h5>Admission Details</h5>
                                        </div>
                                        <div class="ibox-content">
                                            <div class="mt-3">
                                                <div class="form-group row m-b">
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Admission Type:<span class="text-danger">*</span></span>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <asp:DropDownList ID="t3dropAdmissionType" AutoPostBack="true" runat="server" CssClass="form-control" Enabled="False">
                                                            <asp:ListItem Value="0">Planned</asp:ListItem>
                                                            <asp:ListItem Value="1">Emergency</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Admission Date:<span class="text-danger">*</span></span>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <asp:Label ID="t3lbAdmissionDate" runat="server" Text="" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="form-group row m-b">
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Package Cost:<span class="text-danger">*</span></span>
                                                    </div>
                                                    <div class="col-lg-3" style="display: flex; align-items: center;">
                                                        <span class="fa fa-inr" style="margin-right: 5px;"></span>
                                                        <asp:Label ID="t3lbPackageCost" runat="server" Text="0" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Hospital Incentive:<span class="text-danger">*</span></span>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <asp:Label ID="t3lbHospitalIncentive" runat="server" Text="" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="form-group row m-b">
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Incentive Amount:<span class="text-danger">*</span></span>
                                                    </div>
                                                    <div class="col-lg-3" style="display: flex; align-items: center;">
                                                        <span class="fa fa-inr" style="margin-right: 5px;"></span>
                                                        <asp:Label ID="t3lbIncentiveAmount" runat="server" Text="0" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="form-group row m-b">
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Total Package Cost:</span>
                                                    </div>
                                                    <div class="col-lg-3" style="display: flex; align-items: center;">
                                                        <span class="fa fa-inr" style="margin-right: 5px;"></span>
                                                        <asp:Label ID="t3lbTotalPackageCost" runat="server" Text="0" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                    </div>
                                                </div>
                                                <br />
                                                <br />
                                                <div class="form-group row m-b">
                                                    <div class="col-lg-12 text-center">
                                                        <asp:Button ID="btnRequestEnhancement" runat="server" CssClass="btn btn-primary" Text="Request For Enhancement" OnClick="btnRequestEnhancement_Click" />
                                                        <asp:Button ID="btnChangeWard" runat="server" CssClass="btn btn-warning" Text="Initiate Change Of Ward" OnClick="btnChangeWard_Click" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <asp:MultiView ID="MultiView3" runat="server">
                                            <asp:View ID="viewEnhancement" runat="server">
                                                <div class="ibox-title">
                                                    <h5>Enhancement</h5>
                                                </div>
                                                <div class="ibox-content">
                                                    <div class="mt-3">
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">From Date:</span><br />
                                                                <asp:TextBox ID="t3tbEnhancementFromDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">To Date:</span><br />
                                                                <asp:TextBox ID="t3tbEnhancementToDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">No Of Days:</span><br />
                                                                <asp:Label ID="t3lbEnhancementNoOfDays" runat="server" Text="0" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">Stratification Details:</span><br />
                                                                <asp:DropDownList ID="t3DropEnhancementStratification" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="dropIsSpecialCase_SelectedIndexChanged">
                                                                    <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">Remarks:</span><br />
                                                                <asp:TextBox ID="t3EnhancementRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-12">
                                                                <asp:Button ID="btnEnhancementAttachment" runat="server" CssClass="btn btn-primary" Text="Add/View Attachment" />
                                                            </div>
                                                        </div>
                                                        <hr />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-12 text-center">
                                                                <asp:Button ID="btnInitiateEnhancement" runat="server" CssClass="btn btn-primary" Text="Initiate Enhancement" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:View>
                                            <asp:View ID="viewChangeWard" runat="server">
                                                <div class="ibox-title">
                                                    <h5>Change Of Ward</h5>
                                                </div>
                                                <div class="ibox-content">
                                                    <div class="mt-3">
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">From Date:</span><br />
                                                                <asp:TextBox ID="t3tbChangeWardFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">To Date:</span><br />
                                                                <asp:TextBox ID="t3tbChangeWardToDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">No Of Days:</span><br />
                                                                <asp:Label ID="t3lbChangeWardNoOfDays" runat="server" Text="0" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">Stratification Details:</span><br />
                                                                <asp:DropDownList ID="t3dropChangeWardStratification" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="dropIsSpecialCase_SelectedIndexChanged">
                                                                    <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">Remarks:</span><br />
                                                                <asp:TextBox ID="t3ChangeWardRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-12 text-center">
                                                                <asp:Button ID="btnInitiateChangeOfWard" runat="server" CssClass="btn btn-primary" Text="Initiate Ward Change" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:View>
                                        </asp:MultiView>
                                        <div class="ibox-title">
                                            <h5>Work Flow</h5>
                                        </div>
                                        <div class="ibox-content">
                                            <div class="mt-3">
                                                <div class="form-group row m-b">
                                                    <div class="col-lg-12">
                                                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                            <RowStyle BackColor="White" Height="20px" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Sl No.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Speciality">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbAddedSpeciality" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Procedure">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbAddedProcedure" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="35%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Package Cost">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbAddedAmount" runat="server" Text='<%# Eval("ProcedureAmountFinal") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Stratification">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbAddedStratification" runat="server" Text='<%# Eval("StratificationName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Implants">
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
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Implant Cost">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbImplantAmount" runat="server" Text='<%# Eval("ImplantAmount") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="viewTreatmentDischarge" runat="server">
                                        <div class="ibox ">
                                            <div class="ibox-title">
                                                <h5>Surgeon Details</h5>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="mt-3">
                                                    <div class="form-group row m-b">
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Doctor Type:<span class="text-danger">*</span></span><br />
                                                            <asp:DropDownList ID="dropDroctorType" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="dropDroctorType_SelectedIndexChanged">
                                                                <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Doctor Name:<span class="text-danger">*</span></span><br />
                                                            <asp:DropDownList ID="dropDoctorId" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="dropDoctorId_SelectedIndexChanged">
                                                                <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Reg No:</span><br />
                                                            <asp:Label ID="lbSurgeonRegNo" runat="server" Text="" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Qualification:</span><br />
                                                            <asp:Label ID="lbSurgeonQualification" runat="server" Text="" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row m-b">
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Contact No:<span class="text-danger">*</span></span><br />
                                                            <asp:Label ID="lbSurgeonContactNo" runat="server" Text="" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="ibox-title">
                                                <h5>Anesthetist Details</h5>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="mt-3">
                                                    <div class="form-group row m-b">
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Anesthetist Name:</span><br />
                                                            <asp:DropDownList ID="dropAnesName" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="dropAnesName_SelectedIndexChanged">
                                                                <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Reg No:</span><br />
                                                            <asp:Label ID="lbAnesRegNo" runat="server" Text="" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Contact No:</span><br />
                                                            <asp:Label ID="lbAnesContactNo" runat="server" Text="" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Anesthesia Type:</span><br />
                                                            <asp:Label ID="lbAnesthesiaType" runat="server" Text="" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="ibox-title">
                                                <h5>Procedure Details</h5>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="mt-3">
                                                    <div class="form-group row m-b">
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Incision Type:</span><br />
                                                            <asp:TextBox ID="tbIncisionType" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">OP Photos/WebEx Taken:</span><br />
                                                            <asp:RadioButton ID="rbOPPhotosYes" runat="server" Text="Yes" GroupName="rbOPPhotos" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:RadioButton ID="rbOPPhotosNo" runat="server" Text="No" GroupName="rbOPPhotos" Checked="true" />
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Video Recording Done:</span><br />
                                                            <asp:RadioButton ID="rbVideoRecordingYes" runat="server" Text="Yes" GroupName="rbVideoRecording" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:RadioButton ID="rbVideoRecordingNo" runat="server" Text="No" GroupName="rbVideoRecording" Checked="true" />
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Swab Count Instruments Count</span><br />
                                                            <asp:TextBox ID="tbSwabCount" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <br />
                                                    <div class="form-group row m-b">
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Sutures Ligatures:</span><br />
                                                            <asp:TextBox ID="tbSutures" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Specimen Required:</span><br />
                                                            <asp:RadioButton ID="rbSpecimenYes" runat="server" Text="Yes" GroupName="rbSpecimen" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:RadioButton ID="rbSpecimenNo" runat="server" Text="No" GroupName="rbSpecimen" Checked="true" />
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Drainage Count:</span><br />
                                                            <asp:TextBox ID="tbDrainageCount" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Blood Loss:</span><br />
                                                            <asp:TextBox ID="tbBloodLoss" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <br />
                                                    <div class="form-group row m-b">
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Post Operative Instructions:</span><br />
                                                            <asp:TextBox ID="tbPostOperativeInstructions" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Patient Condition:</span><br />
                                                            <asp:TextBox ID="tbPatientCondition" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Complications If Any:</span><br />
                                                            <asp:RadioButton ID="rbComplicationsYes" runat="server" Text="Yes" GroupName="rbComplications" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:RadioButton ID="rbComplicationsNo" runat="server" Text="No" GroupName="rbComplications" Checked="true" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="ibox-title">
                                                <h5>Treatment/Surgery Date</h5>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="mt-3">
                                                    <div class="form-group row m-b">
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Treatment/Surgery Date:<span class="text-danger">*</span></span><br />
                                                            <asp:TextBox ID="tbTreatmentSurgeryDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Surgery Start Time:</span><br />
                                                            <asp:TextBox ID="tbSurgeryStartTime" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Surgery End Time:</span><br />
                                                            <asp:TextBox ID="tbSurgeryEndTime" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="ibox-title">
                                                <h5>Surgery/Treatment Start Date Details</h5>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="mt-3">
                                                    <div class="form-group row m-b">
                                                        <div class="col-lg-3">
                                                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                                <AlternatingRowStyle BackColor="Gainsboro" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sl No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure Code">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbProcedureCode" runat="server" Text='<%# Eval("ProcedureCode") %>' Font-Bold="True"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbProcedureName" runat="server" Text='<%# Eval("ProcedureName") %>' Font-Bold="True"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="55%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Surgery Date/Treatment Start Date">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbProcedureName" runat="server" Text='<%# Eval("ProcedureName") %>' Font-Bold="True"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="ibox-title">
                                                <h5>Treatment Summary</h5>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="mt-3">
                                                    <div class="form-group row m-b">
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Treatment Given:<span class="text-danger">*</span>:</span><br />
                                                            <asp:TextBox ID="tbTreatmentGiven" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Operative Findings:</span><br />
                                                            <asp:TextBox ID="tbOperativeFindings" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Post Operative Period:</span><br />
                                                            <asp:TextBox ID="tbPostOperativePeriod" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3" style="margin-top: -21px!important;">
                                                            <span style="font-weight: 600!important;">Post Surgery/Therapy Special Investigation Given:</span><br />
                                                            <asp:TextBox ID="tbPostSurgeryTherapy" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <br />
                                                    <div class="form-group row m-b">
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Status at discharge:<span class="text-danger">*</span>:</span><br />
                                                            <asp:TextBox ID="tbStatusDischarge" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Review:</span><br />
                                                            <asp:TextBox ID="tbReview" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Advice:</span><br />
                                                            <asp:TextBox ID="tbAdvice" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <span style="font-weight: 600!important;">Discharge:</span><br />
                                                            <asp:RadioButton ID="rbDischarge" runat="server" Text="Discharge" GroupName="rbDischarge" Font-Bold="True" AutoPostBack="True" OnCheckedChanged="rbDischarge_CheckedChanged" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:RadioButton ID="rbDeath" runat="server" Text="Death" GroupName="rbDischarge" Font-Bold="True" ForeColor="#FF3300" AutoPostBack="True" OnCheckedChanged="rbDeath_CheckedChanged" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <asp:Panel ID="panelDischarge" runat="server" Visible="false">
                                                <div class="ibox-title">
                                                    <h5>Discharge</h5>
                                                </div>
                                                <div class="ibox-content">
                                                    <div class="mt-3">
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 600!important;">Discharge Date:<span class="text-danger">*</span></span><br />
                                                                <asp:TextBox ID="tbDischargeDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 600!important;">Next Follow Up Date:<span class="text-danger">*</span></span><br />
                                                                <asp:TextBox ID="tbNextFollowUpDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 600!important;">Consult at Block Name:</span><br />
                                                                <asp:TextBox ID="tbConsultAtBlockName" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 600!important;">Floor:</span><br />
                                                                <asp:TextBox ID="tbFloor" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 600!important;">Room No:</span><br />
                                                                <asp:TextBox ID="tbRoomNo" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 600!important;">Is Special Case:<span class="text-danger">*</span></span><br />
                                                                <asp:DropDownList ID="dropIsSpecialCase" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="dropIsSpecialCase_SelectedIndexChanged">
                                                                    <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                                                    <asp:ListItem Value="1">Yes</asp:ListItem>
                                                                    <asp:ListItem Value="2">No</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div id="divSpecialCaseValue" runat="server" class="col-lg-3" visible="false">
                                                                <span style="font-weight: 600!important;">Special Case Value:<span class="text-danger">*</span></span><br />
                                                                <asp:DropDownList ID="dropSpecialCaseValue" runat="server" CssClass="form-control">
                                                                    <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 600!important;">Final Diagnosis:</span><br />
                                                                <asp:DropDownList ID="dropFinalDiagnosis" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="dropFinalDiagnosis_SelectedIndexChanged">
                                                                    <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                                                    <asp:ListItem Value="1">Other</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div id="divFinalDiagnosisDesc" runat="server" class="col-lg-3" visible="false">
                                                                <span style="font-weight: 600!important;">Final Diagnosis Description:</span><br />
                                                                <asp:TextBox ID="tbFinalDiagnosisDesc" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 600!important;">Procedure Consent:<span class="text-danger">*</span></span><br />
                                                                <asp:RadioButton ID="rbProcedureConsentYes" runat="server" Text="Yes" GroupName="rbProcedureConsent" Font-Bold="True" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:RadioButton ID="rbProcedureConsentNo" runat="server" Text="No" GroupName="rbProcedureConsent" Font-Bold="True" ForeColor="#FF3300" />
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="col-lg-12">
                                                            <asp:CheckBox ID="cbDeclaration" runat="server" Text="&nbsp; I hereby declare that the discharge type selected is correct." />
                                                        </div>
                                                        <br />
                                                        <div class="col-lg-12 text-center">
                                                            <asp:Button ID="btnSubmit" runat="server" Text="Verify and Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
                                                            <asp:Button ID="btnAttachment" runat="server" Text="Add/View Attachments" CssClass="btn btn-primary" OnClick="btnAttachment_Click" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="viewAttachments" runat="server">
                                        tab-5
                                    </asp:View>
                                </asp:MultiView>
                            </div>
                        </asp:View>
                    </asp:MultiView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
