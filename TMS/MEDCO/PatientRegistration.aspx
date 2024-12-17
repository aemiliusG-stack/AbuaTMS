<%@ Page Title="" Language="C#" MasterPageFile="~/MEDCO/MEDCO.master" AutoEventWireup="true" Async="true" CodeFile="PatientRegistration.aspx.cs" Inherits="MEDCO_PatientRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function showModal() {
            $('#modal2').modal('hide');
            // Remove all backdrops
            $('.modal-backdrop').remove();
            $('#modal2').modal('show');
        }
    </script>
    <script type="text/javascript">
        function hideModal() {
            $('#modal2').modal('hide');
            // Remove all backdrops
            $('.modal-backdrop').remove();
            $('#modal2').modal('hide');
        }
    </script>
    <script type="text/javascript">
        function showDocumentUploadModal() {
            $('#modalDocumentUpload').modal('hide');
            // Remove all backdrops
            $('.modal-backdrop').remove();
            $('#modalDocumentUpload').modal('show');
        }
    </script>
    <script type="text/javascript">
        function hideDocumentUploadModal() {
            $('#modalDocumentUpload').modal('hide');
            // Remove all backdrops
            $('.modal-backdrop').remove();
            $('#modalDocumentUpload').modal('hide');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
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
                    <asp:Button ID="btnUploadPreInvestigationFile" CssClass="btn btn-primary btn-sm rounded-pill" runat="server" Text="Upload" />
                </div>
                <div class="modal-footer">
                    <asp:Button ID="Button6" CssClass="btn btn-secondary" Text="Close" runat="server" OnClientClick="hideDocumentUploadModal();" />
                </div>

            </div>
        </div>
    </div>
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="viewRetrieve" runat="server">
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox ">
                        <div class="ibox-title d-flex justify-content-center">
                            <h5 style="text-align: center;">Patient Registration</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                                <a class="close-link">
                                    <i class="fa fa-times"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <div class="form-group  row">
                                <div class="col-md-3">
                                    <label class="">ABUA/Scheme</label>
                                    <asp:DropDownList ID="dropScheme" runat="server" class="form-control">
                                        <asp:ListItem Text="ABUA-JHARKHAND" Value="1" Selected="True" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3">
                                    <label class="">ID Number</label>
                                    <asp:TextBox ID="tbIdNumber" runat="server" class="form-control" OnKeypress="return isAlphaNumeric(event);" ValidationGroup="a" required="True"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:Label ID="lbIdType" runat="server" AssociatedControlID="dropIdType" class="form-label">ID Type</asp:Label>
                                    <asp:DropDownList ID="dropIdType" runat="server" class="form-control">
                                        <%--<asp:ListItem Text="Select" Value="" />--%>
                                        <asp:ListItem Text="ABUA ID" Value="1" Selected="True" />
                                        <%--<asp:ListItem Text="ABHA No" Value="2" />--%>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3">
                                    <asp:Label ID="lbcheckif" runat="server" AssociatedControlID="tbIdNumber" class="form-label">Please Check if</asp:Label>
                                    <br />
                                    <asp:CheckBox ID="cbIsChild" runat="server" class="form-check-input ml-1" Text="&nbsp;&nbsp;Child Below 5 Year" />
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <p>
                                Note: *<b>ID Number could be Ayushman Card ID/Mobile No/ABUA No.</b><br />
                                To Register patient in Portability Mode, Please check <a href="#">here</a>
                                Portability Mode'P' may be used while registering the patient under:<br />
                                1. From other state beneficiary<br />
                                2. From Other Central sponsored scheme beneficiary.<br />
                                Please select "Child Below 5 years" option if ABUA ID is not available for the child.
                            </p>
                            <div class="col-md-12 text-center">
                                <%--<input type="submit" value="Retrieve" action="/ABUAReg/PatientRegistration" class="btn btn-warning btn-rounded" />--%>
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-warning btn-rounded" ValidationGroup="a" OnClick="btnSubmit_Click" />
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </asp:View>
        <asp:View ID="viewDetails" runat="server">
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox ">
                        <div class="ibox-title d-flex justify-content-center">
                            <h5>Patient Registration</h5>
                        </div>
                        <div class="ibox-content">
                            <div class="row">
                                <div class="col-lg-4">
                                    <div class="ibox">
                                        <div class="ibox-content">
                                            <div class="d-flex justify-content-around">
                                                <asp:Image ID="imgPatientPhoto" runat="server" class="img-fluid mb-3" Style="max-width: 150px;" />
                                            </div>
                                            <div class="form-group row m-b">
                                                <div class="col-lg-4">
                                                    <span style="font-weight: 700!important; color: #494141;">Abua Id:</span>
                                                </div>
                                                <div class="col-lg-8">
                                                    <asp:Label ID="lbAbuaId" runat="server" Text="" Style="padding-left: 5px;"></asp:Label>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="form-group row m-b">
                                                <div class="col-lg-4">
                                                    <span style="font-weight: 700!important; color: #494141;">Name:</span>
                                                </div>
                                                <div class="col-lg-8">
                                                    <asp:Label ID="lbName" runat="server" Text="" Style="padding-left: 5px;"></asp:Label>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="form-group row m-b">
                                                <div class="col-lg-4">
                                                    <span style="font-weight: 700!important; color: #494141;">Gender:</span>
                                                </div>
                                                <div class="col-lg-8">
                                                    <asp:Label ID="lbGender" runat="server" Text="" Style="padding-left: 5px;"></asp:Label>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="form-group row m-b">
                                                <div class="col-lg-4">
                                                    <span style="font-weight: 700!important; color: #494141;">Mobile No.:</span>
                                                </div>
                                                <div class="col-lg-8">
                                                    <asp:Label ID="lbMobileNo" runat="server" Text="" Style="padding-left: 5px;"></asp:Label>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="form-group row m-b">
                                                <div class="col-lg-4">
                                                    <span style="font-weight: 700!important; color: #494141;">YOB:</span>
                                                </div>
                                                <div class="col-lg-8">
                                                    <asp:Label ID="lbYOB" runat="server" Text="" Style="padding-left: 5px;"></asp:Label>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="form-group row m-b">
                                                <div class="col-lg-4">
                                                    <span style="font-weight: 700!important; color: #494141;">Age:</span>
                                                </div>
                                                <div class="col-lg-8">
                                                    <asp:Label ID="lbAge" runat="server" Text="" Style="padding-left: 5px;"></asp:Label>
                                                </div>
                                            </div>
                                            <hr />
                                            <h3 style="color: black;">ABUA Card Address:</h3>
                                            <hr />
                                            <div class="form-group row m-b">
                                                <div class="col-lg-4">
                                                    <span style="font-weight: 700!important; color: #494141;">Address:</span>
                                                </div>
                                                <div class="col-lg-8">
                                                    <asp:Label ID="lbAddress" runat="server" Text="" Style="padding-left: 5px;"></asp:Label>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="form-group row m-b">
                                                <div class="col-lg-4">
                                                    <span style="font-weight: 700!important; color: #494141;">State:</span>
                                                </div>
                                                <div class="col-lg-8">
                                                    <asp:Label ID="lbState" runat="server" Text="" Style="padding-left: 5px;"></asp:Label>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="form-group row m-b">
                                                <div class="col-lg-4">
                                                    <span style="font-weight: 700!important; color: #494141;">District:</span>
                                                </div>
                                                <div class="col-lg-8">
                                                    <asp:Label ID="lbDistrict" runat="server" Text="" Style="padding-left: 5px;"></asp:Label>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="form-group row m-b">
                                                <div class="col-lg-4">
                                                    <span style="font-weight: 700!important; color: #494141;">Pin Code:</span>
                                                </div>
                                                <div class="col-lg-8">
                                                    <asp:Label ID="lbPinCode" runat="server" Text="" Style="padding-left: 5px;"></asp:Label>
                                                </div>
                                            </div>
                                            <hr />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-8">
                                    <asp:Panel ID="childDetailPanel" runat="server" Visible="false">
                                        <div class="ibox">
                                            <div class="ibox-content">
                                                <span style="font-weight: 700!important; color: #494141; font-size: 18px;">Child Details:</span>
                                                <div class="form-row mt-3">
                                                    <div class="form-group col-md-4">
                                                        <span style="font-weight: 700!important; color: #494141;">Relation with Beneficiary<span class="text-danger">*</span>:</span>
                                                        <asp:DropDownList ID="dropBeneficiaryRelation" runat="server" class="form-control mt-1">
                                                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                            <asp:ListItem Value="1">Father</asp:ListItem>
                                                            <asp:ListItem Value="2">Mother</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <span style="font-weight: 700!important; color: #494141;">Date Of Birth<span class="text-danger">*</span>:</span>
                                                        <asp:TextBox ID="tbDob" runat="server" CssClass="form-control mt-1" ValidationGroup="b" required="true" TextMode="Date"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <span style="font-weight: 700!important; color: #494141;">Name Of Child<span class="text-danger">*</span>:</span>
                                                        <asp:TextBox ID="tbChildName" runat="server" CssClass="form-control mt-1" ValidationGroup="b" required="true"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-4">
                                                        <span style="font-weight: 700!important; color: #494141;">Gender Of Child<span class="text-danger">*</span>:</span>
                                                        <asp:DropDownList ID="dropChildGender" runat="server" class="form-control mt-1">
                                                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                            <asp:ListItem Value="1">Male</asp:ListItem>
                                                            <asp:ListItem Value="2">Female</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <span style="font-weight: 700!important; color: #494141;">Father Name<span class="text-danger">*</span>:</span>
                                                        <asp:TextBox ID="tbFatherName" runat="server" CssClass="form-control mt-1" ValidationGroup="b" required="true"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <span style="font-weight: 700!important; color: #494141;">Mother Name<span class="text-danger">*</span>:</span>
                                                        <asp:TextBox ID="tbMotherName" runat="server" CssClass="form-control mt-1" ValidationGroup="b" required="true"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-6">
                                                        <span style="font-weight: 700!important; color: #494141;">Child Photo<span class="text-danger">*</span>:</span><br />
                                                        <asp:FileUpload ID="fuChildPhoto" runat="server" CssClass="mt-1" />
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <span style="font-weight: 700!important; color: #494141;">BirthCertificate/Ration Card<span class="text-danger">*</span>:</span><br />
                                                        <asp:FileUpload ID="fuRationCard" runat="server" CssClass="mt-1" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                    <div class="ibox">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <div class="ibox-content">
                                                    <span style="font-weight: 700!important; color: #494141; font-size: 18px;">Communication Address:</span>
                                                    <div class="mt-3">
                                                        <asp:CheckBox ID="cbIfAddressSame" runat="server" Text="&nbsp;&nbsp;If card and communication address are same" AutoPostBack="True" OnCheckedChanged="cbIfAddressSame_CheckedChanged" />
                                                        <hr />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 700!important; color: #494141;">Address<span class="text-danger">*</span>:</span>
                                                            </div>
                                                            <div class="col-lg-9">
                                                                <asp:TextBox ID="tbCommAddress" runat="server" CssClass="form-control" ValidationGroup="b" required="true" OnKeypress="return isAlphaNumeric(event);"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 700!important; color: #494141;">State<span class="text-danger">*</span>:</span>
                                                            </div>
                                                            <div class="col-lg-9">
                                                                <asp:DropDownList ID="dropState" runat="server" class="form-control" AutoPostBack="True" ControlToValidate="dropState" OnSelectedIndexChanged="dropState_SelectedIndexChanged"></asp:DropDownList>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Select State" ValidationGroup="b" ControlToValidate="dropState" ForeColor="Red" InitialValue="0" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 700!important; color: #494141;">District<span class="text-danger">*</span>:</span>
                                                            </div>
                                                            <div class="col-lg-9">
                                                                <asp:DropDownList ID="dropDistrict" runat="server" class="form-control" AutoPostBack="True" ValidationGroup="b" OnSelectedIndexChanged="dropDistrict_SelectedIndexChanged"></asp:DropDownList>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Select District" ValidationGroup="b" ControlToValidate="dropDistrict" ForeColor="Red" InitialValue="0" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 700!important; color: #494141;">Block/ULB:</span>
                                                            </div>
                                                            <div class="col-lg-9">
                                                                <asp:DropDownList ID="dropBlock" runat="server" class="form-control" AutoPostBack="True" ValidationGroup="b" OnSelectedIndexChanged="dropBlock_SelectedIndexChanged"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 700!important; color: #494141;">City/Town:</span>
                                                            </div>
                                                            <div class="col-lg-9">
                                                                <asp:DropDownList ID="dropVillage" runat="server" class="form-control" ValidationGroup="b"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 700!important; color: #494141;">Pin Code<span class="text-danger">*</span>:</span>
                                                            </div>
                                                            <div class="col-lg-9">
                                                                <asp:TextBox ID="tbPinCode" runat="server" CssClass="form-control" ValidationGroup="b" required="true" MaxLength="6" OnKeypress="return isNumeric(event);"></asp:TextBox>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="* Invalid Pin Code!" ControlToValidate="tbPinCode" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^[1-9][0-9]{5}$" ValidationGroup="b"></asp:RegularExpressionValidator>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 700!important; color: #494141;">Mobile Number Belongs To<span class="text-danger">*</span>:</span>
                                                            </div>
                                                            <div class="form-group col-lg-9">
                                                                <asp:DropDownList ID="dropMobileBelongsTo" runat="server" class="form-control" AutoPostBack="True" OnSelectedIndexChanged="dropMobileBelongsTo_SelectedIndexChanged">
                                                                    <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                                                    <asp:ListItem Value="1">Self</asp:ListItem>
                                                                    <asp:ListItem Value="2">Family</asp:ListItem>
                                                                    <asp:ListItem Value="3">Attendant</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*Select Mobile Belongs To" ValidationGroup="b" ControlToValidate="dropMobileBelongsTo" ForeColor="Red" InitialValue="0" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                        </div>
                                                        <br />
                                                        <div id="divMobileBelongsTo" runat="server" class="form-group row m-b" visible="false">
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 700!important; color: #494141;">Relation<span class="text-danger">*</span>:</span>
                                                            </div>
                                                            <div class="col-lg-9">
                                                                <asp:DropDownList ID="dropRelation" runat="server" class="form-control">
                                                                    <asp:ListItem Value="0">--SELCT--</asp:ListItem>
                                                                    <asp:ListItem Value="1">Daughter</asp:ListItem>
                                                                    <asp:ListItem Value="2">Father</asp:ListItem>
                                                                    <asp:ListItem Value="3">Father In Law</asp:ListItem>
                                                                    <asp:ListItem Value="4">Husband</asp:ListItem>
                                                                    <asp:ListItem Value="5">Mother</asp:ListItem>
                                                                    <asp:ListItem Value="6">Mother In Law</asp:ListItem>
                                                                    <asp:ListItem Value="7">New Born Baby</asp:ListItem>
                                                                    <asp:ListItem Value="8">Son</asp:ListItem>
                                                                    <asp:ListItem Value="9">Wife</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="form-group row m-b">
                                                            <div class="col-lg-3">
                                                                <span style="font-weight: 700!important; color: #494141;">Mobile Number<span class="text-danger">*</span>:</span>
                                                            </div>
                                                            <div class="col-lg-9">
                                                                <asp:TextBox ID="tbCommMobileNo" runat="server" CssClass="form-control" ValidationGroup="b" required="true" MaxLength="10" OnKeypress="return isNumeric(event);"></asp:TextBox>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*Invalid Mobile No!" ControlToValidate="tbCommMobileNo" ForeColor="Red" ValidationExpression="^[6-9]\d{9}$" ValidationGroup="b"></asp:RegularExpressionValidator>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="ibox-content mt-4">
                                                    <span style="font-weight: 700!important; color: #494141; font-size: 18px;">Registration Details:</span>
                                                    <div class="form-row mt-3">
                                                        <div class="form-group col-md-6">
                                                            <span style="font-weight: 700!important; color: #494141;">Registration Date<span class="text-danger">*</span>:</span>
                                                            <asp:TextBox ID="tbRegDate" runat="server" CssClass="form-control mt-1" ValidationGroup="b" required="true" TextMode="Date" OnKeypress="return isDate(event);"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <span style="font-weight: 700!important; color: #494141;">Abua Mitra Id<span class="text-danger">*</span>:</span>
                                                            <asp:TextBox ID="tbMitraId" runat="server" CssClass="form-control mt-1" ValidationGroup="b" required="true" ReadOnly="True"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div>
                                    <h5 class="text-danger">All fields marked with * are mandatory</h5>
                                    <div class="form-check text-dark">
                                        <asp:CheckBox ID="cbConcentHealthCard" runat="server" CssClass="form-check-input" Checked="True" Enabled="False" ValidationGroup="b" />
                                        <asp:Label ID="Label1" runat="server" CssClass="form-check-label" Text="I consent to generate Health ID and link my health records with Health ID" />
                                    </div>
                                    <div class="form-check text-dark">
                                        <asp:CheckBox ID="cbMobileNumber" runat="server" CssClass="form-check-input" ValidationGroup="b" />
                                        <asp:Label ID="lblMobileNumberOwnership" runat="server" CssClass="form-check-label" Text="This mobile number is owned by beneficiary/beneficiary family and not by PMAM." />
                                    </div>
                                    <div class="form-check text-dark">
                                        <asp:CheckBox ID="cbSharePersonalData" runat="server" CssClass="form-check-input" ValidationGroup="b" />
                                        <asp:Label ID="lblSharePII" runat="server" CssClass="form-check-label" Text="I consent to share my Personally Identifiable Information (PII) including health data with National Health Authority (NHA) in order to avail services under Mukhyamantri ABUA Swastha Surakhsha Yojna (MMASSY). I understand that my Personally Identifiable information (PII) including health data will be securely stored with NHA on permanent relation period. I have been duly informed that my information as stated above will be shared with NHA empaneled hospitals, Insurance Agencies (ISAs) and State Health Agencies (SHA) for MMASSY operations. I agree to receive feedback/survey calls & SMS on the number shared, made by third party on behalf of NHA." />
                                    </div>
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <div class="col-md-12 text-center">
                                                <asp:Button ID="btnVerifyRegister" runat="server" ValidationGroup="b" CssClass="btn btn-primary" Text="Verify and Register" OnClick="btnVerifyRegister_Click" />
                                                <i class="fa-solid fa-file-medical"></i>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <div class="form-check text-dark mt-5">
                                        <asp:Label ID="lblNote" runat="server" CssClass="text-danger" Text="Note :" />
                                        <asp:Label ID="lblNoteDetail" runat="server" Text="Registering this patient means that you have taken the patient consent as per NHA data Privacy Policy and Aadhar Act incase of Biometric Verification of the patient. Click here to download." />
                                        <asp:HyperLink ID="hlPrivacyPolicy" runat="server" NavigateUrl="URL_TO_PRIVACY_POLICY" Text="Data Privacy Policy" Target="_blank" />
                                    </div>
                                    <div class="modal fade" id="modal2" tabindex="-1" role="dialog" aria-labelledby="modal2Label" aria-hidden="true">
                                        <div class="modal-dialog modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="ibox-title modal-header round">
                                                    <h5>Authentication Modes</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                        <ContentTemplate>
                                                            <div class="ibox">
                                                                <div class="ibox-content">
                                                                    <asp:MultiView ID="MultiView2" runat="server">
                                                                        <asp:View ID="View1" runat="server">
                                                                            <asp:Label ID="lbAuthModes" runat="server" CssClass="text-dark" Text="Please select any one of the below Authentication Modes." />
                                                                            <div class="col-md-12 mt-3 d-flex align-items-center">
                                                                                <div class="form-group col-lg-8 mb-0 d-flex align-items-center ml-2">
                                                                                    <div class="form-check form-check-inline">
                                                                                        <asp:RadioButton ID="rbFaceAuth" runat="server" CssClass="form-check-input" GroupName="authMode" Value="Face" />
                                                                                        <asp:Label ID="lblFaceAuth" runat="server" CssClass="form-check-label font-weight-bold mb-0" Text="Face Authentication" AssociatedControlID="rbFaceAuth" />
                                                                                    </div>
                                                                                    <div class="form-check form-check-inline">
                                                                                        <asp:RadioButton ID="rbFingerprintAuth" runat="server" CssClass="form-check-input" GroupName="authMode" Value="Fingerprint" />
                                                                                        <asp:Label ID="lblFingerprintAuth" runat="server" CssClass="form-check-label font-weight-bold mb-0" Text="Fingerprint Authentication" AssociatedControlID="rbFingerprintAuth" />
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <br />
                                                                            <div class="row">
                                                                                <div class="col-md-12 text-center">
                                                                                    <asp:Button ID="btnRegister" class="btn btn-primary" runat="server" Text="Register" OnClick="btnRegister_Click" />
                                                                                </div>
                                                                            </div>
                                                                        </asp:View>
                                                                        <asp:View ID="View2" runat="server">
                                                                            Rv
                                                                        </asp:View>
                                                                        <asp:View ID="View3" runat="server">
                                                                            Registered Successfully!
                                                                        </asp:View>
                                                                    </asp:MultiView>
                                                                </div>
                                                            </div>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:PostBackTrigger ControlID="btnRegister" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </div>
                                                <div class="modal-footer">
                                                    <asp:Button ID="btnHide" runat="server" Text="Close" class="btn btn-secondary" OnClick="btnHideModal_Click" />
                                                    <%--<button type="button" class="btn btn-secondary" OnClick="btnShowModal_Click">Close</button>--%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </asp:View>
    </asp:MultiView>
    <asp:HiddenField ID="hdAbuaId" runat="server" Visible="false" />
    <asp:HiddenField ID="hdFamilyId" runat="server" Visible="false" />
    <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
    <asp:HiddenField ID="hdUserName" runat="server" Visible="false" />
    <asp:HiddenField ID="hdHospitalId" runat="server" Visible="false" />
</asp:Content>
