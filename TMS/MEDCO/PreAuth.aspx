<%@ Page Title="" Language="C#" MasterPageFile="~/MEDCO/MEDCO.master" AutoEventWireup="true" CodeFile="PreAuth.aspx.cs" Inherits="MEDCO_PreAuth" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function showDocumentViewModal() {
            $('#modalDocumentView').modal('hide');
            $('.modal-backdrop').remove();
            $('#modalDocumentView').modal('show');
        }
        function hideDocumentViewModal() {
            $('#modalDocumentView').modal('hide');
            $('.modal-backdrop').remove();
            $('#modalDocumentView').modal('hide');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <contenttemplate>
            <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="mdl">
                        <div class="ctr">
                            <img id="Img1" src="../images/progress.gif" width="20" height="20" alt="" style="margin-left: 0%;" />
                            <p style="color: white; margin-top: 5px; margin-bottom: 0px;">Please Wait... </p>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>--%>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdAbuaId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPatientRegId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdHospitalId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPackageId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdProcedureId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPreInvestigationId" runat="server" Visible="false" />
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
                            <asp:Button ID="btnUploadPreInvestigationFile" CssClass="btn btn-primary btn-sm rounded-pill" runat="server" Text="Upload" OnClick="btnUploadPreInvestigationFile_Click" />
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="Button6" CssClass="btn btn-secondary" Text="Close" runat="server" OnClick="hideDocumentUploadModal_Click" />
                        </div>

                    </div>
                </div>
            </div>
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
                            <asp:Panel runat="server" ID="anamolyPanel" Visible="false">
                                <div class="ibox">
                                    <div class="ibox-content">
                                        <asp:Label ID="Label1" CssClass="form-label" runat="server" Text="Please upload a valid ID proof of the Beneficiary:"></asp:Label>
                                        <asp:FileUpload ID="FileUpload7" runat="server" />
                                        <asp:Button ID="Button9" runat="server" Text="Upload" CssClass="btn btn-sm btn-primary rounded-pill ml-3" />
                                        <br />
                                        <br />
                                        <asp:Label ID="Label2" CssClass="form-label" runat="server" Text="No Attachments Found"></asp:Label>
                                        <br />
                                        <asp:Label ID="Label3" CssClass="fw-bolder text-danger" runat="server" Text="Note: Please upload any of the document from the following list"></asp:Label>
                                        <br />
                                        <br />
                                        <ul>
                                            <li>Voter Id Card</li>
                                            <li>Ration Card</li>
                                            <li>Driving License</li>
                                            <li>Certificate of identity having photo issued by Gazetted Officer or Tehsildar on letter head</li>
                                            <li>MNREGA Job Card</li>
                                            <li>Birth Certificate</li>
                                            <li>Adoptation Certificate</li>
                                            <li>Passport</li>
                                        </ul>
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:Panel runat="server" ID="attachmentPanel" Visible="true">
                                <div class="tab-pane fade show active" id="attachment" role="tabpanel">
                                    <ul class="nav nav-tabs d-flex flex-row justify-content-around" id="attachTab" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active nav-attach" id="one-tab"
                                                data-toggle="tab" href="#one" role="tab" aria-controls="one" aria-selected="true">
                                                <span>Preauthorization</span>
                                            </a>
                                        </li>
                                        <%--<li class="nav-item ml-2">
                                            <a class="nav-link nav-attach" id="two-tab" data-toggle="tab" href="#two" role="tab" aria-controls="two" aria-selected="false">
                                                <span>discharge</span>
                                            </a>
                                        </li>--%>
                                    </ul>
                                    <div class="tab-content" id="attachTabContent">
                                        <div class="tab-pane fade show active" id="one" role="tabpanel">
                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                    <h3 class="m-0">Preauthorization</h3>
                                                </div>
                                            </div>
                                            <div class="ibox-content">
                                                <table class="table table-bordered table-striped" style="width: 100%;">
                                                    <thead>
                                                        <tr class="table-primary">
                                                            <th style="background-color: #007e72; color: white; width: 20%;">Attachment Name</th>
                                                            <th style="background-color: #007e72; color: white; width: 20%;">Select File To Upload</th>
                                                            <th style="background-color: #007e72; color: white; width: 40%;">Upload</th>
                                                            <th style="background-color: #007e72; color: white; width: 20%;">Beneficiary Options</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>Consent Documents</td>
                                                            <td>
                                                                <div class="d-flex align-items-center">
                                                                    <asp:FileUpload ID="fuConsent" runat="server" />
                                                                    <asp:Button ID="btnUploadConsent" runat="server" Text="Upload" CssClass="btn btn-sm btn-primary rounded-pill ml-3" OnClick="btnUploadConsent_Click" />
                                                                </div>
                                                            </td>
                                                            <td>NA</td>
                                                            <td>
                                                                <asp:LinkButton ID="btnConsentDocument" runat="server" enabled="false"
                                                                    Style="font-size: 12px;" OnClick="btnConsentDocument_Click">
                                                                    <asp:Label Visible="false" ID="lbConsentFolderName" runat="server" Text=''></asp:Label>
                                                                    <asp:Label Visible="false" ID="lbConsentUploadedFileName" runat="server" Text=''></asp:Label>
                                                                    <asp:Label ID="lbConsentStatus" runat="server" Text='NA'></asp:Label>
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Health Card</td>
                                                            <td>
                                                                <div class="d-flex align-items-center">
                                                                    <asp:FileUpload ID="fuHealthCard" runat="server" />
                                                                    <asp:Button ID="btnUploadHealthCard" runat="server" Text="Upload" CssClass="btn btn-sm btn-primary rounded-pill ml-3" OnClick="btnUploadHealthCard_Click" />
                                                                </div>
                                                                <td>NA</td>
                                                            <td>
                                                                <asp:LinkButton ID="btnHealthDocument" runat="server" enabled="false"
                                                                    Style="font-size: 12px;" OnClick="btnHealthDocument_Click">
                                                                    <asp:Label Visible="false" ID="lbHealthFolderName" runat="server" Text=''></asp:Label>
                                                                    <asp:Label Visible="false" ID="lbHealthUploadedFileName" runat="server" Text=''></asp:Label>
                                                                    <asp:Label ID="lbHealthStatus" runat="server" Text='NA'></asp:Label>
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Patient Photo<span class="text-danger">*</span></td>
                                                            <td>
                                                                <div class="d-flex align-items-center">
                                                                    <asp:FileUpload ID="fuPatientPhoto" runat="server" />
                                                                    <asp:Button ID="btnUploadPatientPhoto" runat="server" Text="Upload" CssClass="btn btn-sm btn-primary rounded-pill ml-3" OnClick="btnUploadPatientPhoto_Click" />
                                                                </div>
                                                            </td>
                                                            <td>NA</td>
                                                            <td>
                                                                <asp:LinkButton ID="btnPatientDocument" runat="server" enabled="false"
                                                                    Style="font-size: 12px;" OnClick="btnPatientDocument_Click">
                                                                    <asp:Label Visible="false" ID="lbPatientPhotoFolderName" runat="server" Text=''></asp:Label>
                                                                    <asp:Label Visible="false" ID="lbPatientPhotoUploadedFileName" runat="server" Text=''></asp:Label>
                                                                    <asp:Label ID="lbPatientPhotoStatus" runat="server" Text='NA'></asp:Label>
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="container mt-4">
                                            <strong class="text-danger">Note:</strong>
                                            <ol class="text-danger font-weight-bold">
                                                <li>File size should not exceed 500 kb</li>
                                            </ol>
                                        </div>
                                        <div class="col-md-12 mt-2 mb-2">
                                            <button class="btn btn-primary rounded-pill" type="button">Download as one PDF<img src="../images/pdf-viewer-svgrepo-com.svg" width="15" class="ml-2" /></button>
                                        </div>
                                    </div>
                                </div>
                            </asp:Panel>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="Button10" CssClass="btn btn-secondary" Text="Close" runat="server" OnClientClick="hideAttachmentAnamolyModal();" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="modalDocumentView" tabindex="-1" role="dialog" aria-labelledby="modal2Label" aria-hidden="true">
                <div class="modal-dialog modal-xl" role="document">
                    <div class="modal-content">
                        <div class="modal-header round" style="background-color: #007e72;">
                            <h2 class="modal-title text-white" style="margin: 0px !important;"><asp:Label ID="lbTitle" runat="server" Text="" class="modal-title font-weight-bolder" style="font-size: 20px; color: white;"></asp:Label></h2>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row table-responsive" style="max-height: 700px; overflow-y: scroll;">
                                <asp:Image ID="imgChildView" runat="server" class="img-fluid" AlternateText="Document View" style="width:80%; height:80%;"></asp:Image>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="Button2" CssClass="btn btn-secondary" Text="Close" runat="server" OnClick="hideDocumentUploadModal_Click" />
                        </div>

                    </div>
                </div>
            </div>
            <asp:MultiView ID="MultiView1" runat="server">
                <asp:View ID="viewRegisteredPatient" runat="server">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="ibox-title text-center">
                                <h3 class="text-white">View Registered Patients</h3>
                            </div>
                            <div class="ibox-content">
                                <div class="ibox">
                                    <div class="ibox-content text-dark">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <asp:Label runat="server" AssociatedControlID="tbSearchRegno" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Registration No." />
                                                <asp:TextBox ID="tbSearchRegno" runat="server" OnKeypress="return isNumeric(event)" CssClass="form-control" />
                                            </div>
                                            <div class="col-md-4">
                                                <asp:Label runat="server" AssociatedControlID="tbSearchBeneficiaryCardNo" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Beneficiary Card No." />
                                                <asp:TextBox ID="tbSearchBeneficiaryCardNo" runat="server" OnKeypress="return isAlphaNumeric(event)" CssClass="form-control" />
                                            </div>
                                            <div class="col-md-4">
                                                <asp:Label runat="server" AssociatedControlID="dropSearchStateScheme" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="State/Scheme" />
                                                <br />
                                                <asp:DropDownList ID="dropSearchStateScheme" runat="server" CssClass="form-control">
                                                    <asp:ListItem Text="ABUA-JHARKHAND" Value="1"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-md-4 mt-4">
                                                <asp:Label runat="server" AssociatedControlID="dropSearchDistrict" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="District" />
                                                <br />
                                                <asp:DropDownList ID="dropSearchDistrict" runat="server" CssClass="form-control">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-md-4 mt-4">
                                                <asp:Label runat="server" AssociatedControlID="tbSearchRegisteredFromDate" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Registered From Date" />
                                                <asp:TextBox ID="tbSearchRegisteredFromDate" runat="server" OnKeypress="return isDate(event)" CssClass="form-control" TextMode="Date" />
                                            </div>
                                            <div class="col-md-4 mt-4">
                                                <asp:Label runat="server" AssociatedControlID="tbSearchRegisteredToDate" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Registered To Date" />
                                                <asp:TextBox ID="tbSearchRegisteredToDate" runat="server" OnKeypress="return isDate(event)" CssClass="form-control" TextMode="Date" />
                                            </div>
                                            <%--<div class="col-md-3 mt-3">
                                                <asp:Label runat="server" AssociatedControlID="tbRegistrationType" CssClass="form-label fw-semibold" Style="font-size: 14px;">Registration Type</asp:Label><br />
                                                <asp:DropDownList ID="tbRegistrationType" runat="server" CssClass="form-control">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-md-3 mt-3">
                                                <asp:Label runat="server" AssociatedControlID="tbReferedPatient" CssClass="form-label fw-semibold" Style="font-size: 14px;">Refered Patient</asp:Label><br />
                                                <asp:DropDownList ID="tbReferedPatient" runat="server" CssClass="form-control">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>--%>
                                            <div class="col-lg-12 text-center mt-3">
                                                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success rounded-pill" Text="Search" OnClick="btnSearch_Click" />
                                                <asp:Button ID="btnReset" runat="server" CssClass="btn btn-warning rounded-pill" Text="Reset" OnClick="btnReset_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex mt-3 text-danger font-weight-bold">
                                <span>Note: </span>
                                <div><span class="pink mr-1"></span>Silver Card Registrations</div>
                                <div><span class="green mr-1"></span>Non PMJAY Registrations</div>
                                <div><span class="white mr-1"></span>Refered Patients</div>
                            </div>
                            <div class="card mt-3">
                                <div class="card-body table-responsive">
                                    <asp:GridView ID="gridRegisteredPatient" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                        <alternatingrowstyle backcolor="Gainsboro" />
                                        <columns>
                                            <asp:TemplateField HeaderText="Sl No.">
                                                <itemtemplate>
                                                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Registration No.">
                                                <itemtemplate>
                                                    <asp:Label ID="lbRegId" runat="server" Text='<%# Eval("PatientRegId") %>' Visible="false"></asp:Label>
                                                    <asp:LinkButton ID="lnkRegId" runat="server" OnClick="lnkRegId_Click"><%# Eval("PatientRegId") %></asp:LinkButton>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Patient Name">
                                                <itemtemplate>
                                                    <asp:Label ID="lbName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Beneficiary Card No.">
                                                <itemtemplate>
                                                    <asp:Label ID="lbCardNo" runat="server" Text='<%# Eval("CardNumber") %>'></asp:Label>
                                                    <asp:Label ID="lbPatientCardNo" runat="server" Text='<%# Eval("CardNumber") %>' Visible="false"></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="District">
                                                <itemtemplate>
                                                    <asp:Label ID="lbDistrict" runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Address">
                                                <itemtemplate>
                                                    <asp:Label ID="lbAddress" runat="server" Text='<%# Eval("PatientAddress") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Gender">
                                                <itemtemplate>
                                                    <asp:Label ID="lbGender" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Age">
                                                <itemtemplate>
                                                    <asp:Label ID="lbAge" runat="server" Text='<%# Eval("Age") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Registration Date">
                                                <itemtemplate>
                                                    <asp:Label ID="lbRegDate" runat="server" Text='<%# Eval("RegDate") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Print">
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Cancel">
                                                <itemtemplate>
                                                    <asp:LinkButton ID="lnkDeletePatient" runat="server" CssClass="text-danger" OnClick="lnkDeletePatient_Click">Cancel</asp:LinkButton>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                            </asp:TemplateField>
                                        </columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:View>
                <asp:View ID="viewAdmission" runat="server">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="ibox">
                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                    <div class="d-flex">
                                        <h3 class="m-0">
                                            <asp:LinkButton ID="lnkBackToList" runat="server" ForeColor="White" OnClick="lnkBackToList_Click">Back To List</asp:LinkButton></h3>
                                    </div>
                                    <div class="d-flex justify-content-center">
                                        <h3 class="m-0">Pre-Auth</h3>
                                    </div>
                                    <div class="text-white text-nowrap">
                                        <span class="font-weight-bold">Registration No:</span>
                                        <asp:Label ID="lbRegNo" runat="server" Text=""></asp:Label>
                                    </div>
                                </div>
                                <div class="ibox-content text-dark">
                                    <div class="row">
                                        <div class="col-lg-9">
                                            <div class="row">
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Name:</span><br>
                                                    <asp:Label ID="lbName" runat="server" Text="" CssClass="small-text"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Gender:</span><br />
                                                    <asp:Label ID="lbGender" runat="server" Text="" CssClass="small-text"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Beneficiary Card ID:</span><br>
                                                    <asp:Label ID="lbCardNumber" runat="server" Text="" CssClass="small-text"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Age:</span><br>
                                                    <asp:Label ID="lbAge" runat="server" Text="" CssClass="small-text"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Registration Date</span><br />
                                                    <asp:Label ID="lbRegDate" runat="server" Text="" CssClass="small-text"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Conatct No:</span><br>
                                                    <asp:Label ID="lbMobileNo" runat="server" Text="" CssClass="small-text"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Family ID:</span><br>
                                                    <asp:Label ID="lbFamilId" runat="server" Text="" CssClass="small-text"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Aadhar Verified:</span><br>
                                                    <asp:Label ID="lbAadharVerified" runat="server" Text="" CssClass="small-text"></asp:Label>
                                                </div>
                                                <div class="col-md-3 mt-3">
                                                    <span class="font-weight-bold">Biometric Verified:</span><br>
                                                    <asp:Label ID="lbBiometricVerified" runat="server" Text="" CssClass="small-text"></asp:Label>
                                                </div>
                                                <div id="divChild" runat="server" class="row w-100">
                                                    <div class="col-md-3 mt-3">
                                                        <span class="font-weight-bold">Child Name:</span><br>
                                                        <asp:Label ID="lbChildName" runat="server" Text="" CssClass="small-text"></asp:Label>
                                                    </div>
                                                    <div class="col-md-3 mt-3">
                                                        <span class="font-weight-bold">Child DOB:</span><br>
                                                        <asp:Label ID="lbChildDOB" runat="server" Text="" CssClass="small-text"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-3">
                                            <div class="d-flex justify-content-center">
                                                <asp:Image ID="imgPatientPhoto" runat="server" ImageUrl="../img/profile.jpg" CssClass="img-fluid mb-3" Style="max-width: 130px; height: 130px; border: 1px groove #007e72; padding: 2px;" AlternateText="Patient Photo" />
                                                <asp:Image ID="imgChildPhoto" runat="server" ImageUrl="../img/profile.jpg" CssClass="img-fluid mb-3" Style="max-width: 130px; height: 130px; border: 1px groove #007e72; padding: 2px;" AlternateText="Patient Photo" Visible="false" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col-md-2">
                                    <asp:Button ID="btnGeneralFindings" runat="server" Text='General Findings' CssClass="btn btn-primary" OnClick="showGeneralFindingModal_Click" />
                                </div>
                                <div class="col-md-2">
                                    <asp:Button ID="btnPersonalHistory" runat="server" Text='Personal History' CssClass="btn btn-primary" OnClick="showPersonalHistoryModal_Click" />
                                </div>
                                <div class="col-md-2">
                                    <asp:Button ID="btnPastFamilyHistory" runat="server" Text='Past and Family History' CssClass="btn btn-primary" OnClick="showFamilyHistoryModal_Click" />
                                </div>
                            </div>
                            <!-- Modal 1 -->
                            <div class="modal fade" id="modalGeneralFindings" tabindex="-1" role="dialog" aria-labelledby="modal2Label" aria-hidden="true">
                                <div class="modal-dialog modal-xl" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header round" style="background-color: #007e72;">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <!-- Modal 1 content goes here -->
                                            <%--<h3>History of Present Illness</h3>--%>
                                            <asp:MultiView ID="MultiView2" runat="server">
                                                <asp:View ID="View1" runat="server">
                                                    <div class="col-md-12 mt-2" style="border: 1px solid black; border-radius: 5px; padding: 0px;">
                                                        <p class="p-2 bg-primary text-white" style="border-radius: 5px;">General Examination Findings</p>
                                                        <div class="row justify-content-around">
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">Temperature(C/F)<span class="text-danger">*</span></span>
                                                            </div>
                                                            <div class="col-md-3 d-flex">
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGTempC" runat="server" GroupName="Temperature" Text="C" class="font-weight-bold text-dark" />
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGTempF" runat="server" GroupName="Temperature" Text="F" class="font-weight-bold text-dark" />
                                                                </div>
                                                                <asp:TextBox ID="tbGTemp" runat="server" CssClass="form-control border-0 border-bottom" Text="0" OnKeypress="return isDecimal(event);"></asp:TextBox>
                                                            </div>
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">Pulse Rate Per Minute<span class="text-danger">*</span></span>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="tbGPulseRate" runat="server" CssClass="form-control border-0 border-bottom" Text="0" OnKeypress="return isNumeric(event);"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                        <div class="row justify-content-around mt-1">
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">BP Lt.Arm mm/Hg<span class="text-danger">*</span></span>
                                                            </div>
                                                            <div class="col-md-3 d-flex">
                                                                <asp:TextBox ID="tbGBPLArm1" runat="server" CssClass="form-control border-0 border-bottom" Width="50%" Text="0" OnKeypress="return isDecimal(event);"></asp:TextBox>
                                                                <span class="font-weight-bold text-dark">/</span><asp:TextBox ID="tbGBPLArm2" runat="server" CssClass="form-control border-0 border-bottom" Width="50%" Text="0" OnKeypress="return isDecimal(event);"></asp:TextBox>
                                                            </div>
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">BP Rt.Arm mm/Hg</span>
                                                            </div>
                                                            <div class="col-md-3 d-flex">
                                                                <asp:TextBox ID="tbGBPRArm1" runat="server" CssClass="form-control border-0 border-bottom" Width="50%" Text="0" OnKeypress="return isDecimal(event);"></asp:TextBox>
                                                                /<asp:TextBox ID="tbGBPRArm2" runat="server" CssClass="form-control border-0 border-bottom" Width="50%" Text="0" OnKeypress="return isDecimal(event);"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="row justify-content-around mt-1">
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">Height(in cm)</span>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="tbGHeight" runat="server" CssClass="form-control border-0 border-bottom" Text="0" OnKeypress="return isNumeric(event);"></asp:TextBox>
                                                            </div>
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">Weight(in Kg)</span>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="tbGWeight" runat="server" CssClass="form-control border-0 border-bottom" Text="0" OnKeypress="return isDecimal(event);"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                        <div class="row justify-content-around mt-1">
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">BMI</span>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="tbGBMI" runat="server" CssClass="form-control border-0 border-bottom" Text="0" OnKeypress="return isDecimal(event);"></asp:TextBox>
                                                            </div>
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">Pallor</span>
                                                            </div>
                                                            <div class="col-md-3 d-flex">
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGPallorYes" runat="server" GroupName="Pallor" Text="Yes" class="font-weight-bold text-dark" />
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGPallorNo" runat="server" GroupName="Pallor" Text="No" class="font-weight-bold text-dark" />
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row justify-content-around mt-1">
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">Cyanosis</span>
                                                            </div>
                                                            <div class="col-md-3 d-flex">
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGCyanosisYes" runat="server" GroupName="Cyanosis" Text="Yes" class="font-weight-bold text-dark" />
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGCyanosisNo" runat="server" GroupName="Cyanosis" Text="No" class="font-weight-bold text-dark" />
                                                                </div>
                                                            </div>
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">Clubbing Of Fingers/Toes</span>
                                                            </div>
                                                            <div class="col-md-3 d-flex">
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGClubbingYes" runat="server" GroupName="Clubbing" Text="Yes" class="font-weight-bold text-dark" />
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGClubbingNo" runat="server" GroupName="Clubbing" Text="No" class="font-weight-bold text-dark" />
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row justify-content-around mt-1">
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">Lymphadenopathy</span>
                                                            </div>
                                                            <div class="col-md-3 d-flex">
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGLymphaYes" runat="server" GroupName="Lymph" Text="Yes" class="font-weight-bold text-dark" />
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGLymphaNo" runat="server" GroupName="Lymph" Text="No" class="font-weight-bold text-dark" />
                                                                </div>
                                                            </div>
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">Oedema In Feet</span>
                                                            </div>
                                                            <div class="col-md-3 d-flex">
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGOedemaYes" runat="server" GroupName="Oedema" Text="Yes" class="font-weight-bold text-dark" />
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGOedemaNo" runat="server" GroupName="Oedema" Text="No" class="font-weight-bold text-dark" />
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row justify-content-around mt-1">
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">Malnutrition</span>
                                                            </div>
                                                            <div class="col-md-3 d-flex">
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGMalYes" runat="server" GroupName="Mal" Text="Yes" class="font-weight-bold text-dark" />
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGMalNo" runat="server" GroupName="Mal" Text="No" class="font-weight-bold text-dark" />
                                                                </div>
                                                            </div>
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">Dehydration</span>
                                                            </div>
                                                            <div class="col-md-3 d-flex">
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGDehydYes" runat="server" GroupName="Dehyd" Text="Yes" class="font-weight-bold text-dark" />
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <asp:RadioButton ID="rbGDehydNo" runat="server" GroupName="Dehyd" Text="No" class="font-weight-bold text-dark" />
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row justify-content-around mt-1">
                                                            <div class="form-check col-md-3">
                                                                <span class="font-weight-bold text-dark">Respiration Rate</span>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="tbGRespiration" runat="server" CssClass="form-control border-0 border-bottom"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                            </div>
                                                            <div class="col-md-3">
                                                            </div>
                                                        </div>
                                                        <div class="text-center mt-3 mb-2">
                                                            <asp:Button ID="btnGeneralFinding" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnGeneralFinding_Click" />
                                                        </div>
                                                    </div>
                                                </asp:View>
                                                <asp:View ID="View2" runat="server">
                                                    <div class="ibox">
                                                        <div class="ibox-title text-dark">
                                                            <h5>Personal History</h5>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="col-md-12 mt-2 d-flex align-items-center">
                                                                <div class="col-md-4">
                                                                    <asp:Label ID="lbAppetite" CssClass="m-b dark-label font-weight-bold" runat="server" Text="Appetite"></asp:Label>
                                                                    <asp:DropDownList ID="dropAppetite" CssClass="form-control m-b" runat="server">
                                                                        <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                                                        <asp:ListItem Value="1">Normal</asp:ListItem>
                                                                        <asp:ListItem Value="2">Lost</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <asp:Label ID="lbDiet" CssClass="m-b dark-label font-weight-bold" runat="server" Text="Diet"></asp:Label>
                                                                    <asp:DropDownList ID="dropDiet" CssClass="form-control m-b" runat="server">
                                                                        <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                                                        <asp:ListItem Value="1">Veg</asp:ListItem>
                                                                        <asp:ListItem Value="2">Non-Veg</asp:ListItem>
                                                                        <asp:ListItem Value="3">Eggeterian</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <asp:Label ID="lbBowels" CssClass="m-b dark-label font-weight-bold" runat="server" Text="Bowels"></asp:Label>
                                                                    <asp:DropDownList ID="dropBowels" CssClass="form-control m-b" runat="server">
                                                                        <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                                                        <asp:ListItem Value="1">Regular</asp:ListItem>
                                                                        <asp:ListItem Value="2">Irregular</asp:ListItem>
                                                                        <asp:ListItem Value="3">Constipation</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12 mt-2 d-flex align-items-center">
                                                                <div class="col-md-4">
                                                                    <asp:Label ID="lbNutrition" CssClass="m-b dark-label font-weight-bold" runat="server" Text="Nutrition"></asp:Label>
                                                                    <asp:DropDownList ID="dropNutrition" CssClass="form-control m-b" runat="server">
                                                                        <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                                                        <asp:ListItem Value="1">Normal</asp:ListItem>
                                                                        <asp:ListItem Value="2">Abnormal</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <span class="font-weight-bold text-dark">Known Allergies</span>
                                                                    <div class="form-check form-check-inline">
                                                                        <asp:RadioButton ID="rbAllergiesYes" CssClass="form-check-input font-weight-bold text-dark" GroupName="KnownAllergies" runat="server" Text="Yes" />
                                                                    </div>
                                                                    <div class="form-check form-check-inline">
                                                                        <asp:RadioButton ID="rbAllergiesNo" CssClass="form-check-input font-weight-bold text-dark" GroupName="KnownAllergies" runat="server" Text="No" />
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <span class="font-weight-bold text-dark">Habits/Addictions</span>
                                                                    <div class="form-check form-check-inline">
                                                                        <asp:RadioButton ID="rbHabitsYes" CssClass="form-check-input font-weight-bold text-dark" GroupName="HabitsAddictions" runat="server" Text="Yes" />
                                                                    </div>
                                                                    <div class="form-check form-check-inline">
                                                                        <asp:RadioButton ID="rbHabitsNo" CssClass="form-check-input font-weight-bold text-dark" GroupName="HabitsAddictions" runat="server" Text="No" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="text-center mt-3 mb-2">
                                                                <asp:Button ID="btnSavePersonalHistory" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSavePersonalHistory_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:View>
                                                <asp:View ID="View3" runat="server">
                                                    <div class="row">
                                                        <!-- First Half (Left Column) -->
                                                        <div class="col-lg-6">
                                                            <div class="ibox">
                                                                <div class="ibox-title text-dark">
                                                                    <h5>History of Past Illness</h5>
                                                                </div>
                                                                <div class="ibox-content">
                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbPEndocrineDiseases" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Endocrine Diseases Diseases Diseases Diseases" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbPDiabetes" CssClass="mr-2 text-dark font-weight-bold" Text="&nbsp;&nbsp;Diabetes" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbPHypertension" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbspHyperension" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbPCAD" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;CAD" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbPAsthma" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Asthma" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbPTuberculosis" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Tuberculosis" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbPStroke" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Stroke" runat="server" />

                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbPCancers" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Cancers" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbPBloodTransfusion" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Blood Transfusion" runat="server" />

                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbPSurgeries" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Surgeries" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbPOther" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Other if any" runat="server" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbPNotApplicable" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Not Applicable" runat="server" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- Second Half (Right Column) -->
                                                        <div class="col-lg-6">
                                                            <div class="ibox">
                                                                <div class="ibox-title text-dark">
                                                                    <h5>Family History</h5>
                                                                </div>
                                                                <div class="ibox-content">
                                                                    <!-- Family History content goes here -->
                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbFDiabetes" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Diabetes" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbFHypertension" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Hypertension" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbFHeartDisease" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Heart Disease" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbFStroke" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Stroke" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbFCancers" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Cancers" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbFTuberculosis" CssClass="mr-2 text-dark font-weight-bold" Text="&nbsp;&nbsp;Tuberculosis" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbFAsthma" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Asthma" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbFAnyOtherHereditary" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Any Other Fereditary" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbFPsychiatristIllness" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Psychiatrist Illness" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbFAnyOther" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Any Other" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="row mt-2 d-flex align-items-center">
                                                                        <div class="form-group mb-0 d-flex align-items-center">
                                                                            <asp:CheckBox ID="cbFNotApplicable" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;Not Applicable" runat="server" />
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 text-center">
                                                            <div class="text-center mt-3 mb-2">
                                                                <asp:Button ID="btnSaveFamilyHistory" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSaveFamilyHistory_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:View>
                                            </asp:MultiView>

                                        </div>
                                        <div class="modal-footer">
                                            <asp:Button ID="btnClose" CssClass="btn btn-secondary" Text="Close" runat="server" OnClick="hideGeneralFindingModal_Click" />
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <%--Diagnosis--%>
                            <div class="ibox mt-4">
                                <div class="ibox-title text-center">
                                    <h3 class="text-white m-0">Diagnosis</h3>
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
                                            <div class="col-md-6">
                                                <asp:GridView ID="gridPrimaryDiagnosis" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                    <alternatingrowstyle backcolor="Gainsboro" />
                                                    <columns>
                                                        <asp:TemplateField HeaderText="Sl No.">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbPPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Diagnosis Name">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Cancel">
                                                            <itemtemplate>
                                                                <asp:LinkButton ID="lnkDeletePrimaryDiagnosis" runat="server" CssClass="text-danger" OnClick="lnkDeletePrimaryDiagnosis_Click">Remove</asp:LinkButton>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                    </columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="col-md-6">
                                                <asp:GridView ID="gridSecondaryDiagnosis" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                    <alternatingrowstyle backcolor="Gainsboro" />
                                                    <columns>
                                                        <asp:TemplateField HeaderText="Sl No.">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbSPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Diagnosis Name">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Cancel">
                                                            <itemtemplate>
                                                                <asp:LinkButton ID="lnkDeleteSecondaryDiagnosis" runat="server" CssClass="text-danger" OnClick="lnkDeleteSecondaryDiagnosis_Click">Remove</asp:LinkButton>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
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

                            <%--Treatment Protocol--%>
                            <div class="ibox mt-4">
                                <div class="ibox-title text-center">
                                    <h3 class="text-white m-0">Treatment Protocol</h3>
                                </div>
                                <div class="ibox-content">
                                    <div class="row text-dark">
                                        <div class="row col-lg-12">
                                            <div class="col-md-4 mb-3">
                                                <div class="form-group">
                                                    <span class="font-weight-bold text-dark">Speciality</span>
                                                    <span class="text-danger">*</span>
                                                    <asp:DropDownList ID="dropPackageMaster" runat="server" CssClass="form-control" Style="width: 300px; word-wrap: break-word;" AutoPostBack="True" OnSelectedIndexChanged="dropPackageMaster_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <div class="form-group">
                                                    <span class="font-weight-bold text-dark">Procedure</span>
                                                    <span class="text-danger">*</span>
                                                    <asp:DropDownList ID="dropProcedure" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="dropProcedure_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <div class="form-group">
                                                    <span class="font-weight-bold text-dark">ICHI Code/Description</span>
                                                    <span class="text-danger">*</span>
                                                    <asp:DropDownList ID="dropICHICode" runat="server" CssClass="form-control">
                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                        <asp:ListItem Value="1" Selected="True">NA</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <asp:Panel ID="panelUnspecified" runat="server" Visible="false">
                                                    <div class="ibox">
                                                        <div class="ibox-title text-center">
                                                            <h3 class="text-white m-0">Unspecified Package Detail</h3>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row">
                                                                <div class="col-lg-4 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Procedure Name</span>
                                                                        <span class="text-danger">*</span>
                                                                        <asp:TextBox ID="tbUnspecifiedProcedureName" OnKeypress="return isAlphaNumeric(event);" runat="server" CssClass="form-control" Text=""></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-4 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Procedure Amount</span>
                                                                        <span class="text-danger">*</span>
                                                                        <asp:TextBox ID="tbUnspecifiedProcedureAmount" OnKeypress="return isNumeric(event);" runat="server" TextMode="number" CssClass="form-control" Text="0"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-lg-8 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Investigation</span>
                                                                        <span class="text-danger">*</span>
                                                                        <asp:TextBox ID="tbUnspecifiedProcedureInvestigation" OnKeypress="return isAlphaNumeric(event);" runat="server" CssClass="form-control" Text="" TextMode="MultiLine"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </div>
                                            <div class="col-lg-12">
                                                <asp:Panel ID="panelStratification" runat="server">
                                                    <div class="ibox">
                                                        <div class="ibox-title text-center">
                                                            <h3 class="text-white m-0">Stratification</h3>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row">
                                                                <div class="col-lg-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Stratification Detail</span>
                                                                        <span class="text-danger">*</span>
                                                                        <asp:DropDownList ID="dropStratificationType" runat="server" CssClass="form-control" AutoPostBack="True">
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Stratification Option</span>
                                                                        <span class="text-danger">*</span>
                                                                        <asp:DropDownList ID="dropStratificationOption" runat="server" CssClass="form-control">
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </div>

                                            <div class="col-lg-12">
                                                <asp:Panel ID="panelImplant" runat="server">
                                                    <div class="ibox">
                                                        <div class="ibox-title text-center">
                                                            <h3 class="text-white m-0">Implants</h3>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row">
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Implant Option</span>
                                                                        <span class="text-danger">*</span>
                                                                        <asp:DropDownList ID="dropImplantOption" runat="server" CssClass="form-control">
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">No. Of Implants</span>
                                                                        <span class="text-danger">*</span>
                                                                        <asp:TextBox ID="tbImplantCount" OnKeypress="return isNumeric(event);" runat="server" TextMode="number" CssClass="form-control" Text="0"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </div>

                                            <div class="col-lg-12 text-center">
                                                <asp:Button ID="btnAddProcedure" runat="server" OnClick="btnAddProcedure_Click" CssClass="btn btn-primary mt-3" Text="Add Procedure" />
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <asp:Panel ID="panelAddedProcedure" runat="server">
                                <div class="ibox mt-4">
                                    <asp:Panel ID="panelAddedDocument" runat="server">
                                        <div class="ibox-title text-center">
                                            <h3 class="text-white m-0">Added Procedure</h3>
                                        </div>
                                        <div class="ibox-content">
                                            <div class="row text-dark">
                                                <div class="col-lg-12">
                                                    <asp:GridView ID="gridAddedpackageProcedure" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                        <rowstyle backcolor="White" height="20px" />
                                                        <columns>
                                                            <asp:TemplateField HeaderText="Package Id" Visible="false">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbPackageId" runat="server" Text='<%# Eval("PackageId") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Left" verticalalign="Middle" width="35%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Procedure Id" Visible="false">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbProcedureId" runat="server" Text='<%# Eval("ProcedureId") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Left" verticalalign="Middle" width="35%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Sl No.">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Speciality">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbAddedSpeciality" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Left" verticalalign="Middle" width="15%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Procedure">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbAddedProcedure" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Left" verticalalign="Middle" width="35%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Package Cost">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbAddedAmount" runat="server" Text='<%# Eval("ProcedureAmountFinal") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Stratification">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbAddedStratification" runat="server" Text='<%# Eval("StratificationName") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Left" verticalalign="Middle" width="15%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Implants">
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
                                                                <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Implant Cost">
                                                                <itemtemplate>
                                                                    <asp:Label ID="lbImplantAmount" runat="server" Text='<%# Eval("ImplantAmount") %>'></asp:Label>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Remove">
                                                                <itemtemplate>
                                                                    <asp:LinkButton ID="lnkDeleteProcedure" runat="server" CssClass="text-danger" OnClick="lnkDeleteProcedure_Click">Remove</asp:LinkButton>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                                            </asp:TemplateField>
                                                        </columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                </div>
                            </asp:Panel>
                            <asp:Panel ID="panelDocumentsRequired" runat="server">
                                <div class="ibox mt-4">
                                    <div class="ibox-title text-center">
                                        <h3 class="text-white m-0">Documents Required</h3>
                                    </div>
                                    <div class="ibox-content">
                                        <div class="row text-dark">
                                            <div class="col-lg-12">
                                                <asp:GridView ID="GridPackage" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" OnRowDataBound="GridPackage_RowDataBound">
                                                    <rowstyle backcolor="White" height="20px" />
                                                    <columns>
                                                        <asp:BoundField DataField="PackageID" HeaderText="Package ID" Visible="false" />
                                                        <asp:BoundField DataField="ProcedureId" HeaderText="Procedure ID" Visible="false" />
                                                        <asp:TemplateField HeaderText="Package Id" Visible="false">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbPackageId" runat="server" Text='<%# Eval("PackageId") %>' CssClass="font-weight-bold text-dark"></asp:Label>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="40%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Procedure/Treatment">
                                                            <itemtemplate>
                                                                <asp:Label ID="lbDocumentName" runat="server" Text='<%# Eval("SpecialityName") %>' CssClass="font-weight-bold text-dark"></asp:Label>
                                                                <asp:GridView ID="gridInvestigation" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                                    <alternatingrowstyle backcolor="Gainsboro" />
                                                                    <columns>
                                                                        <asp:TemplateField HeaderText="Pre Investigation Documents" Visible="false">
                                                                            <itemtemplate>
                                                                                <asp:Label ID="lbPreInvestigationPackageId" runat="server" Text='<%# Eval("PackageId") %>' CssClass="font-weight-bold text-dark" Visible="false"></asp:Label>
                                                                                <asp:Label ID="lbPreInvestigationProcedureId" runat="server" Text='<%# Eval("ProcedureId") %>' CssClass="font-weight-bold text-dark" Visible="false"></asp:Label>
                                                                                <asp:Label ID="lbPreInvestigationId" runat="server" Text='<%# Eval("PreInvestigationId") %>' CssClass="font-weight-bold text-dark" Visible="false"></asp:Label>
                                                                            </itemtemplate>
                                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="60%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Pre Investigation Documents">
                                                                            <itemtemplate>
                                                                                <asp:Label ID="lbPreInvestigationName" runat="server" Text='<%# Eval("InvestigationName") %>'></asp:Label>
                                                                            </itemtemplate>
                                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="40%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Select File To Upload">
                                                                            <itemtemplate>
                                                                                <asp:Button ID="btnUploadPreInvestigation" runat="server" Text="Click Here To Upload" CssClass="btn btn-primary btn-sm rounded-pill" Style="font-size: 11px;" CommandArgument='<%# Eval("PreInvestigationId") %>' OnClick="btnUploadPreInvestigation" />
                                                                            </itemtemplate>
                                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="40%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Uploaded File">
                                                                            <itemtemplate>
                                                                                <asp:LinkButton ID="btnUploadStatus" runat="server"
                                                                                    Style="font-size: 12px;" OnClick="btnUploadStatus_Click">
                                                                                    <asp:Label Visible="false" ID="lbFolder" runat="server" Text='<%# Eval("FolderName") %>'></asp:Label>
                                                                                    <asp:Label Visible="false" ID="lbUploadedFileName" runat="server" Text='<%# Eval("UploadedFileName") %>'></asp:Label>
                                                                                    <asp:Label ID="lbUploadStatus" runat="server" Text='<%# Eval("UploadStatus") %>'></asp:Label>
                                                                                </asp:LinkButton>
                                                                            </itemtemplate>
                                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="20%" />
                                                                        </asp:TemplateField>
                                                                    </columns>
                                                                </asp:GridView>
                                                            </itemtemplate>
                                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" cssclass="text-left" width="95%" />
                                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="95%" />
                                                        </asp:TemplateField>
                                                    </columns>
                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </asp:Panel>
                            <%--Admission Details--%>
                            <div class="ibox mt-4">
                                <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                    <div class="w-100 text-center">
                                        <h3 class="m-0">Admission Details</h3>
                                    </div>
                                </div>
                                <div class="ibox-content">
                                    <div class="row text-dark">
                                        <div class="col-md-3 mb-3">
                                            <div class="form-group">
                                                <asp:Label ID="Label49" runat="server" CssClass="form-label font-weight-bold" Text="Admission Type"></asp:Label>
                                                <asp:DropDownList ID="dropAdmissionType" AutoPostBack="true" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value="0">Planned</asp:ListItem>
                                                    <asp:ListItem Value="1">Emergency</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <div class="form-group">
                                                <asp:Label ID="lbProposedTreatmentDate" runat="server" CssClass="form-label font-weight-bold" Text="Proposed Surgery/Treatment Date"></asp:Label>
                                                <span class="text-danger">*</span>
                                                <asp:TextBox ID="tbProposedTreatmentDate" OnKeypress="return isDate(event);" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <div class="form-group">
                                                <asp:Label ID="lbAdmissionDate" runat="server" CssClass="form-label font-weight-bold" Text="Admission Date"></asp:Label>
                                                <span class="text-danger">*</span>
                                                <asp:TextBox ID="tbAdmissionDate" OnKeypress="return isDate(event);" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <div class="form-group">
                                                <asp:Label ID="lbMedcoLegalCase" runat="server" CssClass="form-label font-weight-bold" Text="Medco Legal Case, If any"></asp:Label>

                                                <div class="d-flex">
                                                    <div class="form-check form-check-inline me-2">
                                                        <asp:RadioButton ID="rbLegalCaseYes" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" />
                                                        <asp:Label ID="Label53" runat="server" CssClass="form-check-label" AssociatedControlID="rbLegalCaseYes" Text="Yes"></asp:Label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <asp:RadioButton ID="rbLegalCaseNo" runat="server" GroupName="inlineRadioOptions" CssClass="form-check-input" Checked="true" />
                                                        <asp:Label ID="Label54" runat="server" CssClass="form-check-label" AssociatedControlID="rbLegalCaseNo" Text="No"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4 mb-3">
                                            <span class="font-weight-bold text-dark">Package Cost</span>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <asp:Label ID="lbPackageCost" runat="server" CssClass="form-label" Text="0" />
                                            <hr />
                                        </div>
                                        <div class="col-md-4 mb-3">
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <span class="font-weight-bold text-dark">Incentive Amount</span>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <asp:Label ID="lbIncentiveAmount" runat="server" CssClass="form-label" Text="0" />
                                            <hr />
                                        </div>
                                        <div class="col-md-4 mb-3">
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <span class="font-weight-bold text-dark">Total Package Cost</span>
                                            <p class="text-danger font-weight-bold">(Note:Incentive Applicable)</p>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <asp:Label ID="lbTotalPackageCost" runat="server" CssClass="form-label" Text="0" />
                                            <hr />
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <span class="font-weight-bold text-dark">Hospital Incentive:</span>
                                            <asp:Label ID="lbHospitalIncentivePercentage" runat="server" CssClass="form-label" Text="0%"></asp:Label>
                                        </div>
                                        <div class="col-md-12 mb-3">
                                            <div class="form-group">
                                                <span class="font-weight-bold text-dark">Remarks</span>
                                                <asp:TextBox ID="tbRemarks" runat="server" TextMode="MultiLine" CssClass="form-control" OnKeypress="return isAlphaNumericSpecial(event);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <asp:Label ID="lbNotes" runat="server" CssClass="form-label font-weight-bold text-danger" Text="Note: Only (). special characters are allowed for Remarks"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%-- Action Type--%>
                            <div class="col-md-3 mb-3">
                                <div class="form-group">
                                    <asp:Label ID="ibActionType" runat="server" CssClass="form-label font-weight-bold" Text="Action Type"></asp:Label>

                                    <asp:DropDownList ID="dropActionType" runat="server" CssClass="form-control" AutoPostBack="true">
                                        <%--<asp:ListItem Value="0">Save</asp:ListItem>--%>
                                        <asp:ListItem Value="1">Initiate Preauth</asp:ListItem>

                                    </asp:DropDownList>
                                </div>
                            </div>

                            <%-- Buttons--%>
                            <div class="col-md-12 d-flex justify-content-center">
                                <asp:Button ID="btnSubmitAdmission" runat="server" CssClass="btn btn-primary mr-1" Text="Submit" OnClick="btnSubmitAdmission_Click" />
                                <asp:Button ID="btnAddViewAttachment" runat="server" CssClass="btn btn-primary mr-2" Text="Add/View Attachments" OnClick="btnAddViewAttachment_Click" />
                                <%--<asp:Button ID="btnAddViewDataAnamoly" runat="server" CssClass="btn btn-primary mr-2" Text="Add/View Data Anamoly Attachments" OnClick="btnAddViewDataAnamoly_Click" />--%>
                                <asp:Button ID="btnAdhikarPatra" runat="server" CssClass="btn btn-primary mr-2" Text="Adhikar Patra" />
                            </div>
                            <%--Note--%>
                            <%--<div class="container mt-4">
                                <strong class="text-danger">Note:</strong>
                                <ol class="text-danger font-weight-bold">
                                    <li>Insurance Wallet Amount: Rs.85700</li>
                                    <li>Scheme Wallet Amount:Rs.485700</li>
                                </ol>
                            </div>--%>
                        </div>
                    </div>
                </asp:View>
            </asp:MultiView>
        </contenttemplate>
        <triggers>
            <asp:PostBackTrigger ControlID="btnUploadPreInvestigationFile" />
            <asp:PostBackTrigger ControlID="btnUploadConsent" />
            <asp:PostBackTrigger ControlID="btnUploadHealthCard" />
            <asp:PostBackTrigger ControlID="btnUploadPatientPhoto" />
        </triggers>
    </asp:UpdatePanel>

</asp:Content>
