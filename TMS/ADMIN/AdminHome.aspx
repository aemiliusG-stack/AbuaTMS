<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="AdminHome.aspx.cs" Inherits="Admin_AdminHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="ibox-content d-flex" style="flex-wrap: wrap; gap: 30px; justify-content: flex-start">
        <div style="height: 140px; background-color: #19c0a0; border-radius: 5px; width: 220px; position: relative">
            <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white;">Total Users</span>
                <asp:Label ID="lbAdmin" runat="server" Text="0" Style="font-size: 35px; line-height: 1.5; font-weight: bold; color: white;"></asp:Label>
            </div>
            <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #008e81; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">Admin</span>
            </div>
        </div>
        <div style="height: 140px; background-color: #19c0a0; border-radius: 5px; width: 220px; position: relative">
            <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white;">Total Users</span>
                <asp:Label ID="lbMedco" runat="server" Text="0" Style="font-size: 35px; line-height: 1.5; font-weight: bold; color: white;"></asp:Label>
            </div>
            <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #008e81; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">MEDCO</span>
            </div>
        </div>
        <div style="height: 140px; background-color: #19c0a0; border-radius: 5px; width: 220px; position: relative">
            <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white;">Total Users</span>
                <asp:Label ID="lbPPDInsurer" runat="server" Text="0" Style="font-size: 35px; line-height: 1.5; font-weight: bold; color: white;"></asp:Label>
            </div>
            <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #008e81; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">PPD(Insurer)</span>
            </div>
        </div>
        <div style="height: 140px; background-color: #19c0a0; border-radius: 5px; width: 220px; position: relative">
            <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white;">Total Users</span>
                <asp:Label ID="lbPPDTrust" runat="server" Text="0" Style="font-size: 35px; line-height: 1.5; font-weight: bold; color: white;"></asp:Label>
            </div>
            <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #008e81; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">PPD(Trust)</span>
            </div>
        </div>

        <%--Trust Below--%>
        <div style="height: 140px; background-color: #6770b7; border-radius: 5px; width: 220px; position: relative">
            <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white;">Total Users</span>
                <asp:Label ID="lbCEXInsurer" runat="server" Text="0" Style="font-size: 35px; line-height: 1.5; font-weight: bold; color: white;"></asp:Label>
            </div>
            <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #35409b; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">CEX(Insurer)</span>
            </div>
        </div>
        <div style="height: 140px; background-color: #6770b7; border-radius: 5px; width: 220px; position: relative">
            <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white;">Total Users</span>
                <asp:Label ID="lbCEXTrust" runat="server" Text="0" Style="font-size: 35px; line-height: 1.5; font-weight: bold; color: white;"></asp:Label>
            </div>
            <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #35409b; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">CEX(Trust)</span>
            </div>
        </div>
        <div style="height: 140px; background-color: #6770b7; border-radius: 5px; width: 220px; position: relative">
            <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white;">Total Users</span>
                <asp:Label ID="lbCPDInsurer" runat="server" Text="0" Style="font-size: 35px; line-height: 1.5; font-weight: bold; color: white;"></asp:Label>
            </div>
            <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #35409b; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">CPD(Insurer)</span>
            </div>
        </div>
        <div style="height: 140px; background-color: #6770b7; border-radius: 5px; width: 220px; position: relative">
            <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white;">Total Users</span>
                <asp:Label ID="lbCPDTrust" runat="server" Text="0" Style="font-size: 35px; line-height: 1.5; font-weight: bold; color: white;"></asp:Label>
            </div>
            <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #35409b; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">CPD(Trust)</span>
            </div>
        </div>


        <%--Common Below--%>
        <div style="height: 140px; background-color: #78c389; border-radius: 5px; width: 220px; position: relative">
            <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white;">Total Users</span>
                <asp:Label ID="lbACOInsurer" runat="server" Text="0" Style="font-size: 35px; line-height: 1.5; font-weight: bold; color: white;"></asp:Label>
            </div>
            <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #4b9d5f; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">ACO(Insurer)</span>
            </div>
        </div>
        <div style="height: 140px; background-color: #78c389; border-radius: 5px; width: 220px; position: relative">
            <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white;">Total Users</span>
                <asp:Label ID="lbACOTrust" runat="server" Text="0" Style="font-size: 35px; line-height: 1.5; font-weight: bold; color: white;"></asp:Label>
            </div>
            <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #4b9d5f; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">ACO(Trust)</span>
            </div>
        </div>
        <div style="height: 140px; background-color: #78c389; border-radius: 5px; width: 220px; position: relative">
            <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white;">Total Users</span>
                <asp:Label ID="lbSHAInsurer" runat="server" Text="0" Style="font-size: 35px; line-height: 1.5; font-weight: bold; color: white;"></asp:Label>
            </div>
            <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #4b9d5f; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">SHA(Insurer)</span>
            </div>
        </div>
        <div style="height: 140px; background-color: #78c389; border-radius: 5px; width: 220px; position: relative">
            <div style="height: 100px; border-radius: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white;">Total Users</span>
                <asp:Label ID="lbSHATrust" runat="server" Text="0" Style="font-size: 35px; line-height: 1.5; font-weight: bold; color: white;"></asp:Label>
            </div>
            <div style="position: absolute; bottom: 0; height: 40px; width: 100%; background-color: #4b9d5f; border-radius: 5px; padding: 5px;" class="d-flex flex-column justify-content-center align-items-center">
                <span style="font-size: 14px; font-weight: 600; color: white; line-height: 1;" class="text-center">SHA(Trust)</span>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdAdminUserId" runat="server" Visible="false" />
</asp:Content>

