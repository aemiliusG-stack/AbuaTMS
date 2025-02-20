<%@ Page Title="" Language="C#" MasterPageFile="~/ADMIN/Admin.master" AutoEventWireup="true" CodeFile="ImplantMaster.aspx.cs" Inherits="ADMIN_ImplantMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
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
                                        <asp:TextBox runat="server" ID="tbImplantCode" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)" OnPaste="return validatePaste(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Implant Name</span>
                                        <asp:TextBox runat="server" ID="tbImplantName" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)" OnPaste="return validatePaste(event)"></asp:TextBox>
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
                            <div class="d-flex justify-content-between align-items-center">
                                <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold m-0"></asp:Label>
                                <div class="d-flex align-items-center">
                                    <asp:TextBox runat="server" ID="tbSearch" class="form-control" OnKeypress="return isAlphaNumeric(event)" placeholder="Search..."></asp:TextBox>
                                    <asp:LinkButton ID="btnSearch" runat="server"
                                        Style="font-size: 12px; margin-left: 10px;" OnClick="btnSearch_Click">
                                        <asp:Label ID="Label2" runat="server" Text='Search' CssClass="btn btn-success btn-sm rounded-pill"></asp:Label>
                                    </asp:LinkButton>
                                </div>
                            </div>
                            <div class="table-responsive mt-2">
                                <asp:GridView ID="gridImplant" runat="server" AllowPaging="True" OnPageIndexChanging="gridImplant_PageIndexChanging" OnRowDataBound="gridImplant_RowDataBound" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
                                    <AlternatingRowStyle BackColor="Gainsboro" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sl. No.">
                                            <ItemTemplate>
                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ImplantCode">
                                            <ItemTemplate>
                                                <asp:Label ID="lbImplantCode" runat="server" Text='<%# Eval("ImplantCode") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Implant Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbImplantName" runat="server" Text='<%# Eval("ImplantName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Implant Count">
                                            <ItemTemplate>
                                                <asp:Label ID="lbMaxImplant" runat="server" Text='<%# Eval("MaxImplant") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Implant Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lbImplantAmount" runat="server" Text='<%# Eval("ImplantAmount") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Created On">
                                            <ItemTemplate>
                                                <asp:Label ID="lbCreatedOn" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Updated On">
                                            <ItemTemplate>
                                                <asp:Label ID="lbUpdatedOn" runat="server" Text='<%# Eval("UpdatedOn") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnDelete" runat="server"
                                                    Style="font-size: 12px;" OnClick="btnDelete_Click">
                                                    <asp:Label ID="lbStatus" runat="server" Text='<%# Eval("IsActive") %>' CssClass="btn btn-success btn-sm rounded-pill" Style="padding: 4px 15px;"></asp:Label>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:Label ID="lbImplantId" runat="server" Text='<%# Eval("ImplantId") %>' Visible="false"></asp:Label>
                                                <asp:LinkButton ID="btnEdit" runat="server"
                                                    Style="font-size: 12px;" OnClick="btnEdit_Click">
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

