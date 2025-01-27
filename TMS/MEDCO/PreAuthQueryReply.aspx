<%@ Page Title="" Language="C#" MasterPageFile="~/MEDCO/MEDCO.master" AutoEventWireup="true" CodeFile="PreAuthQueryReply.aspx.cs" Inherits="MEDCO_PreAuthQueryReply" %>

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
            <asp:HiddenField ID="hdQueryId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdMedcoReply" runat="server" Visible="false" />
            <asp:HiddenField ID="hdAdmissionDate" runat="server" Visible="false" />
            <div class="modal fade" id="modalDocumentUpload" tabindex="-1" role="dialog" aria-labelledby="modal2Label" aria-hidden="true">
                <div class="modal-dialog modal-xl" role="document">
                    <div class="modal-content">
                        <div class="modal-header round" style="background-color: #007e72;">
                            <asp:Label ID="Label4" runat="server" Text="Query Document Upload" class="modal-title fs-5 font-weight-bolder text-white"></asp:Label>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <asp:FileUpload ID="fuQueryImage" runat="server" />
                            <asp:Button ID="btnUploadQueryImage" CssClass="btn btn-primary btn-sm rounded-pill" runat="server" Text="Upload" OnClick="btnUploadQueryImage_Click" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="hideDocumentUploadModal();">
                                Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="contentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <asp:Label ID="lbTitle" runat="server" Text="" class="modal-title fs-5 font-weight-bolder"></asp:Label>
                            <button type="button" class="btn" onclick="hideContentModal();">
                                <i class="fa fa-times"></i>
                            </button>
                        </div>
                        <asp:MultiView ID="MultiView5" runat="server">
                            <asp:View ID="viewPhoto" runat="server">
                                <div class="modal-body">
                                    <div class="row table-responsive" style="max-height: 700px; overflow-y: scroll;">
                                        <asp:Image ID="imgChildView" runat="server" class="img-fluid" ImageUrl="https://plus.unsplash.com/premium_photo-1664304370934-b21ea9e0b1f5?q=80&w=1883&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" AlternateText="Child Document" />
                                    </div>
                                </div>
                            </asp:View>
                        </asp:MultiView>
                    </div>
                </div>
            </div>

            <asp:MultiView ID="MultiView1" runat="server">
                <asp:View ID="viewPatientList" runat="server">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="ibox-title text-center">
                                <h3 class="text-white">Preauth Query Cases For Updation</h3>
                            </div>
                            <div class="ibox-content">
                                <div class="ibox">
                                    <div class="ibox-content text-dark">
                                        <div class="row">
                                            <div class="col-md-3 mb-3">
                                                <asp:Label runat="server" AssociatedControlID="tbRegno" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Case No." />
                                                <asp:TextBox ID="tbRegno" runat="server" OnKeypress="return isNumeric(event)" CssClass="form-control" />
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <asp:Label runat="server" AssociatedControlID="tbBeneficiaryCardNo" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Beneficiary Card No." />
                                                <asp:TextBox ID="tbBeneficiaryCardNo" runat="server" OnKeypress="return isNumeric(event)" CssClass="form-control" />
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <asp:Label runat="server" AssociatedControlID="tbBeneficiaryCardNo" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Patient Name" />
                                                <asp:TextBox ID="TextBox1" runat="server" OnKeypress="return isNumeric(event)" CssClass="form-control" />
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <asp:Label runat="server" AssociatedControlID="tbRegisteredFromDate" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Registered From Date" />
                                                <asp:TextBox ID="tbRegisteredFromDate" runat="server" OnKeypress="return isDate(event)" CssClass="form-control" TextMode="Date" />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" AssociatedControlID="tbRegisteredToDate" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Registered To Date" />
                                                <asp:TextBox ID="tbRegisteredToDate" runat="server" OnKeypress="return isDate(event)" CssClass="form-control" TextMode="Date" />
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <span class="form-label fw-semibold">Scheme Id</span>
                                                <asp:DropDownList ID="dlSchemeId" runat="server" class="form-control mt-2">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <span class="form-label fw-semibold">Category</span>
                                                <asp:DropDownList ID="DropDownList1" runat="server" class="form-control mt-2">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <span class="form-label fw-semibold">Procedure Name</span>
                                                <asp:DropDownList ID="DropDownList2" runat="server" class="form-control mt-2">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                </asp:DropDownList>
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
                                    <asp:GridView ID="gridQueryCases" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                        <Columns>
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
                        </div>
                    </div>
                </asp:View>
                <asp:View ID="viewDischarge" runat="server">
                    <div class="col-lg-12">
                        <div class="ibox">
                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                <div class="d-flex">
                                    <h3 class="m-0">
                                        <asp:LinkButton ID="lnkBackToList" runat="server" ForeColor="White" OnClick="lnkBackToList_Click">Back To List</asp:LinkButton></h3>
                                </div>
                                <div class="d-flex justify-content-center">
                                    <h3 class="m-0">Patient Details</h3>
                                </div>
                                <div class="text-white text-nowrap">
                                    <span class="font-weight-bold">Case No:</span>
                                    <asp:Label ID="lbDisplayCaseNo" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
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
                                                        <span style="font-weight: 600!important;">Name:</span><br />
                                                        <asp:Label ID="t3lbHospitalName" runat="server" Text="" Style="padding: 8px 0px 0px 0px;" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Type:</span><br />
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
                                                        <span style="font-weight: 600!important;">Admission Type:</span>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <asp:DropDownList ID="t3dropAdmissionType" AutoPostBack="true" runat="server" CssClass="form-control" Enabled="False">
                                                            <asp:ListItem Value="0">Planned</asp:ListItem>
                                                            <asp:ListItem Value="1">Emergency</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Admission Date:</span>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <asp:Label ID="t3lbAdmissionDate" runat="server" Text="" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="form-group row m-b">
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Package Cost:</span>
                                                    </div>
                                                    <div class="col-lg-3" style="display: flex; align-items: center;">
                                                        <span class="fa fa-inr" style="margin-right: 5px;"></span>
                                                        <asp:Label ID="t3lbPackageCost" runat="server" Text="0" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Hospital Incentive:</span>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <asp:Label ID="t3lbHospitalIncentive" runat="server" Text="" CssClass="form-control border-0 border-bottom"></asp:Label>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="form-group row m-b">
                                                    <div class="col-lg-3">
                                                        <span style="font-weight: 600!important;">Incentive Amount:</span>
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
                                            </div>
                                        </div>
                                        <div class="ibox-title">
                                            <h5>Work Flow</h5>
                                        </div>
                                        <div class="ibox-content">
                                            <div class="mt-3">
                                                <div class="form-group row m-b">
                                                    <div class="col-lg-12">
                                                        <asp:GridView ID="gridWorkFlow" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                            <RowStyle BackColor="White" Height="20px" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Sl No.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
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
                                                                <asp:TemplateField HeaderText="Role">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label10" runat="server" Text='<%# Eval("RoleName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
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
                                                                <asp:TemplateField HeaderText="Remarks">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label11" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Claim Query/Rejection Reasons">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label16" runat="server" Text='<%# Eval("RejectName") %>'></asp:Label>
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

                                        <div class="ibox mt-4">
                                            <div class="ibox-title text-center">
                                                <h3 class="text-white">Preauth Query/ Rejection Reason</h3>
                                            </div>
                                            <div class="ibox-content table-responsive">
                                                <asp:GridView ID="gridPreauthQueryRejectionReason" OnRowDataBound="gridPreauthQueryRejectionReason_RowDataBound" runat="server" AutoGenerateColumns="false" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
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
                                                                <asp:Label ID="lbQueryDate" runat="server" Text='<%# Eval("QueryRaisedDate") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1e8c86" Font-Bold="true" ForeColor="white" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="middle" Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Main Reason">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbMainReason" runat="server" Text='<%# Eval("ReasonName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1e8c86" Font-Bold="true" ForeColor="white" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="middle" Width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Sub Reason">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbSubReason" runat="server" Text='<%# Eval("SubReasonName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1e8c86" Font-Bold="true" ForeColor="white" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="middle" Width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PPD Query">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbPpdQuery" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1e8c86" Font-Bold="true" ForeColor="white" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="middle" Width="15%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Medco Reply">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbMedcoReply" Visible="false" runat="server" Text='<%# Eval("QueryReply") %>'></asp:Label>
                                                                <asp:TextBox ID="tbMedcoReply" TextMode="MultiLine" Visible="false" Rows="2" runat="server" placeholder="Enter reply" OnKeypress="return isAlphaNumeric(event)" CssClass="form-control" />
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1e8c86" Font-Bold="true" ForeColor="white" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="middle" Width="15%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Status">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIsQueryReplied" Visible="false" runat="server" Text='<%# Eval("IsQueryReplied") %>'></asp:Label>
                                                                <asp:Label ID="lbQueryFolderName" Visible="false" runat="server" Text='<%# Eval("QueryFolderName") %>'></asp:Label>
                                                                <asp:Label ID="lbQueryUploadedFileName" Visible="false" runat="server" Text='<%# Eval("QueryUploadedFileName") %>'></asp:Label>
                                                                <asp:LinkButton ID="lnkQueryStatus" runat="server" Enabled="false"
                                                                    Style="font-size: 12px;" OnClick="lnkQueryStatus_Click">
                                                                    <asp:Label ID="lbQueryStatus" runat="server" Text="Query Pending" Font-Bold="True" Style="font-size: 12px;"></asp:Label>
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1e8c86" Font-Bold="true" ForeColor="white" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="middle" Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Attachment">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbQueryId" Visible="false" runat="server" Text='<%# Eval("QueryId") %>'></asp:Label>
                                                                <asp:Label ID="lbQueryRasiedByRole" Visible="false" runat="server" Text='<%# Eval("QueryRasiedByRole") %>'></asp:Label>
                                                                <asp:LinkButton ID="lnkAttachment" runat="server" Enabled="false" class="btn btn-primary btn-sm rounded-pill text-white" Style="font-size: 12px;" OnClick="lnkAttachment_Click">
                                                                    Upload <i class="fa fa-upload"></i>
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1e8c86" Font-Bold="true" ForeColor="white" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="middle" Width="10%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>

                                        <div class="col-lg-12 text-start">
                                            <asp:Button ID="btnSubmit" runat="server" class="btn btn-primary rounded-pill" Text="Submit" OnClick="btnSubmit_Click" />
                                        </div>

                                    </asp:View>
                                    <asp:View ID="viewAttachment" runat="server">
                                        <div class="tab-pane fade show active" role="tabpanel">
                                            <ul class="nav nav-tabs d-flex flex-row" role="tablist">
                                                <li class="nav-item mr-2 mt-1" id="preAuth">
                                                    <asp:LinkButton ID="lnkPreauthorization" runat="server" CssClass="nav-link active nav-attach" OnClick="lnkPreauthorization_Click">Preauthorization</asp:LinkButton>
                                                </li>
                                                <li class="nav-item mr-2 mt-1" id="specialInvestigation">
                                                    <asp:LinkButton ID="lnkSpecialInvestigation" runat="server" CssClass="nav-link nav-attach" OnClick="lnkSpecialInvestigation_Click">Special Investigation</asp:LinkButton>
                                                </li>
                                            </ul>

                                            <div class="tab-content">
                                                <asp:MultiView ID="MultiView4" runat="server" ActiveViewIndex="0">
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
                                                </asp:MultiView>
                                                <div class="col-md-12 mt-2 mb-2">
                                                    <asp:Button ID="btnDownloadPdf" runat="server" Text="Download as one PDF" class="btn btn-primary rounded-pill" OnClick="btnDownloadPdf_Click" />
                                                </div>
                                            </div>
                                        </div>
                                    </asp:View>
                                </asp:MultiView>
                            </div>
                        </div>
                    </div>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnDownloadPdf" />
            <asp:PostBackTrigger ControlID="btnUploadQueryImage" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

