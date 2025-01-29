<%@ Page Title="" Language="C#" MasterPageFile="~/PPD/PPD.master" AutoEventWireup="true" CodeFile="PPDDashboard.aspx.cs" Inherits="PPD_PPDDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
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
                        <div class="ibox-content d-flex" style="flex-wrap: wrap; gap: 30px; justify-content: flex-start">

                            <%--Insurer Below--%>

                            <asp:Panel ID="panelInsurerCountToday" runat="server" Style="height: 140px; background-color: #a2c09a; border-radius: 5px; width: 200px; position: relative">
                                <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white;">Today's Count</span>
                                    <asp:Label ID="lbInsurerCountToday" runat="server" Text="0" Style="font-size: 50px; line-height: 1; font-weight: bold; color: white;"></asp:Label>
                                </div>
                                <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #89ad7f; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">Preauth Panel Doctor<br />
                                        Insurer</span>
                                </div>
                            </asp:Panel>
                            <asp:Panel ID="panelInsurerCountOverall" runat="server" Style="height: 140px; background-color: #fecf97; border-radius: 5px; width: 200px; position: relative">
                                <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white;">Overall Count</span>
                                    <asp:Label ID="lbInsurerCountOverall" runat="server" Text="0" Style="font-size: 50px; line-height: 1; font-weight: bold; color: white;"></asp:Label>
                                </div>
                                <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #e8b573; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">Preauth Panel Doctor<br />
                                        Insurer</span>
                                </div>
                            </asp:Panel>
                            <asp:Panel ID="panelInsurerAssignedToday" runat="server" Style="height: 140px; background-color: #6770b7; border-radius: 5px; width: 200px; position: relative">
                                <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white;">Today's Count</span>
                                    <asp:Label ID="lbInsurerAssignedToday" runat="server" Text="0" Style="font-size: 50px; line-height: 1; font-weight: bold; color: white;"></asp:Label>
                                </div>
                                <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #35409b; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">Preauth Panel Doctor Insurer (Assigned)</span>
                                </div>
                            </asp:Panel>
                            <asp:Panel ID="panelInsurerAssignedOverall" runat="server" Style="height: 140px; background-color: #ea6c00; border-radius: 5px; width: 200px; position: relative">
                                <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white;">Overall Count</span>
                                    <asp:Label ID="lbInsurerAssignedOverall" runat="server" Text="0" Style="font-size: 50px; line-height: 1; font-weight: bold; color: white;"></asp:Label>
                                </div>
                                <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #c56512; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">Preauth Panel Doctor Insurer (Assigned)</span>
                                </div>
                            </asp:Panel>

                            <%--Trust Below--%>

                            <asp:Panel ID="panelTrustCountToday" runat="server" Style="height: 140px; background-color: #eb7ada; border-radius: 5px; width: 200px; position: relative">
                                <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white;">Today's Count</span>
                                    <asp:Label ID="lbTrustCountToday" runat="server" Text="0" Style="font-size: 50px; line-height: 1; font-weight: bold; color: white;"></asp:Label>
                                </div>
                                <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #db41ae; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">Preauth Panel Doctor<br />
                                        Trust</span>
                                </div>
                            </asp:Panel>
                            <asp:Panel ID="panelTrustCountOverall" runat="server" Style="height: 140px; background-color: #f57e4d; border-radius: 5px; width: 200px; position: relative">
                                <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white;">Overall Count</span>
                                    <asp:Label ID="lbTrustOverall" runat="server" Text="0" Style="font-size: 50px; line-height: 1; font-weight: bold; color: white;"></asp:Label>
                                </div>
                                <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #e76c1c; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">Preauth Panel Doctor<br />
                                        Trust</span>
                                </div>
                            </asp:Panel>
                            <asp:Panel ID="panelTrustAssignedToday" runat="server" Style="height: 140px; background-color: #b898c1; border-radius: 5px; width: 200px; position: relative">
                                <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white;">Today's Count</span>
                                    <asp:Label ID="lbTrustAssignedToday" runat="server" Text="0" Style="font-size: 50px; line-height: 1; font-weight: bold; color: white;"></asp:Label>
                                </div>
                                <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #a789af; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">Preauth Panel Doctor Trust (Assigned)</span>
                                </div>
                            </asp:Panel>
                            <asp:Panel ID="panelTrustAssignedOverall" runat="server" Style="height: 140px; background-color: #c09a99; border-radius: 5px; width: 200px; position: relative">
                                <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white;">Overall Count</span>
                                    <asp:Label ID="lbTrustAssignedOverall" runat="server" Text="0" Style="font-size: 50px; line-height: 1; font-weight: bold; color: white;"></asp:Label>
                                </div>
                                <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #ae8485; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">Preauth Panel Doctor Trust (Assigned)</span>
                                </div>
                            </asp:Panel>


                            <%--Common Below--%>

                            <div style="height: 140px; background-color: #78c389; border-radius: 5px; width: 200px; position: relative">
                                <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white;">Today's Count</span>
                                    <span style="font-size: 50px; line-height: 1; font-weight: bold; color: white;">0</span>
                                </div>
                                <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #4b9d5f; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">Unspecified Case</span>
                                </div>
                            </div>
                            <div style="height: 140px; background-color: #dbdb89; border-radius: 5px; width: 200px; position: relative">
                                <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white;">Overall Count</span>
                                    <span style="font-size: 50px; line-height: 1; font-weight: bold; color: white;">0</span>
                                </div>
                                <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #b9b916; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">Unspecified Case</span>
                                </div>
                            </div>
                            <div style="height: 140px; background-color: #f58275; border-radius: 5px; width: 200px; position: relative">
                                <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white;">Today's Count</span>
                                    <asp:Label ID="lbPreauthCountToday" runat="server" Text="0" Style="font-size: 50px; line-height: 1; font-weight: bold; color: white;"></asp:Label>
                                </div>
                                <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #bb2d1d; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">Preauth Count</span>
                                </div>
                            </div>
                            <div style="height: 140px; background-color: #7f9de3; border-radius: 5px; width: 200px; position: relative">
                                <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white;">Overall Count</span>
                                    <asp:Label ID="lbPreauthCountOverall" runat="server" Text="0" Style="font-size: 50px; line-height: 1; font-weight: bold; color: white;"></asp:Label>
                                </div>
                                <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #365eb9; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                                    <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">Preauth Count</span>
                                </div>
                            </div>

                            <%--<table class="table table-bordered table-striped">
                                <thead>
                                    <tr class="table-primary text-center">
                                        <th scope="col" style="background-color: #007e72; color: white;"></th>
                                        <th scope="col" style="background-color: #007e72; color: white;">Today</th>
                                        <th scope="col" style="background-color: #007e72; color: white;">Overall</th>
                                    </tr>
                                </thead>
                                <tbody class="text-center">
                                    <tr>
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
                            </table>--%>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

