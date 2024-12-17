<%@ Page Title="" Language="C#" MasterPageFile="~/CPD/CPD.master" AutoEventWireup="true" CodeFile="CPDReconciliationRequest.aspx.cs" Inherits="CPD_CPDReconciliationRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <main id="main" class="main">
        <section class="section">
            <div class="row">
                <div class="col-lg-12">
                    <form role="form" id="RecociliationClaimForm">
                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                            <div class="d-flex w-100 justify-content-center position-relative">
                                <h3 class="m-0">Reconciliation Claim Cases for Updation</h3>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <div class="ibox">
                                <div class="ibox-content text-dark">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Case Number</span>
                                            <asp:TextBox ID="tbCaseNumber" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
                                        </div>
                                        <div class="col-md-3">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Beneficiary Card Number</span>
                                            <asp:TextBox ID="tbBeneficiaryNo" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Registered From Date</span>
                                            <asp:TextBox ID="tbRegFromDate" runat="server" CssClass="form-control" OnKeyPress="return isDate(event)" TextMode="Date"></asp:TextBox>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Registered To Date</span>
                                            <asp:TextBox ID="tbRegToDate" runat="server" CssClass="form-control" OnKeyPress="return isDate(event)" TextMode="Date"></asp:TextBox>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Scheme Id</span>
                                            <asp:DropDownList ID="ddSchemeId" runat="server" class="form-control" AutoPostBack="True" ControlToValidate="ddSchemeId"></asp:DropDownList>
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Category</span>
                                            <asp:DropDownList ID="ddCategory" runat="server" class="form-control" OnSelectedIndexChanged="ddCategory_SelectedIndexChanged" AutoPostBack="True" ControlToValidate="ddCategor"></asp:DropDownList>
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Procedure Name</span>
                                            <asp:DropDownList ID="ddProcedureName" runat="server" class="form-control" AutoPostBack="True"></asp:DropDownList>
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                        </div>
                                        <div class="text-center mt-5 col-lg-12">
                                            <asp:Button ID="btnCPDSearch" type="button" class="btn btn-success" runat="server" Text="Search" OnClick="btnCPDSearch_Click" />
                                            <asp:Button ID="btnCPDReset" type="reset" class="btn btn-warning" runat="server" Text="Reset" OnClick="btnCPDReset_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <h5 class="card-title">Displaying Records:</h5>
                    <div class="card mt-4">
                        <div class="card-body table-responsive">
                            <asp:GridView ID="gvReconciliationClaim" runat="server"
                                OnRowDataBound="gvReconciliationClaim_RowDataBound"
                                AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
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
                                                NavigateUrl='<%# "CPDReconciliationPatientDetail.aspx?CaseNumber=" + Convert.ToString(Eval("CaseNumber")) %>' />
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
        </section>
    </main>
</asp:Content>

