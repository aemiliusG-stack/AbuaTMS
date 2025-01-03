<%@ Page Title="" Language="C#" MasterPageFile="~/ACO/ACO.master" AutoEventWireup="true" CodeFile="MISHybridPaymentReport.aspx.cs" Inherits="ACO_MISHybridPaymentReport" %>

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
                     <h3 class="m-0">Hybrid Claim Payment Report</h3>
                 </div>
             </div>
             <div class="ibox-content p-4 bg-light">
                 <div class="row mb-3">
                     <!--  From Date -->
                     <div class="col-md-4">
                         <label class="form-label fw-bold">From Date</label>
                         <asp:TextBox ID="tbRegisteredFromDate" runat="server" OnKeypress="return isDate(event)" CssClass="form-control" TextMode="Date" Style="border: none; border-bottom: 2px solid #D3D3D3;" />
                     </div>
                     <!--  To Date -->
                     <div class="col-md-4">
                         <label class="form-label fw-bold">To Date</label>
                         <asp:TextBox ID="toDate" runat="server" OnKeypress="return isDate(event)" CssClass="form-control" TextMode="Date" Style="border: none; border-bottom: 2px solid #D3D3D3;" />
                     </div>
                 </div>
                 <div class="row mb-3">
                     <!-- Patient State -->
                     <div class="col-md-4">
                         <label class="form-label fw-bold">Patient State</label>
                         <asp:DropDownList ID="DropDownListPatientState" runat="server" CssClass="form-control" AppendDataBoundItems="True" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                             <asp:ListItem Text="Select State" Value="0"></asp:ListItem>
                             <asp:ListItem Text="Jharkhand" Value="1" Selected="True"></asp:ListItem>
                         </asp:DropDownList>
                     </div>
                     <!-- Scheme -->
                     <div class="col-md-6 col-lg-3 mb-3">
                         <label class="form-label fw-bold">Scheme:<span style="color: red;">*</span></label>
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
                         <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-warning rounded-pill" OnClick="btnReset_Click">
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
</asp:Content>

