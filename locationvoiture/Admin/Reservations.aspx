<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reservations.aspx.cs" Inherits="locationvoiture.Admin.Reservations" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - Reservations</title>
    <meta charset="utf-8" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <style>
        body { margin:0; background:#f5f7fa; font-family:'Inter',Arial,sans-serif; }
        .dashboard-layout { display:flex; min-height:100vh;}
        .sidebar { background:#fff; width:235px; min-width:200px; box-shadow:2px 0 20px #e2e8ef66;
            padding:36px 0 24px 0; display:flex; flex-direction:column; }
        .sidebar .logo { font-size:1.5em; font-weight:900; color:#185adb; margin-bottom:44px; text-align:center; }
        .sidebar-menu { flex:1 1 auto; }
        .sidebar-menu a {
            display:flex; align-items:center; padding:13px 38px;
            font-size:1.13em; color:#222; text-decoration:none; font-weight:700;
            transition:background 0.14s; border-left:4px solid transparent; gap:15px;
        }
        .sidebar-menu a.active, .sidebar-menu a:hover {
            background:#e9f1fd; color:#185adb; border-left:4px solid #185adb;
        }
        .sidebar-menu .fa { width:23px; }
        .sidebar-bottom { text-align:center; margin-top:32px;}
        .sidebar-bottom a { color:#da254d; font-weight:700; text-decoration:none; font-size:1.04em;}
        .main-content { flex:1 1 auto; padding:36px 34px; }
        .section-title { font-size:1.35em; font-weight:800; color:#185adb; margin-bottom:18px;}
        .reserv-table { width:100%; border-collapse:collapse; }
        .reserv-table th, .reserv-table td { padding:10px 8px; border-bottom:1.2px solid #e4e7ed;}
        .reserv-table th { background:#f7fafc; font-weight:800;}
        .reserv-table tr:hover { background:#eaf1fa;}
        @media (max-width: 700px) {
            .dashboard-layout { flex-direction:column;}
            .sidebar { width:100vw; flex-direction:row; align-items:center; justify-content:space-between;}
            .sidebar-menu { flex-direction:row; gap:10px;}
            .sidebar-menu a { padding:11px 10px; font-size:1em;}
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-layout">
            <div class="sidebar">
                <div class="logo"><i class="fa fa-shield-halved"></i> Admin Panel</div>
                <div class="sidebar-menu">
                    <a href="Dashboard.aspx"><i class="fa fa-gauge"></i> Dashboard</a>
                    <a href="Cars.aspx"><i class="fa fa-car"></i> All Cars</a>
                    <a href="Owners.aspx"><i class="fa fa-user-tie"></i> Owners</a>
                    <a href="Clients.aspx"><i class="fa fa-users"></i> Clients</a>
                    <a href="Reservations.aspx" class="active"><i class="fa fa-calendar-check"></i> Reservations</a>
                </div>
                <div class="sidebar-bottom">
                    <a href="../Logout.aspx"><i class="fa fa-arrow-right-from-bracket"></i> Logout</a>
                </div>
            </div>
            <div class="main-content">
                <div class="section-title">All Reservations</div>
                <asp:Label ID="lblMsg" runat="server" />
                <asp:GridView ID="gvReservations" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="reserv-table">
                    <Columns>
                        <asp:BoundField DataField="ReservationID" HeaderText="ID" />
                        <asp:BoundField DataField="UserFullName" HeaderText="Client" />
                        <asp:BoundField DataField="CarModel" HeaderText="Car" />
                        <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="ReservationDate" HeaderText="Reserved On" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                        <asp:BoundField DataField="FullName" HeaderText="Name Entered" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" />
                        <asp:BoundField DataField="PickupLocation" HeaderText="Pickup Location" />
                        <asp:BoundField DataField="Notes" HeaderText="Notes" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
