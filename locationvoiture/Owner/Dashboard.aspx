<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="locationvoiture.Owner.Dashboard" %>

<!DOCTYPE html>
<html>
<head>
    <title>Owner Dashboard</title>
    <meta charset="utf-8" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <style>
        body { margin:0; background:#f5f7fa; font-family:'Inter',Arial,sans-serif; }
        .dashboard-layout { display:flex; min-height:100vh;}
        .sidebar {
            background:#fff;
            width:235px;
            min-width:200px;
            box-shadow:2px 0 20px #e2e8ef66;
            padding:36px 0 24px 0;
            display:flex;
            flex-direction:column;
        }
        .sidebar .logo {
            font-size:1.5em;
            font-weight:900;
            color:#185adb;
            letter-spacing:1px;
            margin-bottom:44px;
            text-align:center;
        }
        .sidebar-menu { flex:1 1 auto; }
        .sidebar-menu a {
            display:flex; align-items:center;
            padding:13px 38px;
            font-size:1.13em;
            color:#222;
            text-decoration:none;
            font-weight:700;
            transition:background 0.14s;
            border-left:4px solid transparent;
            gap:15px;
        }
        .sidebar-menu a.active,
        .sidebar-menu a:hover {
            background:#e9f1fd;
            color:#185adb;
            border-left:4px solid #185adb;
        }
        .sidebar-menu .fa { width:23px; }
        .sidebar-bottom { text-align:center; margin-top:32px;}
        .sidebar-bottom a { color:#da254d; font-weight:700; text-decoration:none; font-size:1.04em;}
        .main-content { flex:1 1 auto; padding:36px 34px; }
        .stats-row { display:flex; gap:26px; margin-bottom:38px;}
        .stat-card {
            flex:1 1 0;
            background:#fff;
            border-radius:12px;
            box-shadow:0 2px 14px #e3eaf1b8;
            padding:28px 26px 21px 26px;
            text-align:center;
        }
        .stat-card .stat-number { font-size:2.18em; font-weight:900; color:#185adb;}
        .stat-card .stat-label { font-size:1.11em; font-weight:600; color:#333; margin-top:8px;}
        .section-title { font-size:1.36em; font-weight:800; color:#185adb; margin:15px 0 17px 0;}
        .car-table { width:100%; border-collapse:collapse;}
        .car-table th, .car-table td { padding:11px 9px; border-bottom:1.2px solid #e4e7ed;}
        .car-table th { background:#f7fafc; font-weight:800;}
        .car-table tr:hover { background:#eaf1fa;}
        .car-img { width:62px; border-radius:6px;}
        .car-actions a { margin-right:13px; color:#185adb; font-weight:700; text-decoration:none;}
        .car-actions a.delete { color:#da254d;}
        .car-actions a:hover { text-decoration:underline; }
        @media (max-width: 900px) {
            .stats-row { flex-direction:column; gap:15px;}
        }
        @media (max-width: 700px) {
            .dashboard-layout { flex-direction:column;}
            .sidebar { width:100vw; min-width:0; flex-direction:row; align-items:center; justify-content:space-between;}
            .sidebar .logo { margin-bottom:0;}
            .sidebar-menu { flex-direction:row; gap:10px;}
            .sidebar-menu a { padding:11px 10px; border-left:none; font-size:1em;}
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="dashboard-layout">
        <div class="sidebar">
            <div class="logo"><i class="fa fa-car-side"></i> Owner Panel</div>
            <div class="sidebar-menu">
                <a href="Dashboard.aspx" class="active"><i class="fa fa-gauge"></i> Dashboard</a>
                <a href="Dashboard.aspx#cars"><i class="fa fa-car"></i> My Cars</a>
                <a href="Dashboard.aspx#reservations"><i class="fa fa-calendar-check"></i> My Reservations</a>
                <a href="Profile.aspx"><i class="fa fa-user"></i> Profile</a>
            </div>
            <div class="sidebar-bottom">
                <a href="../Logout.aspx"><i class="fa fa-arrow-right-from-bracket"></i> Logout</a>
            </div>
        </div>
        <div class="main-content">
            <!-- STATS -->
            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblTotalCars" runat="server" /></div>
                    <div class="stat-label">My Cars</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblTotalReservations" runat="server" /></div>
                    <div class="stat-label">Total Reservations</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblIncome" runat="server" /></div>
                    <div class="stat-label">Estimated Income (MAD)</div>
                </div>
            </div>
            <!-- MY CARS -->
            <div class="section-title" id="cars">My Cars <a href="AddCar.aspx" style="float:right; font-size:0.86em; font-weight:700; color:#185adb;">+ Add New Car</a></div>
            <asp:Label ID="lblMsg" runat="server" />
            <asp:GridView ID="gvCars" runat="server" AutoGenerateColumns="False" GridLines="None" ShowHeader="True" CssClass="car-table"
                OnRowDeleting="gvCars_RowDeleting" DataKeyNames="CarID">
                <Columns>
                    <asp:BoundField DataField="CarID" HeaderText="ID" ReadOnly="true" ItemStyle-Width="35px" />
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <img src='<%# Eval("MainImage") %>' class="car-img" alt="Car" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Model" HeaderText="Model" />
                    <asp:BoundField DataField="Type" HeaderText="Type" />
                    <asp:BoundField DataField="PricePerDay" HeaderText="Price/Day" DataFormatString="{0} MAD" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <span class="car-actions">
                                <a href='EditCar.aspx?carid=<%# Eval("CarID") %>'>Edit</a>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("CarID") %>' OnClientClick="return confirm('Delete this car?');" CssClass="delete">Delete</asp:LinkButton>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
    </form>
</body>
</html>