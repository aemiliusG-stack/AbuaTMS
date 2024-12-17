<%@ Page Title="" Language="C#" MasterPageFile="~/ACO/ACO.master" AutoEventWireup="true" CodeFile="PaymentRejectedCases.aspx.cs" Inherits="ACO_PaymentRejectedCases" %>

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
             <%--<div class="ibox-title d-flex justify-content-between text-white align-items-center">
             <h4 class="m-0">Hospital Amount Recovery WorkList</h4>
         </div>--%>
             <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                 <div class="d-flex w-100 justify-content-center position-relative">
                     <h3 class="m-0">Payment Rejected Cases</h3>
                 </div>
             </div>
             <div class="ibox-content p-4 bg-light">
                 <div class="row mb-3">
                     <!-- Hospitals Name -->
                     <div class="col-md-4">
                         <label class="form-label fw-bold">Hospitals Name</label>
                         <asp:DropDownList ID="ddlHospitals" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                             <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                         </asp:DropDownList>
                         <%--<asp:DropDownList ID="ddlHospitals" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlHospitals_SelectedIndexChanged">
                             <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                         </asp:DropDownList>--%>
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
                         <%--<asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success rounded-pill" Text="Search" />--%>
                         <%--<asp:Button ID="Button1" runat="server" CssClass="btn btn-success rounded-pill" Text="Search" OnClick="btnSearch_Click" />--%>
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

<div class="table-section" style="overflow: scroll;">
    <asp:Label ID="Label1" runat="server" ForeColor="Red" Visible="false"></asp:Label>
    <table class="table table-bordered">
        <thead class="table-header">
            <tr>
                <th>S.No</th>
                <th>CasesId</th>
                <th>HospitalId</th>
                <th>Hospital Name</th>
                <th>Hospital Type</th>
                <th>Status</th>
                <th>Recent PAN No.</th>
                <th>Recent Account No.</th>
                <th>Recent Account Name</th>
                <th>Recent Bank Name</th>
                <th>Recent IFSC Code</th>
                <th>Total Rejected Amount</th>
                <th>Last update date(Finacial Details in TMS)</th>
                <th>Scheme</th>
                <th>Rejected Remarks</th>
            </tr>
        </thead>
        <tbody>
            <asp:Repeater ID="rptClaimCases" runat="server">
                <ItemTemplate>
                    <tr>
                        <td><%# Container.ItemIndex + 1 %></td>
                        <td><%# Eval("CaseNumber") %></td>
                        <td><%# Eval("HospitalId") %></td>
                        <td><%# Eval("HospitalName") %></td>
                        <td><%# Eval("HospitalType") %></td>
                        <td><%# Eval("Status") %></td>
                        <td><%# Eval("HospitalPan") %></td>
                        <td><%# Eval("AccountNumber") %></td>
                        <td><%# Eval("NameAsAppearingInBankAccount") %></td>
                        <td><%# Eval("BankName") %></td>
                        <td><%# Eval("IFSCCode") %></td>
                        <td><%# Eval("TotalPackageCost") %></td>
                        <td><%# Eval("UpdatedOn") %></td>
                        <td><%# Eval("Scheme") %></td>
                        <td><%# Eval("Remarks") %></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>
</div>

    <div class="row mt-3">
        <div class="col-md-12 text-center">
            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success rounded-pill">
              Re-Initiate Payment
            </asp:LinkButton>
            <%--<asp:Button ID="Button1" runat="server" CssClass="btn btn-success rounded-pill" Text="Search" OnClick="btnSearch_Click" />--%>
            <asp:Button ID="Button1" runat="server" CssClass="btn btn-warning rounded-pill" Text="Inform to Hospital" />
        </div>
    </div>
</asp:Content>

