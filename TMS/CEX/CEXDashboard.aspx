<%@ Page Title="" Language="C#" MasterPageFile="~/CEX/CEX.master" AutoEventWireup="true" CodeFile="CEXDashboard.aspx.cs" Inherits="CEX_CEXDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdRoleId" runat="server" Visible="false" />
            <asp:MultiView ID="MultiView1" runat="server">
                <asp:View ID="ViewForInsurer" runat="server">
                    <div class="row">
                        <div class="col-md-5 mb-3">
                            <div class="form-group">
                                <asp:Label ID="idScheme" runat="server" CssClass="form-label font-weight-bold text-dark" Text="Scheme"></asp:Label>
                                <asp:DropDownList ID="dropScheme" runat="server" CssClass="form-control" AutoPostBack="true">
                                    <asp:ListItem>--Select--</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-5 mb-3">
                            <div class="form-group">
                                <asp:Label ID="idPolicyPeriod" runat="server" CssClass="form-label font-weight-bold text-dark" Text="Policy Period"></asp:Label>
                                <asp:DropDownList ID="dropPolicyPeriod" runat="server" CssClass="form-control" AutoPostBack="true">
                                    <asp:ListItem>--Select--</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2 text-center mt-3">
                            <asp:Button runat="server" CssClass="btn btn-success rounded-pill" Text="Search" />
                        </div>
                    </div>
                    <div class="container-fluid text-center">

                        <div class="row bg-secondary text-white align-items-center">
                            <div class="col">
                                <h3>Pendency at Insurer</h3>
                            </div>
                            <div class="col-auto">
                                <asp:LinkButton ID="RefreshButton" runat="server" CssClass="btn btn-link text-white">
                    <i class="bi bi-arrow-clockwise"></i>
                                </asp:LinkButton>
                            </div>
                        </div>

                        <div class="row align-items-center mt-1 text-dark" style="background-color: #dee0e0;">
                            <div class="col">
                                <h4></h4>
                            </div>
                            <div class="col">
                                <h4>Today</h4>
                            </div>
                            <div class="col">
                                <h4>Overall</h4>
                            </div>
                        </div>
                        <div class="row bg-light text-dark mt-1 align-items-center">
                            <div class="col">
                                <h4>Claim Executive Insurer</h4>
                            </div>
                            <div class="col">
                                <asp:Label ID="lbTodayPendency" runat="server"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:Label ID="lbOverallPendency" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>
                </asp:View>
                <asp:View ID="ViewForTrust" runat="server">
                    <div class="row">
                        <div class="col-md-5 mb-3">
                            <div class="form-group">
                                <asp:Label ID="Label1" runat="server" CssClass="form-label font-weight-bold text-dark" Text="Scheme"></asp:Label>
                                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" AutoPostBack="true">
                                    <asp:ListItem>--Select--</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-5 mb-3">
                            <div class="form-group">
                                <asp:Label ID="Label2" runat="server" CssClass="form-label font-weight-bold text-dark" Text="Policy Period"></asp:Label>
                                <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control" AutoPostBack="true">
                                    <asp:ListItem>--Select--</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2 text-center mt-3">
                            <asp:Button runat="server" CssClass="btn btn-success rounded-pill" Text="Search" />
                        </div>
                    </div>
                    <div class="container-fluid text-center">

                        <div class="row bg-secondary text-white align-items-center">
                            <div class="col">
                                <h3>Pendency at Trust</h3>
                            </div>
                            <div class="col-auto">
                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-link text-white">
                                    <i class="bi bi-arrow-clockwise"></i>
                                </asp:LinkButton>
                            </div>
                        </div>

                        <div class="row align-items-center mt-1 text-dark" style="background-color: #dee0e0;">
                            <div class="col">
                                <h4></h4>
                            </div>
                            <div class="col">
                                <h4>Today</h4>
                            </div>
                            <div class="col">
                                <h4>Overall</h4>
                            </div>
                        </div>
                        <div class="row bg-light text-dark mt-1 align-items-center">
                            <div class="col">
                               <h4>Claim Executive Trust</h4> 
                            </div>
                            <div class="col">
                                <asp:Label ID="lbTrustToday" runat="server"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:Label ID="lbTrustOverall" runat="server"></asp:Label>
                            </div>
                        </div>
                        <%--<div class="row bg-light text-dark  align-items-center">
                            <div class="col">
                                <h4>Claim Executive Insurer</h4>
                            </div>
                            <div class="col">
                                <asp:Label ID="lbInsurerforToday" runat="server"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:Label ID="lbInsurerforOverall" runat="server"></asp:Label>
                            </div>
                        </div>--%>
                    </div>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

