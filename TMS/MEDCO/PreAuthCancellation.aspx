<%@ Page Title="" Language="C#" MasterPageFile="~/MEDCO/MEDCO.master" AutoEventWireup="true" CodeFile="PreAuthCancellation.aspx.cs" Inherits="MEDCO_PreAuthCancellation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox ">
                        <div class="ibox-title d-flex justify-content-center">
                            <h5 style="text-align: center;">Cases For Cancellation</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                                <a class="close-link">
                                    <i class="fa fa-times"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <div class="col-lg-12">
                                <asp:GridView ID="gridPatientForCancellation" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" AllowPaging="True" PageSize="20" OnPageIndexChanging="gridPatientForCancellation_PageIndexChanging">
                                    <AlternatingRowStyle BackColor="Gainsboro" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sl No.">
                                            <ItemTemplate>
                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Check All">
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="cbHeaderCheckAll" runat="server" Text="Check All" AutoPostBack="true" OnCheckedChanged="cbHeaderCheckAll_CheckedChanged" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbcheck" runat="server" OnCheckedChanged="cbcheckRow_CheckedChanged" AutoPostBack="True" />
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Case No.">
                                            <ItemTemplate>
                                                <asp:Label ID="lbHospitalId" runat="server" Text='<%# Eval("HospitalId") %>' Visible="false"></asp:Label>
                                                <asp:Label ID="lbPatientRegId" runat="server" Text='<%# Eval("PatientRegId") %>' Visible="false"></asp:Label>
                                                <asp:Label ID="lbCaseNo" runat="server" Text='<%# Eval("CaseNumber") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Patient Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbPatientName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Card Number">
                                            <ItemTemplate>
                                                <asp:Label ID="lbCardNumber" runat="server" Text='<%# Eval("CardNumber") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Hospital Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Registered Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lbRegDate" runat="server" Text='<%# Eval("RegDate") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Remarks">
                                            <ItemTemplate>
                                                <asp:TextBox ID="tbRemarks" runat="server" CssClass="form-control" OnKeypress="return isAlphaNumericSpecial(event);"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                            <div class="col-lg-12 text-center m-t-md">
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel PreAuth" OnClick="btnCancel_Click" CssClass="btn btn-success rounded-pill" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <asp:HiddenField ID="hdUserId" runat="server" />
            <asp:HiddenField ID="hdHospitalId" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

