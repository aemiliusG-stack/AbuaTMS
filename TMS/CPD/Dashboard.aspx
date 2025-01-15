<%@ Page Title="" Language="C#" MasterPageFile="~/CPD/CPD.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="CPD_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <%--<div class="form-group row">
        <div class="col-md-4">
            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Scheme</span><span class="text-danger">*</span><br />
            <asp:DropDownList ID="dropCPDScheme" runat="server" class="form-control" AutoPostBack="True"></asp:DropDownList>
        </div>
        <div class="col-md-4">
            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Policy</span><span class="text-danger">*</span><br />
            <asp:DropDownList ID="dropCPDPolicy" runat="server" class="form-control" AutoPostBack="True"></asp:DropDownList>
        </div>
        <div class="col-md-4 d-flex align-items-end">
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" />
        </div>
    </div>
    <div class="card mt-4">
        <div class="card-body table-responsive">
            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                <div class="d-flex w-100 justify-content-center position-relative">
                    <h3 class="m-0">Pendency at Insurer</h3>
                </div>
            </div>
            <asp:GridView ID="gvCaseSearch" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                <AlternatingRowStyle BackColor="Gainsboro" />
                <Columns>
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <asp:Label ID="lbSlNo" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Today">
                        <ItemTemplate>
                            <asp:Label ID="lbToday" runat="server" Text='<%# Eval("Today") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Overall">
                        <ItemTemplate>
                            <asp:Label ID="lbOverall" runat="server" Text='<%# Eval("Overall") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>--%>

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
                                <h4>Claim Processing Doctor Insurer</h4>
                            </div>
                            <div class="col">
                                <asp:Label ID="lbTodayPendency" runat="server"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:Label ID="lbOverallPendency" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row bg-light text-dark mt-1 align-items-center">
                            <div class="col">
                                <h4>Claim Processing Doctor Insurer(Assigned)</h4>
                            </div>
                            <div class="col">
                                <asp:Label ID="lbTodayPendencyAssigned" runat="server"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:Label ID="lbOverallPendencyAssigned" runat="server"></asp:Label>
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
                                <h4>Claim Processing Doctor Trust</h4>
                            </div>
                            <div class="col">
                                <asp:Label ID="lbTrustToday" runat="server"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:Label ID="lbTrustOverall" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row bg-light text-dark mt-1 align-items-center">
                            <div class="col">
                                <h4>Claim Processing Doctor Trust(Assigned)</h4>
                            </div>
                            <div class="col">
                                <asp:Label ID="lbTrustTodayAssigned" runat="server"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:Label ID="lbTrustOverallAssigned" runat="server"></asp:Label>
                            </div>
                        </div>
                        <%-- <div class="row bg-light text-dark  align-items-center">
                            <div class="col">
                                <h4>Claim Processing Doctor Insurer</h4>
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
