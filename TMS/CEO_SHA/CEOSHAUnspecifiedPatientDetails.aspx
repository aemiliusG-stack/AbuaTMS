<%@ Page Title="" Language="C#" MasterPageFile="~/CEO_SHA/SHA_CEO.master" AutoEventWireup="true" CodeFile="CEOSHAUnspecifiedPatientDetails.aspx.cs" Inherits="CEO_SHA_CEOSHAUnspecifiedPatientDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
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
                                            <span class="font-weight-bold">Beneficiary Card Number:</span><br>
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
                                            <span class="font-weight-bold">Contact No:</span><br>
                                            <asp:Label ID="lbContact" runat="server"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mt-3">
                                            <span class="font-weight-bold">Communication Contact No:</span><br>
                                            <asp:Label ID="lbComContactNo" runat="server"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mt-3">
                                            <span class="font-weight-bold">Patient Address:</span><br>
                                            <asp:Label ID="lbPatientAddress" runat="server"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mt-3">
                                            <span class="font-weight-bold">Communication Address:</span><br>
                                            <asp:Label ID="lbCommunicationAddress" runat="server"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mt-3">
                                            <span class="font-weight-bold">Hospital Name:</span><br>
                                            <asp:Label ID="lbHospitalName" runat="server" Text="N/A"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mt-3">
                                            <span class="font-weight-bold">Hospital Address:</span><br>
                                            <asp:Label ID="lbHospitalAddress" runat="server" Text="N/A"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mt-3">
                                            <span class="font-weight-bold">Hospital Type:</span><br>
                                            <asp:Label ID="lbHospitalType" runat="server" Text="N/A"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mt-3">
                                            <span class="font-weight-bold">Family ID:</span><br>
                                            <asp:Label ID="lbFamilyID" runat="server"></asp:Label>
                                        </div>
                                        <div class="col-md-3 mt-3">
                                            <span class="font-weight-bold">Gender:</span><br>
                                            <asp:Label ID="lbGender" runat="server"></asp:Label>
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
                                            <span class="font-weight-bold">Member Type:</span><br>
                                            <asp:Label ID="Label1" runat="server"></asp:Label>
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
                                    <div class="col-lg-12 text-center">
                                        <asp:Button ID="btnSECC" runat="server" Text="SECC Details" class="btn btn-primary rounded-pill font-bold" OnClick="btnSECC_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="ibox-content">
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
                                        <asp:BoundField DataField="SpecialityName" HeaderText="Category Name" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                        <asp:BoundField DataField="ProcedureName" HeaderText="Procedure Name" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                        <asp:BoundField DataField="TreatingDoctor" HeaderText="Treating Doctor" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                        <asp:BoundField DataField="ProcedureAmountFinal" HeaderText="Amount(Rs)" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                        <asp:BoundField DataField="StratificationName" HeaderText="Stratification" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                    </Columns>
                                </asp:GridView>
                            </div>
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
                        </div>
                        <%--WorkFlow--%>
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
                                        <asp:BoundField DataField="Role" HeaderText="Role Name" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                        <asp:BoundField DataField="Action" HeaderText="Action" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                        <asp:BoundField DataField="Amount" HeaderText="Amount(Rs)" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                        <asp:BoundField DataField="Preauth Querry Rejection" HeaderText="Preauth Querry Rejection" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                        <div class="form-group row col-md-12 mb-3">
                            <label for="tbRemark" class="col-md-5 col-form-label font-weight-bold text-dark">
                                Remarks:<span class="text-danger font-bold">*</span>
                            </label>
                            <div class="col-md-7">
                                <asp:TextBox ID="tbRemark" CssClass="form-control border-0 border-bottom" TextMode="MultiLine" OnKeypress="return isAlphaNumeric(event);" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row col-md-12 mb-3">
                            <label for="tbAmount" class="col-md-5 col-form-label font-weight-bold text-dark">
                                Amount:<span class="text-danger font-bold">*</span>
                            </label>
                            <div class="col-md-7">
                                <asp:TextBox ID="tbAmount" CssClass="form-control border-0 border-bottom" OnKeypress="return isNumeric(event);" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-3 mt-4">
                            <div class="form-group">
                                <asp:Label ID="ibActionType" runat="server" CssClass="form-label font-weight-bold text-dark" Text="Action Type"></asp:Label>
                                <asp:DropDownList ID="dropActionType" runat="server" CssClass="form-control" AutoPostBack="true">
                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                    <asp:ListItem Value="1">Query To Medco</asp:ListItem>
                                    <asp:ListItem Value="2">Approve</asp:ListItem>
                                    <asp:ListItem Value="3">Reject</asp:ListItem>
                                    <asp:ListItem Value="4">Query to Medical Committee SHA</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-lg-12 text-center mb-3">
                            <asp:Button ID="btnSubmitCEOSHAUnspecifiedDetails" runat="server" CssClass="btn btn-success rounded-pill" Text="Submit" />
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


