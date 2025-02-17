<%@ Page Title="" Language="C#" MasterPageFile="~/PPD/PPD.master" AutoEventWireup="true" CodeFile="PPDHome.aspx.cs" Inherits="PPD_PPDHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        /* From Uiverse.io by zanina-yassine */
        #loading-div {
            position: absolute;
            z-index: 1;
            width: 100%;
            height: 100vh;
            background-color: #00000030
        }

        #loading-container {
            position: absolute;
            z-index: 1;
            width: 100%;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #container {
            width: 300px;
            height: 200px;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            transition: box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .loading-title {
            display: block;
            text-align: center;
            font-size: 20px;
            font-family: 'Inter', sans-serif;
            font-weight: bold;
            margin-top: 50px;
            color: #000;
        }

        .loading-circle {
            display: block;
            text-align: center;
            border-left: 5px solid;
            border-top-left-radius: 100%;
            border-top: 5px solid;
            margin: 5px;
            animation-name: Loader_611;
            animation-duration: 1500ms;
            animation-timing-function: linear;
            animation-delay: 0s;
            animation-iteration-count: infinite;
            animation-direction: normal;
            animation-fill-mode: forwards;
        }

        .sp1 {
            border-left-color: #F44336;
            border-top-color: #F44336;
            width: 40px;
            height: 40px;
            margin-right: 55px
        }

        .sp2 {
            border-left-color: #FFC107;
            border-top-color: #FFC107;
            width: 30px;
            height: 30px;
        }

        .sp3 {
            width: 20px;
            height: 20px;
            border-left-color: #8bc34a;
            border-top-color: #8bc34a;
        }

        @keyframes Loader_611 {
            0% {
                transform: rotate(0deg);
                transform-origin: right bottom;
            }

            25% {
                transform: rotate(90deg);
                transform-origin: right bottom;
            }

            50% {
                transform: rotate(180deg);
                transform-origin: right bottom;
            }

            75% {
                transform: rotate(270deg);
                transform-origin: right bottom;
            }

            100% {
                transform: rotate(360deg);
                transform-origin: right bottom;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />

            <asp:Panel ID="panelLoading" runat="server" Visible="false">
                <div id="loading-div">
                    <div id="loading-container">
                        <div id="container">
                            <span class="loading-circle sp1">
                                <span class="loading-circle sp2">
                                    <span class="loading-circle sp3"></span>
                                </span>
                            </span>
                            <label class="loading-title">Loading ...</label>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Assigned Cases</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Scheme</span>
                                <asp:DropDownList ID="dlSchemeId" runat="server" class="form-control mt-2">
                                    <asp:ListItem Text="ABUA-JHARKHAND" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Case Number</span>
                                <asp:TextBox runat="server" ID="tbCaseNo" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Beneficiary Card Number</span>
                                <asp:TextBox runat="server" ID="tbBeneficiaryCardNo" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Registered From Date</span>
                                <asp:TextBox runat="server" ID="tbRegisteredFromDate" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <span class="form-label fw-semibold">Registered To Date</span>
                                <asp:TextBox runat="server" ID="tbRegisteredToDate" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
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
                                <asp:GridView ID="gridAssignedCases" runat="server" AllowPaging="True" OnRowDataBound="gridAssignedCases_RowDataBound" OnPageIndexChanging="gridAssignedCases_PageIndexChanging" PageSize="10" AutoGenerateColumns="False" Width="100%" CssClass="table table-bordered table-striped">
                                    <AlternatingRowStyle BackColor="Gainsboro" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sl. No.">
                                            <ItemTemplate>
                                                <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Case No">
                                            <ItemTemplate>
                                                <asp:Label Visible="false" ID="lbAdmissionId" runat="server" Text='<%# Eval("AdmissionId") %>'></asp:Label>
                                                <asp:Label Visible="false" ID="lbClaimId" runat="server" Text='<%# Eval("ClaimId") %>'></asp:Label>
                                                <asp:Label Visible="false" ID="lbClaimMode" runat="server" Text='<%# Eval("ClaimMode") %>'></asp:Label>
                                                <asp:Label Visible="false" ID="lbPackageId" runat="server" Text='<%# Eval("PackageId") %>'></asp:Label>
                                                <asp:LinkButton ID="lnkCaseNo" runat="server" OnClick="lnkCaseNo_Click" Text='<%# Eval("CaseNumber") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Claim No">
                                            <ItemTemplate>
                                                <asp:Label ID="lbClaimNo" runat="server" Text='<%# Eval("ClaimNumber") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Patient Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbPatientName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Beneficiary Card Number">
                                            <ItemTemplate>
                                                <asp:Label ID="lbBeneficiaryCardNo" runat="server" Text='<%# Eval("CardNumber") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Case Status">
                                            <ItemTemplate>
                                                <asp:Label ID="lbCaseStatus" runat="server" Text="NA"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="25%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Hospital Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Registred Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lbRegisteredDate" runat="server" Text='<%# Eval("RegDate") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="10%" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:Panel ID="panelNoData" runat="server" Visible="false">
                                    <div class="row ibox-content" style="background-color: #f0f0f0;">
                                        <div class="col-md-12 d-flex flex-column justify-content-center align-items-center" style="height: 200px;">
                                            <i class="fa fa-search" style="font-size: 20px;"></i>
                                            <span class="mt-2">No Record Found</span>
                                            <span class="text-body-tertiary">Currently, no cases assigned to you at this moment.</span>
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

