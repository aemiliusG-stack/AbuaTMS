<%@ Page Title="" Language="C#" MasterPageFile="~/ADMIN/Admin.master" AutoEventWireup="true" CodeFile="MapProcedureStratificationMaster.aspx.cs" Inherits="ADMIN_MapProcedureStratificationMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <contenttemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdProcedureStratificationId" runat="server" Visible="false" />
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Map Procedure Addon Primary Master</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="ibox">
                            <div class="ibox-content text-dark">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Procedure Code</span>
                                        <asp:DropDownList ID="dropProcedureCode" runat="server" class="form-control" Style="margin-top: 2%;" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Stratification Code</span>
                                        <asp:DropDownList ID="dropStratificationCode" runat="server" class="form-control" Style="margin-top: 2%;" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-12 text-center mt-2">
                                        <asp:Button ID="btnAdd" runat="server" Text="Add Mapping" class="btn btn-success rounded-pill" OnClick="btnAdd_Click" />
                                        <asp:Button ID="btnUpdate" Visible="false" runat="server" Text="Update Mapping" class="btn btn-warning rounded-pill" OnClick="btnUpdate_Click" />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset Mapping" class="btn btn-danger rounded-pill" OnClick="btnReset_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card mt-4">
                        <div class="card-body">
                            <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
                            <div class="table-responsive mt-2">
                                <asp:GridView ID="gridMapProcedureStratification" runat="server" AllowPaging="True" OnPageIndexChanging="gridMapProcedureStratification_PageIndexChanging" OnRowDataBound="gridMapProcedureStratification_RowDataBound" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
                                    <alternatingrowstyle backcolor="Gainsboro" />
                                    <columns>
                                        <asp:TemplateField HeaderText="Sl. No.">
                                            <itemtemplate>
                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Procedure Code">
                                            <itemtemplate>
                                                <asp:Label ID="lbProcedureCode" runat="server" Text='<%# Eval("ProcedureCode") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Procedure Name">
                                            <itemtemplate>
                                                <asp:Label ID="lbProcedureName" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="20%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Procedure Amount">
                                            <itemtemplate>
                                                <asp:Label ID="lbProcedureAmount" runat="server" Text='<%# Eval("ProcedureAmount") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Stratification Code">
                                            <itemtemplate>
                                                <asp:Label ID="lbStratificationCode" runat="server" Text='<%# Eval("StratificationCode") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Stratification Name">
                                            <itemtemplate>
                                                <asp:Label ID="lbStratificationName" runat="server" Text='<%# Eval("StratificationName") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Stratification Amount">
                                            <itemtemplate>
                                                <asp:Label ID="lbStratificationAmount" runat="server" Text='<%# Eval("StratificationAmount") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Created On">
                                            <itemtemplate>
                                                <asp:Label ID="lbCreatedOn" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Updated On">
                                            <itemtemplate>
                                                <asp:Label ID="lbUpdatedOn" runat="server" Text='<%# Eval("UpdatedOn") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
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
                                                <asp:Label ID="lbProcedureStratificationId" runat="server" Text='<%# Eval("ProcedureStratificationId") %>' Visible="false"></asp:Label>
                                                <asp:Label ID="lbProcedureId" runat="server" Text='<%# Eval("ProcedureId") %>' Visible="false"></asp:Label>
                                                <asp:Label ID="lbStratificationId" runat="server" Text='<%# Eval("StratificationId") %>' Visible="false"></asp:Label>
                                                <asp:LinkButton ID="btnEdit" runat="server"
                                                    CssClass="btn btn-success btn-sm rounded-pill"
                                                    Style="font-size: 12px;" OnClick="btnEdit_Click">
                                                    <span class="bi bi-pencil"></span>
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

