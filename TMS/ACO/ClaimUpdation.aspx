<%@ Page Title="" Language="C#" MasterPageFile="~/ACO/ACO.master" AutoEventWireup="true" CodeFile="ClaimUpdation.aspx.cs" Inherits="ACO_ClaimUpdation" %>

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
    <asp:HiddenField ID="hdInsurerAmount" runat="server" Visible="false" />
    <asp:HiddenField ID="hdTrustAmount" runat="server" Visible="false" />
    <asp:HiddenField ID="hdClaimId" runat="server" Visible="false" />
    <asp:HiddenField ID="hdRemarks" runat="server" Visible="false" />
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
                            <asp:Label ID="lblSuccess" runat="server" CssClass="text-danger" Visible="False"></asp:Label>
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
    <div class="col-lg-12">
        <div class="ibox-content">
            <div class="form-group  row">
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
                            <asp:TemplateField HeaderText="Checkbox">
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chkSelectAll" runat="server" OnCheckedChanged="chkSelectAll_CheckedChanged" AutoPostBack="True" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbClaimId" runat="server" Text='<%# Eval("ClaimId") %>' Visible="false"></asp:Label>
                                    <asp:CheckBox ID="cbCheckbox" runat="server" OnCheckedChanged="cbCheckbox_CheckedChanged" AutoPostBack="True" />
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Claim Id" Visible="False">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hfClaimId" runat="server" Value='<%# Eval("ClaimId") %>' />
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </asp:TemplateField>--%>

                            <asp:TemplateField HeaderText="Case No">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hlCaseNumber" runat="server"
                                        NavigateUrl='<%# "CaseDetails.aspx?CaseNumber=" + Eval("CaseNumber") %>'>
                                            <%# Eval("CaseNumber") %>
                                    </asp:HyperLink>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Beneficiary CardNumber">
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
                            <asp:TemplateField HeaderText="Claim Submited Date">
                                <ItemTemplate>
                                    <asp:Label ID="lbClaimSubmittedDate" runat="server" Text='<%# Eval("ClaimSubmittedDate") %>'></asp:Label>
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
                            <asp:TemplateField HeaderText="TDS Exemption(Y/N)">
                                <ItemTemplate>
                                    <asp:Label ID="lbTDSExemption" runat="server" Text='<%# Eval("TDSExemption") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="4%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TDS Percentage">
                                <ItemTemplate>
                                    <asp:Label ID="lbTDSPercentage" runat="server" Text='<%# Eval("TDSPercentage") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="4%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Claim Initiated Amount(Rs.)">
                                <ItemTemplate>
                                    <asp:Label ID="lbClaimInitiatedAmount" runat="server" Text='<%# Eval("ClaimInitiatedAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Approved Amount(Ins)(Rs.)">
                                <ItemTemplate>
                                    <asp:Label ID="lbInsurerApprovedAmount" runat="server" Text='<%# Eval("InsurerApprovedAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Approved Amount(Trust)(Rs.)">
                                <ItemTemplate>
                                    <asp:Label ID="lbTrustApprovedAmount" runat="server" Text='<%# Eval("TrustApprovedAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Approved Amount(Rs.)">
                                <ItemTemplate>
                                    <asp:Label ID="lbApprovedAmount" runat="server" Text='<%# Eval("ApprovedAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tds Amount(Ins)(Rs.)">
                                <ItemTemplate>
                                    <asp:Label ID="lbInsurerTDSAmount" runat="server" Text='<%# Eval("InsurerTDSAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Final Amount(Ins)(Rs.)">
                                <ItemTemplate>
                                    <asp:Label ID="lbInsurerFinalAmount" runat="server" Text='<%# Eval("InsurerFinalAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tds Amount(Trust)(Rs.)">
                                <ItemTemplate>
                                    <asp:Label ID="lbTrustTdsAmount" runat="server" Text='<%# Eval("TrustTdsAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Final Amount(Trust)(Rs.)">
                                <ItemTemplate>
                                    <asp:Label ID="lbTrustFinalAmount" runat="server" Text='<%# Eval("TrustFinalAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="BFA Amount(Trust)(Rs.)">
                                <ItemTemplate>
                                    <asp:Label ID="lbBFAAmount" runat="server" Text='<%# Eval("BFAAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Claim Payable Amount(Rs.)">
                                <ItemTemplate>
                                    <asp:Label ID="ClaimPayableAmount" runat="server" Text='<%# Eval("ClaimPayableAmount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ACO Exemption Remarks">
                                <ItemTemplate>
                                    <asp:TextBox ID="tbExemptionRemarks" runat="server" class="form-control" TextMode="MultiLine"></asp:TextBox>
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


    <div class="row mt-3">
        <div class="col-md-12 text-center">
            <asp:LinkButton ID="btnApprove" runat="server" CssClass="btn btn-success" OnClick="btnApprove_Click">
                    <i class="fas fa-check"></i> Approve
            </asp:LinkButton>

        </div>
    </div>
</asp:Content>

