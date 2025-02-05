<%@ Page Title="" Language="C#" MasterPageFile="~/CEO_SHA/SHA_CEO.master" AutoEventWireup="true" CodeFile="CEOSHAUnspecifiedPatientDetails.aspx.cs" Inherits="CEO_SHA_CEOSHAUnspecifiedPatientDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdRoleId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdAbuaId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPatientRegId" runat="server" Visible="false" />
            <asp:HiddenField ID="hfClaimId" runat="server" Visible="false" />
            <asp:HiddenField ID="hfCaseNumber" runat="server" Visible="false" />
            <asp:HiddenField ID="hfHospitalId" runat="server" Visible="false" />
            <asp:HiddenField ID="hfPackageId" runat="server" Visible="false" />
            <asp:HiddenField ID="hfPDId" runat="server" Visible="false" />
            <asp:HiddenField ID="hfAdmissionId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdHospitalId" runat="server" Visible="false" />
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
                                            <asp:Label ID="lbBeneficiaryId" runat="server"></asp:Label>
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
                                            <asp:Label ID="lbCaseStatus" runat="server" Text="N/A"></asp:Label>
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
                                            <asp:Label ID="lbFamilyId" runat="server"></asp:Label>
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
                                <asp:GridView ID="gvTreatmentProtocol" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                    <AlternatingRowStyle BackColor="Gainsboro" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Category">
                                            <ItemTemplate>
                                                <asp:Label ID="lbSpeciality" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Font-Size="12px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Procedure Name">
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
                                        <asp:TemplateField HeaderText="Implant">
                                            <ItemTemplate>
                                                <asp:Label ID="lbImplants" runat="server" Text='<%# Eval("ImplantName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" Font-Size="12px" />
                                        </asp:TemplateField>

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
                                        <asp:Label ID="lbPackageCost" runat="server" CssClass="form-label" Text="64748" />
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
                                        <asp:Label ID="lbIncentiveAmount" runat="server" CssClass="form-label" Text="2750" />
                                        <hr />
                                    </div>
                                    <div class="col-md-4 mb-3">
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <span class="font-weight-bold text-dark">Total Package Cost</span>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <asp:Label ID="lbTotalPackageCost" runat="server" CssClass="form-label" Text="64748" />
                                        <hr />
                                    </div>
                                    <div class="col-md-4 mb-3">
                                    </div>
                                    <asp:Panel ID="PanelTotLiableInsurance" Visible="false" runat="server" CssClass="form-group col-md-4 mb-3">
                                        <span class="font-weight-bold text-dark">Total Amount Liable by Insurance is:</span>

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


