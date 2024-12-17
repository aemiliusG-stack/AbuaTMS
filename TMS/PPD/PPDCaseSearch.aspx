<%@ Page Title="" Language="C#" MasterPageFile="~/PPD/PPD.master" AutoEventWireup="true" CodeFile="PPDCaseSearch.aspx.cs" Inherits="PPD_PPDCaseSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server">
        <contenttemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Case Search</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="ibox">
                            <div class="row">
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Case Number</span>
                                    <asp:TextBox runat="server" ID="tbCaseNo" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Beneficiary Card Number</span>
                                    <asp:TextBox runat="server" ID="tbBeneficiaryCardNumber" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Patient State<span class="text-danger">*</span></span><br />
                                    <asp:DropDownList ID="dlPatientState" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Patient District</span><br />
                                    <asp:DropDownList ID="dlPatientDistrict" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Case Type<span class="text-danger">*</span></span><br />
                                    <asp:DropDownList ID="dlCaseType" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Scheme<span class="text-danger">*</span></span><br />
                                    <asp:DropDownList ID="dlScheme" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Hospital State<span class="text-danger">*</span></span><br />
                                    <asp:DropDownList ID="dlHospitalState" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Hospital Name<span class="text-danger">*</span></span><br />
                                    <asp:DropDownList ID="dlHospitalName" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Category<span class="text-danger">*</span></span><br />
                                    <asp:DropDownList ID="dlCategory" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Procedure Name<span class="text-danger">*</span></span><br />
                                    <asp:DropDownList ID="dlProcedureName" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Case Status<span class="text-danger">*</span></span><br />
                                    <asp:DropDownList ID="dlCaseStatus" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Policy Period<span class="text-danger">*</span></span><br />
                                    <asp:DropDownList ID="dlPolicyPeriod" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">UTR<span class="text-danger">*</span></span>
                                    <asp:TextBox ID="tbUtr" runat="server" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Hospital District<span class="text-danger">*</span></span><br />
                                    <asp:DropDownList ID="dlHospitalDistrict" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Record Period<span class="text-danger">*</span></span><br />
                                    <asp:DropDownList ID="dlRecordPeriod" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Special Case<span class="text-danger">*</span></span><br />
                                    <asp:DropDownList ID="dlSpecialCase" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">Advance Search Parameter<span class="text-danger">*</span></span><br />
                                    <asp:DropDownList ID="dlAdvanceSearchParameter" runat="server" class="form-control mt-2">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">From Date<span class="text-danger">*</span></span>
                                    <asp:TextBox ID="tbFromDate" runat="server" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <span class="form-label fw-semibold" style="font-size: 14px;">To Date<span class="text-danger">*</span></span>
                                    <asp:TextBox ID="tbToDate" runat="server" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mt-3">
                                    <span class="text-danger fw-bold">Note:<span class="fw-normal"> Report will be generated for maximum of 90 days.</span></span>
                                </div>
                                <div class="col-lg-12 text-center mt-2">
                                    <asp:Button ID="btnSearch" runat="server" class="btn btn-success rounded-pill" Text="Search" />
                                    <asp:Button ID="btnReset" runat="server" class="btn btn-warning rounded-pill" Text="Reset" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card mt-4">
                        <div class="card-body">
                            <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
                            <div class="table-responsive mt-2">
                                <asp:GridView ID="gridCaseSearch" runat="server" AllowPaging="True" OnPageIndexChanging="gridCaseSearch_PageIndexChanging" OnRowDataBound="gridCaseSearch_RowDataBound" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
                                    <alternatingrowstyle backcolor="Gainsboro" />
                                    <columns>
                                        <asp:TemplateField HeaderText="Sl. No.">
                                            <itemtemplate>
                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Case Number">
                                            <itemtemplate>
                                                <asp:Label ID="lbAdmissionId" runat="server" Text='<%# Eval("AdmissionId") %>' Visible="false"></asp:Label>
                                                <asp:Label ID="lbClaimId" runat="server" Text='<%# Eval("ClaimId") %>' Visible="false"></asp:Label>
                                                <asp:LinkButton ID="lnkCaseNo" runat="server" OnClick="lnkCaseNo_Click" Text='<%# Eval("CaseNumber") %>'></asp:LinkButton>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="18%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Claim Number">
                                            <itemtemplate>
                                                <asp:Label ID="lbClaimNumber" runat="server" Text='<%# Eval("ClaimNumber") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="18%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Patient Name">
                                            <itemtemplate>
                                                <asp:Label ID="lbPatientName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Contact Number">
                                            <itemtemplate>
                                                <asp:Label ID="lbContactNumber" runat="server" Text='<%# Eval("MobileNumber") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="9%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Beneficiary Card Number">
                                            <itemtemplate>
                                                <asp:Label ID="lbCardNumber" runat="server" Text='<%# Eval("CardNumber") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Hospital Name">
                                            <itemtemplate>
                                                <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Patient Registration Date">
                                            <itemtemplate>
                                                <asp:Label ID="lbRegistrationDate" runat="server" Text='<%# Eval("RegDate") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Patient DischargeDate Date">
                                            <itemtemplate>
                                                <asp:Label ID="lbDischargeDate" runat="server" Text='<%# Eval("DischargeDate") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                        </asp:TemplateField>
                                    </columns>
                                </asp:GridView>
                                <asp:Panel ID="panelNoData" runat="server" Visible="false">
                                    <div class="row ibox-content" style="background-color: #f0f0f0;">
                                        <div class="col-md-12 d-flex flex-column justify-content-center align-items-center" style="height: 200px;">
                                            <img src="../images/search.svg" />
                                            <span class="fs-6 mt-2">No Record Found</span>
                                            <span class="text-body-tertiary">Currently, no cases available at this moment.</span>
                                        </div>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </contenttemplate>
    </asp:UpdatePanel>
</asp:Content>
