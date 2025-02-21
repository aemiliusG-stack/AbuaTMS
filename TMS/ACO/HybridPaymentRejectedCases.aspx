<%@ Page Title="" Language="C#" MasterPageFile="~/ACO/ACO.master" AutoEventWireup="true" CodeFile="HybridPaymentRejectedCases.aspx.cs" Inherits="ACO_HybridPaymentRejectedCases" %>

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
    <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
    <div class="row">
        <div class="col-lg-12">
            <div class="ibox">
                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                    <div class="d-flex w-100 justify-content-center position-relative">
                        <h3 class="m-0">Hybrid Payment Rejected Cases</h3>
                    </div>
                </div>
                <div class="ibox-content p-4 bg-light">
                    <div class="row mb-3">
                        <!-- Hospitals Name -->
                        <div class="col-md-4">
                            <label class="form-label fw-bold">Hospitals Name</label>
                            <%--<asp:DropDownList ID="ddlHospitals" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;" EnableViewState="true">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>--%>
                            <asp:DropDownList ID="ddlHospitals" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Rejected From Date -->
                        <div class="col-md-4">
                            <label class="form-label fw-bold">Rejected From Date</label>
                            <asp:TextBox ID="tbRegisteredFromDate" runat="server" OnKeypress="return isDate(event)" CssClass="form-control" TextMode="Date" Style="border: none; border-bottom: 2px solid #D3D3D3;" />
                        </div>
                        <!-- Rejected To Date -->
                        <div class="col-md-4">
                            <label class="form-label fw-bold">Rejected To Date</label>
                            <asp:TextBox ID="TextBox1" runat="server" OnKeypress="return isDate(event)" CssClass="form-control" TextMode="Date" Style="border: none; border-bottom: 2px solid #D3D3D3;" />
                        </div>
                    </div>
                    <div class="row mb-3">
                        <!-- Patient State -->
                        <div class="col-md-4">
                            <label class="form-label fw-bold">Patient State</label>
                            <asp:DropDownList ID="DropDownListDistricts" runat="server" CssClass="form-control" AppendDataBoundItems="True" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="Select State" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Jharkhand" Value="1" Selected="True"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- Scheme -->
                        <div class="col-md-4">
                            <label class="form-label fw-bold">Scheme <span style="color: red;">*</span></label>
                            <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="MSBY(P)" Value="MSBY(P)"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- Error Message -->
                    <div class="row mt-3">
                        <div class="col-md-12 text-center">
                            <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="False"></asp:Label>
                        </div>
                    </div>

                    <!-- Search and Reset Buttons -->
                    <div class="row mt-3">
                        <div class="col-md-12 text-center">
                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success rounded-pill" OnClick="btnSearch_Click">
                                    <i class="fas fa-search"></i> Search
                            </asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-warning rounded-pill" OnClick="btnReset_Click">
                                <i class="fas fa-minus"></i> Reset
                            </asp:LinkButton>
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
    <table style="width: 50%; text-align: center; border-collapse: collapse; margin-top: 20px;">
        <tr>
            <td style="padding: 10px; font-weight: bold; color: #006666;">Total Number Of Pending Hospitals:
            </td>
            <td style="padding: 10px; color: red; font-weight: bold;">
                <asp:Label ID="lblPendingHospitals" runat="server" Text="2"></asp:Label>
            </td>
            <td style="padding: 10px; font-weight: bold; color: #006666;">Total Number Of Hospitals Selected:
            </td>
            <td style="padding: 10px; color: red; font-weight: bold;">
                <asp:Label ID="lblSelectedHospitals" runat="server" Text="0"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="padding: 10px; font-weight: bold; color: #006666;">Total Amount that can be Approved:
            </td>
            <td style="padding: 10px; color: red; font-weight: bold;">Rs
                <asp:Label ID="lblAmountCanBeApproved" runat="server" Text="6904612"></asp:Label>/-
            </td>
            <td style="padding: 10px; font-weight: bold; color: #006666;">Total Amount Being Approved:
            </td>
            <td style="padding: 10px; color: red; font-weight: bold;">Rs
                <asp:Label ID="lblAmountBeingApproved" runat="server" Text="0"></asp:Label>/-
            </td>
        </tr>
    </table>

    
    <div class="table-responsive mt-2">
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
            <AlternatingRowStyle BackColor="Gainsboro" />
            <Columns>
                <asp:TemplateField HeaderText="Sl. No.">
                    <ItemTemplate>
                        <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="CaseNumber">
                    <ItemTemplate>
                        <asp:Label ID="lbCaseNumber" runat="server" Text='<%# Eval("CaseNumber") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="HospitalId">
                    <ItemTemplate>
                        <asp:Label ID="lbHospitalId" runat="server" Text='<%# Eval("HospitalId") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Hospital Name">
                    <ItemTemplate>
                        <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Hospital Type">
                    <ItemTemplate>
                        <asp:Label ID="lbHospitalType" runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="lbStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Recent PAN No.">
                    <ItemTemplate>
                        <asp:Label ID="lbHospitalPan" runat="server" Text='<%# Eval("HospitalPan") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Recent Account No.">
                    <ItemTemplate>
                        <asp:Label ID="lbAccountNumber" runat="server" Text='<%# Eval("AccountNumber") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Recent Bank Name.">
                    <ItemTemplate>
                        <asp:Label ID="lbBankName" runat="server" Text='<%# Eval("BankName") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Bank IFSCCode.">
                    <ItemTemplate>
                        <asp:Label ID="lbIFSCCode" runat="server" Text='<%# Eval("IFSCCode") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total Package Cost.">
                    <ItemTemplate>
                        <asp:Label ID="lbTotalPackageCost" runat="server" Text='<%# Eval("TotalPackageCost") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Remarks">
                    <ItemTemplate>
                        <asp:Label ID="lbRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>

                <%--<!-- Total Reject Amount Column -->
                <asp:TemplateField HeaderText="Total Reject Amount">
                    <ItemTemplate>
                        <asp:Label ID="lbTotalRejectedAmount" runat="server" Text='<%# Eval("TotalRejectedAmount") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>

                <!-- Last Update Date Column -->
                <asp:TemplateField HeaderText="Last Update Date (TMS)">
                    <ItemTemplate>
                        <asp:Label ID="lbLastUpdatedOn" runat="server" Text='<%# Eval("LastUpdatedOn") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>

                <!-- Remarks Column -->
                <asp:TemplateField HeaderText="Remarks">
                    <ItemTemplate>
                        <asp:Label ID="lbRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                </asp:TemplateField>--%>
            </Columns>
        </asp:GridView>

        <!-- No Data Panel -->
        <asp:Panel ID="panelNoData" runat="server" Visible="false">
            <div class="row ibox-content" style="background-color: #f0f0f0;">
                <div class="col-md-12 d-flex flex-column justify-content-center align-items-center" style="height: 200px;">
                    <i class="fa fa-search" style="font-size: 20px;"></i>
                    <span class="mt-2">No Record Found</span>
                    <span class="text-body-tertiary">Currently, no cases available at this moment.</span>
                </div>
            </div>
        </asp:Panel>
    </div>

</asp:Content>

