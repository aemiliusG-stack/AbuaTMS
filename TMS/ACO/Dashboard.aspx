<%@ Page Title="" Language="C#" MasterPageFile="~/ACO/ACO.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="ACO_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <style>
        .btn-search-icon::before {
            font-family: 'Font Awesome 5 Free';
            content: '\f002'; /* Unicode for search icon */
            margin-right: 5px;
            font-weight: 900;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
    <asp:HiddenField ID="hdRoleId" runat="server" Visible="false" />
    <div class="row">
        <div class="col-lg-12">
            <div class="ibox">
                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                    <h4 class="m-0">Dashboard</h4>
                </div>
                <div class="ibox-content p-4 bg-light">
                    <div class="row mb-3">
                        <!-- Scheme -->
                        <div class="col-md-5">
                            <label class="form-label fw-bold">Scheme <span style="color: red;">*</span></label>
                            <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control">
                                <asp:ListItem Text="MSBY(P)" Value="MSBY(P)"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Policy Period -->
                        <div class="col-md-5">
                            <label class="form-label fw-bold">Policy Period<span style="color: red;">*</span></label>
                            <asp:DropDownList ID="ddPolicyPeriod" runat="server" CssClass="form-control">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Search and Reset Buttons -->
                        <div class="row mt-3">
                            <div class="col-md-12 text-center" style="margin-top: 10px;">
                                <%--<asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success rounded-pill" Text="Search" />--%>
                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success rounded-pill">
                                        <i class="fas fa-search"></i> Search
                                </asp:LinkButton>
                                <%--<asp:Button ID="Button1" runat="server" CssClass="btn btn-success rounded-pill" Text="Search" OnClick="btnSearch_Click" />--%>
                            </div>
                        </div>
                    </div>
                    <!-- Error Message -->
                    <div class="row mt-3">
                        <div class="col-md-12 text-center">
                            <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="False"></asp:Label>
                        </div>
                    </div>
                    <!-- Information Message -->
                    <div class="row mt-3">
                        <div class="col-md-12 text-center">
                            <span>Please use any search criteria along with Scheme to fetch data.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="ibox mt-4">
        <div class="ibox-title text-center">
            <h3 class="text-white">
                <asp:Label ID="lbTitle" runat="server" Text="Pendency Dashboard"></asp:Label>
            </h3>
        </div>
        <div class="ibox-content table-responsive">
            <table class="table table-bordered table-striped">
                <thead>
                    <tr class="table-primary text-center">
                        <%--<th scope="col" style="background-color: #007e72; color: white;">S.No</th>--%>
                        <th scope="col" style="background-color: #007e72; color: white;">Role</th>
                        <th scope="col" style="background-color: #007e72; color: white;">Today</th>
                        <th scope="col" style="background-color: #007e72; color: white;">Overall</th>
                    </tr>
                </thead>
                <tbody class="text-center">
                    <!-- Preauth Panel Doctor Insurer -->
                    <tr>
                        <td>
                            <asp:Label ID="lbPreauthPanelDoctorInsurer" runat="server" Text="Preauth Panel Doctor Insurer"></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbPreauthPanelDoctorInsurerToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbPreauthPanelDoctorInsurerOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                    <!-- Preauth Panel Doctor trust -->
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Preauth Panel Doctor Trust"></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbPreauthPanelDoctorTrustToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbPreauthPanelDoctorTrustOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                    <!-- Preauth Panel Doctor Insurer (Assigned) -->
                    <tr>
                        <td>
                            <asp:Label ID="lbPreauthPanelDoctorInsurerAssigned" runat="server" Text="Preauth Panel Doctor Insurer (Assigned)"></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbPreauthPanelDoctorInsurerAssignedToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbPreauthPanelDoctorInsurerAssignedOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                    <!-- Preauth Panel Doctor Trust(Assigned) -->
                    <tr>
                        <td>
                            <asp:Label ID="lbPreauthPanelDoctorTrust" runat="server" Text="Preauth Panel Doctor Trust (Assigned)"></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbPreauthPanelDoctorTrustAssignedToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbPreauthPanelDoctorTrustAssignedOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                    <!-- Claim Executive Officer Insurer -->
                    <tr>
                        <td>
                            <asp:Label ID="lbClaimExecutiveInsurer" runat="server" Text="Claim Executive Officer Insurer"></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbClaimExecutiveInsurerToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbClaimExecutiveInsurerOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                    <!-- Claim Executive Officer TRUST -->
                    <tr>
                        <td>
                            <asp:Label ID="lbClaimExecutiveTrust" runat="server" Text="Claim Executive Officer Trust"></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbClaimExecutiveTrustToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbClaimExecutiveTrustOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                    <!-- Claim Panel Doctor Insurer -->
                    <tr>
                        <td>
                            <asp:Label ID="lbClaimPanelDoctorInsurer" runat="server" Text="Claim Panel Doctor Insurer"></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbClaimPanelDoctorInsurerToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbClaimPanelDoctorInsurerOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                    <!-- Claim Panel Doctor Insurer (Assigned) -->
                    <tr>
                        <td>
                            <asp:Label ID="lbClaimPanelDoctorInsurerAssigned" runat="server" Text="Claim Panel Doctor Insurer (Assigned)"></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbClaimPanelDoctorInsurerAssignedToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbClaimPanelDoctorInsurerAssignedOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                    <!-- Claim Panel Doctor Trust (Assigned)-->
                    <tr>
                        <td>
                            <asp:Label ID="lbClaimPanelDoctorTrustAssigned" runat="server" Text="Claim Panel Doctor Trust(Assigned) "></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbClaimPanelDoctorTrustAssignedToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbClaimPanelDoctorTrustAssignedOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                    <!-- Claim Panel Doctor Trust -->
                    <tr>
                        <td>
                            <asp:Label ID="lbClaimPanelDoctorTrust" runat="server" Text="Claim Panel Doctor Trust "></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbClaimPanelDoctorTrustToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbClaimPanelDoctorTrustOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                    <!-- Account Claim Officer Insurer -->
                    <tr>
                        <td>
                            <asp:Label ID="lbACOInsurer" runat="server" Text="Account Claim Officer Insurer"></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbACOInsurerToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbACOInsurerOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                    <!-- Account Claim Officer Trsut -->
                    <tr>
                        <td>
                            <asp:Label ID="lbACOTrust" runat="server" Text="Account Claim Officer Trust"></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbACOTrustAssignedToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbACOTrustAssignedOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                    <!-- SHA Insurer -->
                    <tr>
                        <td>
                            <asp:Label ID="lbSHAInsurer" runat="server" Text="SHA Insurer"></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbSHAInsurerToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbSHAInsurerOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                    <!-- SHA Trsut -->
                    <tr>
                        <td>
                            <asp:Label ID="lbSHATrust" runat="server" Text="SHA Trust"></asp:Label></td>
                        <td>
                            <h4>
                                <asp:Label ID="lbSHATrustAssignedToday" runat="server" Text="0"></asp:Label></h4>
                        </td>
                        <td>
                            <h4>
                                <asp:Label ID="lbSHATrustAssignedOverall" runat="server" Text="0"></asp:Label></h4>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</asp:Content>

