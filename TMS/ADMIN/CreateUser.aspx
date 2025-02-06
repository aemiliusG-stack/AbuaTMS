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
            <asp:HiddenField ID="hdRndNum" runat="server" />
            <asp:HiddenField ID="hdUserId" runat="server" />
            <asp:HiddenField ID="hdRoleId" runat="server" />
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
                                    <asp:TextBox ID="tbUserName" runat="server" class="form-control" ValidationGroup="a" required="True"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label>Password:</label><span class="text-danger">*</span>
                                    <asp:TextBox ID="tbPassword" TextMode="Password" class="form-control" runat="server" AutoCompleteType="Disabled" autocomplete="new-password"></asp:TextBox>
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
                                    <asp:TextBox ID="tbFullName" runat="server" class="form-control" ValidationGroup="a" required="True"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label>Address:</label>
                                    <asp:TextBox ID="tbAddress" runat="server" class="form-control" ValidationGroup="a"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label>Mobile No:</label><span class="text-danger">*</span>
                                    <asp:TextBox ID="tbMobileNo" runat="server" class="form-control" ValidationGroup="a" required="True"></asp:TextBox>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="col-md-12 text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-primary btn-rounded" ValidationGroup="a" OnClick="btnSubmit_Click" />
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" Visible="false" class="btn btn-warning btn-rounded" ValidationGroup="a" OnClick="btnUpdate_Click" />
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
                                    <asp:GridView ID="gridUserDetail" runat="server" OnRowDataBound="gridUserDetail_RowDataBound" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
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
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Role">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbRoleName" runat="server" Text='<%# Eval("RoleName") %>'></asp:Label>
                                                    <asp:Label ID="lbRoleId" runat="server" Text='<%# Eval("RoleId") %>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="District">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbDistrictName" runat="server" Text='<%# Eval("DistrictName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Hospital">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Full Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbFullName" runat="server" Text='<%# Eval("FullName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Address">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbAddress" runat="server" Text='<%# Eval("UserAddress") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Mobile No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbMobile" runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Created On">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbCreatedOn" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnDelete" runat="server"
                                                        Style="font-size: 12px;" OnClick="btnDelete_Click">
                                                        <asp:Label ID="lbStatus" runat="server" Text='<%# Eval("IsActive") %>' CssClass="btn btn-success btn-sm rounded-pill" Style="padding: 4px 15px;"></asp:Label>
                                                        <asp:Label ID="lbUserId" runat="server" Visible="false" Text='<%# Eval("UserId") %>' CssClass="btn btn-success btn-sm rounded-pill" Style="padding: 4px 15px;"></asp:Label>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnEdit" runat="server"
                                                        Style="font-size: 12px;" OnClick="btnEdit_Click">
                                                        <asp:Label ID="lbHospitalId" runat="server" Text='<%# Eval("HospitalId") %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lbDistrictId" runat="server" Text='<%# Eval("DistrictId") %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lbUserPassword" runat="server" Text='<%# Eval("UserPassword") %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="Label1" runat="server" Text='Edit' CssClass="btn btn-warning btn-sm rounded-pill" Style="padding: 4px 15px;"></asp:Label>
                                                    </asp:LinkButton>
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
