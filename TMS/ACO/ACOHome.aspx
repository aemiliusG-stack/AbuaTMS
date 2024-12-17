<%@ Page Title="" Language="C#" MasterPageFile="~/ACO/ACO.master" AutoEventWireup="true" CodeFile="ACOHome.aspx.cs" Inherits="ACO_ACOHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <style>
        .btn-search-icon::before {
            font-family: 'Font Awesome 5 Free';
            content: '\f002'; /* Unicode for search icon */
            margin-right: 5px;
            font-weight: 900;
        }
        /*add nothing*/
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <div class="ibox">
                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                    <h4 class="m-0">Case Search</h4>
                </div>
                <div class="ibox-content p-4 bg-light">
                    <div class="row mb-3">
                        <!-- Case Number -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label">Case Number</label>
                            <asp:TextBox ID="txtCaseNumber" runat="server" CssClass="form-control"
                                placeholder="Enter Case Number" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:TextBox>
                        </div>
                        <div class="col-md-6 col-lg-3 mb-3"">
                            <label class="form-label fw-bold">Beneficiary Card Number</label>
                            <asp:TextBox ID="TextBeneficiaryCardNumber" runat="server" CssClass="form-control"
                                placeholder="Enter Beneficiary Card Number"
                                Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:TextBox>
                        </div>
                        <!-- Patient State -->
                        <div class="col-md-6 col-lg-3 mb-3"">
                            <label class="form-label fw-bold">Patient State<span style="color: red;">*</span></label>
                            <asp:DropDownList ID="ddlPatientState" runat="server" CssClass="form-control">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- District -->
                        <div class="col-md-6 col-lg-3 mb-3"">
                            <label class="form-label fw-bold">District</label>
                            <asp:DropDownList ID="DropDownListDistricts" runat="server" CssClass="form-control" AppendDataBoundItems="True">
                                <%--<asp:ListItem Text="---select---" Value=""></asp:ListItem>--%>
                                <asp:ListItem Text="Select District" Value="0"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <!-- Type -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Case Type<span style="color: red;">*</span></label>
                            <asp:DropDownList ID="ddlCaseTypeS" runat="server" CssClass="form-control">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Scheme -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Scheme <span style="color: red;">*</span></label>
                            <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control">
                                <asp:ListItem Text="MSBY(P)" Value="MSBY(P)"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Hospital State -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Hospital State <span style="color: red;">*</span></label>
                            <asp:DropDownList ID="ddHospitalState" runat="server" CssClass="form-control">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Hospital Name -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Hospital Name</label>
                            <asp:DropDownList ID="ddHospitalName" runat="server" CssClass="form-control">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <!-- Category -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Category</label>
                            <asp:DropDownList ID="ddCategory" runat="server" CssClass="form-control">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Procedure Name -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Procedure Name</label>
                            <asp:DropDownList ID="ddProcedureName" runat="server" CssClass="form-control">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Case Status -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Case Status</label>
                            <asp:DropDownList ID="ddCaseStatus" runat="server" CssClass="form-control">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Policy Period -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Policy Period</label>
                            <asp:DropDownList ID="ddPolicyPeriod" runat="server" CssClass="form-control">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <!-- UTR -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">UTR</label>
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"
                                placeholder="Enter UTR Number"
                                Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:TextBox>
                        </div>
                        <!-- Hospital District -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Hospital District</label>
                            <asp:DropDownList ID="ddHospitalDistrict" runat="server" CssClass="form-control">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Record Period -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Record Period</label>
                            <asp:DropDownList ID="ddRecordPeriod" runat="server" CssClass="form-control">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Special Cases -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Special Cases</label>
                            <asp:DropDownList ID="ddSpecialCases" runat="server" CssClass="form-control">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <!-- Advanced Search Cases -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Advanced Search Cases</label>
                            <asp:DropDownList ID="ddAdvancedSearchCases" runat="server" CssClass="form-control">
                                <asp:ListItem Text="---select---" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Form Date -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Form Date</label>
                            <asp:TextBox ID="TxtFormDate" runat="server" CssClass="form-control"
                                placeholder="Enter Date" TextMode="Date"
                                Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:TextBox>
                        </div>
                        <!-- To Date -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">To Date</label>
                            <asp:TextBox ID="TxtToDate" runat="server" CssClass="form-control"
                                placeholder="Enter Date" TextMode="Date"
                                Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:TextBox>
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
                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success rounded-pill">
                                    <i class="fas fa-search"></i> Search
                            </asp:LinkButton>
                            <%--<asp:Button ID="Button1" runat="server" CssClass="btn btn-success rounded-pill" Text="Search" OnClick="btnSearch_Click" />--%>
                            <asp:Button ID="btnReset" runat="server" CssClass="btn btn-warning rounded-pill" Text="Reset" />
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
    <%--<asp:GridView ID="gvCaseSearch" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
        <AlternatingRowStyle BackColor="Gainsboro" />
        <Columns>
            <asp:TemplateField HeaderText="Sl.No.">
                <ItemTemplate>
                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Case No">
                <ItemTemplate>
                    <asp:HyperLink ID="hyperlinkCaseNo" runat="server"
                        Text='<%# Eval("CaseNo") %>'
                        NavigateUrl='<%# "ACOCaseSearchPatientDetails.aspx?CaseNo=" & Eval("CaseNo") %>'>
                 </asp:HyperLink>
                </ItemTemplate>
                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Claim No">
                <ItemTemplate>
                    <asp:Label ID="lbClaimNo" runat="server" Text='<%# Eval("ClaimNo") %>'></asp:Label>
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

            <asp:TemplateField HeaderText="Patient Registration Date">
                <ItemTemplate>
                    <asp:Label ID="lbPatientRegDate" runat="server" Text='<%# Eval("PatientRegistrationDate") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>--%>



    <%--<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered">
        <Columns>
            <asp:TemplateField HeaderText="S.No.">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Hospital Code">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkHospitalCode" runat="server"
                        NavigateUrl='<%# "HospitalDetails.aspx?HospitalId=" + Eval("HospitalId") %>'
                        NavigateUrl='<%# "ACOCaseSearchPatientDetails.aspx?CaseNo=" & Eval("CaseNo") %>'>'
                        Text='<%# Eval("HospitalId") %>'>
                    </asp:HyperLink>

                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="HospitalName" HeaderText="Name" />
            <asp:BoundField DataField="HospitalType" HeaderText="Type" />
            <asp:BoundField DataField="District" HeaderText="District" />
        </Columns>
    </asp:GridView>--%>
</asp:Content>

