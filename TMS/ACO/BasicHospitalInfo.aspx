<%@ Page Title="" Language="C#" MasterPageFile="~/ACO/ACO.master" AutoEventWireup="true" CodeFile="BasicHospitalInfo.aspx.cs" Inherits="ACO_BasicHospitalInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <style>
        .btn-search-icon::before {
            font-family: 'Font Awesome 5 Free';
            content: '\f002'; /* Unicode for search icon */
            margin-right: 5px;
            font-weight: 900;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
    <div class="row">
        <div class="col-lg-12">
            <div class="ibox">
                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                    <h4 class="m-0">Hospital Details</h4>
                </div>
                <div class="ibox-content p-4 bg-light">
                    <div class="row mb-3">
                        <!-- Hospital Code -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Hospital Code</label>
                            <asp:TextBox ID="txtHospitalCode" runat="server" CssClass="form-control"
                                placeholder="Enter Hospital Code"
                                Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:TextBox>
                        </div>
                        <!-- Hospitals -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Hospitals</label>
                            <asp:DropDownList ID="ddlHospitals" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:DropDownList>
                        </div>
                        <!-- Type -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Type</label>
                            <asp:DropDownList ID="ddlTypeS" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:DropDownList>
                        </div>
                        <!-- District -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">District</label>
                            <asp:DropDownList ID="DropDownListDistricts" runat="server" CssClass="form-control" AppendDataBoundItems="True" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            </asp:DropDownList>
                        </div>
                        <!-- Scheme -->
                        <div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Scheme <span style="color: red;">*</span></label>
                            <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="MSBY(P)" Value="MSBY(P)"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- Green Chanel/non Green Chanel -->
                        <%--<div class="col-md-6 col-lg-3 mb-3">
                            <label class="form-label fw-bold">Green Chanel/non Green Chanel</label>
                            <asp:DropDownList ID="ddlGreen" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>--%>
                    </div>

                    <!-- Error Message -->
                    <div class="row mt-3">
                        <div class="col-md-12 text-center">
                            <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="False"></asp:Label>
                        </div>
                    </div>

                    <!-- Search and Reset Buttons -->
                    <div class="row mt-3">
                        <div class="col-md-12 text-center">
                            <%--<asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success rounded-pill" Text="Search" />--%>
                            <%--<asp:Button ID="Button1" runat="server" CssClass="btn btn-success rounded-pill" Text="Search" OnClick="btnSearch_Click" />--%>
                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success rounded-pill" OnClick="btnSearch_Click">
                                    <i class="fas fa-search"></i> Search
                            </asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-warning rounded-pill" OnClick="btnReset_Click">
                                    <i class="fas fa-minus"></i> Reset
                            </asp:LinkButton>
                            <%--<asp:Button ID="btnReset" runat="server" CssClass="btn btn-warning rounded-pill" Text="Reset" OnClick="btnReset_Click" />--%>
                        </div>
                    </div>

                    <!-- Information Message -->
                    <div class="row mt-3">
                        <div class="col-md-12 text-center">
                            <span>Please use any search criteria along with Scheme to fetch data.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_PageIndexChanging" Width="100%" CssClass="table table-bordered table-striped" >
        <alternatingrowstyle backcolor="Gainsboro" />
        <Columns>
            <asp:TemplateField HeaderText="S.No.">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Hospital Code">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkHospitalCode" runat="server"
                        NavigateUrl='<%# "HospitalDetails.aspx?HospitalId=" + Eval("HospitalId") %>'
                        Text='<%# Eval("HospitalId") %>'>
                    </asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="HospitalName" HeaderText="Name" />
            <asp:BoundField DataField="HospitalType" HeaderText="Type" />
            <asp:BoundField DataField="District" HeaderText="District" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
            <asp:BoundField DataField="PaymentActivity" HeaderText="Stop payment" />
        </Columns>
    </asp:GridView>--%>
    <div class="card mt-4">
        <div class="card-body">
            <asp:Label ID="lbRecordCount" runat="server" Text="Total No Records:" class="card-title fw-bold"></asp:Label>
            <div class="table-responsive mt-2">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
                    <AlternatingRowStyle BackColor="Gainsboro" />
                    <Columns>
                        <asp:TemplateField HeaderText="Sl. No.">
                            <ItemTemplate>
                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Hospital Code">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkHospitalCode" runat="server"
                                    NavigateUrl='<%# "HospitalDetails.aspx?HospitalId=" + Eval("HospitalId") %>'
                                    Text='<%# Eval("HospitalId") %>'>
                                </asp:HyperLink>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hospital Code">
                            <ItemTemplate>
                                <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hospital Code">
                            <ItemTemplate>
                                <asp:Label ID="lbHospitalType" runat="server" Text='<%# Eval("HospitalType") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hospital Code">
                            <ItemTemplate>
                                <asp:Label ID="lbDistrict" runat="server" Text='<%# Eval("District") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hospital Code">
                            <ItemTemplate>
                                <asp:Label ID="lbStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hospital Code">
                            <ItemTemplate>
                                <asp:Label ID="lbPaymentActivity" runat="server" Text='<%# Eval("PaymentActivity") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
                <asp:Panel ID="panelNoData" runat="server" Visible="false">
                    <div class="row ibox-content" style="background-color: #f0f0f0;">
                        <div class="col-md-12 d-flex flex-column justify-content-center align-items-center" style="height: 200px;">
                            <i class="fa fa-search" style="font-size: 20px;"></i>
                            <span class="mt-2">No Record Found</span>
                            <span class="text-body-tertiary">Currently, no cases available at this moment.</span>
                        </div>
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>

</asp:Content>

