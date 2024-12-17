<%@ Page Title="" Language="C#" MasterPageFile="~/ADMIN/Admin.master" AutoEventWireup="true" CodeFile="PackageMaster.aspx.cs" Inherits="ADMIN_PackageMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdPackageId" runat="server" Visible="false" />
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Package Master</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="ibox">
                            <div class="ibox-content text-dark">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Speciality Code</span>
                                        <asp:TextBox runat="server" ID="tbSpecialityCode" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Speciality Name</span>
                                        <asp:TextBox runat="server" ID="tbSpecialityName" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-12 text-center mt-2">
                                        <asp:Button ID="btnAdd" runat="server" Text="Add Package" class="btn btn-success rounded-pill" OnClick="btnAdd_Click" />
                                        <asp:Button ID="btnUpdate" Visible="false" runat="server" Text="Update Package" class="btn btn-warning rounded-pill" OnClick="btnUpdate_Click" />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset Package" class="btn btn-danger rounded-pill" OnClick="btnReset_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card mt-4">
                        <div class="card-body">
                            <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
                            <div class="table-responsive mt-2">
                                <asp:GridView ID="gridPackageMaster" runat="server" AllowPaging="True" OnPageIndexChanging="gridPackageMaster_PageIndexChanging" OnRowDataBound="gridPackageMaster_RowDataBound" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
                                    <AlternatingRowStyle BackColor="Gainsboro" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sl. No.">
                                            <ItemTemplate>
                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Speciality Code">
                                            <ItemTemplate>
                                                <asp:Label ID="lbSpecialityCode" runat="server" Text='<%# Eval("SpecialityCode") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Speciality Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbSpecialityName" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Created On">
                                            <ItemTemplate>
                                                <asp:Label ID="lbCreatedOn" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Updated On">
                                            <ItemTemplate>
                                                <asp:Label ID="lbUpdatedOn" runat="server" Text='<%# Eval("UpdatedOn") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnDelete" runat="server"
                                                    Style="font-size: 12px;" OnClick="btnDelete_Click">
                                                    <asp:Label ID="lbStatus" runat="server" Text='<%# Eval("IsActive") %>' CssClass="btn btn-success btn-sm rounded-pill"></asp:Label>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:Label ID="lbPackageId" runat="server" Text='<%# Eval("PackageId") %>' Visible="false"></asp:Label>
                                                <asp:LinkButton ID="btnEdit" runat="server"
                                                    CssClass="btn btn-success btn-sm rounded-pill"
                                                    Style="font-size: 12px;" OnClick="btnEdit_Click">
                    <span class="bi bi-pencil"></span>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
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

