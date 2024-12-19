<%@ Page Title="" Language="C#" MasterPageFile="~/ADMIN/Admin.master" AutoEventWireup="true" CodeFile="MapProcedureNonRelated.aspx.cs" Inherits="ADMIN_MapProcedureNonRelated" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdProcedureNonRelatedId" runat="server" Visible="false" />
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Map Procedure Non Related </h3>
                    </div>
                    <div class="ibox-content">
                        <div class="ibox">
                            <div class="ibox-content text-dark">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Primary Procedure Code</span>
                                        <asp:DropDownList ID="ddPrimaryProcedureCode" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Procedure Code</span>
                                        <asp:DropDownList ID="ddProcedureCode" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Remarks</span>
                                        <asp:TextBox runat="server" ID="tbRemarks" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-12 text-center mt-2">
                                        <asp:Button ID="btnAddProcedureNonRelated" runat="server" Text="ADD" class="btn btn-success rounded-pill" OnClick="btnAddProcedureNonRelated_Click" />
                                        <asp:Button ID="btnReset" runat="server" Text="RESET" class="btn btn-danger rounded-pill" OnClick="btnReset_Click" />
                                        <asp:Button ID="btnUpdate" Visible="false" runat="server" Text="UPDATE" class="btn btn-warning rounded-pill" OnClick="btnUpdate_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card mt-4">
                        <div class="card-body">
                            <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
                            <div class="table-responsive mt-2">
                                <asp:GridView ID="gridProcedureNonRelated" runat="server" AllowPaging="True" OnPageIndexChanging="gridProcedureNonRelated_PageIndexChanging" OnRowDataBound="gridProcedureNonRelated_RowDataBound" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
                                    <AlternatingRowStyle BackColor="Gainsboro" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sl. No.">
                                            <ItemTemplate>
                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Primary Procedure Code">
                                            <ItemTemplate>
                                                <asp:Label ID="lbProcedureCode" runat="server" Text='<%# Eval("ProcedureCode_ProcedureId") %>'></asp:Label>
                                                <asp:Label ID="lbProcedureId" runat="server" Visible="false" Text='<%# Eval("ProcedureId") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center"/>
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Procedure Code">
                                            <ItemTemplate>
                                                <asp:Label ID="lbNonRelatedCode" runat="server" Text='<%# Eval("ProcedureCode_NonRelatedId") %>'></asp:Label>
                                                <asp:Label ID="lbNonRelatedId" runat="server" Visible="false" Text='<%# Eval("NonRelatedId") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center"/>
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Remarks">
                                            <ItemTemplate>
                                                <asp:Label ID="lbRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center"/>
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="35%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Created On">
                                            <ItemTemplate>
                                                <asp:Label ID="lbCreatedOn" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center"/>
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Updated On">
                                            <ItemTemplate>
                                                <asp:Label ID="lbUpdatedOn" runat="server" Text='<%# Eval("UpdatedOn") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center"/>
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <asp:Button ID="btnStatus" runat="server" Text='<%# Eval("IsActive", "{0:Active;Inactive}") %>' CssClass="btn btn-sm rounded-pill" OnClick="btnStatus_Click" />
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center"/>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:Label ID="lbProcedureNonRelatedId" runat="server" Text='<%# Eval("ProcedureNonRelatedId") %>' Visible="false"></asp:Label>
                                                <%--<asp:LinkButton ID="btnDelete" runat="server"
                                                    CssClass="btn btn-warning btn-sm rounded-pill"
                                                    Style="font-size: 12px;" OnClick="btnDelete_Click">
                                         <span class="bi bi-arrow-repeat"></span>
                                                </asp:LinkButton>--%>
                                                <asp:LinkButton ID="btnEdit" runat="server"
                                                    CssClass="btn btn-success btn-sm rounded-pill"
                                                    Style="font-size: 12px;" OnClick="btnEdit_Click">
                                         <span class="bi bi-pencil"></span>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center"/>
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

