<%@ Page Title="" Language="C#" MasterPageFile="~/CPD/CPD.master" AutoEventWireup="true" CodeFile="CPDCaseSearch.aspx.cs" Inherits="CPD_CPDCaseSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        window.onload = function () {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById('<%= tbToDate.ClientID %>').setAttribute('max', today);
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-lg-12">
                    <form role="form" id="CPDCaseSearchForm">
                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                            <div class="d-flex w-100 justify-content-center position-relative">
                                <h3 class="m-0">Case Search</h3>
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
                                            <asp:TextBox ID="tbCardNumber" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
                                        </div>
                                        <div class="col-md-3">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Patient State</span><span class="text-danger">*</span><br />
                                            <asp:DropDownList ID="ddPatientState" runat="server" class="form-control" AutoPostBack="True" ControlToValidate="dropCPDPatientState" OnSelectedIndexChanged="dropPatientState_SelectedIndexChanged"></asp:DropDownList>
                                        </div>

                                        <div class="col-md-3">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">District</span><br />
                                            <asp:DropDownList ID="ddPatientDistrict" runat="server" class="form-control" AutoPostBack="True" ControlToValidate="dropCPDDistrict"></asp:DropDownList>
                                        </div>

                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Case Type</span><span class="text-danger">*</span><br />
                                            <asp:DropDownList ID="ddCaseType" runat="server" class="form-control" AutoPostBack="True" ControlToValidate="dropCPDCaseType">
                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Insurer" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Trust" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="All" Value="3"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Scheme</span><span class="text-danger">*</span><br />
                                            <asp:DropDownList ID="ddScheme" runat="server" class="form-control">
                                                <asp:ListItem Text="ABUA-JHARKHAND" Value="1" Selected="True" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Hospital State</span><span class="text-danger">*</span><br />
                                            <asp:DropDownList ID="ddHospitalState" runat="server" class="form-control" OnSelectedIndexChanged="dropHospitalState_SelectedIndexChanged" AutoPostBack="True" ControlToValidate="dropCPDHospitalState"></asp:DropDownList>

                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Hospital Name</span><span class="text-danger">*</span><br />
                                            <asp:DropDownList ID="ddHospitalName" runat="server" class="form-control" AutoPostBack="True" ControlToValidate="dropHospitalName"></asp:DropDownList>
                                        </div>

                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Category</span><span class="text-danger">*</span><br />
                                            <asp:DropDownList ID="ddCategory" runat="server" class="form-control" OnSelectedIndexChanged="ddCategory_SelectedIndexChanged" AutoPostBack="True" ControlToValidate="ddCategor"></asp:DropDownList>
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Procedure Name</span><span class="text-danger">*</span><br />
                                            <asp:DropDownList ID="ddProcedureName" runat="server" class="form-control" AutoPostBack="True" ControlToValidate="dropProcedureName"></asp:DropDownList>
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>

                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Case Status</span><span class="text-danger">*</span><br />
                                            <asp:DropDownList ID="ddCaseStatus" runat="server" class="form-control" AutoPostBack="True" ControlToValidate="dropCaseStatus"></asp:DropDownList>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Policy Period</span><span class="text-danger">*</span><br />
                                            <asp:DropDownList ID="ddPolicyPeriod" runat="server" class="form-control" AutoPostBack="True">
                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="PS-1" Value="1"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">UTR</span><span class="text-danger">*</span><br />
                                            <asp:TextBox ID="tbUTR" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Hospital District</span><span class="text-danger">*</span><br />
                                            <asp:DropDownList ID="ddHospitalDistrict" runat="server" class="form-control" AutoPostBack="True" ControlToValidate="dropHospitalDistrict"></asp:DropDownList>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Record Period</span><span class="text-danger">*</span><br />
                                            <asp:DropDownList ID="ddRecordPeriod" runat="server" class="form-control" AutoPostBack="True" ControlToValidate="dropRecordPeriod"></asp:DropDownList>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Special Case</span><span class="text-danger">*</span><br />
                                            <asp:DropDownList ID="ddSpecialCase" runat="server" class="form-control" AutoPostBack="True">
                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Advance Search Parameter</span><span class="text-danger">*</span><br />
                                            <asp:DropDownList ID="ddSearchParameter" runat="server" class="form-control" AutoPostBack="True">
                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Discharge Date" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Surgery Date" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="Preauth Initiation Date" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="Registered Date" Value="4"></asp:ListItem>
                                                <asp:ListItem Text="Claim Date" Value="5"></asp:ListItem>
                                                <asp:ListItem Text="Preauth Approved Date" Value="6"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">From Date</span><span class="text-danger">*</span><br />
                                            <asp:TextBox ID="tbFromDate" runat="server" CssClass="form-control" OnKeyPress="return isDate(event)" TextMode="Date"></asp:TextBox>
                                        </div>
                                        <div class="col-md-3 mt-2">
                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">To Date</span><span class="text-danger">*</span><br />
                                            <asp:TextBox ID="tbToDate" runat="server" CssClass="form-control" OnKeyPress="return isDate(event)" TextMode="Date"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6 mt-2">
                                            <p class="m-0 text-danger">Note: Report will be generated for maximum of 90 days.</p>
                                        </div>
                                        <div class="text-center mt-5">
                                            <asp:LinkButton ID="btnCPDSearch" runat="server" CssClass="btn btn-success rounded-pill" OnClick="btnCPDSearch_Click">
                                                <i class="bi bi-search"></i>Search
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnCPDReset" runat="server" CssClass="btn btn-warning rounded-pill" OnClick="btnCPDReset_Click1">
                                                <i class="bi bi-arrow-counterclockwise"></i>Reset
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="card mt-4">
                        <div class="card-body table-responsive">
                            <h5 class="card-title">Total No Of Records</h5>
                            <asp:GridView ID="gvCaseSearch" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%" OnRowDataBound="gvCaseSearch_RowDataBound">
                                <AlternatingRowStyle BackColor="Gainsboro" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Sl.No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lbSlNo" runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Case No">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="hyperlinkCaseNo" runat="server"
                                                Text='<%# Eval("CaseNumber") %>'
                                                NavigateUrl='<%# "CPDcaseSearchPatientDetail.aspx?CaseNo=" + Eval("CaseNumber") %>' />
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
                                    <asp:TemplateField HeaderText="Patient Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lbPatientName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Contact No">
                                        <ItemTemplate>
                                            <asp:Label ID="lbContactNo" runat="server" Text='<%# Eval("ContactNumber") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Beneficiary Card Number">
                                        <ItemTemplate>
                                            <asp:Label ID="lbBeneficiaryNo" runat="server" Text='<%# Eval("BeneficiaryCardNo") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="Case Status">
                                <ItemTemplate>
                                    <asp:Label ID="lbCaseStatus" runat="server" Text='<%# Eval("CaseStatus") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Hospital Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Patient Registration Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lbPatientRegDate" runat="server" Text='<%# Eval("PatientRegistrationDate") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:Panel ID="paginationPanel" runat="server" Visible="false">
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
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

