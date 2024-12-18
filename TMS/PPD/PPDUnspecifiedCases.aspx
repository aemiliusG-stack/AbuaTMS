<%@ Page Title="" Language="C#" MasterPageFile="~/PPD/PPD.master" AutoEventWireup="true" CodeFile="PPDUnspecifiedCases.aspx.cs" Inherits="PPD_PPDUnspecifiedCases" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server">
        <contenttemplate>
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Assigned Cases</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Case Number</span>
                                <asp:TextBox runat="server" ID="tbCaseNo" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Beneficiary Card Number</span>
                                <asp:TextBox runat="server" ID="tbBeneficiaryCardNo" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Patient Name</span>
                                <asp:TextBox runat="server" ID="tbPatientName" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Registered From Date</span>
                                <asp:TextBox ID="tbRegisteredFromDate" runat="server" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Registered To Date</span>
                                <asp:TextBox ID="tbRegisteredToDate" runat="server" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Scheme Id</span>
                                <asp:DropDownList ID="dlSchemeId" runat="server" class="form-control mt-2">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Category</span>
                                <asp:DropDownList ID="dlCategory" runat="server" class="form-control mt-2">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Procudure Name</span>
                                <asp:DropDownList ID="dlProcedureName" runat="server" class="form-control mt-2">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-12 text-center mt-2">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn btn-success rounded-pill" />
                                <asp:Button ID="btnReset" runat="server" Text="Reset" class="btn btn-warning rounded-pill" />
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
                                            <td><a href="#" class="text-decoration-underline text-black fw-semibold">CASE/PS7/HOSP20G12238/P2897102</a></td>
                                            <td>TRUST/RAN/2024/3393003210/1</td>
                                            <td>SEETA KUMARI</td>
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
        </contenttemplate>
    </asp:UpdatePanel>
</asp:Content>

