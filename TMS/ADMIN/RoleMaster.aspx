<%@ Page Title="" Language="C#" MasterPageFile="~/ADMIN/Admin.master" AutoEventWireup="true" CodeFile="RoleMaster.aspx.cs" Inherits="ADMIN_RoleMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <contenttemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdRoleId" runat="server" Visible="false" />
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Role Master</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="ibox">
                            <div class="ibox-content text-dark">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Role Name</span>
                                        <asp:TextBox runat="server" ID="tbRoleName" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-12 text-center mt-2">
                                        <asp:Button ID="btnAdd" runat="server" Text="Add Role" class="btn btn-success rounded-pill" OnClick="btnAdd_Click" />
                                        <asp:Button ID="btnUpdate" Visible="false" runat="server" Text="Update Role" class="btn btn-warning rounded-pill" OnClick="btnUpdate_Click"/>
                                        <asp:Button ID="btnReset" runat="server" Text="Reset Role" class="btn btn-danger rounded-pill" OnClick="btnReset_Click"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card mt-4">
                        <div class="card-body">
                            <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
                            <div class="table-responsive mt-2">
                                <asp:GridView ID="gridRole" runat="server" AllowPaging="True" OnPageIndexChanging="gridRole_PageIndexChanging" OnRowDataBound="gridRole_RowDataBound" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
                                    <alternatingrowstyle backcolor="Gainsboro" />
                                    <columns>
                                        <asp:TemplateField HeaderText="Sl. No.">
                                            <itemtemplate>
                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Role Name">
                                            <itemtemplate>
                                                <asp:Label ID="lbRoleName" runat="server" Text='<%# Eval("RoleName") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="40%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Created On">
                                            <itemtemplate>
                                                <asp:Label ID="lbCreatedOn" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Updated On">
                                            <itemtemplate>
                                                <asp:Label ID="lbUpdatedOn" runat="server" Text='<%# Eval("UpdatedOn") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <itemtemplate>
                                                <asp:LinkButton ID="btnDelete" runat="server"
                                                    Style="font-size: 12px;" OnClick="btnDelete_Click">
                                                    <asp:Label ID="lbStatus" runat="server" Text='<%# Eval("IsActive") %>' CssClass="btn btn-success btn-sm rounded-pill"></asp:Label>
                                                </asp:LinkButton>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action">
                                            <itemtemplate>
                                                <asp:Label ID="lbRoleId" runat="server" Text='<%# Eval("RoleId") %>' Visible="false"></asp:Label>
                                                <asp:LinkButton ID="btnEdit" runat="server"
                                                    CssClass="btn btn-warning btn-sm rounded-pill"
                                                    Style="font-size: 12px;" OnClick="btnEdit_Click">Edit
                                                </asp:LinkButton>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                        </asp:TemplateField>
                                    </columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </contenttemplate>
    </asp:UpdatePanel>
</asp:Content>

