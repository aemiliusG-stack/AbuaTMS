<%@ Page Title="" Language="C#" MasterPageFile="~/ADMIN/Admin.master" AutoEventWireup="true" CodeFile="ImplantMaster.aspx.cs" Inherits="ADMIN_ImplantMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <contenttemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdImplantId" runat="server" Visible="false" />
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Implant Master</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="ibox">
                            <div class="ibox-content text-dark">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Implant Code</span>
                                        <asp:TextBox runat="server" ID="tbImplantCode" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Implant Name</span>
                                        <asp:TextBox runat="server" ID="tbImplantName" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Max Implant Count</span>
                                        <asp:TextBox runat="server" ID="tbImplantCount" class="form-control mt-2" TextMode="Number" OnKeypress="return isNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Implant Amount</span>
                                        <asp:TextBox runat="server" ID="tbImplantAmount" class="form-control mt-2" TextMode="Number" OnKeypress="return isDecimal(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-12 text-center mt-2">
                                        <asp:Button ID="btnAddImplant" runat="server" Text="Add Implant" class="btn btn-success rounded-pill" OnClick="btnAddImplant_Click" />
                                        <asp:Button ID="btnUpdate" Visible="false" runat="server" Text="Update Implant" class="btn btn-warning rounded-pill" OnClick="btnUpdate_Click" />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset Implant" class="btn btn-danger rounded-pill" OnClick="btnReset_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card mt-4">
                        <div class="card-body">
                            <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
                            <div class="table-responsive mt-2">
                                <asp:GridView ID="gridImplant" runat="server" AllowPaging="True" OnPageIndexChanging="gridImplant_PageIndexChanging" OnRowDataBound="gridImplant_RowDataBound" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
                                    <alternatingrowstyle backcolor="Gainsboro" />
                                    <columns>
                                        <asp:TemplateField HeaderText="Sl. No.">
                                            <itemtemplate>
                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ImplantCode">
                                            <itemtemplate>
                                                <asp:Label ID="lbImplantCode" runat="server" Text='<%# Eval("ImplantCode") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Implant Name">
                                            <itemtemplate>
                                                <asp:Label ID="lbImplantName" runat="server" Text='<%# Eval("ImplantName") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="30%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Implant Count">
                                            <itemtemplate>
                                                <asp:Label ID="lbMaxImplant" runat="server" Text='<%# Eval("MaxImplant") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Implant Amount">
                                            <itemtemplate>
                                                <asp:Label ID="lbImplantAmount" runat="server" Text='<%# Eval("ImplantAmount") %>'></asp:Label>
                                            </itemtemplate>
                                            <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                            <itemstyle horizontalalign="Left" verticalalign="Middle" width="10%" />
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
                                                <asp:Label ID="lbImplantId" runat="server" Text='<%# Eval("ImplantId") %>' Visible="false"></asp:Label>
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

