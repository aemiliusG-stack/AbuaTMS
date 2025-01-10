<%@ Page Title="" Language="C#" MasterPageFile="~/ADMIN/Admin.master" AutoEventWireup="true" CodeFile="MapPackageAddon.aspx.cs" Inherits="ADMIN_MapPackageAddon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdAddOnId" runat="server" Visible="false" />
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox ">
                        <div class="ibox-title d-flex justify-content-center">
                            <h5 style="text-align: center;">Add Package AddOn</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <div class="form-group row">
                                <div class="col-md-3">
                                    <label class="form-label fw-bold" style="font-weight: 800;">Speciality Name</label><span class="text-danger">*</span>
                                    <asp:DropDownList runat="server" ID="ddSpecialityName" CssClass="form-control border-0 border-bottom" AutoPostBack="true">
                                        <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fw-bold" style="font-weight: 800;">Procedure Code</label><span class="text-danger">*</span>
                                    <asp:DropDownList runat="server" ID="ddProcedureCode" CssClass="form-control border-0 border-bottom">
                                        <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="hr-line-dashed mt-4"></div>
                            <div class="col-md-12 text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Add " class="btn btn-primary btn-rounded" ValidationGroup="a" OnClick="btnSubmit_Click" />
                                <asp:Button ID="btnUpdate" runat="server" Text="Update " class="btn btn-warning btn-rounded" ValidationGroup="a" Visible="false" OnClick="btnUpdate_Click" />
                                <asp:Button ID="btnReset" runat="server" Text="Reset" class="btn btn-danger btn-rounded" ValidationGroup="a" OnClick="btnReset_Click" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="ibox ">
                        <div class="ibox-title d-flex justify-content-center">
                            <h5 style="text-align: center;">Mapped Package AddOn Record</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <div class="form-group row">
                                <div class="col-md-10"></div>
                                <div class="col-md-2 d-flex text-end">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Search..."></asp:TextBox>
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                                </div>
                            </div>
                            <div class="form-group  row">
                                <div class="col-md-12">
                                    <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
                                    <asp:GridView ID="gridPackageAddOn" runat="server" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="gridPackageAddOn_PageIndexChanging" PageSize="10" OnRowCommand="gridPackageAddOn_RowCommand" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sl No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" CssClass="text-center" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Speciality">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbSpeciality" runat="server" Text='<%# Eval("Speciality") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" CssClass="text-center" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Procedure Code">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbActionName" runat="server" Text='<%# Eval("ProcedureCode") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" CssClass="text-center" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Procedure Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbActionName" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" CssClass="text-center" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Created On">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" CssClass="text-center" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Package AddOn Status">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnActiveStatus" runat="server" Text='<%# Eval("IsActive") %>' OnClientClick="return confirmAction();" CommandArgument='<%# Eval("PackageAddOnId") %>' CssClass='<%# Eval("IsActive").ToString() == "Active" ? "btn btn-success rounded-pill" : "btn btn-danger rounded-pill" %>' OnClick="btnActiveStatus_Click" />
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" CssClass="text-center" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server"
                                                        CommandName="EditAddOn" CommandArgument='<%# Eval("PackageAddOnId") %>'
                                                        CssClass="btn btn-success btn-sm rounded-pill"
                                                        Style="font-size: 12px;">
                                                        <span class="bi bi-pencil"></span>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" CssClass="text-center" ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
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
    <script type="text/javascript">
        function confirmAction() {
            var result = confirm("Are you sure you want to change the status?");
            if (result) {
                return true;
            }
            return false;
        }
    </script>
</asp:Content>

