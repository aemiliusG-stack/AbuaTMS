<%@ Page Title="" Language="C#" MasterPageFile="~/ACO/ACO.master" AutoEventWireup="true" CodeFile="HospitalDetails.aspx.cs" Inherits="ACO_HospitalDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="ibox">
        <%-- <div class="ibox-title text-center" style="background-color: #31859c; color: white;">
            <h4>
                <asp:Label ID="lblHospitalHeading" runat="server" Text="">
            Hospital Details</asp:Label></h4>
        </div>--%>
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">Hospital Details</h3>
            </div>
        </div>
        <!-- Error Message -->
        <div class="row mt-3">
            <div class="col-md-12 text-center">
                <asp:Label ID="lblErrorMessage" runat="server" CssClass="text-danger" Visible="False"></asp:Label>
            </div>
        </div>
        <div class="ibox-content text-dark">
            <div class="row">
                <div class="col-lg-9">
                    <div class="row">
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Hospital Code:</span><br />
                            <asp:Label ID="lblHospitalCode" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Name:</span><br>
                            <asp:Label ID="lblHospitalName" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Type:</span><br>
                            <asp:Label ID="lblHospitalType" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Email:</span><br>
                            <asp:Label ID="lblEmail" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">City:</span><br>
                            <asp:Label ID="lblCity" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">District:</span><br>
                            <asp:Label ID="lblDistrict" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">State:</span><br>
                            <asp:Label ID="lblState" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Phone No:</span><br>
                            <asp:Label ID="lblContactNumber" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Scheme:</span><br>
                            <asp:Label ID="lblScheme" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Total Bed Strength:</span><br>
                            <asp:Label ID="lblTotalBedStrength" runat="server" Text="public"></asp:Label>
                        </div>
                        <div class="col-md-3 mt-3">
                            <span class="font-weight-bold">Total Amount Raise for Recovery:</span><br>
                            <asp:Label ID="RecoveryAmount" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="ibox mt-4">
        <div class="ibox-title d-flex justify-content-between text-white align-items-center">
            <div class="d-flex w-100 justify-content-center position-relative">
                <h3 class="m-0">Enter Amount</h3>
            </div>
        </div>
        <div class="ibox-content p-4 bg-light">
            <div class="row mb-3">
                <div class="col-md-6 col-lg-3 mb-3">
                    <div class="form-group">
                        <label class="fw-bold" style="color: black;">Recovery Amount <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtRecoveryAmount" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 mb-3">
                    <div class="form-group">
                        <label class="fw-bold" style="color: black;">Remarks <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" Style="border: none; border-bottom: 2px solid #D3D3D3;"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 mb-33">
                    <div class="form-group">
                        <label class="fw-bold" style="color: black;">Scheme <span class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;">
                            <asp:ListItem Text="MSBY(P)" Value="MSBY(P)" />
                        </asp:DropDownList>
                    </div>
                </div>
                <!-- File Upload Section -->
                <div class="col-md-6 col-lg-3 mb-3">
                    <div class ="form-group" id="fileUploadContainer" runat="server">
                        <div class="file-upload-item">
                            <label class="fw-bold" style="color: black;">File Upload</label>
                            <asp:FileUpload ID="fileUpload1" runat="server" CssClass="form-control" Style="border: none; border-bottom: 2px solid #D3D3D3;" />
                        </div>
                    </div>
                    <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-success mt-2" OnClick="btnAdd_Click" />
                    <asp:Button ID="btnMinus" runat="server" Text="Minus" CssClass="btn btn-danger mt-2" OnClick="btnMinus_Click" />
                </div>
               <%-- <!-- File Upload Section -->
                <div class="col-md-6 col-lg-3 mb-3">
                    <div class="form-group">
                        <label class="fw-bold" style="color: black;">File Upload</label>
                        <asp:FileUpload ID="fileUpload1" runat="server" CssClass="form-control" />
                    </div>
                    <div class="d-flex justify-content-between">
                        <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-success me-2" OnClick="btnAdd_Click" />
                        <asp:Button ID="btnMinus" runat="server" Text="Minus" CssClass="btn btn-danger" OnClick="btnMinus_Click" />
                    </div>
                </div>--%>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="fw-bold" style="color: black;">Recovery Type</label><br>
                        <asp:CheckBox ID="chkInsurance" runat="server" Text="Insurance" />
                    </div>
                </div>
            </div>
            <div class="col-md-6 text-right">
                <asp:Button ID="btnRaiseRecovery" runat="server" CssClass="btn btn-primary" Text="Raise Recovery" />
            </div>
        </div>
    </div>

</asp:Content>

