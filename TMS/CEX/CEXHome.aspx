<%@ Page Title="" Language="C#" MasterPageFile="~/CEX/CEX.master" AutoEventWireup="true" CodeFile="CEXHome.aspx.cs" Inherits="CEX_CEXHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <div class="ibox-title text-center">
                <h3 class="text-white">Dashboard</h3>
            </div>
            <div class="ibox-content">
                <%--<div class="ibox-content text-dark">
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
                </div>--%>
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="ViewForInsurer" runat="server">
                        <div class="ibox mt-4">
                            <div class="ibox-title text-center">
                                <h3 class="text-white">Pendency at Insurer</h3>
                            </div>
                            <div class="ibox-content table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr class="table-primary">
                                            <th scope="col" style="background-color: #007e72; color: white;">Details</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Today</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Overall</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td style="font-weight:bold">Claim Executive Insurer</td>
                                            <td>
                                                <asp:Label ID="lbTodayPendency" runat="server" Text="0"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lbOverallPendency" runat="server" Text="0"></asp:Label>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </asp:View>
                    <asp:View ID="ViewForTrust" runat="server">
                        <div class="ibox mt-4">
                            <div class="ibox-title text-center">
                                <h3 class="text-white">Pendency at Trust</h3>
                            </div>
                            <div class="ibox-content table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr class="table-primary">
                                            <th scope="col" style="background-color: #007e72; color: white;">Details</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Today</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Overall</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td style="font-weight:bold">Claim Executive Trust</td>
                                            <td>
                                                <asp:Label ID="lbTrustToday" runat="server" Text="0"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lbTrustOverall" runat="server" Text="0"></asp:Label>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </asp:View>
                </asp:MultiView>
            </div>

        </div>
    </div>
    <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
    <asp:HiddenField ID="hdRoleId" runat="server" Visible="false" />
</asp:Content>

