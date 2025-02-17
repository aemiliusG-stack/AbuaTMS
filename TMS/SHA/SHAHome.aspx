<%@ Page Title="" Language="C#" MasterPageFile="~/SHA/SHA.master" AutoEventWireup="true" CodeFile="SHAHome.aspx.cs" Inherits="SHA_SHAHome" %>

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
                        <h3 class="text-white">Dashboard</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="row align-items-end">
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Scheme</span>
                                <asp:DropDownList ID="dlScheme" runat="server" class="form-control mt-2">
                                    <asp:ListItem Text="ABUA-JHARKHAND" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Policy Period</span>
                                <asp:DropDownList ID="dlPolicyPeriod" runat="server" class="form-control mt-2">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-3 mb-3">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn btn-success rounded-pill" />
                            </div>
                        </div>
                    </div>

                    <div class="ibox mt-4">
                        <div class="ibox-title text-center">
                            <h3 class="text-white">
                                <asp:Label ID="lbTitle" runat="server" Text=""></asp:Label>
                            </h3>
                        </div>
                        <div class="ibox-content table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr class="table-primary text-center">
                                        <th scope="col" style="background-color: #007e72; color: white;">Sl.No</th>
                                        <th scope="col" style="background-color: #007e72; color: white;"></th>
                                        <th scope="col" style="background-color: #007e72; color: white;">Today</th>
                                        <th scope="col" style="background-color: #007e72; color: white;">Overall</th>
                                    </tr>
                                </thead>
                                <tbody class="text-center">
                                    <tr>
                                        <td>1</td>
                                        <td>
                                            <asp:Label ID="lbUserRole" runat="server" Text="Preauth Panel Doctor"></asp:Label>
                                        </td>
                                        <td>
                                            <h4>
                                                <asp:Label ID="lbUserTodayCount" runat="server" Text="0"></asp:Label>
                                            </h4>
                                        </td>
                                        <td>
                                            <h4>
                                                <asp:Label ID="lbUserOverallCount" runat="server" Text="0"></asp:Label>
                                            </h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>
                                            <asp:Label ID="lbUserRoleAssigned" runat="server" Text="Preauth Panel Doctor (Assigned)"></asp:Label>
                                        </td>
                                        <td>
                                            <h4>
                                                <asp:Label ID="lbAssignedToday" runat="server" Text="0"></asp:Label>
                                            </h4>
                                        </td>
                                        <td>
                                            <h4>
                                                <asp:Label ID="lbAssignedOverall" runat="server" Text="0"></asp:Label>
                                            </h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>
                                            <asp:Label ID="lbUnspecifiedCase" runat="server" Text="Unspecified Case"></asp:Label>
                                        </td>
                                        <td>
                                            <h4>
                                                <asp:Label ID="lbUnspecifiedToday" runat="server" Text="0"></asp:Label>
                                            </h4>
                                        </td>
                                        <td>
                                            <h4>
                                                <asp:Label ID="lbUnspecifiedOverall" runat="server" Text="0"></asp:Label>
                                            </h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td>
                                            <asp:Label ID="lbPreauthCount" runat="server" Text="Preauth Count"></asp:Label>
                                        </td>
                                        <td>
                                            <h4>
                                                <asp:Label ID="lbPreauthToday" runat="server" Text="0"></asp:Label>
                                            </h4>
                                        </td>
                                        <td>
                                            <h4>
                                                <asp:Label ID="lbPreauthOverall" runat="server" Text="0"></asp:Label>
                                            </h4>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </contenttemplate>
    </asp:UpdatePanel>
</asp:Content>

