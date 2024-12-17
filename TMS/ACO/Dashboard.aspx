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
    <asp:Repeater ID="PendencyRepeater" runat="server">
        <HeaderTemplate>
            <div class="container-fluid text-center">
                <div class="row bg-secondary text-white align-items-center">
                    <div class="col">
                        <h3>Pendency at Trust</h3>
                    </div>
                    <div class="col-auto">
                        <asp:LinkButton ID="RefreshButton" runat="server" CssClass="btn btn-link text-white">
                        <i class="bi bi-arrow-clockwise"></i>
                        </asp:LinkButton>
                    </div>
                </div>
                <div class="row align-items-center text-dark" style="background-color: #dee0e0;">
                    <div class="col">
                        <h4>S No</h4>
                    </div>
                    <div class="col">
                        <h4>Role Name</h4>
                    </div>
                    <div class="col">
                        <h4>Today</h4>
                    </div>
                    <div class="col">
                        <h4>Overall</h4>
                    </div>
                </div>
        </HeaderTemplate>

        <ItemTemplate>
            <div class="row bg-light text-dark align-items-center">
                <div class="col">
                    <%# Eval("SNo") %>
                </div>
                <div class="col">
                    <%# Eval("RoleName") %>
                </div>
                <div class="col">
                    <%# Eval("Today") %>
                </div>
                <div class="col">
                    <%# Eval("Overall") %>
                </div>
            </div>
        </ItemTemplate>

        <FooterTemplate>
            </div>
        </FooterTemplate>
    </asp:Repeater>

</asp:Content>

