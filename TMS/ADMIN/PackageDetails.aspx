<%@ Page Title="" Language="C#" MasterPageFile="~/ADMIN/Admin.master" AutoEventWireup="true" CodeFile="PackageDetails.aspx.cs" Inherits="ADMIN_PackageDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdProcedureId" runat="server" Visible="false" />
            <asp:HiddenField ID="hdClubbingId" runat="server" Visible="false" />

            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Package Details Master</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="ibox">
                            <div class="ibox-content text-dark">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Category</span>
                                        <asp:DropDownList ID="ddSpecialityName" runat="server" class="form-control mt-2">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Procedure Code</span>
                                        <asp:TextBox runat="server" ID="tbProcedureCode" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Procedure Name</span>
                                        <asp:TextBox runat="server" ID="tbProcedureName" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Procedure Amount</span>
                                        <asp:TextBox runat="server" ID="tbProcedureAmount" class="form-control mt-2" TextMode="Number" OnKeypress="return isNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Multiple Procedure</span>
                                        <asp:DropDownList ID="ddIsMultipleProcedure" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Level Applied</span>
                                        <asp:DropDownList ID="ddIsLevelApplied" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Auto Approved</span>
                                        <asp:DropDownList ID="ddIsAutoApproved" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Procedure Type</span>
                                        <asp:TextBox runat="server" ID="tbProcedureType" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Reservance</span>
                                        <asp:TextBox runat="server" ID="tbReservance" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Stratification Required</span>
                                        <asp:DropDownList ID="ddIsStratificationRequired" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Max Stratification</span>
                                        <asp:TextBox runat="server" ID="tbMaxStratification" class="form-control mt-2" TextMode="Number" OnKeypress="return isNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Implant Required</span>
                                        <asp:DropDownList ID="ddIsImplantRequired" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Max Implant</span>
                                        <asp:TextBox runat="server" ID="tbMaxImplant" class="form-control mt-2" TextMode="Number" OnKeypress="return isNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Special Condition</span>
                                        <asp:DropDownList ID="ddIsSpecialCondition" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Reservation Public Hospital</span>
                                        <asp:DropDownList ID="ddReservationPublicHospital" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Reservation Tertiary Hospital</span>
                                        <asp:DropDownList ID="ddReservationTertiaryHospital" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Level Of Care</span>
                                        <asp:TextBox runat="server" ID="tbLevelOfCare" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">LOS</span>
                                        <asp:TextBox runat="server" ID="tbLOS" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Pre Investigation</span>
                                        <asp:TextBox runat="server" ID="tbPreInvestigation" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Post Investigation</span>
                                        <asp:TextBox runat="server" ID="tbPostInvestigation" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Procedure Label</span>
                                        <asp:TextBox runat="server" ID="tbProcedureLabel" class="form-control mt-2" TextMode="Number" OnKeypress="return isNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Special Condition PopUp</span>
                                        <asp:DropDownList ID="ddSpecialConditionPopUp" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Special Condition Rule</span>
                                        <asp:DropDownList ID="ddSpecialConditionRule" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Enhancement Applicable</span>
                                        <asp:DropDownList ID="ddIsEnhancementApplicable" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Medical Surgical</span>
                                        <asp:DropDownList ID="ddIsMedicalSurgical" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Day Care</span>
                                        <asp:DropDownList ID="ddIsDayCare" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Clubbing Remarks</span>
                                        <asp:DropDownList ID="ddClubbingRemarks" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <%--<div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Clubbing Remarks</span>
                                        <asp:TextBox runat="server" ID="tbClubbingRemarks" class="form-control mt-2" OnKeypress="return isNumeric(event)"></asp:TextBox>
                                    </div>--%>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Cycle Based</span>
                                        <asp:DropDownList ID="ddIsCycleBased" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">No Of Cycle</span>
                                        <asp:TextBox runat="server" ID="tbNoOfCycle" class="form-control mt-2" TextMode="Number" OnKeypress="return isNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Cycle Based Remarks</span>
                                        <asp:TextBox runat="server" ID="tbCycleBasedRemarks" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Sitting Procedure</span>
                                        <asp:DropDownList ID="ddIsSittingProcedure" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Sitting No Of Days</span>
                                        <asp:TextBox runat="server" ID="tbSittingNoOfDays" class="form-control mt-2" TextMode="Number" OnKeypress="return isNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold">Sitting Procedure Remarks</span>
                                        <asp:TextBox runat="server" ID="tbSittingProcedureRemarks" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-12 text-center mt-2">
                                        <asp:Button ID="btnAddProcedure" runat="server" Text="ADD" class="btn btn-success rounded-pill" OnClick="btnAddProcedure_Click" />
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
                                <h5 style="text-align: center;">Package Details Record</h5>
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
                                            <div style="overflow-x: auto; white-space: nowrap;">
                                                <asp:GridView ID="gridMasterPackage" runat="server" AllowPaging="True" OnPageIndexChanging="gridPackage_PageIndexChanging" OnRowDataBound="gridPackage_RowDataBound" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
                                                    <AlternatingRowStyle BackColor="Gainsboro" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Status">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnStatus" runat="server" Text='<%# Eval("IsActive", "{0:Active;Inactive}") %>' CssClass="btn btn-sm rounded-pill" OnClick="btnStatus_Click" />
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Action">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbProcedureId" runat="server" Text='<%# Eval("ProcedureId") %>' Visible="false"></asp:Label>
                                                                <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm rounded-pill btn-success" OnClick="btnEdit_Click" />
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                        </asp:TemplateField>

                                                        <%--   <asp:TemplateField HeaderText="Action">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbProcedureId" runat="server" Text='<%# Eval("ProcedureId") %>' Visible="false"></asp:Label>
                                                                <asp:LinkButton ID="btnEdit" runat="server"
                                                                    CssClass="btn btn-success btn-sm rounded-pill"
                                                                    Style="font-size: 12px;" OnClick="btnEdit_Click">
                                                        <span class="bi bi-pencil"></span>
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="2%" />
                                                        </asp:TemplateField>--%>
                                                        <asp:TemplateField HeaderText="Sl. No.">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Speciality Code">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbSpecialityCode" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                                                <asp:Label ID="lbPackageId" runat="server" Visible="false" Text='<%# Eval("PackageId") %>'></asp:Label>

                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Procedure Code">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbProcedureCode" runat="server" Text='<%# Eval("ProcedureCode") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Procedure Name">
                                                            <ItemTemplate>
                                                                <div style="width: 500px; white-space: normal; word-wrap: break-word; overflow-wrap: break-word;">
                                                                    <asp:Label ID="lbProcedureName" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                                </div>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Procedure Amount">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbProcedureAmount" runat="server" Text='<%# Eval("ProcedureAmount") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Multiple Procedure">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIsMultipleProcedure" runat="server" Text='<%# Eval("IsMultipleProcedure") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Level Applied">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIsLevelApplied" runat="server" Text='<%# Eval("IsLevelApplied") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Auto Approved">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIsAutoApproved" runat="server" Text='<%# Eval("IsAutoApproved") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Procedure Type">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbProcedureType" runat="server" Text='<%# Eval("ProcedureType") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Reservance">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbReservance" runat="server" Text='<%# Eval("Reservance") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Stratification Required">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIsStratificationRequired" runat="server" Text='<%# Eval("IsStratificationRequired") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Max Stratification">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbMaxStratification" runat="server" Text='<%# Eval("MaxStratification") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Implant Required">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIsImplantRequired" runat="server" Text='<%# Eval("IsImplantRequired") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Max Implant">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbMaxImplant" runat="server" Text='<%# Eval("MaxImplant") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Special Condition">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIIsSpecialCondition" runat="server" Text='<%# Eval("IsSpecialCondition") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Reservation Public Hospital">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbReservationPublicHospital" runat="server" Text='<%# Eval("ReservationPublicHospital") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Reservation Tertiary Hospital">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbReservationTertiaryHospital" runat="server" Text='<%# Eval("ReservationTertiaryHospital") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Level Of Care">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbLevelOfCare" runat="server" Text='<%# Eval("LevelOfCare") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="LOS">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbLOS" runat="server" Text='<%# Eval("LOS") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PreInvestigation">
                                                            <ItemTemplate>
                                                                <div style="width: 300px; white-space: normal; word-wrap: break-word; overflow-wrap: break-word;">

                                                                    <asp:Label ID="lbPreInvestigation" runat="server" Text='<%# Eval("PreInvestigation") %>'></asp:Label>
                                                                </div>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PostInvestigation">
                                                            <ItemTemplate>
                                                                <div style="width: 300px; white-space: normal; word-wrap: break-word; overflow-wrap: break-word;">
                                                                    <asp:Label ID="lbPostInvestigation" runat="server" Text='<%# Eval("PostInvestigation") %>'></asp:Label>
                                                                </div>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Procedure Label">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbProcedureLabel" runat="server" Text='<%# Eval("ProcedureLabel") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Special Condition PopUp">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbSpecialConditionPopUp" runat="server" Text='<%# Eval("SpecialConditionPopUp") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Special Condition Rule">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbSpecialConditionRule" runat="server" Text='<%# Eval("SpecialConditionRule") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Enhancement Applicable">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIsEnhancementApplicable" runat="server" Text='<%# Eval("IsEnhancementApplicable") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Medical Surgical">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIsMedicalSurgical" runat="server" Text='<%# Eval("IsMedicalSurgical") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Day Care">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIsDayCare" runat="server" Text='<%# Eval("IsDayCare") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <%-- <asp:TemplateField HeaderText="Clubbing Id">
                                                <itemtemplate>
                                                    <asp:Label ID="lbClubbingId" runat="server" Text='<%# Eval("ClubbingId") %>'></asp:Label>
                                                </itemtemplate>
                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                                <itemstyle horizontalalign="Left" verticalalign="Middle" width="50px" />
                                            </asp:TemplateField>--%>
                                                        <asp:TemplateField HeaderText="Clubbing Remarks">
                                                            <ItemTemplate>
                                                                <div style="width: 150px; white-space: normal; word-wrap: break-word; overflow-wrap: break-word;">
                                                                    <asp:Label ID="lbClubbingId" runat="server" Visible="false" Text='<%# Eval("ClubbingId") %>'></asp:Label>

                                                                    <asp:Label ID="lbClubbingRemarks" runat="server" Text='<%# Eval("ClubbingRemarks") %>'></asp:Label>
                                                                </div>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Cycle Based">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIsCycleBased" runat="server" Text='<%# Eval("IsCycleBased") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Number Of Cycle">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbNoOfCycle" runat="server" Text='<%# Eval("NoOfCycle") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Cycle Based Remarks">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbCycleBasedRemarks" runat="server" Text='<%# Eval("CycleBasedRemarks") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Sitting Procedure">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbIsSittingProcedure" runat="server" Text='<%# Eval("IsSittingProcedure") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Sitting Number Of Days">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbSittingNoOfDays" runat="server" Text='<%# Eval("SittingNoOfDays") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Sitting Procedure Remarks">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbSittingProcedureRemarks" runat="server" Text='<%# Eval("SittingProcedureRemarks") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Created On">
                                                            <ItemTemplate>
                                                                <div style="width: 100px; white-space: normal; word-wrap: break-word; overflow-wrap: break-word;">
                                                                    <asp:Label ID="lbCreatedOn" runat="server" Text='<%# Eval("CreatedOn") %>'></asp:Label>
                                                                </div>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Updated On">
                                                            <ItemTemplate>
                                                                <div style="width: 100px; white-space: normal; word-wrap: break-word; overflow-wrap: break-word;">
                                                                    <asp:Label ID="lbUpdatedOn" runat="server" Text='<%# Eval("UpdatedOn") %>'></asp:Label>
                                                                </div>
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                        </asp:TemplateField>

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

