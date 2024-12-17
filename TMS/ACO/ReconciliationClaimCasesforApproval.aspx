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
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Category <span style="color: red;">*</span></label>
                            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Procedure Name -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Procedure Name <span style="color: red;">*</span></label>
                            <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
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
            <asp:Label ID="lblAmountCanBeApproved" runat="server" Text="6904612"></asp:Label>/-
            </td>
            <td style="padding: 10px; font-weight: bold; color: #006666;">Total Amount Being Approved:
            </td>
            <td style="padding: 10px; color: red; font-weight: bold;">Rs
            <asp:Label ID="lblAmountBeingApproved" runat="server" Text="0"></asp:Label>/-
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



    <div class="table-section" style="overflow: scroll;">
        <table class="table table-bordered">
            <thead class="table-header">
                <tr>
                    <th>S.No</th>
                    <th>Case No</th>
                    <th>Claim No</th>
                    <th>Beneficiary Card Number</th>
                    <th>Case Status</th>
                    <th>Hospital Name</th>
                    <th>Registered Date</th>
                    <th>Claim Submitted Date</th>
                    <th>Hospital Account No</th>
                    <th>Hospital IFSC Code</th>
                    <th>TDS Percentage</th>
                    <%-- <th>RF Percentage</th>--%>
                    <th>Claim Initiated Amount(Rs.)</th>
                    <th>Approved Amount(I)(Rs.)</th>
                    <th>Approved Amount(T)(Rs.)</th>
                    <th>Approved Amount(Rs.)</th>
                    <th>Tds Amount(I)(Rs.)</th>
                    <th>RF Amount(I)(Rs.)</th>
                    <th>Final Amount(I)(Rs.)</th>
                    <th>Tds Amount(T)(Rs.)</th>
                    <th>RF Amount(T)(Rs.)</th>
                    <th>Final Amount(T)(Rs.)</th>
                    <th>BFA Amount(T)(Rs.)</th>
                    <th>Claim Payable Amount(Rs.)</th>
                    <th>ACO Exemption Remarks</th>
                </tr>
            </thead>
            <tbody>
                <!-- Dynamically add rows here -->
                <asp:Repeater ID="rptClaimCases" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%# Container.ItemIndex + 1 %></td>
                            <td><%# Eval("CaseNo") %></td>
                            <%--<td>
                            <asp:LinkButton ID="lnkCaseNo" runat="server"
                                Text='<%# Eval("CaseNo") %>'
                                CommandArgument='<%# Eval("CaseNo") %>'
                                OnClick="lnkCaseNo_Click" />
                        </td>--%>
                            <td><%# Eval("ClaimNo") %></td>
                            <td><%# Eval("BeneficiaryCardNumber") %></td>
                            <td><%# Eval("CaseStatus") %></td>
                            <td><%# Eval("HospitalName") %></td>
                            <td><%# Eval("RegisteredDate") %></td>
                            <td><%# Eval("ClaimSubmittedDate") %></td>
                            <td><%# Eval("HospitalAccountNo") %></td>
                            <td><%# Eval("HospitalIFSCCode") %></td>
                            <td><%# Eval("TDSPercentage") %></td>
                            <%--<td><%# Eval("RFPercentage") %></td>--%>
                            <td><%# Eval("ClaimInitiatedAmount") %></td>
                            <td><%# Eval("ApprovedAmountI") %></td>
                            <td><%# Eval("ApprovedAmountT") %></td>
                            <td><%# Eval("TdsAmountI") %></td>
                            <td><%# Eval("RFAmountI") %></td>
                            <td><%# Eval("FinalAmountI") %></td>
                            <td><%# Eval("TdsAmountT") %></td>
                            <td><%# Eval("RFAmountT") %></td>
                            <td><%# Eval("FinalAmountT") %></td>
                            <td><%# Eval("BFAmountT") %></td>
                            <td><%# Eval("ClaimPayableAmount") %></td>
                            <td>
                                <!-- Text area for ACO Exemption Remarks -->
                                <textarea rows="4" cols="40" placeholder="Enter remarks here"></textarea>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
</asp:Content>

