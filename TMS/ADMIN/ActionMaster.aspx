<%@ Page Title="" Language="C#" MasterPageFile="~/ADMIN/Admin.master" AutoEventWireup="true" CodeFile="ActionMaster.aspx.cs" Inherits="ADMIN_ActionMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <contenttemplate>
            <asp:HiddenField ID="hdRndNum" runat="server" Visible="false" />
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdActionId" runat="server" Visible="false" />
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox ">
                        <div class="ibox-title d-flex justify-content-center">
                            <h5 style="text-align: center;">Add Action</h5>
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
                            <div class="form-group row">
                                <!-- Action Name -->
                                <div class="col-md-4 text-dark font-bold">
                                    <label class="text-dark font-bold">Action Name:</label><span class="text-danger">*</span>
                                    <asp:TextBox ID="tbActionName" runat="server" class="form-control" ValidationGroup="a" OnKeypress="return isAlphaNumeric(event);"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group text-center text-dark font-bold">
                                <h4 class="mb-4">Configure Action Permissions</h4>
                            </div>

                            <div class="form-group row justify-content-center text-dark font-bold">
                                <!-- PPD Checkbox -->
                                <div class="col-md-2 mb-3 d-flex align-items-center text-dark justify-content-center">
                                    <asp:CheckBox ID="chkPPD" runat="server" Text="&nbsp;&nbsp;&nbsp;PPD" class="mr-2" />
                                </div>

                                <!-- CEX Checkbox -->
                                <div class="col-md-2 mb-3 d-flex align-items-center text-dark justify-content-center">
                                    <asp:CheckBox ID="chkCEX" runat="server" Text="&nbsp;&nbsp;&nbsp;CEX" class="mr-2" />
                                </div>

                                <!-- CPD Checkbox -->
                                <div class="col-md-2 mb-3 d-flex align-items-center text-dark justify-content-center">
                                    <asp:CheckBox ID="chkCPD" runat="server" Text="&nbsp;&nbsp;&nbsp;CPD" class="mr-2" />
                                </div>

                                <!-- ACO Checkbox -->
                                <div class="col-md-2 mb-3 d-flex align-items-center text-dark justify-content-center">
                                    <asp:CheckBox ID="chkACO" runat="server" Text="&nbsp;&nbsp;&nbsp;ACO" class="mr-2" />
                                </div>

                                <!-- SHA Checkbox -->
                                <div class="col-md-2 mb-3 d-flex align-items-center text-dark justify-content-center">
                                    <asp:CheckBox ID="chkSHA" runat="server" Text="&nbsp;&nbsp;&nbsp;SHA" class="mr-2" />
                                </div>
                            </div>

                            <div class="hr-line-dashed mt-4"></div>


                            <div class="col-md-12 text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Add Action" class="btn btn-primary btn-rounded" ValidationGroup="a" OnClick="btnSubmit_Click" />
                                <asp:Button ID="btnUpdate" runat="server" Text="Update Action" class="btn btn-warning btn-rounded" ValidationGroup="a" OnClick="btnUpdate_Click" Visible="false" />
                                <asp:Button ID="btnReset" runat="server" Text="Reset" class="btn btn-danger btn-rounded" ValidationGroup="a" OnClick="btnReset_Click" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="ibox ">
                        <div class="ibox-title d-flex justify-content-center">
                            <h5 style="text-align: center;">Action Record</h5>
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
                                    <asp:GridView ID="gridActionDetail" runat="server" AutoGenerateColumns="False" BackColor="White" AllowPaging="True" OnPageIndexChanging="gridActionDetail_PageIndexChanging" PageSize="10" OnRowCommand="gridActionDetail_RowCommand" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                        <alternatingrowstyle backcolor="Gainsboro" />
                                        <columns>
                                            <asp:TemplateField HeaderText="Sl No.">
                                                <itemtemplate>
                                                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action Name">
                                                <itemtemplate>
                                                    <asp:Label ID="lbActionName" runat="server" Text='<%# Eval("ActionName") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="PPD Status">
                                                <itemtemplate>
                                                    <asp:Label ID="lblPPD" runat="server" Text='<%# Eval("PPD") %>'
                                                        CssClass='<%# Eval("PPD").ToString() == "Active" ? "text-success" : "text-danger" %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CEX Status">
                                                <itemtemplate>
                                                    <asp:Label ID="lbCEX" runat="server" Text='<%# Eval("CEX") %>'
                                                        CssClass='<%# Eval("CEX").ToString() == "Active" ? "text-success" : "text-danger" %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CPD Status">
                                                <itemtemplate>
                                                    <asp:Label ID="lbCPD" runat="server" Text='<%# Eval("CPD") %>'
                                                        CssClass='<%# Eval("CPD").ToString() == "Active" ? "text-success" : "text-danger" %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ACO Status">
                                                <itemtemplate>
                                                    <asp:Label ID="lbACO" runat="server" Text='<%# Eval("ACO") %>'
                                                        CssClass='<%# Eval("ACO").ToString() == "Active" ? "text-success" : "text-danger" %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SHA Status">
                                                <itemtemplate>
                                                    <asp:Label ID="lbSHA" runat="server" Text='<%# Eval("SHA") %>'
                                                        CssClass='<%# Eval("SHA").ToString() == "Active" ? "text-success" : "text-danger" %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Created On">
                                                <itemtemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action Active Status">
                                                <itemtemplate>
                                                    <asp:Button ID="btnActiveStatus" runat="server" Text='<%# Eval("IsActive") %>' OnClientClick="return confirmAction();" CommandArgument='<%# Eval("ActionId") %>' CssClass='<%# Eval("IsActive").ToString() == "Active" ? "btn btn-success rounded-pill" : "btn btn-danger rounded-pill" %>' OnClick="btnActiveStatus_Click" />
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit">
                                                <itemtemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server"
                                                        CommandName="EditAction" CommandArgument='<%# Eval("ActionId") %>'
                                                        CssClass="btn btn-success btn-sm rounded-pill"
                                                        Style="font-size: 12px;">
                                                        <span class="bi bi-pencil"></span>
                                                    </asp:LinkButton>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="20%" />
                                            </asp:TemplateField>
                                        </columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </contenttemplate>
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

