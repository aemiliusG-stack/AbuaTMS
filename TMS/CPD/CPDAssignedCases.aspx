<%@ Page Title="" Language="C#" MasterPageFile="~/CPD/CPD.master" AutoEventWireup="true" CodeFile="CPDAssignedCases.aspx.cs" Inherits="CPD_CPDAssignedCases" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <style>
        .btn-search-icon::before {
            font-family: 'Font Awesome 5 Free';
            content: '\f002';
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
                <div class="ibox-title d-flex justify-content-center text-white align-items-center">
                    <h4 class="m-0 text-center">Assigned Cases</h4>
                </div>
                <div class="ibox-content">
                    <div class="ibox-content text-dark">
                        <div class="row">
                            <div class="col-md-3">
                                <label class="form-label fw-bold" style="font-weight: 800;">Case Number</label>
                                <asp:TextBox runat="server" ID="tbCaseNumber" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold" style="font-weight: 800;">Beneficiary Card Number</label>
                                <asp:TextBox runat="server" ID="tbBeneficiaryCardNumber" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold" style="font-weight: 800;">Scheme</label>
                                <asp:DropDownList runat="server" ID="ddlScheme" CssClass="form-control">
                                    <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                    <asp:ListItem Text="MSBY(P)" Value="MSBY(P)"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold" style="font-weight: 800;">Category</label>
                                <asp:DropDownList runat="server" ID="ddCategory" CssClass="form-control" OnSelectedIndexChanged="ddCategory_SelectedIndexChanged" AutoPostBack="True">
                                    <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-3">
                                <label class="form-label fw-bold" style="font-weight: 800;">Procedure Name</label>
                                <asp:DropDownList runat="server" ID="ddProcedureName" CssClass="form-control">
                                    <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold" style="font-weight: 800;">Registered From Date</label>
                                <asp:TextBox runat="server" type="date" ID="tbFromDate" CssClass="form-control" Placeholder="Enter Date"></asp:TextBox>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold" style="font-weight: 800;">Registered To Date</label>
                                <asp:TextBox runat="server" type="date" ID="tbToDate" CssClass="form-control" Placeholder="Enter Date"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12 text-center">
                                <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="False"></asp:Label>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12 text-center">
                                <asp:LinkButton ID="btnCPDSearch" runat="server" CssClass="btn btn-success rounded-pill" OnClick="btnCPDSearch_Click">
                                   <i class="bi bi-search"></i> Search
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnCPDReset" runat="server" CssClass="btn btn-warning rounded-pill" OnClick="btnCPDReset_Click">
                                   <i class="bi bi-arrow-counterclockwise"></i> Reset
                               </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <asp:GridView ID="gridAssignedCases" runat="server" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
                    <AlternatingRowStyle BackColor="Gainsboro" />
                    <Columns>
                        <asp:TemplateField HeaderText="Sl. No." HeaderStyle-CssClass="text-center">
                            <ItemTemplate>
                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Case No" HeaderStyle-CssClass="text-center">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkCaseNo" runat="server"
                                    Text='<%# Eval("CaseNumber") %>'
                                    NavigateUrl='<%# "CPDAssignedCasePatientDetails.aspx?CaseNo=" + Eval("CaseNumber") %>'>
                                </asp:HyperLink>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Claim No" HeaderStyle-CssClass="text-center">
                            <ItemTemplate>
                                <asp:Label ID="lbClaimNo" runat="server" Text='<%# Eval("ClaimNumber") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Patient Name" HeaderStyle-CssClass="text-center">
                            <ItemTemplate>
                                <asp:Label ID="lbPatientName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Beneficiary Card Number" HeaderStyle-CssClass="text-center">
                            <ItemTemplate>
                                <asp:Label ID="lbBeneficiaryCardNo" runat="server" Text='<%# Eval("CardNumber") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Case Status" HeaderStyle-CssClass="text-center">
                            <ItemTemplate>
                                <asp:Label ID="lbCaseStatus" runat="server" Text="Procedure auto approved insurance (Insurance)"></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="25%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hospital Name" HeaderStyle-CssClass="text-center">
                            <ItemTemplate>
                                <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Registred Date" HeaderStyle-CssClass="text-center">
                            <ItemTemplate>
                                <asp:Label ID="lbRegisteredDate" runat="server" Text='<%# Eval("RegDate") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

</asp:Content>

