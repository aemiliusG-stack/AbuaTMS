<%@ Page Title="" Language="C#" MasterPageFile="~/PPD/PPD.master" AutoEventWireup="true" CodeFile="PPDCaseSearch.aspx.cs" Inherits="PPD_PPDCaseSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox-title text-center">
                        <h3 class="text-white">Case Search</h3>
                    </div>
                    <div class="ibox-content">
                        <div class="ibox">
                            <div class="ibox-content text-dark">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Case Number</span>
                                        <asp:TextBox runat="server" ID="tbCaseNo" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Beneficiary Card Number</span>
                                        <asp:TextBox runat="server" ID="tbBeneficiaryCardNumber" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Patient State<span class="text-danger">*</span></span><br />
                                        <asp:DropDownList ID="dlPatientState" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Patient District</span><br />
                                        <asp:DropDownList ID="dlPatientDistrict" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Case Type<span class="text-danger">*</span></span><br />
                                        <asp:DropDownList ID="dlCaseType" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Scheme<span class="text-danger">*</span></span><br />
                                        <asp:DropDownList ID="dlScheme" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Hospital State<span class="text-danger">*</span></span><br />
                                        <asp:DropDownList ID="dlHospitalState" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Hospital Name<span class="text-danger">*</span></span><br />
                                        <asp:DropDownList ID="dlHospitalName" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Category<span class="text-danger">*</span></span><br />
                                        <asp:DropDownList ID="dlCategory" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Procedure Name<span class="text-danger">*</span></span><br />
                                        <asp:DropDownList ID="dlProcedureName" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Case Status<span class="text-danger">*</span></span><br />
                                        <asp:DropDownList ID="dlCaseStatus" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Policy Period<span class="text-danger">*</span></span><br />
                                        <asp:DropDownList ID="dlPolicyPeriod" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">UTR<span class="text-danger">*</span></span>
                                        <asp:TextBox ID="tbUtr" runat="server" class="form-control mt-2" OnKeypress="return isAlphaNumeric(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Hospital District<span class="text-danger">*</span></span><br />
                                        <asp:DropDownList ID="dlHospitalDistrict" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Record Period<span class="text-danger">*</span></span><br />
                                        <asp:DropDownList ID="dlRecordPeriod" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Special Case<span class="text-danger">*</span></span><br />
                                        <asp:DropDownList ID="dlSpecialCase" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">Advance Search Parameter<span class="text-danger">*</span></span><br />
                                        <asp:DropDownList ID="dlAdvanceSearchParameter" runat="server" class="form-control mt-2">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">From Date<span class="text-danger">*</span></span>
                                        <asp:TextBox ID="tbFromDate" runat="server" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <span class="form-label fw-semibold" style="font-size: 14px;">To Date<span class="text-danger">*</span></span>
                                        <asp:TextBox ID="tbToDate" runat="server" class="form-control mt-2" TextMode="Date" OnKeypress="return isDate(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-md-6 mt-3">
                                        <span class="text-danger fw-bold">Note:<span class="fw-normal"> Report will be generated for maximum of 90 days.</span></span>
                                    </div>
                                    <div class="col-lg-12 text-center mt-2">
                                        <asp:Button ID="btnSearch" runat="server" class="btn btn-success rounded-pill" Text="Search" />
                                        <asp:Button ID="btnReset" runat="server" class="btn btn-warning rounded-pill" Text="Reset" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card mt-4">
                        <div class="card-body">
                            <h5 class="card-title">Total No Of Records</h5>
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr class="table-primary">
                                            <th scope="col" style="background-color: #007e72; color: white;">S.No</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Case No</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Claim No</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Patient Name</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Contact No</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Card Number</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Case Status</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Hospital Name</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Patient Registration Date</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Case Registration Date</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Category</th>
                                            <th scope="col" style="background-color: #007e72; color: white;">Others</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td><a href="PPDCaseDetails.aspx" class="text-decoration-underline text-black fw-semibold">CASE/PS7/HOSP20G12238/P2897102</a></td>
                                            <td>TRUST/RAN/2024/3393003210/1</td>
                                            <td>SEETA KUMARI</td>
                                            <td>9898989898</td>
                                            <td>MD02V937R</td>
                                            <td>Procedure auto approved insurance (Insurance)
                                            </td>
                                            <td>CHC NAMKUM</td>
                                            <td>16/07/2024</td>
                                            <td>16/07/2024</td>
                                            <td>Emergency Room Package......</td>
                                            <td>Other data</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <%--<asp:GridView ID="gridCaseSearch" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                            <alternatingrowstyle backcolor="Gainsboro" />
                            <columns>
                                <asp:TemplateField HeaderText="S.No.">
                                    <itemtemplate>
                                        <asp:Label ID="lbSlNo" runat="server" Text="1"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Case No">
                                    <itemtemplate>
                                        <asp:Label ID="lbCaseNo" runat="server" Text="CASE/PS7"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Claim No">
                                    <itemtemplate>
                                        <asp:Label ID="lbClaimNo" runat="server" Text="TRUST/RAN"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Patient Name">
                                    <itemtemplate>
                                        <asp:Label ID="lbPatientName" runat="server" Text="Patient Name"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Contact No	">
                                    <itemtemplate>
                                        <asp:Label ID="lbContactNo" runat="server" Text="Contact No"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Beneficiary Card Number">
                                    <itemtemplate>
                                        <asp:Label ID="lbBeneficiaryCardNumber" runat="server" Text="Beneficiary Card Number"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Case Status">
                                    <itemtemplate>
                                        <asp:Label ID="lbCaseStatus" runat="server" Text="Case Status"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Hospital Name">
                                    <itemtemplate>
                                        <asp:Label ID="lbHospitalName" runat="server" Text="Hospital Name"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Patient Registration Date">
                                    <itemtemplate>
                                        <asp:Label ID="lbPatientRegistrationDate" runat="server" Text="Patient Registration Date"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Case Registration Date">
                                    <itemtemplate>
                                        <asp:Label ID="lbCaseRegistrationDate" runat="server" Text="Case Registration Date"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Category">
                                    <itemtemplate>
                                        <asp:Label ID="lbCategory" runat="server" Text="Category"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Others">
                                    <itemtemplate>
                                        <asp:Label ID="lbOthers" runat="server" Text="Others"></asp:Label>
                                    </itemtemplate>
                                    <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" />
                                    <itemstyle horizontalalign="Center" verticalalign="Middle" width="5%" />
                                </asp:TemplateField>
                            </columns>
                        </asp:GridView>--%>
                            </div>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-end" style="margin: 10px 0 0 0;">
                                    <li class="page-item disabled">
                                        <a class="page-link">Previous</a>
                                    </li>
                                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">Next</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
