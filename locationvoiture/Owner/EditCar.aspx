<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditCar.aspx.cs" Inherits="locationvoiture.Owner.EditCar" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Car</title>
    <meta charset="utf-8" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@600;700&display=swap" rel="stylesheet">
    <style>
        body { background: #f7f7fb; font-family: 'Inter', Arial, sans-serif; margin: 0; }
        .editcar-container { max-width: 500px; margin: 60px auto; background: #fff; border-radius: 18px; box-shadow: 0 6px 28px #e1eaf5b2; padding: 40px 32px 32px 32px;}
        .form-title { font-size: 1.38em; font-weight: 800; color: #185adb; text-align: center; margin-bottom: 27px; }
        .form-group { margin-bottom: 16px; }
        .form-group label { display: block; margin-bottom: 6px; font-weight: 600; color: #185adb; }
        .form-group input, .form-group select { width: 100%; padding: 8px 13px; border-radius: 8px; border: 1.2px solid #e1e8ef; font-size: 1.03em; }
        .form-group textarea { width: 100%; border-radius: 8px; border: 1.2px solid #e1e8ef; font-size: 1.03em; min-height: 48px; }
        .edit-btn { background: #185adb; color: #fff; border: none; border-radius: 11px; padding: 11px 38px; font-size: 1.09em; font-weight: 700; cursor: pointer; transition: background 0.16s; box-shadow: 0 1px 8px #e1eaf5b2;}
        .edit-btn:hover { background: #103c80; }
        .cancel-btn { background: #e2e8ef; color: #185adb; border: none; border-radius: 11px; padding: 11px 38px; font-size: 1.09em; font-weight: 700; cursor: pointer; margin-left:12px;}
        .msg-success { color: #12a15c; font-size: 1.09em; font-weight: 700; text-align: center; margin-top: 14px;}
        .msg-error { color: #d33c3c; font-size: 1.03em; font-weight: 600; text-align: center; margin-top: 10px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="editcar-container">
            <div class="form-title">Edit Car</div>
            <asp:Label ID="lblMsg" runat="server" />
            <div class="form-group">
                <label>Model</label>
                <asp:TextBox ID="txtModel" runat="server" required="required" />
            </div>
            <div class="form-group">
                <label>Type</label>
                <asp:DropDownList ID="ddlType" runat="server">
                    <asp:ListItem Value="Sedan" Text="Sedan" />
                    <asp:ListItem Value="SUV" Text="SUV" />
                    <asp:ListItem Value="Hatchback" Text="Hatchback" />
                    <asp:ListItem Value="Convertible" Text="Convertible" />
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Price per Day (MAD)</label>
                <asp:TextBox ID="txtPrice" runat="server" required="required" TextMode="Number" />
            </div>
            <div class="form-group">
                <label>Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="Disponible" Text="Disponible" />
                    <asp:ListItem Value="Non Disponible" Text="Non Disponible" />
                    <asp:ListItem Value="En Maintenance" Text="En Maintenance" />
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Main Image URL</label>
                <asp:TextBox ID="txtMainImage" runat="server" />
            </div>
            <div class="form-group">
                <label>Image 1</label>
                <asp:TextBox ID="txtImage1" runat="server" />
            </div>
            <div class="form-group">
                <label>Image 2</label>
                <asp:TextBox ID="txtImage2" runat="server" />
            </div>
            <div class="form-group">
                <label>Image 3</label>
                <asp:TextBox ID="txtImage3" runat="server" />
            </div>
            <div class="form-group">
                <label>Image 4</label>
                <asp:TextBox ID="txtImage4" runat="server" />
            </div>
            <asp:Button ID="btnUpdate" runat="server" Text="Update Car" CssClass="edit-btn" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancel-btn" OnClick="btnCancel_Click" CausesValidation="false" />
        </div>
    </form>
</body>
</html>