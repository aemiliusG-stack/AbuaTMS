<%@ Page Title="" Language="C#" MasterPageFile="~/SHA/SHA.master" AutoEventWireup="true" CodeFile="SHAClaimUpdation.aspx.cs" Inherits="SHA_SHAClaimUpdation" %>

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
                <div class="ibox-title text-center" class="bg-primary">
                    <h4 class="m-0 text-white">Claim Cases For Approval</h4>
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
    <div class="total-info row text-center">
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

    <div class="card mt-4">
        <div class="card-body">
            <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
            <div class="table-responsive mt-2">
                <asp:GridView ID="gridClaimCases" runat="server" AllowPaging="True" OnPageIndexChanging="gridClaimCases_PageIndexChanging" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
                    <AlternatingRowStyle BackColor="Gainsboro" />
                    <Columns>
                        <asp:TemplateField HeaderText="Sl. No.">
                            <ItemTemplate>
                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Case No">
                            <ItemTemplate>
                                <%--<asp:Label Visible="false" ID="lbAdmissionId" runat="server" Text='<%# Eval("AdmissionId") %>'></asp:Label>
                                <asp:Label Visible="false" ID="lbClaimId" runat="server" Text='<%# Eval("ClaimId") %>'></asp:Label>--%>
                                <asp:LinkButton ID="lnkCaseNo" runat="server" OnClick="lnkCaseNo_Click" Text='<%# Eval("CaseNumber") %>'></asp:LinkButton>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Claim Number">
                            <ItemTemplate>
                                <asp:Label ID="lbClaimNo" runat="server" Text='<%# Eval("ClaimNo") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Beneficiary Card Number">
                            <ItemTemplate>
                                <asp:Label ID="lbCardNumber" runat="server" Text='<%# Eval("BeneficiaryCardNumber") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Case Status">
                            <ItemTemplate>
                                <asp:Label ID="lbCaseStatus" runat="server" Text='<%# Eval("CaseStatus") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="HospitalName">
                            <ItemTemplate>
                                <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Registered Date">
                            <ItemTemplate>
                                <asp:Label ID="lbRegisteredDate" runat="server" Text='<%# Eval("RegisteredDate") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Claim Submitted Date">
                            <ItemTemplate>
                                <asp:Label ID="lbClaimSubmittedDate" runat="server" Text='<%# Eval("ClaimSubmittedDate") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="HospitalAccountNo">
                            <ItemTemplate>
                                <asp:Label ID="lbHospitalAccountNo" runat="server" Text='<%# Eval("HospitalAccountNo") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hospital IFSC Code">
                            <ItemTemplate>
                                <asp:Label ID="lbHospitalIFSCCode" runat="server" Text='<%# Eval("HospitalIFSCCode") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TDS Exemption">
                            <ItemTemplate>
                                <asp:Label ID="lbTDSExemption" runat="server" Text='<%# Eval("TDSExemption") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TDS Percentage">
                            <ItemTemplate>
                                <asp:Label ID="lbTDSPercentage" runat="server" Text='<%# Eval("TDSPercentage") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Claim Initiated Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbClaimInitiatedAmount" runat="server" Text='<%# Eval("ClaimInitiatedAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Insurer Approved Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbInsurerApprovedAmount" runat="server" Text='<%# Eval("InsurerApprovedAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Trust Approved Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbTrustApprovedAmount" runat="server" Text='<%# Eval("TrustApprovedAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Approved Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbApprovedAmount" runat="server" Text='<%# Eval("ApprovedAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="InsurerTDSAmount">
                            <ItemTemplate>
                                <asp:Label ID="lbInsurerTDSAmount" runat="server" Text='<%# Eval("InsurerTDSAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Insurer Final Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbInsurerFinalAmount" runat="server" Text='<%# Eval("InsurerFinalAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Trust Tds Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbTrustTdsAmount" runat="server" Text='<%# Eval("TrustTdsAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Trust Final Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbTrustFinalAmount" runat="server" Text='<%# Eval("TrustFinalAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="BFA Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbBFAAmount" runat="server" Text='<%# Eval("BFAAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Claim Payable Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbClaimPayableAmount" runat="server" Text='<%# Eval("ClaimPayableAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="SHA Exemption Remarks">
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox> 
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

