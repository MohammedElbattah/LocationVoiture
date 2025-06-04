
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reserve.aspx.cs" Inherits="locationvoiture.Reservations" %>

<!DOCTYPE html>
<html>
<head>
    <title>Reserve Your Car</title>
    <meta charset="utf-8" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@600;700&display=swap" rel="stylesheet">
    <style>
        body { background: #f7f7fb; font-family: 'Inter', Arial, sans-serif; margin: 0; }
        .reservation-container { max-width: 560px; margin: 50px auto 0 auto; background: #fff; border-radius: 20px; box-shadow: 0 6px 28px #e1eaf5b2; padding: 40px 30px 30px 30px; }
        .car-summary { display: flex; gap: 24px; align-items: center; margin-bottom: 24px; }
        .car-summary img { width: 120px; border-radius: 12px; box-shadow: 0 2px 12px #e1eaf5b2; }
        .car-summary-details { flex: 1 1 auto; }
        .car-model { font-size: 1.2em; font-weight: 700; color: #222; }
        .car-type { font-size: 1em; color: #666; }
        .car-price { font-size: 1.08em; color: #185adb; font-weight: 600; }
        .form-group { margin-bottom: 19px; }
        .form-group label { display: block; margin-bottom: 7px; font-weight: 600; color: #185adb; }
        .form-group input[type="date"],
        .form-group input[type="text"],
        .form-group input[type="tel"],
        .form-group textarea
        { width: 100%; padding: 8px 13px; border-radius: 8px; border: 1.2px solid #e1e8ef; font-size: 1.04em; }
        .form-group textarea { min-height: 56px; }
        .reserve-btn { background: #185adb; color: #fff; border: none; border-radius: 11px; padding: 12px 40px; font-size: 1.13em; font-weight: 700; cursor: pointer; transition: background 0.16s; box-shadow: 0 1px 8px #e1eaf5b2;}
        .reserve-btn:hover { background: #103c80; }
        .confirmation { color: #12a15c; font-size: 1.16em; font-weight: 700; margin-top: 16px; }
        .error { color: #d33c3c; font-size: 1.07em; font-weight: 600; margin-top: 10px; }
        @media (max-width: 700px) {
            .reservation-container { padding: 10px 2vw; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="reservation-container">
            <div class="car-summary">
                <img id="imgCar" runat="server" src="#" alt="Car" />
                <div class="car-summary-details">
                    <div class="car-model"><asp:Label ID="lblModel" runat="server" /></div>
                    <div class="car-type"><asp:Label ID="lblType" runat="server" /></div>
                    <div class="car-price"><asp:Label ID="lblPrice" runat="server" /> MAD / day</div>
                </div>
            </div>
            <div class="form-group">
                <label>Your Name</label>
                <asp:TextBox ID="txtFullName" runat="server" placeholder="Full Name" required="required" />
            </div>
            <div class="form-group">
                <label>Your Phone</label>
                <asp:TextBox ID="txtPhone" runat="server" placeholder="Phone Number" required="required" TextMode="SingleLine" />
            </div>
            <div class="form-group">
                <label>Pickup Location</label>
                <asp:TextBox ID="txtPickupLocation" runat="server" placeholder="Pickup Location (Hotel, Airport, Branch...)" />
            </div>
            <div class="form-group">
                <label>Start Date</label>
                <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" required="required" />
            </div>
            <div class="form-group">
                <label>End Date</label>
                <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" required="required" />
            </div>
            <div class="form-group">
                <label>Notes</label>
                <asp:TextBox ID="txtNotes" runat="server" placeholder="Any message or request..." TextMode="MultiLine" />
            </div>
            <asp:Button ID="btnReserve" runat="server" Text="Confirm Reservation" CssClass="reserve-btn" OnClick="btnReserve_Click" />
            <asp:Label ID="lblMsg" runat="server" />
        </div>
    </form>
</body>
</html>