<%@ Page Title="" Language="C#" MasterPageFile="~/PPD/PPD.master" AutoEventWireup="true" CodeFile="PPDPackageMaster.aspx.cs" Inherits="PPD_PPDPackageMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Package Master</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <span class="form-label span-title">Speciality Name</span><br />
                                <asp:DropDownList ID="dlSpeciality" runat="server" class="form-control mt-2" AutoPostBack="true" OnSelectedIndexChanged="dlSpeciality_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label span-title">Procedure Name</span><br />
                                <asp:DropDownList ID="dlProcedureName" runat="server" class="form-control mt-2" AutoPostBack="true">
                                    <asp:ListItem Text="--SELECT--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label span-title">State<span class="text-danger">*</span></span><br />
                                <asp:DropDownList ID="dlState" runat="server" class="form-control mt-2">
                                    <asp:ListItem Text="Jharkhand" Value="1"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label span-title">Scheme<span class="text-danger">*</span></span><br />
                                <asp:DropDownList ID="dlScheme" runat="server" class="form-control mt-2">
                                    <asp:ListItem Text="ABUA-JHARKHAND" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-12 text-center mt-2">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn btn-success rounded-pill" OnClick="btnSearch_Click" />
                                <asp:Button ID="btnReset" runat="server" Text="Reset" class="btn btn-warning rounded-pill" OnClick="btnReset_Click" />
                            </div>
                        </div>
                    </div>

                    <div class="card mt-4">
                        <div class="card-body">
                            <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
                            <div class="table-responsive mt-2">
                                <asp:GridView ID="gridPackageMaster" runat="server" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="gridPackageMaster_PageIndexChanging" PageSize="10" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="200%" CssClass="table table-bordered table-striped">
                                    <AlternatingRowStyle BackColor="Gainsboro" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No.">
                                            <ItemTemplate>
                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="2%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Speciality ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lnbSpecialityId" runat="server" Text='<%# Eval("SpecialityCode") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="3%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Speciality Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbSpecialityName" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Procedure ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lbProcedureId" runat="server" Text='<%# Eval("ProcedureCode") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Procedure Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbProcedureName" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Package Amount(Rs.)">
                                            <ItemTemplate>
                                                <asp:Label ID="lbPackageAmount" runat="server" Text='<%# Eval("ProcedureAmount") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Preauth Required">
                                            <ItemTemplate>
                                                <asp:Label ID="lbPreauthRequired" runat="server" Text="NA"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Procedure Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lbProcedureType" runat="server" Text="NA"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Reservance">
                                            <ItemTemplate>
                                                <asp:Label ID="lbReservance" runat="server" Text="NA"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Stratification">
                                            <ItemTemplate>
                                                <asp:Label ID="lbStratification" runat="server" Text="NA"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Implants">
                                            <ItemTemplate>
                                                <asp:Label ID="lbImplants" runat="server" Text="NA"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Pre Investigations">
                                            <ItemTemplate>
                                                <asp:Label ID="lbPreInvestigations" runat="server" Text='<%# Eval("PreInvestigation") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Post Investigations">
                                            <ItemTemplate>
                                                <asp:Label ID="lbPostInvestigations" runat="server" Text='<%# Eval("PostInvestigation") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Is Applicable In State">
                                            <ItemTemplate>
                                                <asp:Label ID="lbIsApplicableInState" runat="server" Text="NA"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Rf Percentage">
                                            <ItemTemplate>
                                                <asp:Label ID="lbRfPercentage" runat="server" Text="NA"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:Panel ID="panelNoData" runat="server" Visible="false">
                                    <div class="row ibox-content" style="background-color: #f0f0f0;">
                                        <div class="col-md-12 d-flex flex-column justify-content-center align-items-center" style="height: 200px;">
                                            <img src="../images/search.svg" />
                                            <span class="mt-2">No Record Found</span>
                                            <span class="text-body-tertiary">Currently, no data available at this moment.</span>
                                        </div>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

