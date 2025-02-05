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
            <asp:HiddenField ID="hdAdmissionDate" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPackageId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdProcedureId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPostInvestigationId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdCount" Value="0" runat="server" Visible="false" />
            <div class="modal fade" id="modalAttachmentAnamoly" tabindex="-1" role="dialog" aria-labelledby="ViewDataAnamolyModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-xl" role="document">
                    <div class="modal-content">
                        <div class="modal-header round align-content-center" style="background-color: #007e72;">
                            <h2 class="modal-title text-white" id="exampleModalLabel" style="margin: 0px !important;">Attachments</h2>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="hideAttachmentAnamolyModal();">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="tab-pane fade show active" id="attachment" role="tabpanel">
                                <ul class="nav nav-tabs d-flex flex-row justify-content-start" id="attachTab" role="tablist">
                                    <li class="nav-item">
                                        <asp:LinkButton ID="btnDischarge" runat="server" class="nav-link active nav-attach" OnClick="btnDischarge_Click">
                                            <span>Discharge Documents</span>
                                        </asp:LinkButton>
                                    </li>
                                    <li class="nav-item">
                                        <asp:LinkButton ID="btnOther" runat="server" OnClick="btnOther_Click" CssClass="nav-link nav-attach ml-2">
                                            <span>Other Documents</span>
                                        </asp:LinkButton>
                                    </li>
                                </ul>
                                <div class="tab-content" id="attachTabContent">
                                    <asp:MultiView ID="multiViewDischarge" runat="server" ActiveViewIndex="0">
                                        <asp:View ID="viewDischargeDocument" runat="server">
                                            <div class="tab-pane fade show active" id="one" role="tabpanel">
                                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                    <div class="d-flex w-100 justify-content-center">
                                                        <h3 class="m-0">Discharge Documents</h3>
                                                    </div>
                                                </div>
                                                <div class="ibox-content">
                                                    <table class="table table-bordered table-striped" style="width: 100%;">
                                                        <thead>
                                                            <tr class="table-primary">
                                                                <th style="background-color: #007e72; color: white; width: 30%;">Attachment Name</th>
                                                                <th style="background-color: #007e72; color: white; width: 30%;">Select File To Upload</th>
                                                                <th style="background-color: #007e72; color: white; width: 40%;">Upload</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td>Discharge Summary</td>
                                                                <td>
                                                                    <div class="d-flex align-items-center">
                                                                        <asp:FileUpload ID="fuDischargeSummary" runat="server" />
                                                                        <asp:Button ID="btnUploadDischargeSummary" runat="server" Text="Upload" CssClass="btn btn-sm btn-primary rounded-pill ml-3" OnClick="btnUploadDischargeSummary_Click" />
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <asp:LinkButton ID="btnDischargeSummary" runat="server" Enabled="false"
                                                                        Style="font-size: 12px;" OnClick="btnDischargeSummary_Click">
                                                                        <asp:Label Visible="false" ID="lbDischargeFolderName" runat="server" Text=''></asp:Label>
                                                                        <asp:Label Visible="false" ID="lbDischargeUploadedFileName" runat="server" Text=''></asp:Label>
                                                                        <asp:Label ID="lbDischargeSummaryStatus" runat="server" Text='NA'></asp:Label>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Operation Document</td>
                                                                <td>
                                                                    <div class="d-flex align-items-center">
                                                                        <asp:FileUpload ID="fuOperationDocument" runat="server" />
                                                                        <asp:Button ID="btnUploadOperationDocument" runat="server" Text="Upload" CssClass="btn btn-sm btn-primary rounded-pill ml-3" OnClick="btnUploadOperationDocument_Click" />
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <asp:LinkButton ID="btnOperationDocument" runat="server" Enabled="false"
                                                                        Style="font-size: 12px;" OnClick="btnOperationDocument_Click">
                                                                        <asp:Label Visible="false" ID="lbOperationDocumentFolderName" runat="server" Text=''></asp:Label>
                                                                        <asp:Label Visible="false" ID="lbOperationDocumentUploadedFileName" runat="server" Text=''></asp:Label>
                                                                        <asp:Label ID="lbOperationDocumentStatus" runat="server" Text='NA'></asp:Label>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>After Discharge Photo<span class="text-danger">*</span></td>
                                                                <td>
                                                                    <div class="d-flex align-items-center">
                                                                        <asp:FileUpload ID="fuDischargePhoto" runat="server" />
                                                                        <asp:Button ID="btnUploadAfterDischargePhoto" runat="server" Text="Upload" CssClass="btn btn-sm btn-primary rounded-pill ml-3" OnClick="btnUploadAfterDischargePhoto_Click" />
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <asp:LinkButton ID="btnDischargePhoto" runat="server" Enabled="false"
                                                                        Style="font-size: 12px;" OnClick="btnDischargePhoto_Click">
                                                                        <asp:Label Visible="false" ID="lbDischargePhotoFolderName" runat="server" Text=''></asp:Label>
                                                                        <asp:Label Visible="false" ID="lbDischargePhotoUploadedFileName" runat="server" Text=''></asp:Label>
                                                                        <asp:Label ID="lbDischargePhotoStatus" runat="server" Text='NA'></asp:Label>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </asp:View>
                                        <asp:View ID="viewMultipleDocument" runat="server">
                                            <div class="tab-pane fade show active" id="two" role="tabpanel">
                                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                    <div class="d-flex w-100 justify-content-between">
                                                        <h3 class="m-0">Other Documents</h3>
                                                        <asp:LinkButton ID="btnAddMore" runat="server" OnClick="btnAddMore_Click" CssClass="nav-link nav-attach ml-2 bg-white" Style="border-radius: 10px; color: green;">
                                                            <span>Add More</span>
                                                            <i class="fa fa-plus"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                                <div class="ibox-content">
                                                    <table class="table table-bordered table-striped" style="width: 100%;">
                                                        <thead>
                                                            <tr class="table-primary">
                                                                <th style="background-color: #007e72; color: white; width: 30%;">Attachment Name</th>
                                                                <th style="background-color: #007e72; color: white; width: 30%;">Select File To Upload</th>
                                                                <th style="background-color: #007e72; color: white; width: 40%;">Upload</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Panel ID="panelOne" runat="server" Visible="false">
                                                                <tr>
                                                                    <td>Document One</td>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <asp:FileUpload ID="fuDocumentOne" runat="server" />
                                                                            <asp:Button ID="btnUploadDocumentOne" runat="server" Text="Upload" CssClass="btn btn-sm btn-primary rounded-pill ml-3" OnClick="btnUploadDocumentOne_Click" />
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <asp:LinkButton ID="btnDocumentOne" runat="server" Enabled="false"
                                                                            Style="font-size: 12px;" OnClick="btnDocumentOne_Click">
                                                                            <asp:Label Visible="false" ID="lbDocumentOneFolderName" runat="server" Text=''></asp:Label>
                                                                            <asp:Label Visible="false" ID="lbDocumentOneUploadedFileName" runat="server" Text=''></asp:Label>
                                                                            <asp:Label ID="lbDocumentOneStatus" runat="server" Text='NA'></asp:Label>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </asp:Panel>
                                                            <asp:Panel ID="panelTwo" runat="server" Visible="false">
                                                                <tr>
                                                                    <td>Document Two</td>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <asp:FileUpload ID="fuDocumentTwo" runat="server" />
                                                                            <asp:Button ID="btnUploadDocumentTwo" runat="server" Text="Upload" CssClass="btn btn-sm btn-primary rounded-pill ml-3" OnClick="btnUploadDocumentTwo_Click" />
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <asp:LinkButton ID="btnDocumentTwo" runat="server" Enabled="false"
                                                                            Style="font-size: 12px;" OnClick="btnDocumentTwo_Click">
                                                                            <asp:Label Visible="false" ID="lbDocumentTwoFolderName" runat="server" Text=''></asp:Label>
                                                                            <asp:Label Visible="false" ID="lbDocumentTwoUploadedFileName" runat="server" Text=''></asp:Label>
                                                                            <asp:Label ID="lbDocumentTwoStatus" runat="server" Text='NA'></asp:Label>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </asp:Panel>
                                                            <asp:Panel ID="panelThree" runat="server" Visible="false">
                                                                <tr>
                                                                    <td>Document Three</td>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <asp:FileUpload ID="fuDocumentThree" runat="server" />
                                                                            <asp:Button ID="btnUploadDocumentThree" runat="server" Text="Upload" CssClass="btn btn-sm btn-primary rounded-pill ml-3" OnClick="btnUploadDocumentThree_Click" />
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <asp:LinkButton ID="btnDocumentThree" runat="server" Enabled="false"
                                                                            Style="font-size: 12px;" OnClick="btnDocumentThree_Click">
                                                                            <asp:Label Visible="false" ID="lbDocumentThreeFolderName" runat="server" Text=''></asp:Label>
                                                                            <asp:Label Visible="false" ID="lbDocumentThreeUploadedFileName" runat="server" Text=''></asp:Label>
                                                                            <asp:Label ID="lbDocumentThreeStatus" runat="server" Text='NA'></asp:Label>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </asp:Panel>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </asp:View>
                                    </asp:MultiView>

                                    <div class="container mt-4">
                                        <strong class="text-danger">Note:</strong>
                                        <ol class="text-danger font-weight-bold">
                                            <li>File size should not exceded 500 kb</li>
                                            <li>Attachment Names with blue color are related to notifications</li>
                                            <li>Discharge Summary Document Quality and its notation
                       
                                        <ul class="text-danger">
                                            <li>Document of Good Quality<i class="fa fa-check-circle text-info"></i></li>
                                            <li>Document of Bad Quality<i class="fa fa-times-circle text-danger"></i> </li>
                                            <li>Document which is not valid<i class="fa fa-check-circle text-info"></i></li>
                                            <li>Document with error<i class="fa fa-times-circle text-danger"></i></li>
                                        </ul>
                                            </li>
                                        </ol>
                                    </div>
                                    <div class="col-md-12 mt-2 mb-2">
                                        <button class="btn btn-primary rounded-pill" type="button">Download as one PDF<img src="../images/pdf-viewer-svgrepo-com.svg" width="15" class="ml-2" /></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="Button10" CssClass="btn btn-secondary" Text="Close" runat="server" OnClientClick="hideAttachmentAnamolyModal();" />
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
                        <div class="modal-body">
                            <div class="row table-responsive" style="max-height: 700px; overflow-y: scroll;">
                                <asp:Image ID="imgChildView" runat="server" class="img-fluid" ImageUrl="https://plus.unsplash.com/premium_photo-1664304370934-b21ea9e0b1f5?q=80&w=1883&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" AlternateText="Child Document" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalDocumentUpload" tabindex="-1" role="dialog" aria-labelledby="modal2Label" aria-hidden="true">
                <div class="modal-dialog modal-xl" role="document">
                    <div class="modal-content">
                        <div class="modal-header round" style="background-color: #007e72;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <asp:FileUpload ID="fuImage" runat="server" />
                            <asp:Button ID="btnUploadPostInvestigationFile" CssClass="btn btn-primary btn-sm rounded-pill" runat="server" Text="Upload" OnClick="btnUploadPostInvestigationFile_Click" />
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="Button6" CssClass="btn btn-secondary" Text="Close" runat="server" OnClick="hideDocumentUploadModal_Click" />
                        </div>

                    </div>
                </div>
            </div>

            <asp:MultiView ID="MultiView1" runat="server">
                <asp:View ID="viewPatientList" runat="server">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="ibox-title text-center">
                                <h3 class="text-white">Patient For Treatment/Discharge</h3>
                            </div>
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
                                                <br />
                                                <div class="form-group row m-b">
                                                    <div class="col-lg-12 text-center">
                                                        <asp:Button ID="btnRequestEnhancement" runat="server" CssClass="btn btn-primary" Text="Request For Enhancement" OnClick="btnRequestEnhancement_Click" />
                                                        <asp:Button ID="btnChangeWard" runat="server" CssClass="btn btn-warning" Text="Initiate Change Of Ward" OnClick="btnChangeWard_Click" Visible="false" />
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
                                                                <asp:TextBox ID="t3tbEnhancementFromDate" runat="server" CssClass="form-control" TextMode="Date" OnTextChanged="t3tbEnhancementFromDate_TextChanged" AutoPostBack="True"></asp:TextBox>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">To Date:</span><br />
                                                                <asp:TextBox ID="t3tbEnhancementToDate" runat="server" CssClass="form-control" TextMode="Date" AutoPostBack="True" OnTextChanged="t3tbEnhancementToDate_TextChanged"></asp:TextBox>
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
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">Patient Photo</span><br />
                                                                <div class="d-flex align-items-center">
                                                                    <asp:FileUpload ID="fuEnhancementPatientPhoto" runat="server" />
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">Justification Of Enhancement</span><br />
                                                                <div class="d-flex align-items-center">
                                                                    <asp:FileUpload ID="fuEnhancementJustification" runat="server" />
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <span style="font-weight: 600!important;">ICP Photo</span><br />
                                                                <div class="d-flex align-items-center">
                                                                    <asp:FileUpload ID="fuEnhancementIcp" runat="server" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <hr />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-12 text-center">
                                                                <asp:Button ID="btnInitiateEnhancement" runat="server" CssClass="btn btn-primary" Text="Initiate Enhancement" OnClick="btnInitiateEnhancement_Click" />
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
                                                                <asp:Button ID="btnInitiateChangeOfWard" runat="server" CssClass="btn btn-primary" Text="Initiate Ward Change" OnClick="btnInitiateChangeOfWard_Click" />
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
                                        <div class="ibox-title">
                                            <h5>Modify Package</h5>
                                        </div>
                                        <div class="ibox-content">
                                            <div class="mt-3">
                                                <div class="form-group row m-b">
                                                    <div class="col-lg-2">
                                                        <span style="font-weight: 600!important;">Remarks:</span>
                                                    </div>
                                                    <div class="col-lg-7">
                                                        <asp:TextBox ID="tbModifyPackageRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <asp:Button ID="btnModifyPackage" runat="server" CssClass="btn btn-primary" Text="Modify Pre-Authorization" OnClick="btnModifyPackage_Click" />
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
                                                        <div class="col-lg-12">
                                                            <asp:GridView ID="t4gridAddedProcedure" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                                <AlternatingRowStyle BackColor="Gainsboro" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sl No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="7%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure Id" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbProcedureId" runat="server" Text='<%# Eval("ProcedureId") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure Code">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbProcedureCode" runat="server" Text='<%# Eval("ProcedureCode") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbProcedureName" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="53%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Surgery/Treatment Start Date">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="tbSurgeryDateTime" runat="server" TextMode="Date" CssClass="form-control" Text='<%# Eval("TreatmentStartDate") %>'></asp:TextBox>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="25%" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <br />
                                                            <asp:Button ID="btnSaveSurgeryDate" runat="server" Text="Save Date" CssClass="btn btn-primary" OnClick="btnSaveSurgeryDate_Click" /><br />
                                                            <br />
                                                            <span class="text-danger"><b>Note:</b></span> Please select Treatment Start Date for Medical Procedures and Surgery Date for Surgical Procedures.
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="ibox-title">
                                                <h5>Document Required</h5>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="row text-dark">
                                                    <div class="col-lg-12">
                                                        <asp:GridView ID="GridPackage" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" OnRowDataBound="GridPackage_RowDataBound">
                                                            <RowStyle BackColor="White" Height="20px" />
                                                            <Columns>
                                                                <asp:BoundField DataField="PackageID" HeaderText="Package ID" Visible="false" />
                                                                <asp:BoundField DataField="ProcedureId" HeaderText="Procedure ID" Visible="false" />
                                                                <asp:TemplateField HeaderText="Package Id" Visible="false">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbPackageId" runat="server" Text='<%# Eval("PackageId") %>' CssClass="font-weight-bold text-dark"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Procedure/Treatment">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbDocumentName" runat="server" Text='<%# Eval("SpecialityName") %>' CssClass="font-weight-bold text-dark"></asp:Label>
                                                                        <asp:GridView ID="gridInvestigation" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                                            <AlternatingRowStyle BackColor="Gainsboro" />
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="Pre Investigation Documents" Visible="false">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lbPostInvestigationPackageId" runat="server" Text='<%# Eval("PackageId") %>' CssClass="font-weight-bold text-dark" Visible="false"></asp:Label>
                                                                                        <asp:Label ID="lbPostInvestigationProcedureId" runat="server" Text='<%# Eval("ProcedureId") %>' CssClass="font-weight-bold text-dark" Visible="false"></asp:Label>
                                                                                        <asp:Label ID="lbPostInvestigationId" runat="server" Text='<%# Eval("PostInvestigationId") %>' CssClass="font-weight-bold text-dark" Visible="false"></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60%" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Post Investigation Documents">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lbPostInvestigationName" runat="server" Text='<%# Eval("InvestigationName") %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40%" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Select File To Upload">
                                                                                    <ItemTemplate>
                                                                                        <asp:Button ID="btnUploadPostInvestigation" runat="server" Text="Click Here To Upload" CssClass="btn btn-primary btn-sm rounded-pill" Style="font-size: 11px;" CommandArgument='<%# Eval("PostInvestigationId") %>' OnClick="btnUploadPostInvestigation" />
                                                                                    </ItemTemplate>
                                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40%" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Uploaded File">
                                                                                    <ItemTemplate>
                                                                                        <asp:LinkButton ID="btnUploadStatus" runat="server"
                                                                                            Style="font-size: 12px;" OnClick="btnUploadStatus_Click">
                                                                                            <asp:Label Visible="false" ID="lbFolder" runat="server" Text='<%# Eval("FolderName") %>'></asp:Label>
                                                                                            <asp:Label Visible="false" ID="lbUploadedFileName" runat="server" Text='<%# Eval("UploadedFileName") %>'></asp:Label>
                                                                                            <asp:Label ID="lbUploadStatus" runat="server" Text='<%# Eval("UploadStatus") %>'></asp:Label>
                                                                                        </asp:LinkButton>
                                                                                    </ItemTemplate>
                                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                                                                </asp:TemplateField>
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-left" Width="95%" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="95%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
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
                                    <%--<asp:View ID="viewAttachments" runat="server">
                                        tab-5
                                    </asp:View>--%>

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
            <asp:PostBackTrigger ControlID="btnUploadPostInvestigationFile" />
            <asp:PostBackTrigger ControlID="btnUploadDischargeSummary" />
            <asp:PostBackTrigger ControlID="btnUploadOperationDocument" />
            <asp:PostBackTrigger ControlID="btnUploadAfterDischargePhoto" />
            <asp:PostBackTrigger ControlID="btnUploadDocumentOne" />
            <asp:PostBackTrigger ControlID="btnUploadDocumentTwo" />
            <asp:PostBackTrigger ControlID="btnUploadDocumentThree" />
            <asp:PostBackTrigger ControlID="btnInitiateEnhancement" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
