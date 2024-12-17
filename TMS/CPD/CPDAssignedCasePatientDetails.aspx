﻿<%@ Page Title="" Language="C#" MasterPageFile="~/CPD/CPD.master" AutoEventWireup="true" CodeFile="CPDAssignedCasePatientDetails.aspx.cs" Inherits="CPD_CPDAssignedCasePatientDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .nav-tabs .nav-link {
            background-color: #1ab394;
            color: white;
            border: none;
        }


            .nav-tabs .nav-link.active {
                background-color: #c9b412;
                color: black;
            }



        .nav-tabs .nav-attach {
            background-color: #e1e1e1;
            color: white;
            border: none;
        }

            .nav-tabs .nav-attach.active {
                background-color: #ff9800;
                color: white;
                border: none;
            }

        .radio-button {
            font-family: Arial, sans-serif;
            margin-bottom: 15px;
        }

        .required {
            color: red;
        }

        .radio-options {
            display: flex;
            align-items: center;
            margin-top: 5px;
        }

            .radio-options label {
                margin-right: 20px;
                font-size: 14px;
                cursor: pointer;
            }

        input[type="radio"] {
            margin-right: 10px;
        }

        .button-group {
            display: flex; /* Arrange buttons in one line */
            gap: 10px; /* Optional: Space between buttons */
        }

            .button-group .nav-link {
                background-color: #1ab394; /* Button background color */
                color: white; /* Text color */
                border: none; /* Remove default border */
                border-radius: 5px; /* Optional: Rounded corners */
                padding: 10px 20px; /* Adjust padding to increase button size */
                cursor: pointer; /* Pointer cursor on hover */
                flex-grow: 1; /* Optional: Makes all buttons the same width */
                text-align: center; /* Center the text */
            }

                .button-group .nav-link:hover {
                    background-color: #18a085; /* Darker shade on hover */
                }

        .dropdown-underline {
            border: none; /* Remove the default dropdown borders */
            border-bottom: 2px solid lightgrey; /* Adds a bottom line like <hr> */
            border-width: thin;
            background-color: transparent; /* Transparent background to avoid box appearance */
            width: 100%; /* Full width */
            padding: 5px 0; /* Padding for space */
            font-size: 12px; /* Set a readable font size */
            outline: none; /* Remove the default focus outline */
            -webkit-appearance: none; /* Remove default dropdown arrow in WebKit browsers */
            -moz-appearance: none; /* Remove default dropdown arrow in Firefox */
            appearance: none; /* Remove default dropdown arrow for modern browsers */
            cursor: pointer; /* Show pointer to indicate dropdown is clickable */
        }

        .dropdown-wrapper {
            position: relative; /* Required for positioning the arrow */
        }

        .dropdown-arrow {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none; /* Ignore clicks on the arrow */
            font-size: 12px; /* Adjust size of the arrow */
            color: grey;
        }

        .span-title {
            font-weight: 700;
            font-size: 14px;
        }

        /* Override Bootstrap tab background color */
        .nav-tabs .nav-link {
            background-color: #1ab394;
            color: white; /* White text color for all tabs */
            border: none; /* Remove borders */
        }

            .nav-tabs .nav-link.active {
                background-color: #c9b412; /* Yellow background for the active tab */
                color: black; /* Change text color to black when active */
            }

        .nav-tabs .nav-attach {
            background-color: #e1e1e1;
            color: black !important; /* White text color for all tabs */
            border: none; /* Remove borders */
        }

            .nav-tabs .nav-attach.active {
                background-color: #ff9800;
                color: white !important; /* White text color for all tabs */
                border: none; /* Remove borders */
            }
    </style>
    <script type="text/javascript">
        function setView(viewIndex) {
            __doPostBack('<%= mvCPDTabs.UniqueID %>', viewIndex.toString());
        }
    </script>
    <script type="text/javascript">
        window.onbeforeunload = function (event) {
            notifyServerOnTabClose();
        };

        function notifyServerOnTabClose() {
            $.ajax({
                type: "POST",
                url: "CPDClaimUpdation.aspx/HandleWindowClose",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log("Window close event handled.");
                },
                failure: function (response) {
                    console.log("Failed to handle window close event.");
                }
            });
        }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:MultiView ID="multiViewRecords" runat="server" ActiveViewIndex="0">
                <asp:View ID="viewMain" runat="server">
                    <asp:HiddenField ID="hdUserId" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdAbuaId" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdPatientRegId" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdHospitalId" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdPackageId" runat="server" Visible="false" />
                    <asp:HiddenField ID="hfPDId" runat="server" Visible="false" />
                    <asp:HiddenField ID="hfAdmissionId" runat="server" Visible="false" />

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="ibox ">
                                <div role="form" id="PatientDetailForm">
                                    <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                        <div class="d-flex w-100 justify-content-center position-relative" style="margin-left: -20px;">
                                            <h3 class="m-0">Patient Details</h3>
                                        </div>
                                        <div class="text-white text-nowrap">
                                            <span>Case No: </span>
                                            <asp:Label ID="lbCaseNoHead" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="ibox-content">

                                        <div class="ibox-content text-dark">
                                            <div class="row">
                                                <div class="col-lg-9">
                                                    <div class="form-group row">
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Name:</span><br />
                                                            <asp:Label ID="lbName" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Beneficiary Card ID:</span><br />
                                                            <asp:Label ID="lbBeneficiaryId" runat="server" Text="N/A"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Registration No:</span><br />
                                                            <asp:Label ID="lbRegNo" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Case No:</span><br />
                                                            <asp:Label ID="lbCaseNo" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Case Status:</span><br />
                                                            <asp:Label ID="lbCaseStatus" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">IP No:</span><br />
                                                            <asp:Label ID="lbIPNo" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">IP Registered Date:</span><br />
                                                            <asp:Label ID="lbIPRegDate" runat="server" Text="N/A"></asp:Label>

                                                        </div>

                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Actual Registration Date:</span><br />
                                                            <asp:Label ID="lbActualRegDate" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Contact No:</span><br />
                                                            <asp:Label ID="lbContactNo" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Hospital Type:</span><br />
                                                            <asp:Label ID="lbHospitalType" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Gender:</span><br />
                                                            <asp:Label ID="lbGender" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Family ID:</span><br />
                                                            <asp:Label ID="lbFamilyId" runat="server" Text="N/A"></asp:Label>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Age:</span><br />
                                                            <asp:Label ID="lbAge" runat="server" Text="N/A"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Aadhar Verified:</span><br />
                                                            <asp:Label ID="lbAadharVerified" runat="server" Text="N/A"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Authentication at Reg/Dis:</span><br />
                                                            <asp:Label ID="lbAuthentication" runat="server" Text="N/A"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Patient District:</span><br />
                                                            <asp:Label ID="lbPatientDistrict" runat="server" Text="N/A"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                            <span class="form-label fw-semibold" style="font-weight: bold;">Patient Scheme:</span><br />
                                                            <asp:Label ID="lbPatientScheme" runat="server" Text="MMASSY"></asp:Label>

                                                        </div>
                                                        <div class="col-md-3">
                                                        </div>

                                                    </div>
                                                </div>
                                                <div class="row col-lg-3">
                                                    <div class="col-lg-6 align-items-center">
                                                        <asp:Image ID="imgPatientPhoto" runat="server" ImageUrl="../images/user_img.jpeg" CssClass="img-fluid mb-3" Style="max-width: 100px; height: 140px; object-fit: cover;" AlternateText="Patient Photo" />
                                                    </div>
                                                    <div class="col-lg-6 align-items-center">
                                                        <asp:Image ID="imgPatientPhotosecond" runat="server" ImageUrl="../images/user_img.jpeg" CssClass="img-fluid mb-3" Style="max-width: 100px; height: 140px; object-fit: cover;" AlternateText="Patient Photo" />
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="button-group">
                                        <asp:Button ID="btnPastHistory" runat="server" Text="Past History" OnClick="btnPastHistory_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnPreauth" runat="server" Text="Preauthorization" OnClick="btnPreauth_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnTreatment" runat="server" Text="Treatment And Discharge" OnClick="btnTreatment_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnClaims" runat="server" Text="Claims" OnClick="btnClaims_Click" class="nav-link d-flex flex-column align-items-center" />
                                        <asp:Button ID="btnAttachments" runat="server" Text="Attachments" OnClick="btnAttachments_Click" class="nav-link d-flex flex-column align-items-center" />
                                    </div>
                                    <div class="tab-content mt-4" id="myTabContent">
                                        <asp:MultiView ID="mvCPDTabs" runat="server">
                                            <asp:View ID="ViewPast" runat="server">
                                                <div class="tab-pane fade show active" id="past" role="tabpanel">
                                                    <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                        <div class="d-flex w-100 justify-content-center position-relative">
                                                            <h3 class="m-0">Past History</h3>
                                                        </div>
                                                    </div>
                                                    <div class="ibox-content">
                                                        <div class="ibox">
                                                            <div class="ibox-content text-dark">
                                                                <div class="row align-items-end">
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-semibold">Case ID</span><br />
                                                                        <asp:TextBox ID="tbCaseId" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>

                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-semibold">From Date</span><br />
                                                                        <asp:TextBox ID="tbFromDate" runat="server" CssClass="form-control" type="date" OnKeyPress="return isDate(event)"></asp:TextBox>

                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <label class="form-label fw-semibold">To Date</label>
                                                                        <input class="form-control" type="date" />
                                                                    </div>
                                                                    <div class="col-lg-3">
                                                                        <button type="button" class="btn btn-primary"><i class="bi bi-search"></i>Search</button>
                                                                        <button type="reset" class="btn btn-warning"><i class="bi bi-search"></i>Reset</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <asp:GridView ID="gridPastHistory" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                            <AlternatingRowStyle BackColor="Gainsboro" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Sl.No.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Case ID">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbCaseId" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Patient Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbPatientName" runat="server" Text='<%# Eval("email") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Hospital Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbHospitalName" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Case Status">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbCaseStatus" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Registered Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbRegDate" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Preauth Amount">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbPreauthAmt" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Claim Amount">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbClaimAmt" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Procedure">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbProcedure" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Admission Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbAdmissionDate" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Preauth Initiation Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbInitiationDate" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </asp:View>
                                            <asp:View ID="ViewPreauth" runat="server">
                                                <div class="tab-pane fade show active" id="preauth" role="tabpanel">
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <div class="d-flex w-100 justify-content-center position-relative">
                                                                <h3 class="m-0">Network Hospital Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="ibox-content text-dark">
                                                                <div class="row">
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Hospital Name</span>
                                                                        <asp:TextBox ID="tbHospitalName" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Type</span>
                                                                        <asp:TextBox ID="tbType" runat="server" CssClass="form-control" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-semibold" style="font-size: 14px; font-weight: bold;">Address</span>
                                                                        <asp:TextBox ID="tbAddress" runat="server" CssClass="form-control" value="Ranchi, Jharkhand" OnKeyPress="return isAlphaNumeric(event)"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <h3 class="m-0">ICD Details</h3>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="ibox mt-4">
                                                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                    <div class="d-flex w-100 justify-content-center position-relative">
                                                                        <h3 class="m-0">Primary Diagnosis ICD Values</h3>
                                                                    </div>
                                                                </div>
                                                                <div class="ibox-content">
                                                                    <asp:GridView ID="gvICDDetails_Preauth" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Sl.No." ControlStyle-Font-Size="Small">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="PreauthId" runat="server" Text="NA"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="ICD Code">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="PreauthICDCode" runat="server" Text="NA"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="ICD Description">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="PreauthICDDes" runat="server" Text="NA"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Acted By Role">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="PreauthActRole" runat="server" Text='<%# Eval("ActedByRole") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <div class="d-flex w-100 justify-content-center position-relative">
                                                                <h3 class="m-0">Treatement Protocol</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <asp:GridView ID="gvTreatmentProtocol" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                <AlternatingRowStyle BackColor="Gainsboro" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Speciality">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbSpeciality" runat="server" Text='<%# Eval("SpecialityName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbProcedure" runat="server" Text='<%# Eval("ProcedureName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Quantity">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Amount(₹)">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbAmount" runat="server" Text='<%# Eval("ProcedureAmountFinal") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Stratification">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbStratification" runat="server" Text='<%# Eval("StratificationName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Implants">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbImplants" runat="server" Text='<%# Eval("ImplantName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <%-- <asp:TemplateField HeaderText="Update ICHI Details">
                                                                <itemtemplate>
                                                                    <asp:HyperLink ID="hlUpdateICHI" runat="server"
                                                                        NavigateUrl='<%# Eval("Id", "UpdateICHI.aspx?id={0}") %>'
                                                                        Text="Update ICHI Details">
                                                                    </asp:HyperLink>
                                                                </itemtemplate>
                                                                <headerstyle backcolor="#1E8C86" font-bold="True" forecolor="White" font-size="14px" />
                                                                <itemstyle horizontalalign="Center" verticalalign="Middle" width="10%" font-size="12px" />
                                                            </asp:TemplateField>--%>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <div class="d-flex w-100 justify-content-center position-relative">
                                                                <h3 class="m-0">ICHI Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <asp:GridView ID="gvICHIDetails" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                <AlternatingRowStyle BackColor="Gainsboro" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Procedure Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbProcedureName" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by MEDCO">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHIMedco" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by PPD">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHIPPD" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by PPD Insurer">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHIPPDInsurer" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by CPD">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHICPD" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by CPD Insurer">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHICPDInsurer" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by SAFO">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHISAFO" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ICHI Code given by NAFO">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbICHINAFO" runat="server" Text="NA"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                    </asp:TemplateField>

                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Admission Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row text-dark">
                                                                <div class="col-md-4 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Admission Type</span>
                                                                        <div class="d-flex">
                                                                            <div class="form-check form-check-inline me-2">
                                                                                <asp:RadioButton ID="RBPlanned" runat="server" GroupName="inlineRadioOptions" Checked="true" Enabled="false" CssClass="form-check-input" />
                                                                                <span class="font-weight-bold text-dark">Planned</span>
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="RBEmergency" runat="server" GroupName="inlineRadioOptions" Enabled="false" CssClass="form-check-input" />
                                                                                <span class="font-weight-bold text-dark">Emergency</span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-8 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Admission Date</span><br />
                                                                        <asp:Label ID="lbAdmissionDate_Preauth" runat="server" CssClass="border-bottom" Style="margin-bottom: 0; padding-bottom: 0;"></asp:Label>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Package Cost</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="lbPackageCost" runat="server" CssClass="form-label" Style="margin-bottom: 0; padding-bottom: 0;"></asp:Label>
                                                                    <hr style="margin-top: 0;" />
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Hospital Incentive:</span>
                                                                    <asp:Label ID="lbHospitalIncentive" runat="server" CssClass="form-label" Style="margin-bottom: 0; padding-bottom: 0;"></asp:Label>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Incentive Amount</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="lbIncentiveAmount" runat="server" CssClass="form-label" Style="margin-bottom: 0; padding-bottom: 0;"></asp:Label>
                                                                    <hr style="margin-top: 0;" />
                                                                </div>
                                                                <div class="col-md-4 mb-3"></div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Total Package Cost</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="lbTotalPackageCost" runat="server" CssClass="form-label" Style="margin-bottom: 0; padding-bottom: 0;"></asp:Label>
                                                                    <hr style="margin-top: 0;" />
                                                                </div>

                                                                <div class="col-md-4 mb-3"></div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Total Amount Liable by Insurance is</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="lbTotalAmtInsurance" runat="server" CssClass="form-label" Text="100000" />
                                                                    <hr style="margin-top: 0;" />
                                                                </div>
                                                                <div class="col-md-4 mb-3"></div>
                                                                <div class="col-md-4 mb-3">
                                                                    <span class="font-weight-bold text-dark">Total Amount Liable by Trust is</span>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <asp:Label ID="lbTotalAmtTrust" runat="server" CssClass="form-label" Text="13615" />
                                                                    <hr style="margin-top: 0;" />
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12 mb-3">
                                                                <div class="form-group">
                                                                    <span class="font-weight-bold text-dark">Remarks</span>
                                                                    <asp:TextBox ID="tbRemarks" runat="server" OnKeypress="return isAlphaNumeric(event);" TextMode="MultiLine" CssClass="form-control" Style="margin-bottom: 0;"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12">
                                                                <span class="font-weight-bold text-danger">Note: Only ()?,./ special characters are allowed for Remarks</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <div class="d-flex w-100 justify-content-center position-relative">
                                                                <h3 class="m-0">Work Flow</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row">
                                                                <div class="table-responsive">
                                                                    <asp:GridView ID="gvPreauthWorkFlow" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="S.No.">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbSlNo" runat="server" Text='<%# Eval("SlNo") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Date And Time">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbPreActionDate" runat="server" Text='<%# Eval("ActionDate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Role Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbPreRoleName" runat="server" Text='<%# Eval("RoleName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Remarks">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbPreRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Action">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbPreActionTaken" runat="server" Text='<%# Eval("ActionTaken") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Approved Amount(Rs.)">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbPreAmount" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="PreAuth Query/Rejection Reasons">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbPreRejectionReason" runat="server" Text='<%# Eval("RejectionReason") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                            <div style="margin-top: 20px;">
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                                                                    <label class="form-check-label" for="flexCheckDefault">
                                                                        I have reviewed the cases with the best of my knowledge and have validated all documents before making any decision
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>


                                                    </div>
                                                </div>
                                            </asp:View>
                                            <asp:View ID="ViewTreatmentDischarge" runat="server">
                                                <div class="tab-pane fade show active" id="treatmentdischarge" role="tabpanel">
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Surgeon Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row text-dark">
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Doctor Type</span><br />
                                                                        <asp:DropDownList ID="dropDocType" runat="server" CssClass="form-control">
                                                                            <asp:ListItem>Other</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Name</span><br />
                                                                        <asp:DropDownList ID="dropDocName" runat="server" CssClass="form-control">
                                                                            <asp:ListItem>Dr. Sanjeet Anand(1759)</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Regn No</span><br />
                                                                        <asp:Label ID="lbRegnNo" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="1759"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Qualification</span><br />
                                                                        <asp:Label ID="lbQualification" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Contact No</span><br />
                                                                        <asp:Label ID="Label2" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--Anaesthetist Details--%>
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Anaesthetist Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row text-dark">
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Anaesthetist Name</span><br />
                                                                        <asp:DropDownList ID="dropAnaesthetistName" runat="server" CssClass="form-control">
                                                                            <asp:ListItem>Select</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Regn No</span><br />
                                                                        <asp:Label ID="lbAnaesthetistRegNo" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="1759"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Contact No</span><br />
                                                                        <asp:Label ID="lbAnaesthetistContactNo" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Anaesthetist Type</span><br />
                                                                        <asp:DropDownList ID="dropAnaesthetistType" runat="server" CssClass="form-control">
                                                                            <asp:ListItem>Select</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--Procedure Details--%>
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Procedure Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row text-dark">
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Incision type</span><br />
                                                                        <asp:Label ID="lbIncisionType" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">OP Photos/WebEx Taken</span><br />
                                                                        <div class="d-flex">
                                                                            <div class="form-check form-check-inline me-2">
                                                                                <asp:RadioButton ID="rbOPPhotoYes" runat="server" GroupName="OPPhotoWebEx" Text="&nbsp;&nbsp;&nbsp;Yes" CssClass="form-check-input" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbOPPhotoNo" runat="server" GroupName="OPPhotoWebEx" Text="&nbsp;&nbsp;&nbsp;No" CssClass="form-check-input" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Vedio Recording Done</span><br />
                                                                        <div class="d-flex">
                                                                            <div class="form-check form-check-inline me-2">
                                                                                <asp:RadioButton ID="rbVedioRecDoneYes" runat="server" GroupName="VedioRecording" Text="&nbsp;&nbsp;&nbsp;Yes" CssClass="form-check-input" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbVedioRecDoneNo" runat="server" GroupName="VedioRecording" Text="&nbsp;&nbsp;&nbsp;No" CssClass="form-check-input" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Swab Count Instruments Count</span><br />
                                                                        <asp:Label ID="lbSwabCounts" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Sutures Ligatures</span><br />
                                                                        <asp:Label ID="lbSurutes" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Specimen Removed</span><br />
                                                                        <div class="d-flex">
                                                                            <div class="form-check form-check-inline me-2">
                                                                                <asp:RadioButton ID="rbSpecimenRemoveYes" runat="server" GroupName="SpecimenRemoved" Text="&nbsp;&nbsp;&nbsp;Yes" CssClass="form-check-input" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbSpecimenRemoveNo" runat="server" GroupName="SpecimenRemoved" Text="&nbsp;&nbsp;&nbsp;No" CssClass="form-check-input" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Drainage Count</span><br />
                                                                        <asp:Label ID="lbDranageCount" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Blood Loss</span><br />
                                                                        <asp:Label ID="lbBloodLoss" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Post Operative Instructions</span><br />
                                                                        <asp:Label ID="lbOperativeInstructions" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Patient Condition</span><br />
                                                                        <asp:Label ID="lbPatientCondition" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Complications If Any</span><br />
                                                                        <div class="d-flex">
                                                                            <div class="form-check form-check-inline me-2">
                                                                                <asp:RadioButton ID="rbComplicationsYes" runat="server" GroupName="ComplicationIfAny" Text="&nbsp;&nbsp;&nbsp;Yes" CssClass="form-check-input" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbComplicationsNo" runat="server" GroupName="ComplicationIfAny" Text="&nbsp;&nbsp;&nbsp;No" CssClass="form-check-input" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--Treatment and Surgery Date--%>
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Treatment/Surgery Date</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row text-dark">
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Traetment/Surgery Date</span><br />
                                                                        <asp:Label ID="lbTraetmentDate" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="14/08/2024"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Surgery Start Time</span><br />
                                                                        <asp:TextBox ID="tbSurgeryStartTime" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Surgery End Time</span><br />
                                                                        <asp:TextBox ID="tbSurgeryEndTime" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--Surgery/Treatment Start Date Details--%>
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Surgery/Treatment Start Date Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <asp:GridView ID="GridSurgeryDate" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false">
                                                                <Columns>
                                                                    <asp:BoundField DataField="Procedure Code" HeaderText="Procedure Code" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                                    <asp:BoundField DataField="Procedure Name" HeaderText="Procedure Name" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                                    <asp:BoundField DataField="Surgery Date/Treatment Start Date" HeaderText="Surgery Date/Treatment Start Date" HtmlEncode="false" HeaderStyle-CssClass="bg-dark-green text-center p-3" ItemStyle-CssClass="text-center p-3" />
                                                                </Columns>
                                                            </asp:GridView>
                                                            <span class="font-weight-bold text-danger">Note:</span>
                                                            <span>Please select Treatment start date for Medical Procedure and Surgical Procedures</span>
                                                        </div>
                                                    </div>
                                                    <%--Treatment Summary--%>
                                                    <div class="ibox">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Treatment Summary</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row text-dark">
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Traetment Given</span><br />
                                                                        <asp:TextBox ID="ybTreatmentGiven" ReadOnly="true" runat="server" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Operative Findings</span><br />
                                                                        <asp:TextBox ID="tbOperativeFindings" ReadOnly="true" runat="server" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Post Operative Period</span><br />
                                                                        <asp:TextBox ID="tbPostOperativePeriod" ReadOnly="true" runat="server" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Post Surgery/Therapy Special Investigations Given</span><br />
                                                                        <asp:TextBox ID="tbSpecialInvestigationGiven" ReadOnly="true" runat="server" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Status at the time of Discharge</span><br />
                                                                        <asp:TextBox ID="tbStatusAtDischarge" runat="server" ReadOnly="true" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Review</span><br />
                                                                        <asp:TextBox ID="tbReview" runat="server" ReadOnly="true" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Advice</span><br />
                                                                        <asp:TextBox ID="tbAdvice" runat="server" ReadOnly="true" TextMode="MultiLine" CssClass="form-control border-0 border-bottom "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3 d-flex justify-content-center">
                                                                    <div class="d-flex">
                                                                        <div class="form-check form-check-inline me-2">
                                                                            <asp:RadioButton ID="rbDischarge" runat="server" GroupName="DischargeOrDeath" Checked="true" Enabled="false" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">Discharge</span>
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <asp:RadioButton ID="rbDeath" runat="server" GroupName="DischargeOrDeath" Enabled="false" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">Death</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- Placeholder for dynamic content -->
                                                    <asp:Panel ID="pnlDischarge" runat="server" CssClass="ibox mt-4">
                                                        <div class="ibox">
                                                            <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                                <div class="w-100 text-center">
                                                                    <h3 class="m-0">Discharge</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <div class="row text-dark">
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Discharge Date</span><br />
                                                                            <asp:Label ID="lbDischargeDate" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="16/07/2024 11:30"></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Next Follow Up Date</span><br />
                                                                            <asp:Label ID="lbNextFollowUp" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="18/07/2024"></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Consult at Block Name</span><br />
                                                                            <asp:Label ID="lbConsultBlockName" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Floor</span><br />
                                                                            <asp:Label ID="lbFloor" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Room No</span><br />
                                                                            <asp:Label ID="lbRoomNo" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Is Special Case</span><br />
                                                                            <asp:Label ID="lbIsSpecialCase" runat="server" CssClass="d-block w-100 border-bottom p-2" Text="&nbsp;"></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Final Diagnosis</span><br />
                                                                            <asp:DropDownList ID="dropFinalDiagnosis" runat="server" CssClass="form-control border-0 border-bottom">
                                                                                <asp:ListItem>Select</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="form-group">
                                                                            <span class="font-weight-bold text-dark">Procedure Consent</span><br />
                                                                            <div class="d-flex">
                                                                                <div class="form-check form-check-inline me-2">
                                                                                    <asp:RadioButton ID="rbConsentYes" runat="server" GroupName="ProceduralConsent" Text="&nbsp;&nbsp;&nbsp;Yes" CssClass="form-check-input" />
                                                                                </div>
                                                                                <div class="form-check form-check-inline">
                                                                                    <asp:RadioButton ID="rbConsentNo" runat="server" GroupName="ProceduralConsent" Text="&nbsp;&nbsp;&nbsp;No" CssClass="form-check-input" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-12 mb-3">
                                                                        <asp:CheckBox ID="cbDischarge" CssClass="text-dark font-weight-bold" Text="&nbsp;&nbsp;&nbsp;I hereby declare that the discharge type selected is correct" runat="server" />
                                                                    </div>
                                                                    <span class="text-danger font-weight-bold">Note:</span>
                                                                    <ol class="text-danger font-weight-bold">
                                                                        <li>Once the Discharge date/Death Date is updated in the discharge summary, it can not be modified at any point of time.</li>
                                                                        <li>Please save surgery/discharge page before printing Discharge summary</li>
                                                                    </ol>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </asp:Panel>
                                                </div>
                                            </asp:View>

                                            <asp:View ID="ViewClaims" runat="server">
                                                <div class="tab-pane fade show active" id="claims" role="tabpanel">
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <div class="d-flex w-100 justify-content-center position-relative">
                                                                <h3 class="m-0">Diagnosis and Treatement</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="ibox-content text-dark">
                                                                <div class="row">
                                                                    <div class="col-md-3 mb-3">
                                                                        <sapn class="form-label fw-semibold">Primary Diagnosis<span class="text-danger">*</span></sapn>
                                                                        <asp:DropDownList ID="dropPrimaryDiagnosis" AutoPostBack="true" OnSelectedIndexChanged="dropPrimaryDiagnosis_SelectedIndexChanged" runat="server" CssClass="form-control">
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="col-md-3"></div>
                                                                    <div class="col-md-3 mb-3">
                                                                        <span class="form-label fw-semibold">Secondary Diagnosis<span class="text-danger">*</span></span>
                                                                        <asp:DropDownList ID="dropSecondaryDiagnosis" AutoPostBack="true" OnSelectedIndexChanged="dropSecondaryDiagnosis_SelectedIndexChanged" runat="server" CssClass="form-control">
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="row mb-3">
                                                                        <div class="col-md-6">
                                                                            <asp:GridView ID="gridPrimaryDiagnosis" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                                <AlternatingRowStyle BackColor="Gainsboro" />
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Sl No.">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lbPPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Diagnosis Name">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Cancel">
                                                                                        <ItemTemplate>
                                                                                            <asp:LinkButton ID="lnkDeletePrimaryDiagnosis" runat="server" CssClass="text-danger" OnClick="lnkDeletePrimaryDiagnosis_Click" CommandArgument='<%# Eval("PDId") %>'>Remove</asp:LinkButton>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <asp:GridView ID="gridSecondaryDiagnosis" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" GridLines="Both" CellPadding="3" Width="100%">
                                                                                <AlternatingRowStyle BackColor="Gainsboro" />
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Sl No.">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lbSlNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="PD Id" Visible="false">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lbSPDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Diagnosis Name">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lbName" runat="server" Text='<%# Eval("PrimaryDiagnosisName") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Cancel">
                                                                                        <ItemTemplate>
                                                                                            <asp:LinkButton
                                                                                                ID="lnkDeleteSecondaryDiagnosis"
                                                                                                runat="server"
                                                                                                CssClass="text-danger"
                                                                                                OnClick="lnkDeleteSecondaryDiagnosis_Click"
                                                                                                CommandArgument='<%# Eval("PDId") %>'>
                                                                                                Remove</asp:LinkButton>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </div>
                                                                        <div class="col-md-12 mt-2">
                                                                            <span class="text-danger">Note: User can select multiple options in Primary and Secondary diagnosis fields.</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <h3 class="m-0">ICD Details</h3>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="ibox mt-4">
                                                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                    <div class="d-flex w-100 justify-content-center position-relative">
                                                                        <h3 class="m-0">Primary Diagnosis ICD Values</h3>
                                                                    </div>
                                                                </div>
                                                                <div class="ibox-content">
                                                                    <asp:GridView ID="gvPICDDetails_Claim" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Sl.No." ControlStyle-Font-Size="Small">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimPICDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="ICD Code">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimPICDCode" runat="server" Text='<%# Eval("ICDCode") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="ICD Description">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimPICDDescription" runat="server" Text='<%# Eval("ICDDescription") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Acted By Role">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimPActRole" runat="server" Text='<%# Eval("ActedByRole") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="ibox mt-4">
                                                                <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                    <div class="d-flex w-100 justify-content-center position-relative">
                                                                        <h3 class="m-0">Secondary Diagnosis ICD Values</h3>
                                                                    </div>
                                                                </div>
                                                                <div class="ibox-content">
                                                                    <asp:GridView ID="gvSICDDetails_Claim" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
                                                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Sl.No." ControlStyle-Font-Size="Small">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimSICDId" runat="server" Text='<%# Eval("PDId") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="ICD Code">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimSICDCode" runat="server" Text='<%# Eval("ICDCode") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="ICD Description">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimSICDDescription" runat="server" Text='<%# Eval("ICDDescription") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Acted By Role">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="ClaimSActRole" runat="server" Text='<%# Eval("ActedByRole") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" Font-Size="14px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" Font-Size="12px" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>

                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <div class="d-flex w-100 justify-content-center position-relative">
                                                                <h3 class="m-0">Claims Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="ibox-content text-dark">
                                                                <div class="col-lg-12">
                                                                    <div class="form-group row">
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Preauth Approved Amount(Rs):</span><br />
                                                                            <asp:Label ID="lbPreauthApprovedAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Preauth Date:</span><br />
                                                                            <asp:Label ID="lbPreauthDate" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Claim Submitted Date:</span><br />
                                                                            <asp:Label ID="lbClaimSubmittedDate" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Last Claim Updated Date:</span><br />
                                                                            <asp:Label ID="lbLastClaimUpadted" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Penalty Amount:</span><br />
                                                                            <asp:Label ID="lbPenaltyAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Claim Amount:</span><br />
                                                                            <asp:Label ID="lbClaimAmount" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Insurance Liable Amount:</span><br />
                                                                            <asp:Label ID="lbInsuranceLiableAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Trust Liable Amount:</span><br />
                                                                            <asp:Label ID="lbTrustLiableAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Bill Amount:</span><br />
                                                                            <asp:Label ID="lbBillAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Final E-rupi Voucher Amount:</span><br />
                                                                            <asp:Label ID="lbFinalErupiAmt" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <span class="form-label fw-semibold" style="font-size: 14px; font-weight: 800;">Remarks:</span>
                                                                            <asp:Label ID="lbRemark" Style="font-size: 12px;" runat="server" Text="N/A"></asp:Label>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--Non Technical Checklist--%>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between align-items-center text-white">
                                                            <div class="w-100 text-center">
                                                                <h3 class="m-0">Non Technical Checklist</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="row text-dark">
                                                                <div class="col-md-8 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">1) Name in Case Sheet and Consent Forms is Correct</span><span class="font-weight-bold text-danger">*</span>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <div class="d-flex">
                                                                        <div class="form-check form-check-inline me-2">
                                                                            <asp:RadioButton ID="rbIsNameCorrectYes" runat="server" GroupName="IsNameCorrect" CssClass="form-check-input" />
                                                                            <span class="form-check-label font-weight-bold text-dark">Yes</span>
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <asp:RadioButton ID="rbIsNameCorrectNo" runat="server" GroupName="IsNameCorrect" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">No</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-8 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">2) Gender in Cse Sheet and Consent Forms is Correct</span><span class="font-weight-bold text-danger">*</span>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <div class="d-flex">
                                                                        <div class="form-check form-check-inline me-2">
                                                                            <asp:RadioButton ID="rbIsGenderCorrectYes" runat="server" GroupName="IsGenderCorrect" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">Yes</span>
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <asp:RadioButton ID="rbIsGenderCorrectNo" runat="server" GroupName="IsGenderCorrect" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">No</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-8 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">3) Is Beneficiary Card Photo is Matching with Discharge Photo and Onbed Photo</span><span class="font-weight-bold text-danger">*</span>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <div class="d-flex">
                                                                        <div class="form-check form-check-inline me-2">
                                                                            <asp:RadioButton ID="rbIsPhotoVerifiedYes" runat="server" GroupName="IsPhotoVerified" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">Yes</span>
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <asp:RadioButton ID="rbIsPhotoVerifiedNo" runat="server" GroupName="IsPhotoVerified" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">No</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-12 mb-4">
                                                                    <span class="font-weight-bold text-dark">Date Verification</span>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <span class="font-weight-bold text-dark">Addmision Date</span><span class="font-weight-bold text-danger">*</span>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <span class="font-weight-bold text-dark">Online</span><br />
                                                                    <asp:Label ID="lbNonTechAdmissionDate" runat="server" CssClass="form-label" />
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <span class="font-weight-bold text-dark">Case Sheet</span>
                                                                    <asp:TextBox ID="tbCSAdmissionDate" runat="server" TextMode="Date" AutoPostBack="true" CssClass="form-control border-0 border-bottom"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="d-flex">
                                                                        <div class="form-check form-check-inline me-2">
                                                                            <asp:RadioButton ID="rbIsAdmissionDateVerifiedYes" runat="server" GroupName="IsAdmissionDateVerified" Enabled="false" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">Yes</span>
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <asp:RadioButton ID="rbIsAdmissionDateVerifiedNo" runat="server" GroupName="IsAdmissionDateVerified" Enabled="false" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">No</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <span class="font-weight-bold text-dark">Surgery/Therepy Date</span><span class="font-weight-bold text-danger">*</span>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <span class="font-weight-bold text-dark">Online</span><br />
                                                                    <asp:Label ID="lbNonTechSurgeryDate" runat="server" CssClass="form-label" />
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <span class="font-weight-bold text-dark">Case Sheet</span>
                                                                    <asp:TextBox ID="tbCSTherepyDate" runat="server" TextMode="Date" AutoPostBack="true" CssClass="form-control border-0 border-bottom"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="d-flex">
                                                                        <div class="form-check form-check-inline me-2">
                                                                            <asp:RadioButton ID="rbIsSurgeryDateVerifiedYes" runat="server" GroupName="IsSurgeryDateCSVerified" Enabled="false" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">Yes</span>
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <asp:RadioButton ID="rbIsSurgeryDateVerifiedNo" runat="server" GroupName="IsSurgeryDateCSVerified" Enabled="false" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">No</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <span class="font-weight-bold text-dark">Discharge/Death Date</span><span class="font-weight-bold text-danger">*</span>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <span class="font-weight-bold text-dark">Online</span><br />
                                                                    <asp:Label ID="lbNonTechDeathDate" runat="server" CssClass="form-label" />
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <span class="font-weight-bold text-dark">Case Sheet</span>
                                                                    <asp:TextBox ID="tbCSDischargeDate" runat="server" TextMode="Date" AutoPostBack="true" CssClass="form-control border-0 border-bottom"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-3 mb-3">
                                                                    <div class="d-flex">
                                                                        <div class="form-check form-check-inline me-2">
                                                                            <asp:RadioButton ID="rbIsDischargeDateCSVerifiedYes" runat="server" GroupName="IsDischargeDateCSVerified" Enabled="false" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">Yes</span>
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <asp:RadioButton ID="rbIsDischargeDateCSVerifiedNo" runat="server" GroupName="IsDischargeDateCSVerified" Enabled="false" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">No</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-12 mb-4">
                                                                    <span class="font-weight-bold text-dark">Document Verification</span>
                                                                </div>
                                                                <div class="col-md-8 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">1) Patient/Attendant Signature is Matching across two Forms(Counselling Form and Consent Letter)</span><span class="font-weight-bold text-danger">*</span>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <div class="d-flex">
                                                                        <div class="form-check form-check-inline me-2">
                                                                            <asp:RadioButton ID="rbIsSignVerifiedYes" runat="server" GroupName="IsSignVerified" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">Yes</span>
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <asp:RadioButton ID="rbIsSignVerifiedNo" runat="server" GroupName="IsSignVerified" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">No</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-8 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">2) Reports are Signed by Doctors with Registration Number</span><span class="font-weight-bold text-danger">*</span>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <div class="d-flex">
                                                                        <div class="form-check form-check-inline me-2">
                                                                            <asp:RadioButton ID="rbIsReportCorrectYes" runat="server" GroupName="IsReportCorrect" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">Yes</span>
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <asp:RadioButton ID="rbIsReportCorrectNo" runat="server" GroupName="IsReportCorrect" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">No</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-8 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">3) Dates and Patient Name are Correctly Stated on the Reports</span><span class="font-weight-bold text-danger">*</span>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4 mb-3">
                                                                    <div class="d-flex">
                                                                        <div class="form-check form-check-inline me-2">
                                                                            <asp:RadioButton ID="rbIsReportVerifiedYes" runat="server" GroupName="IsReportVerified" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">Yes</span>
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <asp:RadioButton ID="rbIsReportVerifiedNo" runat="server" GroupName="IsReportVerified" CssClass="form-check-input" />
                                                                            <span class="font-weight-bold text-dark">No</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-12 mb-3">
                                                                    <div class="form-group">
                                                                        <span class="font-weight-bold text-dark">Remarks</span>
                                                                        <asp:TextBox ID="tbNonTechFormRemark" runat="server" OnKeypress="return isAlphaNumeric(event);" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <div class="d-flex w-100 justify-content-center position-relative">
                                                                <h3 class="m-0">Technical Checklist</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="ibox-content text-dark">
                                                                <div class="col-lg-12">
                                                                    <div class="form-group row mb-3">
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">Total Claims (Rs):</span><br />
                                                                            <asp:TextBox runat="server" ID="tbTotalClaims" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">Insurance Approved Amount (Rs)<span class="text-danger">*</span>:</span><br />
                                                                            <asp:TextBox runat="server" ID="tbInsuranceApprovedAmt" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">Trust Approved Amount (Rs)<span class="text-danger">*</span>:</span><br />
                                                                            <asp:TextBox runat="server" ID="tbTrustApprovedAmt" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row mb-3">
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">Special Case:</span><br />
                                                                            <asp:TextBox runat="server" ID="tbSpecialCase" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                        </div>
                                                                    </div>

                                                                    <div class="row align-items-center">
                                                                        <div class="col-auto">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">1) Diagnosis is Supported by Evidence</span><span class="text-danger">*</span><br />
                                                                        </div>
                                                                        <div class="col text-right">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbDiagnosisSupportedYes" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="DiagnosisSupported" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbDiagnosisSupportedNo" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="DiagnosisSupported" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row align-items-center">
                                                                        <div class="col-auto">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">2) Case Management Proven to be done as per the Standard Treatment Protocols</span><span class="text-danger">*</span><br />
                                                                        </div>
                                                                        <div class="col text-right">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbCaseManagementYes" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="CaseManagement" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbCaseManagementNo" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="CaseManagement" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row align-items-center">
                                                                        <div class="col-auto">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">3) Evidence of the Therapy being Conducted exists beyond Doubts</span><span class="text-danger">*</span><br />
                                                                        </div>
                                                                        <div class="col text-right">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbEvidenceTherapyYes" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="EvidenceTherapy" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbEvidenceTherapyNo" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="EvidenceTherapy" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row align-items-center">
                                                                        <div class="col-auto">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">4) Mandatory Reports are Attached</span><span class="text-danger">*</span><br />
                                                                        </div>
                                                                        <div class="col text-right">
                                                                            <div class="form-check form-check-inline mt-2">
                                                                                <asp:RadioButton ID="rbMandatoryReportsYes" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="MandatoryReports" Text="Yes" />
                                                                            </div>
                                                                            <div class="form-check form-check-inline">
                                                                                <asp:RadioButton ID="rbMandatoryReportsNo" runat="server" class="form-check-label font-weight-bold text-dark" GroupName="MandatoryReports" Text="No" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <span class="form-label fw-bold" style="font-weight: 800;">Remarks:</span><br />
                                                                        <p style="font-size: 12px;">Document Verified</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="ibox mt-4">
                                                        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                            <div class="d-flex w-100 justify-content-center position-relative">
                                                                <h3 class="m-0">Add Deduction</h3>
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content">
                                                            <div class="ibox-content text-dark">
                                                                <div class="col-lg-12">
                                                                    <div class="form-group row mb-3">
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">Type</span><span class="text-danger">*</span><br />
                                                                            <asp:DropDownList runat="server" ID="dropDeductionType" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;">
                                                                                <asp:ListItem Text="--Select--" Value="Select"></asp:ListItem>
                                                                                <asp:ListItem Text="Consultations" Value="Consultation"></asp:ListItem>
                                                                                <asp:ListItem Text="Drugs and Consumable" Value="DrugsAndConsumable"></asp:ListItem>
                                                                                <asp:ListItem Text="Implants" Value="Implants"></asp:ListItem>
                                                                                <asp:ListItem Text="Investigation Charges" Value="InvestigationCharges"></asp:ListItem>
                                                                                <asp:ListItem Text="Others" Value="Others"></asp:ListItem>
                                                                                <asp:ListItem Text="Room Charges" Value="RoomCharges"></asp:ListItem>
                                                                                <asp:ListItem Text="Treatment Charges" Value="TreatmentCharges"></asp:ListItem>
                                                                                <asp:ListItem Text="Unspecified Procedures" Value="UnspecifiedProcedures"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">Amount</span><span class="text-danger">*</span><br />
                                                                            <asp:TextBox runat="server" ID="tbAmount" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">Remarks</span><span class="text-danger">*</span><br />
                                                                            <asp:TextBox runat="server" ID="tbDedRemarks" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="col-lg-12 text-start">
                                                                                <asp:Button runat="server" Text="Add Deduction" ID="btnAddDeduction" class="btn btn-primary rounded-pill mt-3" OnClick="AddDeduction_Click" />
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <span class="form-label fw-bold" style="font-weight: 800;">Total Deduction Amount:</span><br />
                                                                            <asp:TextBox runat="server" ID="tbTotalDeductionAmt" CssClass="border-0 border-bottom" Style="border-color: transparent; border-width: 0 0 1px; outline: none;"></asp:TextBox>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="ibox mt-4">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Work Flow</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <div class="row">
                                                                    <asp:GridView ID="gvClaimWorkFlow" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%">
                                                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="S.No.">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label8" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Date And Time">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("DateAndTime") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label10" runat="server" Text='<%# Eval("Names") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Remarks">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label11" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Action">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label13" runat="server" Text='<%# Eval("Action") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Approved Amount(Rs.)">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label15" runat="server" Text='<%# Eval("ApprovedAmt") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Claim Query/Rejection Reasons">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label16" runat="server" Text='<%# Eval("ClaimQueryRejectionReason") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="#1E8C86" Font-Bold="True" ForeColor="White" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="ibox mt-4">
                                                            <div class="ibox-content">
                                                                <div class="row">
                                                                    <div class="col-md-3 mb-3">
                                                                        <span class="form-label fw-semibold">Action<span class="text-danger">*</span></span>
                                                                        <asp:DropDownList ID="ddlActionType" runat="server" CssClass="form-control mt-2" AutoPostBack="True" OnSelectedIndexChanged="ddlActionType_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <asp:Panel ID="pUserRole" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                                        <span class="form-label fw-semibold">Select User Role<span class="text-danger">*</span></span>
                                                                        <asp:DropDownList ID="ddlUserRole" runat="server" CssClass="form-control mt-2" AutoPostBack="True">
                                                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="CPD INSURER" Value="1"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </asp:Panel>
                                                                    <asp:Panel ID="pUserToAssign" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                                        <span class="form-label fw-semibold">Select User To Assign<span class="text-danger">*</span></span>
                                                                        <asp:DropDownList ID="ddlUserToAssign" runat="server" CssClass="form-control mt-2" AutoPostBack="True">
                                                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </asp:Panel>
                                                                    <asp:Panel ID="pReason" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                                        <span class="form-label fw-semibold">Reason<span class="text-danger">*</span></span>
                                                                        <asp:DropDownList ID="ddlReason" runat="server" CssClass="form-control mt-2" AutoPostBack="true" OnSelectedIndexChanged="ddlReason_SelectedIndexChanged">
                                                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </asp:Panel>
                                                                    <asp:Panel ID="pSubReason" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                                        <span class="form-label fw-semibold">Sub Reason<span class="text-danger">*</span></span>
                                                                        <asp:DropDownList ID="ddlSubReason" runat="server" CssClass="form-control mt-2">
                                                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </asp:Panel>
                                                                    <asp:Panel ID="pRemarks" runat="server" Visible="false" CssClass="col-md-3 mb-3">
                                                                        <span class="form-label fw-semibold">Remarks</span>
                                                                        <asp:TextBox runat="server" ID="tbRejectRemarks" class="form-control mt-2"></asp:TextBox>
                                                                    </asp:Panel>
                                                                </div>
                                                                <div class="row mt-3">
                                                                    <div class="col-md-12 form-check mb-3">
                                                                        <asp:CheckBox ID="cbTerms" runat="server" CssClass="" Text="&nbsp;&nbsp;I have reviewed the case with best of my knowledge and have validated all documents before making any decision." />
                                                                    </div>
                                                                </div>
                                                                <div class="row mt-3">
                                                                    <div class="col-lg-12 text-start">
                                                                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary rounded-pill" Text="Submit" OnClick="btnSubmit_Click" AutoPostBack="True" />
                                                                        <asp:Label ID="lblMessage" runat="server" CssClass="text-success" Style="margin-left: 10px;"></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-12 mt-3">
                                                                    <asp:Label ID="lbInsuranceWalletAmount" class="text-danger m-0" runat="server" Text="Insurance Wallet Amount:  0.00"></asp:Label>
                                                                    <br />
                                                                    <asp:Label ID="lbSchemeWalletAmount" class="text-danger m-0" runat="server" Text="Scheme Wallet Amount:  0.00"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                            </asp:View>
                                            <asp:View ID="ViewAttachment" runat="server">
                                                <div class="tab-pane fade" id="attachment" role="tabpanel">
                                                    <ul class="nav nav-tabs d-flex flex-row justify-content-around" id="attachTab" role="tablist">
                                                        <li class="nav-item">
                                                            <a class="nav-link active nav-attach" id="one-tab"
                                                                data-toggle="tab" href="#one" role="tab" aria-controls="one" aria-selected="true">
                                                                <img src="~/images/notes-notepad-svgrepo-com.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="two-tab" data-toggle="tab" href="#two" role="tab" aria-controls="two" aria-selected="false">
                                                                <img src="~/images/bed-svgrepo-com.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="three-tab" data-toggle="tab" href="#three" role="tab" aria-controls="three" aria-selected="false">
                                                                <img src="~/images/foot-svgrepo-com.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="three-tab" data-toggle="tab" href="#four" role="tab" aria-controls="four" aria-selected="false">
                                                                <img src="~/images/rupee-sign-solid-svgrepo-com.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="three-tab" data-toggle="tab" href="#five" role="tab" aria-controls="five" aria-selected="false">
                                                                <img src="~/images/search.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="three-tab" data-toggle="tab" href="#six" role="tab" aria-controls="six" aria-selected="false">
                                                                <img src="~/images/search.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="three-tab" data-toggle="tab" href="#seven" role="tab" aria-controls="seven" aria-selected="false">
                                                                <img src="~/images/notes-tick-svgrepo-com.svg" width="20" />
                                                            </a>
                                                        </li>
                                                        <li class="nav-item ml-2">
                                                            <a class="nav-link nav-attach" id="three-tab" data-toggle="tab" href="#eight" role="tab" aria-controls="eight" aria-selected="false">
                                                                <img src="~/images/laptop.svg" width="20" />
                                                            </a>
                                                        </li>
                                                    </ul>
                                                    <div class="col-md-12 p-3">
                                                        <button class="btn btn-success rounded-pill">View All Inactive Attachments</button>
                                                        <button class="btn btn-success rounded-pill">View Data Anamoly Attachments</button>
                                                    </div>
                                                    <div class="tab-content" id="attachTabContent">
                                                        <div class="tab-pane fade show active" id="one" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Preauthorization</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <table class="table table-bordered table-striped">
                                                                    <thead>
                                                                        <tr class="table-primary">
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="two" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Discharge</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <table class="table table-bordered table-striped">
                                                                    <thead>
                                                                        <tr class="table-primary">
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="three" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Death</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <table class="table table-bordered table-striped">
                                                                    <thead>
                                                                        <tr class="table-primary">
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="four" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Claims</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <table class="table table-bordered table-striped">
                                                                    <thead>
                                                                        <tr class="table-primary">
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="five" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">General Investigations</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <table class="table table-bordered table-striped">
                                                                    <thead>
                                                                        <tr class="table-primary">
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="six" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Special Investigations</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <table class="table table-bordered table-striped">
                                                                    <thead>
                                                                        <tr class="table-primary">
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Pre or Post</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>PRE</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>PRE</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>PRE</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>PRE</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="seven" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Fraud Documents</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <table class="table table-bordered table-striped">
                                                                    <thead>
                                                                        <tr class="table-primary">
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade" id="eight" role="tabpanel">
                                                            <div class="ibox-title d-flex justify-content-between text-white align-items-center">
                                                                <div class="d-flex w-100 justify-content-center position-relative">
                                                                    <h3 class="m-0">Audit Documents</h3>
                                                                </div>
                                                            </div>
                                                            <div class="ibox-content">
                                                                <table class="table table-bordered table-striped">
                                                                    <thead>
                                                                        <tr class="table-primary">
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Attachment Name</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Uploaded Date</th>
                                                                            <th scope="col" style="background-color: #007e72; color: white;">Beneficiary Options</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Photo</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Declaration Letter From Patient</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Patient Id Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#." class="text-decoration-underline text-black fw-semibold">Certificate Of Proof</a></td>
                                                                            <td>17-08-2024 12:30:00</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-12 mt-3">
                                                            <p class="text-danger m-0">Note:</p>
                                                            <p class="text-danger m-0">1. File size should not exceed 500kb.</p>
                                                            <p class="text-danger m-0">2. Attachment names with blue color are related to notification.</p>
                                                            <p class="text-danger m-0">3. Discharge summary document quality and its notation.</p>
                                                            <p class="text-danger m-0">
                                                                4. Document of good quality.
                           
                                        <img src="~/images/file-check.svg" width="20" />
                                                            </p>
                                                            <p class="text-danger m-0">
                                                                4. Document of bad quality.
                           
                                        <img src="~/images/file-error.svg" width="15" />
                                                            </p>
                                                            <p class="text-danger m-0">
                                                                4. Document which is not valid.
                           
                                        <img src="~/images/invalid.svg" width="15" />
                                                            </p>
                                                            <p class="text-danger m-0">
                                                                4. Document of bad quality.
                           
                                        <img src="~/images/error.svg" width="15" />
                                                            </p>
                                                        </div>
                                                        <div class="col-md-12 mt-2 mb-2">
                                                            <button class="btn btn-success rounded-pill" type="button">Download as one PDF<img src="~/images/pdf.svg" width="15" class="ml-2" /></button>
                                                        </div>
                                                    </div>

                                                </div>
                                            </asp:View>
                                        </asp:MultiView>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </asp:View>

                <asp:View ID="viewNoDataPending" runat="server">
                    <div class="d-flex align-items-center justify-content-center m-5">
                        <asp:Label ID="lbNodataPending" runat="server" CssClass="font-weight-bold text-danger fs-2" Font-Size="Larger" Text="No records found."></asp:Label>
                    </div>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

