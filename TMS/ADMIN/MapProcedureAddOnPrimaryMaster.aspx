<%@ Page Title="" Language="C#" MasterPageFile="~/ADMIN/Admin.master" AutoEventWireup="true" CodeFile="MapProcedureAddOnPrimaryMaster.aspx.cs" Inherits="ADMIN_MapProcedureAddOnPrimaryMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <contenttemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdProcedurePrimaryId" runat="server" Visible="false" />
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
                                        <span class="form-label fw-semibold">Procedure Code AddOn</span>
                                        <asp:DropDownList ID="dropProcedureCodeAddOn" runat="server" class="form-control" Style="margin-top: 2%;" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Remarks</span>
                                        <asp:TextBox runat="server" ID="tbRemarks" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
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
                            <div class="d-flex justify-content-between">
                                <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
                                <div class="d-flex align-items-center">
                                    <asp:TextBox runat="server" ID="tbSearch" class="form-control" OnKeypress="return isAlphaNumeric(event)" placeholder="Search..."></asp:TextBox>
                                    <asp:LinkButton ID="btnSearch" runat="server"
                                        Style="font-size: 12px; margin-left: 10px;" OnClick="btnSearch_Click">
                                        <asp:Label ID="Label2" runat="server" Text='Search' CssClass="btn btn-success btn-sm rounded-pill"></asp:Label>
                                    </asp:LinkButton>
                                </div>
                            </div>
                            <div class="table-responsive mt-2">
                                <asp:GridView ID="gridAddOnPrimary" runat="server" AllowPaging="True" OnPageIndexChanging="gridAddOnPrimary_PageIndexChanging" OnRowDataBound="gridAddOnPrimary_RowDataBound" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
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
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="AddOn Procedure Code">
                                            <itemtemplate>
                                                <asp:Label ID="lbAddOnProcedureCode" runat="server" Text='<%# Eval("AddOnProcedureCode") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Remarks">
                                            <itemtemplate>
                                                <asp:Label ID="lbRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="35%" />
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
                                                    <asp:Label ID="lbStatus" runat="server" Text='<%# Eval("IsActive") %>' CssClass="btn btn-success btn-sm rounded-pill" style="padding: 4px 15px;"></asp:Label>
                                                </asp:LinkButton>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action">
                                            <itemtemplate>
                                                <asp:Label ID="lbProcedurePrimaryId" runat="server" Text='<%# Eval("ProcedurePrimaryId") %>' Visible="false"></asp:Label>
                                                <asp:Label ID="lbProcedureId" runat="server" Text='<%# Eval("ProcedureId") %>' Visible="false"></asp:Label>
                                                <asp:Label ID="lbAddOnPrimaryId" runat="server" Text='<%# Eval("AddOnPrimaryId") %>' Visible="false"></asp:Label>
                                                <asp:LinkButton ID="btnEdit" runat="server"
                                                    Style="font-size: 12px;" OnClick="btnEdit_Click">
                                                    <asp:Label ID="Label1" runat="server" Text='Edit' CssClass="btn btn-warning btn-sm rounded-pill" style="padding: 5px 15px;"></asp:Label>
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

