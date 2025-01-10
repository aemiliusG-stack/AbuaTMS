<%@ Page Title="" Language="C#" MasterPageFile="~/ADMIN/Admin.master" AutoEventWireup="true" CodeFile="StratificationMaster.aspx.cs" Inherits="ADMIN_StratificationMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" EnablePageMethods="true" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <contenttemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdStratId" runat="server" Visible="false" />
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox ">
                        <div class="ibox-title d-flex justify-content-center">
                            <h5 style="text-align: center;">Add Stratification </h5>
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
                                <div class="col-md-3">
                                    <label class="form-label fw-bold" style="font-weight: 800;">Stratification Code</label><span class="text-danger">*</span>
                                    <asp:TextBox ID="tbStratCode" runat="server" class="form-control" ValidationGroup="a" OnKeypress="return isAlphaNumeric(event);"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fw-bold" style="font-weight: 800;">Stratification Name</label><span class="text-danger">*</span>
                                    <asp:TextBox ID="tbStratName" runat="server" class="form-control" ValidationGroup="a" OnKeypress="return isAlphaNumeric(event);"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fw-bold" style="font-weight: 800;">Stratification Amount</label><span class="text-danger">*</span>
                                    <asp:TextBox ID="tbStratAmount" runat="server" class="form-control" ValidationGroup="a" OnKeypress="return isAlphaNumeric(event);"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fw-bold" style="font-weight: 800;">Stratification Detail</label><span class="text-danger">*</span>
                                    <asp:TextBox ID="tbStratDetail" runat="server" class="form-control" ValidationGroup="a" TextMode="MultiLine" OnKeypress="return isAlphaNumeric(event);"></asp:TextBox>
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
                            <h5 style="text-align: center;">Stratification Record</h5>
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
                                    <asp:GridView ID="gridStratification" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="10" OnRowCommand="gridStratification_RowCommand" OnPageIndexChanging="gridStratification_PageIndexChanging" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" CssClass="table table-bordered table-striped">
                                        <alternatingrowstyle backcolor="Gainsboro" />
                                        <columns>
                                            <asp:TemplateField HeaderText="Sl No.">
                                                <itemtemplate>
                                                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" cssclass="text-center" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Stratification Code">
                                                <itemtemplate>
                                                    <asp:Label ID="lbSpeciality" runat="server" Text='<%# Eval("StratificationCode") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" cssclass="text-center" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Stratification Name">
                                                <itemtemplate>
                                                    <asp:Label ID="lbStratificationName" runat="server" Text='<%# Eval("StratificationName") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" cssclass="text-center" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Stratification Detail">
                                                <itemtemplate>
                                                    <asp:Label ID="lbStratificationDetails" runat="server" Text='<%# Eval("StratificationDetail") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" cssclass="text-center" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="20%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Stratification Amount">
                                                <itemtemplate>
                                                    <asp:Label ID="lbStratificationAmount" runat="server" Text='<%# Eval("StratificationAmount") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" cssclass="text-center" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Created On">
                                                <itemtemplate>
                                                    <asp:Label ID="lbCreatedOn" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" cssclass="text-center" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action Active Status">
                                                <itemtemplate>
                                                    <asp:Button ID="btnActiveStatus" runat="server" Text='<%# Eval("IsActive") %>' OnClientClick="return confirmAction();" CommandArgument='<%# Eval("StratificationId") %>' CssClass='<%# Eval("IsActive").ToString() == "Active" ? "btn btn-success rounded-pill" : "btn btn-danger rounded-pill" %>' OnClick="btnActiveStatus_Click" />
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit">
                                                <itemtemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server"
                                                        CommandName="EditStrat" CommandArgument='<%# Eval("StratificationId") %>'
                                                        CssClass="btn btn-success btn-sm rounded-pill"
                                                        Style="font-size: 12px;">
                                                        <span class="bi bi-pencil"></span>
                                                    </asp:LinkButton>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" cssclass="text-center" forecolor="White" />
                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
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

