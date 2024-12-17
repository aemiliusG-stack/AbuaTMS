<%@ Page Title="" Language="C#" MasterPageFile="~/CEX/CEX.master" AutoEventWireup="true" CodeFile="CEXCaseSearch.aspx.cs" Inherits="CEX_CEXCaseSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <div class="ibox-title text-center">
                <h3 class="text-white">Case Search</h3>
            </div>
            <div class="ibox-content">
                <div class="ibox">
                    <div class="ibox-content text-dark">
                        <div class="row">
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="tbCaseNo" CssClass="form-label font-bold" Style="font-size: 14px;" Text="Case Number" />
                                <asp:TextBox ID="tbCaseNo" runat="server" OnKeypress="return isAlphaNumeric(event)" CssClass="form-control border-0 border-bottom" />
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="tbBeneficiaryCardNo" CssClass="form-label font-bold" Style="font-size: 14px;" Text="Beneficiary Card No." />
                                <asp:TextBox ID="tbBeneficiaryCardNo" runat="server" OnKeypress="return isNumeric(event)" CssClass="form-control border-0 border-bottom" />
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropPatientState" CssClass="form-label font-bold" Style="font-size: 14px;">Patient State</asp:Label><br />
                                <asp:DropDownList ID="DropPatientState" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropDistrict" CssClass="form-label font-bold" Style="font-size: 14px;">District</asp:Label><br />
                                <asp:DropDownList ID="DropDistrict" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropCaseType" CssClass="form-label font-bold" Style="font-size: 14px;">Case Type</asp:Label><br />
                                <asp:DropDownList ID="DropCaseType" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Insurer" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="dropScheme" CssClass="form-label font-bold" Style="font-size: 14px;">Scheme</asp:Label><br />
                                <asp:DropDownList ID="dropScheme" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropHospitalState" CssClass="form-label font-bold" Style="font-size: 14px;">Hospital State</asp:Label><br />
                                <asp:DropDownList ID="DropHospitalState" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropHospitalName" CssClass="form-label font-bold" Style="font-size: 14px;">Hospital Name</asp:Label><br />
                                <asp:DropDownList ID="DropHospitalName" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropCategory" CssClass="form-label font-bold" Style="font-size: 14px;">Category</asp:Label><br />
                                <asp:DropDownList ID="DropCategory" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropProcedureName" CssClass="form-label font-bold" Style="font-size: 14px;">Procedure Name</asp:Label><br />
                                <asp:DropDownList ID="DropProcedureName" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropCaseStatus" CssClass="form-label font-bold" Style="font-size: 14px;">Case Status</asp:Label><br />
                                <asp:DropDownList ID="DropCaseStatus" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropCaseStatus" CssClass="form-label font-bold" Style="font-size: 14px;">Case Status</asp:Label><br />
                                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropPolicyPeriod" CssClass="form-label font-bold" Style="font-size: 14px;">Policy Period</asp:Label><br />
                                <asp:DropDownList ID="DropPolicyPeriod" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropPolicyPeriod" CssClass="form-label font-bold" Style="font-size: 14px;">UTR</asp:Label><br />
                                <asp:TextBox ID="tbUTR" runat="server" OnKeypress="return isAlphaNumeric(event)" CssClass="form-control border-0 border-bottom" />
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropHosDistrict" CssClass="form-label font-bold" Style="font-size: 14px;">Hospital District</asp:Label><br />
                                <asp:DropDownList ID="DropHosDistrict" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropRecordPeriod" CssClass="form-label font-bold" Style="font-size: 14px;">Record Period</asp:Label><br />
                                <asp:DropDownList ID="DropRecordPeriod" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropSpecialCase" CssClass="form-label font-bold" Style="font-size: 14px;">Special Case</asp:Label><br />
                                <asp:DropDownList ID="DropSpecialCase" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="DropSpecialCase" CssClass="form-label font-bold" Style="font-size: 14px;">Advance Search Parameter</asp:Label><br />
                                <asp:DropDownList ID="DropAdSearchParameter" runat="server" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="tbRegisteredFromDate" CssClass="form-label font-bold" Style="font-size: 14px;" Text="From Date" />
                                <asp:TextBox ID="tbRegisteredFromDate" runat="server" OnKeypress="return isDate(event)" CssClass="form-control border-0 border-bottom" TextMode="Date" />
                            </div>
                            <div class="col-md-3 mt-3">
                                <asp:Label runat="server" AssociatedControlID="tbRegisteredToDate" CssClass="form-label font-bold" Style="font-size: 14px;" Text="To Date" />
                                <asp:TextBox ID="tbRegisteredToDate" runat="server" OnKeypress="return isDate(event)" CssClass="form-control border-0 border-bottom" TextMode="Date" />
                            </div>

                            <div class="col-lg-12 text-center mt-3">
                                <span class="text-danger font-weight-bold">Report will be generated for maximum of 90 days</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12 text-center mt-3">
                        <asp:Button runat="server" CssClass="btn btn-success rounded-pill" Text="Search" />
                        <asp:Button runat="server" CssClass="btn btn-warning rounded-pill" Text="Reset" />
                    </div>
                </div>
            </div>
            <div class="ibox-content text-dark font-weight-bold mt-3 border-0 text-center">
                <span>Please use any search criteria Along with Scheme to fetch data</span>
            </div>
            <div class="card mt-3">
                <div class="card-body table-responsive">
                    <asp:GridView ID="gridRegisteredPatient" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                        <AlternatingRowStyle BackColor="Gainsboro" />
                        <Columns>
                            <asp:TemplateField HeaderText="Sl No.">
                                <ItemTemplate>
                                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Registration No.">
                                <ItemTemplate>
                                    <asp:Label ID="lbRegId" runat="server" Text='<%# Eval("PatientRegId") %>' Visible="false"></asp:Label>
                                    <asp:LinkButton ID="lnkRegId" runat="server"><%# Eval("PatientRegId") %></asp:LinkButton>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Patient Name">
                                <ItemTemplate>
                                    <asp:Label ID="lbName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Beneficiary Card No.">
                                <ItemTemplate>
                                    <asp:Label ID="lbCardNo" runat="server" Text='<%# Eval("CardNumber") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="District">
                                <ItemTemplate>
                                    <asp:Label ID="lbDistrict" runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Address">
                                <ItemTemplate>
                                    <asp:Label ID="lbAddress" runat="server" Text='<%# Eval("PatientAddress") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Gender">
                                <ItemTemplate>
                                    <asp:Label ID="lbGender" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Age">
                                <ItemTemplate>
                                    <asp:Label ID="lbAge" runat="server" Text='<%# Eval("Age") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Registration Date">
                                <ItemTemplate>
                                    <asp:Label ID="lbRegDate" runat="server" Text='<%# Eval("RegDate") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Print">
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cancel">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDeletePatient" runat="server" CssClass="text-danger">Remove</asp:LinkButton>
                                </ItemTemplate>
                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

