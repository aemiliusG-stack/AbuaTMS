<%@ Page Title="" Language="C#" MasterPageFile="~/ADMIN/Admin.master" AutoEventWireup="true" CodeFile="MasterPopUp.aspx.cs" Inherits="ADMIN_MasterPopUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPopUpId" runat="server" Visible="false" />
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Pop Up Master</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="ibox">
                            <div class="ibox-content text-dark">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Pop Up Description</span>
                                        <asp:TextBox runat="server" ID="tbPopUpDescription" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-12 text-center mt-2">
                                        <asp:Button ID="btnAddPopUp" runat="server" Text="ADD" class="btn btn-success rounded-pill" OnClick="btnAddPopUp_Click" />
                                        <asp:Button ID="btnUpdate" Visible="false" runat="server" Text="UPDATE" class="btn btn-warning rounded-pill" OnClick="btnUpdate_Click" />
                                        <asp:Button ID="btnReset" runat="server" Text="RESET" class="btn btn-danger rounded-pill" OnClick="btnReset_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="ibox ">
                            <div class="ibox-title d-flex justify-content-center">
                                <h5 style="text-align: center;">Pop Up Master Record</h5>
                            </div>
                            <div class="ibox-content">
                                <div class="form-group row">
                                    <div class="col-md-9"></div>
                                    <div class="col-md-3 d-flex text-end">
                                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Search..."></asp:TextBox>
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                                    </div>
                                </div>
                                <div class="form-group  row">
                                    <div class="col-md-12">

                                        <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
                                        <div class="table-responsive mt-2">
                                            <asp:GridView ID="gridPopUp" runat="server" AllowPaging="True" OnPageIndexChanging="gridPopUp_PageIndexChanging" OnRowDataBound="gridPopUp_RowDataBound" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
                                                <AlternatingRowStyle BackColor="Gainsboro" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Sl. No.">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="POP UP Description">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbPopUpDescription" runat="server" Text='<%# Eval("PopUpDescription") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40%" />
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Created On">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbCreatedOn" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Updated On">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbUpdatedOn" runat="server" Text='<%# Eval("UpdatedOn") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Status">
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnStatus" runat="server" Text='<%# Eval("IsActive", "{0:Active;Inactive}") %>' CssClass="btn btn-sm rounded-pill" OnClick="btnStatus_Click" />
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Action">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbPopUpId" runat="server" Text='<%# Eval("PopUpId") %>' Visible="false"></asp:Label>
                                                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm rounded-pill btn-success" OnClick="btnEdit_Click" />
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                    </asp:TemplateField>

                                                    <%--<asp:TemplateField HeaderText="Action">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbPopUpId" runat="server" Text='<%# Eval("PopUpId") %>' Visible="false"></asp:Label>
                                                            <asp:LinkButton ID="btnEdit" runat="server"
                                                                CssClass="btn btn-success btn-sm rounded-pill"
                                                                Style="font-size: 12px;" OnClick="btnEdit_Click">
                                                     <span class="bi bi-pencil"></span>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                    </asp:TemplateField>--%>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

