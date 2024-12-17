<%@ Page Title="" Language="C#" MasterPageFile="~/CPD/CPD.master" AutoEventWireup="true" CodeFile="CPDPackageMaster.aspx.cs" Inherits="CPD_CPDPackageMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
    <asp:HiddenField ID="hdAbuaId" runat="server" Visible="false" />
    <div class="row">
        <div class="col-lg-12">
            <div class="ibox">
                <div class="ibox-title d-flex justify-content-center text-white align-items-center">
                    <h4 class="m-0 text-center">Package Master</h4>
                </div>
                <div class="ibox-content">
                    <div class="ibox-content text-dark">
                        <div class="row">
                            <div class="col-md-3">
                                <label class="form-label fw-bold" style="font-weight: 800;">State</label>
                                <asp:DropDownList runat="server" ID="ddState" CssClass="form-control border-0 border-bottom">
                                    <%--                                    <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>--%>
                                    <asp:ListItem Text="Jharkhand" Value="Jharkhand"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="col-md-3">
                                <label class="form-label fw-bold" style="font-weight: 800;">Scheme</label>
                                <asp:DropDownList runat="server" ID="ddlScheme" CssClass="form-control border-0 border-bottom">
                                    <%--                                    <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>--%>
                                    <asp:ListItem Text="MSBY(P)" Value="MSBY(P)"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold" style="font-weight: 800;">Speciality Name</label>
                                <asp:DropDownList runat="server" ID="ddSpecialityName" CssClass="form-control border-0 border-bottom" OnSelectedIndexChanged="ddSpecialityName_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                </asp:DropDownList>

                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold" style="font-weight: 800;">Procedure Name</label>
                                <asp:DropDownList runat="server" ID="ddProcedureName" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                      <%--  <div class="row mt-3">
                            <div class="col-md-3">
                                <label class="form-label fw-bold" style="font-weight: 800;">Reservance</label>
                                <asp:DropDownList runat="server" ID="ddReservance" CssClass="form-control border-0 border-bottom">
                                    <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>--%>
                        <div class="row mt-3">
                            <div class="col-md-12 text-center">
                                <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="False"></asp:Label>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12 text-center">
                                <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-success rounded-pill" OnClick="btnSearch_Click">
                                     <i class="bi bi-search"></i> Search
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnReset" runat="server" CssClass="btn btn-warning rounded-pill" OnClick="btnReset_Click">
                                    <i class="bi bi-arrow-counterclockwise"></i> Reset
                                </asp:LinkButton>
                            </div>
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

