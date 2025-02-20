<%@ Page Title="" Language="C#" MasterPageFile="~/MEDCO/MEDCO.master" AutoEventWireup="true" CodeFile="ClaimInitiation.aspx.cs" Inherits="MEDCO_ClaimInitiation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        function activateTab(tabId) {
            $('.tab-pane').removeClass('active show');
            $(tabId).addClass('active show');
            return false;
        }
    </script>
    <style>
        .span-title {
            font-weight: 700;
            font-size: 14px;
        }

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
            color: black !important;
            border: none;
        }

            .nav-tabs .nav-attach.active {
                background-color: #ff9800;
                color: white !important;
                border: none;
            }
    </style>
    <script type="text/javascript">
        function showInitiateClaimModal() {
            $('#modalInitiateClaim').modal('hide');
            $('.modal-backdrop').remove();
            $('#modalInitiateClaim').modal('show');
        }
        function hideInitiateClaimModal() {
            $('#modalInitiateClaim').modal('hide');
            $('.modal-backdrop').remove();
            $('#modalInitiateClaim').modal('hide');
        }
    </script>
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
            <asp:HiddenField ID="hdDischargeId" runat="server" Visible="false" />
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
                                                    <asp:Label ID="lbCaseNumber" runat="server" Text='<%# Eval("CaseNumber") %>' Font-Bold="True" Visible="false"></asp:Label>
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
                                            <asp:Button ID="btnClaim" runat="server" Text="Claim" CssClass="btn btn-primary p-3" OnClick="btnClaim_Click" />
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
                                                                <span class="form-label fw-semibold">Doctor Type</span>
                                                                <asp:TextBox runat="server" ID="tbDoctorType" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Name</span>
                                                                <asp:TextBox runat="server" ID="tbDoctorName" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Registration No</span>
                                                                <asp:TextBox runat="server" ID="tbRegistrationNo" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Qualification</span>
                                                                <asp:TextBox runat="server" ID="tbQualification" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Contact No</span>
                                                                <asp:TextBox runat="server" ID="tbContact" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="ibox mt-4">
                                                <div class="ibox-title text-center">
                                                    <h3 class="text-white">Anesthetist Details</h3>
                                                </div>
                                                <div class="ibox-content">
                                                    <div class="ibox-content text-dark">
                                                        <div class="row">
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Anesthetist Name</span>
                                                                <asp:TextBox runat="server" ID="tbAnesthetistName" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Registration No</span>
                                                                <asp:TextBox runat="server" ID="tbAnesthetistRegNo" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Contact No</span>
                                                                <asp:TextBox runat="server" ID="tbAnesthetistContact" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Anaethetist Type</span>
                                                                <asp:TextBox runat="server" ID="tbAnesthetistType" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
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
                                                                <asp:TextBox runat="server" ID="tbIncisionType" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">OP Photos/WebEx Taken</span><br />
                                                                <div class="form-check form-check-inline mt-2">
                                                                    <asp:RadioButton ID="rbPhotoWebYes" runat="server" class="form-check-label" Text="&nbsp;&nbsp;Yes" Enabled="false" />
                                                                    <asp:RadioButton ID="rbPhotoWebNo" runat="server" class="form-check-label" Text="&nbsp;&nbsp;No" Enabled="false" Style="margin-left: 16px;" />
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">View Recording Done</span><br />
                                                                <div class="form-check form-check-inline mt-2">
                                                                    <asp:RadioButton ID="rbVideoYes" runat="server" class="form-check-label" Text="&nbsp;&nbsp;Yes" Enabled="false" />
                                                                    <asp:RadioButton ID="rbVideoNo" runat="server" class="form-check-label" Text="&nbsp;&nbsp;No" Enabled="false" Style="margin-left: 16px;" />
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Swab Count Instruments Count</span>
                                                                <asp:TextBox runat="server" ID="tbSwabCount" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Sutures Ligature</span>
                                                                <asp:TextBox runat="server" ID="tbSutures" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Specimen Removed</span><br />
                                                                <div class="form-check form-check-inline mt-2">
                                                                    <asp:RadioButton Enabled="false" ID="rbSpecimenYes" runat="server" class="form-check-label" GroupName="Specimen" Text="&nbsp;&nbsp;Yes" />
                                                                    <asp:RadioButton Enabled="false" ID="rbSpecimenNo" Checked="true" runat="server" class="form-check-label" GroupName="Specimen" Text="&nbsp;&nbsp;No" Style="margin-left: 16px;" />
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Drainage Count</span>
                                                                <asp:TextBox runat="server" ID="tbDrainageCount" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Blood Loss</span>
                                                                <asp:TextBox runat="server" ID="tbBloodLoss" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Post Operative Instructions</span>
                                                                <asp:TextBox runat="server" ID="tbPostOperative" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Patient Condition</span>
                                                                <asp:TextBox runat="server" ID="tbPatientCondition" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label fw-semibold">Complication If Any</span><br />
                                                                <div class="form-check form-check-inline mt-2">
                                                                    <asp:RadioButton Enabled="false" ID="rbComplicationYes" Checked="true" runat="server" class="form-check-label" GroupName="Complication" Text="&nbsp;&nbsp;Yes" />
                                                                    <asp:RadioButton Enabled="false" ID="rbComplicationNo" runat="server" class="form-check-label" GroupName="Complication" Text="&nbsp;&nbsp;No" Style="margin-left: 16px;" />
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
                                                            <asp:TextBox runat="server" ID="tbTreatementDate" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Surgery Start Time</span>
                                                            <asp:TextBox runat="server" ID="tbSurgeryStartTime" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Surgery End Time</span>
                                                            <asp:TextBox runat="server" ID="tbSurgeryEndTime" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="ibox mt-4">
                                                <div class="ibox-title text-center">
                                                    <h3 class="text-white">Surgery/ Treatement Start Date Details</h3>
                                                </div>
                                                <div class="ibox-content table-responsive">
                                                    <asp:GridView ID="gridSurgeryTreatementDate" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                                        <RowStyle BackColor="White" Height="20px" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Sl. No.">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbSurgerySlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Speciality Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbSurgeryAddedSpeciality" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Procedure Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbSurgeryAddedProcedure" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Stratification Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbSurgeryAddedStratification" runat="server" Text='<%# Eval("StratificationName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Implant Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbSurgeryAddedImplants" runat="server" Text='<%# Eval("ImplantName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Implant Quantity">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbSurgeryAddedQuantity" runat="server" Text='<%# Eval("ImplantCount") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Surgery Start Date">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbSurgeryStartDate" runat="server" Text='<%# Eval("TreatmentStartDate") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Surgery End Date">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbSurgeryEndDate" runat="server" Text='<%# Eval("TreatmentEndDate") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                                <asp:Panel ID="panelSurgeryDate" runat="server" Visible="false">
                                                    <div class="ibox-content table-responsive">
                                                        <div class="row ibox-content" style="background-color: #f0f0f0;">
                                                            <div class="col-md-12 d-flex flex-column justify-content-center align-items-center" style="height: 200px;">
                                                                <i class="fa fa-search" style="font-size: 20px;"></i>
                                                                <span class="mt-2">Details Not Found</span>
                                                                <span class="text-body-tertiary">Surgery/ Treatement start date details not found.</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </div>

                                            <div class="ibox mt-4">
                                                <div class="ibox-title text-center">
                                                    <h3 class="text-white">Treatement Summary</h3>
                                                </div>
                                                <div class="ibox-content text-dark">
                                                    <div class="row">
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Treatement Given</span>
                                                            <asp:TextBox runat="server" ID="tbTreatementGiven" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Operative Finding</span>
                                                            <asp:TextBox runat="server" ID="tbOperativeFinding" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Post Operative Period</span>
                                                            <asp:TextBox runat="server" ID="tbPostOperativePeriod" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Post Surgery/ Therapy Given</span>
                                                            <asp:TextBox runat="server" ID="tbPostSurgeryGiven" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Status at the time of Discharge</span>
                                                            <asp:TextBox runat="server" ID="tbStatusAtDischarge" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Review</span>
                                                            <asp:TextBox runat="server" ID="tbReview" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Advice</span>
                                                            <asp:TextBox runat="server" ID="tbAdvice" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <br />
                                                            <div class="form-check form-check-inline mt-2">
                                                                <asp:RadioButton ID="rbDischarge" runat="server" class="form-check-label" GroupName="Discharge" Text="&nbsp;&nbsp;Discharge" Enabled="false" />
                                                                <asp:RadioButton ID="rbDeath" runat="server" class="form-check-label" GroupName="Discharge" Text="&nbsp;&nbsp;Death" Enabled="false" Style="margin-left: 16px; color: red; font-weight: 600;" />
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
                                                            <span class="form-label fw-semibold">Discharge Date</span>
                                                            <asp:TextBox runat="server" ID="tbDischargeDate" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Next Follow Up Date</span>
                                                            <asp:TextBox runat="server" ID="tbNextFollowDate" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Consult at block name</span>
                                                            <asp:TextBox runat="server" ID="tbConsultAtBlock" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Floor</span>
                                                            <asp:TextBox runat="server" ID="tbFloor" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Room No</span>
                                                            <asp:TextBox runat="server" ID="tbRoomNo" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Is Special Case</span>
                                                            <asp:TextBox runat="server" ID="tbIsSpecialCase" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Special Case Value</span>
                                                            <asp:TextBox runat="server" ID="tbSpecialCaseValue" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Final Diagnosis</span>
                                                            <asp:TextBox runat="server" ID="tbFinalDiagnosis" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span class="form-label fw-semibold">Final Diagnosis Description</span>
                                                            <asp:TextBox runat="server" ID="tbFinalDiagnosisDescription" class="form-control mt-2" Text="NA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-3 mb-3">
                                                            <span>Procedure Consent</span><br />
                                                            <div class="form-check form-check-inline mt-2">
                                                                <asp:RadioButton Checked="true" ID="rbProcedureConsentYes" runat="server" class="form-check-label" GroupName="ProcedureConsent" Text="&nbsp;&nbsp;Yes" Enabled="false" />
                                                                <asp:RadioButton ID="rbProcedureConsentNo" runat="server" class="form-check-label" GroupName="ProcedureConsent" Text="&nbsp;&nbsp;No" Enabled="false" Style="margin-left: 16px;" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="viewClaim" runat="server">
                                        <div class="tab-pane fade show active" id="claim" role="tabpanel">
                                            <div class="ibox">
                                                <div class="ibox-title text-center">
                                                    <h3 class="text-white">Claim Details</h3>
                                                </div>
                                                <div class="ibox-content">
                                                    <div class="ibox-content text-dark">
                                                        <div class="row">
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label span-title">Preauth Approved Amount (Rs.)</span><br />
                                                                <asp:Label ID="lbPreauthApprovedAmount" runat="server" Text="NA" Style="font-size: 12px;"></asp:Label>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label span-title">Preauth Date</span><br />
                                                                <asp:Label ID="lbPreauthDate" runat="server" Text="NA" Style="font-size: 12px;"></asp:Label>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label span-title">Claim Submitted Date</span><br />
                                                                <asp:Label ID="lbClaimSubmittedDate" runat="server" Text="NA" Style="font-size: 12px;"></asp:Label>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label span-title">Last Claim Updated Date</span><br />
                                                                <asp:Label ID="lbClaimUpdatedDate" runat="server" Text="NA" Style="font-size: 12px;"></asp:Label>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label span-title">Penalty Amount (Rs.)</span><br />
                                                                <asp:Label ID="lbPenaltyAmount" runat="server" Text="NA" Style="font-size: 12px;"></asp:Label>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label span-title">Claim Amount (Rs.)</span><br />
                                                                <asp:Label ID="lbClaimAmount" runat="server" Text="NA" Style="font-size: 12px;"></asp:Label>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label span-title">Insurance Liable Amount (Rs.)</span><br />
                                                                <asp:Label ID="lbInsuranceLiableAmount" runat="server" Text="NA" Style="font-size: 12px;"></asp:Label>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label span-title">Trust Liable Amount (Rs.)</span><br />
                                                                <asp:Label ID="lbTrustLiableAmount" runat="server" Text="NA" Style="font-size: 12px;"></asp:Label>
                                                            </div>
                                                            <div class="col-md-3 mb-3">
                                                                <span class="form-label span-title">Bill Amount (Rs.)</span><br />
                                                                <asp:Label ID="lbBillAmount" runat="server" Text="NA" Style="font-size: 12px;"></asp:Label>
                                                            </div>
                                                            <div class="col-md-12">
                                                                <span class="form-label fw-semibold">Remarks</span><br />
                                                                <asp:TextBox ID="tbClaimRemarks" runat="server" ReadOnly="true" OnKeypress="return isAlphaNumeric(event)" class="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
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
                                                            <asp:DropDownList ID="dlAction" runat="server" class="form-control mt-2" AutoPostBack="True">
                                                                <asp:ListItem Text="--Select--" Value="0" />
                                                                <asp:ListItem Text="Initiate Claim" Value="1" />
                                                            </asp:DropDownList>

                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12 text-center">
                                                        <asp:Button ID="btnInitiateClaim" runat="server" class="btn btn-primary" Text="Submit" OnClick="btnInitiateClaim_Click" />
                                                        <asp:Button ID="btnAttachment" runat="server" Text="Add/View Attachments" CssClass="btn btn-primary" OnClick="btnAttachment_Click" />
                                                    </div>
                                                </div>
                                            </div>

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
            <asp:PostBackTrigger ControlID="btnUploadDischargeSummary" />
            <asp:PostBackTrigger ControlID="btnUploadOperationDocument" />
            <asp:PostBackTrigger ControlID="btnUploadAfterDischargePhoto" />
            <asp:PostBackTrigger ControlID="btnUploadDocumentOne" />
            <asp:PostBackTrigger ControlID="btnUploadDocumentTwo" />
            <asp:PostBackTrigger ControlID="btnUploadDocumentThree" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

