<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="locationvoiture.Register" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <meta charset="utf-8" />
    <style>
        body {
            background: #f7f7f9;
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .form-card {
            background: #fff;
            padding: 30px 32px;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            max-width: 400px;
            margin: 64px auto;
        }
        .form-card h3 {
            text-align: center;
            margin-bottom: 24px;
            color: #185adb;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-label {
            display: block;
            margin-bottom: 7px;
            font-weight: 500;
        }
        .form-control {
            width: 100%;
            padding: 10px 12px;
            font-size: 16px;
            border: 1px solid #bdbdbd;
            border-radius: 5px;
            outline: none;
            box-sizing: border-box;
            transition: border 0.2s;
        }
        .form-control:focus {
            border: 1.5px solid #185adb;
        }
        .btn-primary {
            width: 100%;
            background: #185adb;
            color: #fff;
            font-size: 17px;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            transition: background 0.2s;
        }
        .btn-primary:hover {
            background: #103c80;
        }
        .message {
            margin-bottom: 15px;
            text-align: center;
            padding: 10px;
            border-radius: 5px;
        }
        .message-success {
            background: #e7f9ed;
            color: #299e5e;
            border: 1px solid #60d394;
        }
        .message-error {
            background: #ffe7e7;
            color: #d33c3c;
            border: 1px solid #fa8e8e;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-card">
            <h3>Register</h3>
            <asp:Label ID="lblMessage" runat="server" />
            <div class="form-group">
                <asp:Label ID="lblName" runat="server" Text="Full Name" CssClass="form-label" AssociatedControlID="txtName" />
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your name" />
            </div>
            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" Text="Email" CssClass="form-label" AssociatedControlID="txtEmail" />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email" />
            </div>
            <div class="form-group">
                <asp:Label ID="lblPassword" runat="server" Text="Password" CssClass="form-label" AssociatedControlID="txtPassword" />
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your password" />
            </div>
            <div class="form-group">
                <asp:Label ID="lblRole" runat="server" Text="Role" CssClass="form-label" AssociatedControlID="ddlRole" />
                <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Client" Value="Client" />
                    <asp:ListItem Text="Gestionnaire" Value="Gestionnaire" />
                    <asp:ListItem Text="Proprietaire" Value="Proprietaire" />
                </asp:DropDownList>
            </div>
            <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn-primary" OnClick="btnRegister_Click" />
        </div>
    </form>
</body>
</html>