<%@ Page Title="" Language="C#" MasterPageFile="~/PPD/PPD.master" AutoEventWireup="true" CodeFile="PPDDashboard.aspx.cs" Inherits="PPD_PPDDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server">
        <contenttemplate>
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Dashboard</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="ibox-content text-dark">
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
                    </div>

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
                                        <td>Preauth Panel Doctor Insurer</td>
                                        <td>0</td>
                                        <td>0</td>
                                    </tr>
                                    <tr>
                                        <td>Preauth Panel Doctor Insurer (Assigned)</td>
                                        <td>0</td>
                                        <td>0</td>
                                    </tr>
                                    <tr>
                                        <td>Day care count</td>
                                        <td>0</td>
                                        <td>0</td>
                                    </tr>
                                    <tr>
                                        <td>Preauth count</td>
                                        <td>0</td>
                                        <td>0</td>
                                    </tr>
                                </tbody>
                            </table>

                            <%--<asp:GridView ID="gridPendencyInsurer" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                        <alternatingrowstyle backcolor="Gainsboro" />
                        <columns>
                            <asp:TemplateField HeaderText="Details">
                                <itemtemplate>
                                    <asp:Label ID="lbDetails" runat="server" Text="Preauth Panel Doctor Insurer"></asp:Label>
                                </itemtemplate>
                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Today">
                                <itemtemplate>
                                    <asp:Label ID="lbToday" runat="server" Text="10"></asp:Label>
                                </itemtemplate>
                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Overall">
                                <itemtemplate>
                                    <asp:Label ID="lbClaimName" runat="server" Text="30"></asp:Label>
                                </itemtemplate>
                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                            </asp:TemplateField>
                        </columns>
                    </asp:GridView>--%>
                        </div>
                    </div>
                </div>
            </div>
        </contenttemplate>
    </asp:UpdatePanel>
</asp:Content>

