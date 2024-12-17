<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="CreateUser.aspx.cs" Inherits="Admin_CreateUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        table, th, tr, td {
            text-align: center;
            border: 1px groove;
            border-collapse: collapse;
            padding: 7px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdRndNum" runat="server" Visible="false" />
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox ">
                        <div class="ibox-title d-flex justify-content-center">
                            <h5 style="text-align: center;">Patient Registration</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                                <a class="close-link">
                                    <i class="fa fa-times"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <div class="form-group  row">
                                <div class="col-md-4">
                                    <label>Select Role:</label><span class="text-danger">*</span>
                                    <asp:DropDownList ID="dropRole" runat="server" class="form-control" Style="margin-top: 2%;" AutoPostBack="True" OnSelectedIndexChanged="dropRole_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div class="form-group  row">
                                <div class="col-md-4">
                                    <label>User Name:</label><span class="text-danger">*</span>
                                    <asp:TextBox ID="tbUserName" runat="server" class="form-control" ValidationGroup="a" required="True" OnKeypress="return isAlphaNumeric(event);"></asp:TextBox>
                                </div>
                                <div class="col-md-4" style="visibility:hidden;">
                                    <label>Password:</label><span class="text-danger">*</span>
                                    <asp:TextBox ID="tbPassword" TextMode="Password" class="form-control" runat="server" AutoCompleteType="Disabled" autocomplete="off" OnKeypress="return isPassword(event);"></asp:TextBox>
                                </div>
                            </div>
                            <br />
                            <div id="divMEDCO" runat="server" class="form-group  row">
                                <div class="col-md-4">
                                    <asp:Label ID="lbDistrict" runat="server" Text="Select District:"></asp:Label>
                                    <asp:DropDownList ID="dropDistrict" runat="server" class="form-control" Style="margin-top: 2%;" AutoPostBack="True" OnSelectedIndexChanged="dropDistrict_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="lbHospital" runat="server" Text="Select Hospital:"></asp:Label>
                                    <asp:DropDownList ID="dropHospital" runat="server" class="form-control" Style="margin-top: 2%;">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div class="form-group  row">
                                <div class="col-md-4">
                                    <label>Full Name:</label><span class="text-danger">*</span>
                                    <asp:TextBox ID="tbFullName" runat="server" class="form-control" ValidationGroup="a" required="True" OnKeypress="return isAlphabet(event);"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label>Address:</label>
                                    <asp:TextBox ID="tbAddress" runat="server" class="form-control" ValidationGroup="a" OnKeypress="return isAlphaNumericSpecial(event);"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label>Mobile No:</label><span class="text-danger">*</span>
                                    <asp:TextBox ID="tbMobileNo" runat="server" class="form-control" ValidationGroup="a" required="True" OnKeypress="return isNumeric(event);" MaxLength="10"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*Invalid Mobile No!" ControlToValidate="tbMobileNo" ForeColor="Red" ValidationExpression="^[6-9]\d{9}$" ValidationGroup="a"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="col-md-12 text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-primary btn-rounded" ValidationGroup="a" OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="ibox ">
                        <div class="ibox-title d-flex justify-content-center">
                            <h5 style="text-align: center;">User Detail</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                                <a class="close-link">
                                    <i class="fa fa-times"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <div class="form-group  row">
                                <div class="col-md-12">
                                    <asp:GridView ID="gridUserDetail" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sl No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Username">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbUsername" runat="server" Text='<%# Eval("Username") %>'></asp:Label>
                                                    <%--<asp:Label ID="lbRegNo" runat="server" Text='<%# Eval("PatientRegId") %>'></asp:Label>--%>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Role">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbDistrict" runat="server" Text='<%# Eval("RoleName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="District">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbName" runat="server" Text='<%# Eval("DistrictName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Hospital">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbCardNo" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Full Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbAddress" runat="server" Text='<%# Eval("FullName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Address">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbGender" runat="server" Text='<%# Eval("UserAddress") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Mobile No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbAge" runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Created On">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbAge" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
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
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>