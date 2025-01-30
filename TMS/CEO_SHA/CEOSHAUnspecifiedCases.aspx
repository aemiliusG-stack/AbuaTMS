<%@ Page Title="" Language="C#" MasterPageFile="~/CEO_SHA/SHA_CEO.master" AutoEventWireup="true" CodeFile="CEOSHAUnspecifiedCases.aspx.cs" Inherits="CEO_SHA_CEOSHAUnspecifiedCases" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Unspecified Cases for Approval</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Case Number</span>
                                <asp:TextBox runat="server" ID="tbCaseNo" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Beneficiary Card Number</span>
                                <asp:TextBox runat="server" ID="tbBeneficiaryCardNo" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Patient Name</span>
                                <asp:TextBox runat="server" ID="tbPatientName" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Registered From Date</span>
                                <asp:TextBox ID="tbRegisteredFromDate" runat="server" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Registered To Date</span>
                                <asp:TextBox ID="tbRegisteredToDate" runat="server" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Scheme Id</span>
                                <asp:DropDownList ID="dropSchemeId" runat="server" class="form-control mt-2">
                                    <asp:ListItem Text="ABUA-JHARKHAND" Value="1" Selected="True" />
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Category</span>
                                <asp:DropDownList ID="dropCategory" runat="server" class="form-control mt-2" AutoPostBack="true" OnSelectedIndexChanged="dropCategory_SelectedIndexChanged">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label font-bold">Procudure Name</span>
                                <asp:DropDownList ID="dropProcedureName" runat="server" class="form-control mt-2" AutoPostBack="true">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-12 text-center mt-2">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn btn-success rounded-pill" OnClick="btnSearch_Click" />
                                <asp:Button ID="btnReset" runat="server" Text="Reset" class="btn btn-warning rounded-pill" OnClick="btnReset_Click" />
                            </div>
                        </div>
                    </div>

                    <div class="card mt-4">
                        <div class="card-body table-responsive">
                            <asp:GridView ID="gvReconciliationClaim" runat="server" OnRowDataBound="gvReconciliationClaim_RowDataBound" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                <AlternatingRowStyle BackColor="Gainsboro" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Sl.No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lbSlNo" runat="server" Text=""></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Case No">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="hyperlinkCaseNo" runat="server"
                                                Text='<%# Eval("CaseNumber") %>'
                                                NavigateUrl='<%# "CEOSHAUnspecifiedPatientDetails.aspx?CaseNo=" + Eval("CaseNumber") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Claim No">
                                        <ItemTemplate>
                                            <asp:Label ID="lbClaimNo" runat="server" Text='<%# Eval("ClaimNumber") %>'></asp:Label>
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
                                            <asp:Label ID="lbRegDate" runat="server" Text='<%# Eval("AdmissionDate") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Claim Initiated Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lbClaimInitiatedAmt" runat="server" Text='<%# Eval("ClaimInitiatedAmt") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Claim Approved Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lbClaimApprovedAmt" runat="server" Text='<%# Eval("ClaimApprovedAmt") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                    </asp:TemplateField>

                                    <%-- <asp:TemplateField HeaderText="Erroneous Amount">
                       <itemtemplate>
                           <asp:Label ID="lbErroneousAmt" runat="server" Text='<%# Eval("ErroneousAmt") %>'></asp:Label>
                       </itemtemplate>
                       <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                       <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                   </asp:TemplateField>

                   <asp:TemplateField HeaderText="Erroneous Initiated Amount">
                       <itemtemplate>
                           <asp:Label ID="lbErroneousInitiatedAmt" runat="server" Text='<%# Eval("ErroneousInitiatedAmt") %>'></asp:Label>
                       </itemtemplate>
                       <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                       <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                   </asp:TemplateField>--%>
                                </Columns>
                            </asp:GridView>

                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-end">
                                    <li class="page-item disabled">
                                        <a class="page-link">Previous</a>
                                    </li>
                                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">Next</a>
                                    </li>
                                </ul>
                            </nav>

                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

