<%@ Page Title="" Language="C#" MasterPageFile="~/ACO/ACO.master" AutoEventWireup="true" CodeFile="AssignedCases.aspx.cs" Inherits="ACO_AssignedCases" %>

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
                <div class="ibox-title d-flex justify-content-between text-white align-items-center bg-primary p-3 rounded">
                    <h4 class="m-0">Assigned Cases</h4>
                </div>
                <div class="ibox-content p-4 bg-light">
                    <!-- First Row: Case Number and Beneficiary Card Number -->
                    <div class="row mb-3">
                        <!-- Case Number -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label">Case Number</label>
                            <asp:TextBox ID="txtCaseNumber" runat="server" CssClass="form-control"
                                placeholder="Enter Case Number" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:TextBox>
                        </div>

                        <!-- Beneficiary Card Number -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label">Beneficiary Card Number</label>
                            <asp:TextBox ID="TextBeneficiaryCardNumber" runat="server" CssClass="form-control"
                                placeholder="Enter Beneficiary Card Number" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:TextBox>
                        </div>

                        <!-- Scheme -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label">Scheme <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="MSBY(P)" Value="MSBY(P)"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- Category -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label">Category <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddCategory" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="--- Select ---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- Second Row: Procedure Name and Dates -->
                    <div class="row mb-3">
                        <!-- Procedure Name -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label">Procedure Name <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddProcedureName" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="--- Select ---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- Registered From Date -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label">Registered From Date</label>
                            <asp:TextBox ID="TxtFormDate" runat="server" CssClass="form-control"
                                placeholder="Enter From Date" TextMode="Date" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:TextBox>
                        </div>

                        <!-- Registered To Date -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label">Registered To Date</label>
                            <asp:TextBox ID="TxtToDate" runat="server" CssClass="form-control"
                                placeholder="Enter To Date" TextMode="Date" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:TextBox>
                        </div>
                    </div>

                    <!-- Error Message -->
                    <div class="row mt-3">
                        <div class="col-md-12 text-center">
                            <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="False"></asp:Label>
                        </div>
                    </div>

                    <!-- Buttons for Search and Reset -->
                    <div class="row mt-3">
                        <div class="col-md-12 text-center">
                            <!-- Search Button with Icon -->
                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success rounded-pill px-4">
                                <i class="fas fa-search me-2"></i> Search
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
                            <span class="text-muted">Please use any search criteria along with Scheme to fetch data.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>



