<%@ Page Title="" Language="C#" MasterPageFile="~/MEDCO/MEDCO.master" AutoEventWireup="true" CodeFile="MedcoHome.aspx.cs" Inherits="MEDCO_MedcoHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
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
                                <td>Patient Registered</td>
                                <td>
                                    <asp:Label ID="lbTodayPatientRegistered" runat="server" Text="0"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbOverallPatientRegistered" runat="server" Text="0"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>Pre-Auth Initiated</td>
                                <td>
                                    <asp:Label ID="lbTodayPreAuth" runat="server" Text="0"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbOverallPreAuth" runat="server" Text="0"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>Patient Cancelled </td>
                                <td>
                                    <asp:Label ID="lbTodayCancelled" runat="server" Text="0"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbOverallCancelled" runat="server" Text="0"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>Patient Refered</td>
                                <td>
                                    <asp:Label ID="lbTodayRefered" runat="server" Text="0"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbOverallRefered" runat="server" Text="0"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>Claim Initiated</td>
                                <td>
                                    <asp:Label ID="lbTodayClaim" runat="server" Text="0"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbOverallClaim" runat="server" Text="0"></asp:Label>
                                </td>
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
    <asp:HiddenField ID="hdMasterUserId" runat="server" Visible="false" />
    <asp:HiddenField ID="hdMasterRoleId" runat="server" Visible="false" />
    <asp:HiddenField ID="hdMasterRoleName" runat="server" Visible="false" />
    <asp:HiddenField ID="hdHospitalId" runat="server" Visible="false" />
</asp:Content>

