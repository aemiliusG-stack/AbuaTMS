<%@ Page Title="" Language="C#" MasterPageFile="~/MEDCO/MEDCO.master" AutoEventWireup="true" CodeFile="ReferPatient.aspx.cs" Inherits="MEDCO_ReferPatient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function showCommonPopUpModal() {
            $('#modalCommonPopUp').modal('hide');
            // Remove all backdrops
            $('.modal-backdrop').remove();
            $('#modalCommonPopUp').modal('show');
        }
        function hideCommonPopUpModal() {
            $('#modalCommonPopUp').modal('hide');
            // Remove all backdrops
            $('.modal-backdrop').remove();
            $('#modalCommonPopUp').modal('hide');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <div class="modal fade" id="modalCommonPopUp" tabindex="-1" role="dialog" aria-labelledby="btnHidePopUp" aria-hidden="true">
                <div class="modal-dialog modal-xl" role="document">
                    <div class="modal-content">
                        <div class="modal-header round" style="background-color: #007e72;">
                            <h2 class="modal-title text-white" id="exampleModalLabel" style="margin: 0px !important;">Refer Patient</h2>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row col-lg-12">
                                <div class="col-md-6">
                                    <span class="mb-6 font-bold">Referal Hospital</span><br />
                                    <asp:DropDownList ID="dropHospitalList" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                                <div class="col-md-6">
                                    <span class="mb-6 font-bold">Remarks:</span><br />
                                    <asp:TextBox ID="tbRemarks" runat="server" PlaceHolder="Remarks" CssClass="form-control" OnKeypress="return isAlphaNumericSpecial(event);"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-lg-12 text-center mt-3">
                                <asp:Button ID="btnReferPatient" runat="server" Text="Submit" CssClass="btn btn-success rounded-pill" OnClick="btnReferPatient_Click" />
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnHidePopUp" CssClass="btn btn-secondary" Text="Close" runat="server" OnClick="hideCommonModal_Click" />
                        </div>

                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">View Registered Patients</h3>
                    </div>
                    <div class="card mt-3">
                        <div class="card-body table-responsive">
                            <asp:GridView ID="gridRegisteredPatient" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                <AlternatingRowStyle BackColor="Gainsboro" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Sl No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Registration No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lbRegId" runat="server" Text='<%# Eval("PatientRegId") %>'></asp:Label>
                                            <asp:Label ID="lbPatientRegId" runat="server" Text='<%# Eval("PatientRegId") %>' Visible="false"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Patient Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lbName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Beneficiary Card No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lbCardNo" runat="server" Text='<%# Eval("CardNumber") %>'></asp:Label>
                                            <asp:Label ID="lbPatientCardNo" runat="server" Text='<%# Eval("CardNumber") %>' Visible="false"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="District">
                                        <ItemTemplate>
                                            <asp:Label ID="lbDistrict" runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Address">
                                        <ItemTemplate>
                                            <asp:Label ID="lbAddress" runat="server" Text='<%# Eval("PatientAddress") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Gender">
                                        <ItemTemplate>
                                            <asp:Label ID="lbGender" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Age">
                                        <ItemTemplate>
                                            <asp:Label ID="lbAge" runat="server" Text='<%# Eval("Age") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Registration Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lbRegDate" runat="server" Text='<%# Eval("RegDate") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkRefer" runat="server" CssClass="btn btn-success rounded-pill" OnClick="lnkReferPatient">Refer To</asp:LinkButton>
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
            <asp:HiddenField ID="hdUserId" runat="server" />
            <asp:HiddenField ID="hdHospitalId" runat="server" />
            <asp:HiddenField ID="hdRegId" runat="server" />
            <asp:HiddenField ID="hdCardNo" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

