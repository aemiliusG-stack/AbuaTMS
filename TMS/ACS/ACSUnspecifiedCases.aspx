<%@ Page Title="" Language="C#" MasterPageFile="~/ACS/ACS.master" AutoEventWireup="true" CodeFile="ACSUnspecifiedCases.aspx.cs" Inherits="ACS_ACSUnspecifiedCases" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Unspecified Cases for Approval</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Case Number</span>
                                <asp:TextBox runat="server" ID="tbCaseNo" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Beneficiary Card Number</span>
                                <asp:TextBox runat="server" ID="tbBeneficiaryCardNo" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Patient Name</span>
                                <asp:TextBox runat="server" ID="tbPatientName" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Registered From Date</span>
                                <asp:TextBox ID="tbRegisteredFromDate" runat="server" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Registered To Date</span>
                                <asp:TextBox ID="tbRegisteredToDate" runat="server" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Scheme Id</span>
                                <asp:DropDownList ID="dropSchemeId" runat="server" class="form-control mt-2" AutoPostBack="true">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Category</span>
                                <asp:DropDownList ID="dropCategory" runat="server" class="form-control mt-2" AutoPostBack="true" OnSelectedIndexChanged="dropCategory_SelectedIndexChanged">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Procudure Name</span>
                                <asp:DropDownList ID="dropProcedureName" runat="server" class="form-control mt-2" AutoPostBack="true">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-12 text-center mt-2">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn btn-success rounded-pill" OnClick="btnSearch_Click" />
                                <asp:Button ID="btnReset" runat="server" Text="Reset" class="btn btn-warning rounded-pill" OnClick="btnReset_Click" />
                            </div>
                        </div>
                    </div>

                    <div class="card mt-4">
                        <div class="card-body">
                            <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
                            <div class="table-responsive mt-2">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr class="table-primary">
                                            <th scope="col" style="background-color: #007e72; color: white;">S.No</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Case No</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Claim No</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Patient Name</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Card Number</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Case Status</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Hospital Name</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Registred Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td><a href="/ACS/ACSUnspecifiedCaseDetails.aspx" class="text-decoration-underline text-black font-bold">CASE/PS7/HOSP20G12238/P2897102</a></td>
                                            <td>TRUST/RAN/2024/3393003210/1</td>
                                            <td>DUBRAJ MAHTO</td>
                                            <td>MD02V937R</td>
                                            <td>Procedure auto approved insurance (Insurance)
                                            </td>
                                            <td>CHC NAMKUM</td>
                                            <td>16/07/2024</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <%--<asp:GridView ID="gridCaseSearch" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                            <alternatingrowstyle backcolor="Gainsboro" />
                            <columns>
                                <asp:TemplateField HeaderText="S.No.">
                                    <itemtemplate>
                                        <asp:Label ID="lbSlNo" runat="server" Text="1"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Case No">
                                    <itemtemplate>
                                        <asp:Label ID="lbCaseNo" runat="server" Text="CASE/PS7"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Claim No">
                                    <itemtemplate>
                                        <asp:Label ID="lbClaimNo" runat="server" Text="TRUST/RAN"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Patient Name">
                                    <itemtemplate>
                                        <asp:Label ID="lbPatientName" runat="server" Text="Patient Name"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Case Status">
                                    <itemtemplate>
                                        <asp:Label ID="lbCaseStatus" runat="server" Text="Case Status"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Hospital Name">
                                    <itemtemplate>
                                        <asp:Label ID="lbHospitalName" runat="server" Text="Hospital Name"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Registred Date">
                                    <itemtemplate>
                                        <asp:Label ID="lbRegisteredDate" runat="server" Text="Registred Date"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                            </columns>
                        </asp:GridView>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

