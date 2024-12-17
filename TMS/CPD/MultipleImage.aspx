<%@ Page Title="" Language="C#" MasterPageFile="~/CPD/CPD.master" AutoEventWireup="true" CodeFile="MultipleImage.aspx.cs" Inherits="CPD_MultipleImage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:GridView ID="gvUploadImages" runat="server" AutoGenerateColumns="False" EnableViewState="true" OnRowCommand="gvUploadImages_RowCommand">
        <Columns>
            <asp:TemplateField HeaderText="Image">
                <ItemTemplate>
                    <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn btn-primary"
                        CommandName="UploadImage" CommandArgument='<%# Container.DataItemIndex %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnAddRow" runat="server" Text="+" CssClass="btn btn-success" OnClick="btnAddRow_Click" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <asp:Button ID="btnSaveAll" runat="server" Text="Save All" CssClass="btn btn-success" OnClick="btnSaveAll_Click" />
</asp:Content>
