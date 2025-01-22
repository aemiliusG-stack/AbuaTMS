<%@ Page Title="" Language="C#" MasterPageFile="~/SHA/SHA.master" AutoEventWireup="true" CodeFile="ClaimUpdation.aspx.cs" Inherits="SHA_ClaimUpdation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Claim Cases For Approval</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <style>
        .header {
            background-color: #00a9ce;
            color: white;
            padding: 10px;
        }

        .filters {
            margin-bottom: 20px;
        }

        .search-section {
            background-color: #f5f5f5;
            padding: 20px;
        }

        .table-section {
            margin-top: 20px;
        }

        .table-header {
            background-color: #19c0a0 !important;
        }

        .total-info {
            text-align: center;
            padding: 10px;
            background-color: #d1f1ff;
        }

        .total-info {
            padding: 10px;
            /*background-color: #d1f1ff;*/
            background-color: #3ecfd7;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn-search-icon::before {
            font-family: 'Font Awesome 5 Free';
            content: '\f002'; /* Unicode for search icon */
            margin-right: 5px;
            font-weight: 900;
        }

        thead > tr {
            background-color: #19c0a0 !important;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <div class="ibox">
                <div class="ibox-title d-flex justify-content-between text-white align-items-center  bg-primary">
                    <h4 class="m-0">Claim Cases For Approval</h4>
                </div>
                <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
                <div class="ibox-content p-4 bg-light">
                    <div class="row mb-3">
                        <!-- Hospital Type -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Hospital Type:</label>
                            <asp:DropDownList ID="ddlTypeS" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- Scheme -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Scheme:<span style="color: red;">*</span></label>
                            <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="MSBY(P)" Value="MSBY(P)"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Phase -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Phase:<span style="color: red;">*</span></label>
                            <asp:DropDownList ID="ddlPhase" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="---select---" Value="MSBY(P)"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Financial Year -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Financial Year:<span style="color: red;">*</span></label>
                            <asp:DropDownList ID="ddlFinancialYear" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
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
                            <!-- Search Button with Icon -->
                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success rounded-pill" OnClick="SearchSubmit_Click">
                                <i class="fas fa-search"></i>Search
                            </asp:LinkButton>
                            <!-- Reset Button -->
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
    <div class="total-info row text-center bg-primary">
        <div class="col-md-6">
            <p>
                Total Number of Cases:
                <asp:Label ID="lblTotalCases" runat="server" Text="0"></asp:Label>
            </p>
        </div>
        <div class="col-md-6">
            <p>
                Total Number of Cases Selected:
        <asp:Label ID="lblSelectedCases" runat="server" Text="Rs 0"></asp:Label>
            </p>
        </div>
        <div class="col-md-6">
            <p>
                Total Amount to be Approved:
                <asp:Label ID="lblTotalAmount" runat="server" Text="Rs 0"></asp:Label>
            </p>
        </div>
        <div class="col-md-6">
            <p>
                Total Amount Being Approved:
                <asp:Label ID="lblAmountApproved" runat="server" Text="Rs 0"></asp:Label>
            </p>
        </div>
    </div>

    <div class="table-section" style="overflow: scroll;">
        <table class="table table-bordered">
            <thead class="table-header">
                <tr style="background: #19c0a0">
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
                    <th>TDS Exemption(Y/N)</th>
                    <th>TDS Percentage</th>
                    <%--<th>RF Percentage</th>--%>
                    <th>Claim Initiated Amount(Rs.)</th>
                    <th>Approved Amount(I)(Rs.)</th>
                    <th>Approved Amount(T)(Rs.)</th>
                    <th>Approved Amount(Rs.)</th>
                    <th>Tds Amount(I)(Rs.)</th>
                    <%--<th>RF Amount(I)(Rs.)</th>--%>
                    <th>Final Amount(I)(Rs.)</th>
                    <th>Tds Amount(T)(Rs.)</th>
                    <%--<th>RF Amount(T)(Rs.)</th>--%>
                    <th>Final Amount(T)(Rs.)</th>
                    <th>BFA Amount(T)(Rs.)</th>
                    <th>Claim Payable Amount(Rs.)</th>
                    <th>SHA Exemption Remarks</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptClaimCases" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%# Container.ItemIndex + 1 %></td>
                            <td>
                                <a href='<%# "CaseDetails.aspx?CaseNumber=" + Eval("CaseNumber") %>'>
                                    <%# Eval("CaseNumber") %>
                                </a>
                            </td>
                            <td><%# Eval("ClaimNo") %></td>
                            <td><%# Eval("BeneficiaryCardNumber") %></td>
                            <td><%# Eval("CaseStatus") %></td>
                            <td><%# Eval("HospitalName") %></td>
                            <td><%# Eval("RegisteredDate", "{0:dd/MM/yyyy}") %></td>
                            <td><%# Eval("ClaimSubmittedDate", "{0:dd/MM/yyyy}") %></td>
                            <td><%# Eval("HospitalAccountNo") %></td>
                            <td><%# Eval("HospitalIFSCCode") %></td>
                            <td><%# Eval("TDSExemption") %></td>
                            <td><%# Eval("TDSPercentage") %></td>
                            <td><%# Eval("ClaimInitiatedAmount") %></td>
                            <td><%# Eval("InsurerApprovedAmount") %></td>
                            <td><%# Eval("TrustApprovedAmount") %></td>
                            <td><%# Eval("ApprovedAmount") %></td>
                            <td><%# Eval("InsurerTDSAmount") %></td>
                            <td><%# Eval("InsurerFinalAmount") %></td>
                            <td><%# Eval("TrustTdsAmount") %></td>
                            <td><%# Eval("TrustFinalAmount") %></td>
                            <td><%# Eval("BFAAmount") %></td>
                            <td><%# Eval("ClaimPayableAmount") %></td>
                            <td>
                                <textarea rows="2" cols="40" placeholder="Enter remarks here"></textarea>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
    <div class="row mt-3">
        <div class="col-md-12 text-center">
            <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-success rounded-pill" OnClick="btnSearch_Click">
                        Approved
            </asp:LinkButton>
        </div>
    </div>
</asp:Content>



