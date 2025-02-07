<%@ Page Title="" Language="C#" MasterPageFile="~/ACO/ACO.master" AutoEventWireup="true" CodeFile="ReconciliationClaimCasesforApproval.aspx.cs" Inherits="ACO_ReconciliationClaimCasesforApproval" %>

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
                    <div class="d-flex w-100 justify-content-center position-relative">
                        <h3 class="m-0">Reconciliation Claim Cases for Approval</h3>
                    </div>
                </div>
                <div class="ibox-content p-4 bg-light">
                    <div class="row mb-3">
                        <!-- Hospital Code -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Case Number</label>
                            <asp:TextBox ID="txtHospitalCode" runat="server" CssClass="form-control"
                                placeholder="Enter Hospital Code"
                                Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:TextBox>
                        </div>
                        <!-- Hospitals -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Beneficiary Card Number</label>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"
                                placeholder="Enter Beneficiary Card Number"
                                Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:TextBox>
                        </div>
                        <!-- Registered From Date -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Registered From Date</label>
                            <%--<asp:Label runat="server" AssociatedControlID="tbRegisteredFromDate" CssClass="form-label fw-semibold" Style="font-size: 14px;" Text="Registered From Date" />--%>
                            <asp:TextBox ID="tbRegisteredFromDate" runat="server" OnKeypress="return isDate(event)" CssClass="form-control" TextMode="Date" Style="border: none; border-bottom: 2px solid #D3D3D3;" />
                        </div>
                        <!-- Registered To Date -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Registered To Date</label>
                            <asp:TextBox ID="TextBox2" runat="server" OnKeypress="return isDate(event)" CssClass="form-control" TextMode="Date" Style="border: none; border-bottom: 2px solid #D3D3D3;" />
                        </div>
                    </div>
                    <div class="row mb-3">
                        <!-- Scheme -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Scheme <span style="color: red;">*</span></label>
                            <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="MSBY(P)" Value="MSBY(P)"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Category -->
                        <!-- Category -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Category <span style="color: red;">*</span></label>
                            <asp:DropDownList
                                ID="ddCategory"
                                runat="server"
                                CssClass="form-control"
                                OnSelectedIndexChanged="ddCategory_SelectedIndexChanged"
                                AutoPostBack="True"
                                ControlToValidate="ddCategory"
                                Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- Procedure Name -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Procedure Name <span style="color: red;">*</span></label>
                            <asp:DropDownList ID="ddProcedureName" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Hospital Type -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Hospital Type</label>
                            <asp:DropDownList ID="ddlTypeS" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
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
                                <i class="fas fa-search"></i>Search
                            </asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-warning rounded-pill" OnClick="btnReset_Click">
                                <i class="fas fa-minus"></i>Reset
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
            <td style="padding: 10px; font-weight: bold; color: #006666;">Total Number Of Pending Cases:
            </td>
            <td style="padding: 10px; color: red; font-weight: bold;">
                <asp:Label ID="lblPendingHospitals" runat="server" Text="2"></asp:Label>
            </td>
            <td style="padding: 10px; font-weight: bold; color: #006666;">Total Number Of Cases Selected:
            </td>
            <td style="padding: 10px; color: red; font-weight: bold;">
                <asp:Label ID="lblSelectedHospitals" runat="server" Text="0"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="padding: 10px; font-weight: bold; color: #006666;">Total Amount to be Approved:
            </td>
            <td style="padding: 10px; color: red; font-weight: bold;">Rs
            <asp:Label ID="lblAmountCanBeApproved" runat="server" Text="6904612"></asp:Label>
                /-
            </td>
            <td style="padding: 10px; font-weight: bold; color: #006666;">Total Amount Being Approved:
            </td>
            <td style="padding: 10px; color: red; font-weight: bold;">Rs
            <asp:Label ID="lblAmountBeingApproved" runat="server" Text="0"></asp:Label>
                /-
            </td>
        </tr>
    </table>
    <%--<!-- Note -->
    <div class="text-end mt-2">
        <strong>
            <span style="color: red;">Note: Fraudulent/Partial Amount Cases</span>
        </strong>
    </div>--%>
    <div class="text-end mt-2">
        <strong>
            <span style="color: red;">Note:
            <input type="checkbox" id="fraudulentCheckbox" name="fraudulentCheckbox" />
                Fraudulent/Partial Amount Cases
            </span>
        </strong>
    </div>

    <div class="col-lg-12">
    <div class="ibox-content">
        <div class="form-group row">
            <div class="col-md-12 table-responsive mt-2">
                <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
                <asp:GridView ID="gridrptClaimCases" runat="server" AutoGenerateColumns="False" BackColor="White" AllowPaging="True" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                    <AlternatingRowStyle BackColor="Gainsboro" />
                    <Columns>
                        <asp:TemplateField HeaderText="Sl No.">
                            <ItemTemplate>
                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Select">
                            <ItemTemplate>
                                <asp:CheckBox ID="cbSelect" runat="server" />
                                <asp:HiddenField ID="hfClaimId" runat="server" Value='<%# Eval("ClaimId") %>' />
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Case No">
                            <ItemTemplate>
                                <asp:Label ID="lbCaseNo" runat="server" Text='<%# Eval("CaseNo") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Claim No">
                            <ItemTemplate>
                                <asp:Label ID="lbClaimNo" runat="server" Text='<%# Eval("ClaimNo") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Beneficiary Card Number">
                            <ItemTemplate>
                                <asp:Label ID="lbBeneficiaryCardNumber" runat="server" Text='<%# Eval("BeneficiaryCardNumber") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Case Status">
                            <ItemTemplate>
                                <asp:Label ID="lbCaseStatus" runat="server" Text='<%# Eval("CaseStatus") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Hospital Name">
                            <ItemTemplate>
                                <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Registered Date">
                            <ItemTemplate>
                                <asp:Label ID="lbRegisteredDate" runat="server" Text='<%# Eval("RegisteredDate") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Claim Initiated Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbClaimInitiatedAmount" runat="server" Text='<%# Eval("ClaimInitiatedAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Claim Approved Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbClaimApprovedAmount" runat="server" Text='<%# Eval("ClaimApprovedAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Erroneous Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbErroneousAmount" runat="server" Text='<%# Eval("ErroneousAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Erroneous Initiated Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbErroneousInitiatedAmount" runat="server" Text='<%# Eval("ErroneousInitiatedAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Hospital Account No">
                            <ItemTemplate>
                                <asp:Label ID="lbHospitalAccountNo" runat="server" Text='<%# Eval("HospitalAccountNo") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Hospital IFSC Code">
                            <ItemTemplate>
                                <asp:Label ID="lbHospitalIFSCCode" runat="server" Text='<%# Eval("HospitalIFSCCode") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="TDS Percentage">
                            <ItemTemplate>
                                <asp:Label ID="lbTDSPercentage" runat="server" Text='<%# Eval("TDSPercentage") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ACO Exemption Remarks">
                            <ItemTemplate>
                                <asp:TextBox ID="tbExemptionRemarks" runat="server" class="form-control" TextMode="MultiLine" Placeholder="Enter remarks here"></asp:TextBox>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</div>
   
</asp:Content>

