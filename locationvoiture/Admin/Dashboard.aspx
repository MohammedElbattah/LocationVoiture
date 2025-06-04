<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="locationvoiture.Admin.Dashboard" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <meta charset="utf-8" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { margin:0; background:#f5f7fa; font-family:'Inter',Arial,sans-serif; }
        .dashboard-layout { display:flex; min-height:100vh;}
        .sidebar {
            background:#fff; width:235px; min-width:200px; box-shadow:2px 0 20px #e2e8ef66;
            padding:36px 0 24px 0; display:flex; flex-direction:column;
        }
        .sidebar .logo { font-size:1.5em; font-weight:900; color:#185adb; letter-spacing:1px;
            margin-bottom:44px; text-align:center; }
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
        .stats-row { display:flex; gap:26px; margin-bottom:38px;}
        .stat-card {
            flex:1 1 0; background:#fff; border-radius:12px; box-shadow:0 2px 14px #e3eaf1b8;
            padding:28px 26px 21px 26px; text-align:center;
        }
        .stat-card .stat-number { font-size:2.18em; font-weight:900; color:#185adb;}
        .stat-card .stat-label { font-size:1.11em; font-weight:600; color:#333; margin-top:8px;}
        .quick-actions { margin-top:28px; }
        .quick-actions .quick-link {
            display:inline-block; margin:0 16px 12px 0; padding:14px 28px;
            background:#e9f1fd; color:#185adb; font-weight:700; border-radius:10px;
            font-size:1.1em; text-decoration:none; transition:background 0.18s;
        }
        .quick-actions .quick-link:hover { background:#185adb; color:#fff;}
        .section-title { font-size:1.34em; font-weight:800; color:#185adb; margin:20px 0 17px 0;}

        /* New styles for GridView table */
        .car-table {
          width: 100%;
          border-collapse: collapse;
          background: #fff;
          box-shadow: 0 2px 10px rgb(0 0 0 / 0.1);
          border-radius: 10px;
          overflow: hidden;
        }
        .car-table th, .car-table td {
          padding: 12px 15px;
          text-align: left;
          border-bottom: 1px solid #ddd;
        }
        .car-table th {
          background-color: #185adb;
          color: white;
          font-weight: 700;
        }
        .car-table tr:hover {
          background-color: #f1f7ff;
        }

        @media (max-width: 900px) { .stats-row { flex-direction:column; gap:15px;} }
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
            <div class="logo"><i class="fa fa-shield-halved"></i> Admin Panel</div>
            <div class="sidebar-menu">
                <a href="Dashboard.aspx" class="active"><i class="fa fa-gauge"></i> Dashboard</a>
                <a href="Cars.aspx"><i class="fa fa-car"></i> All Cars</a>
                <a href="Owners.aspx"><i class="fa fa-user-tie"></i> Owners</a>
                <a href="Clients.aspx"><i class="fa fa-users"></i> Clients</a>
                <a href="Reservations.aspx"><i class="fa fa-calendar-check"></i> Reservations</a>
            </div>
            <div class="sidebar-bottom">
                <a href="../Logout.aspx"><i class="fa fa-arrow-right-from-bracket"></i> Logout</a>
            </div>
        </div>
        <div class="main-content">
            <div class="stats-row" id="stats">
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblTotalCars" runat="server" /></div>
                    <div class="stat-label">Total Cars</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblTotalReservations" runat="server" /></div>
                    <div class="stat-label">Total Reservations</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblTotalOwners" runat="server" /></div>
                    <div class="stat-label">Total Owners</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblTotalClients" runat="server" /></div>
                    <div class="stat-label">Total Clients</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblTotalIncome" runat="server" /></div>
                    <div class="stat-label">Total Income (MAD)</div>
                </div>
            </div>

            <div class="quick-actions">
                <a href="Cars.aspx" class="quick-link"><i class="fa fa-car"></i> Manage Cars</a>
                <a href="Owners.aspx" class="quick-link"><i class="fa fa-user-tie"></i> Manage Owners</a>
                <a href="Clients.aspx" class="quick-link"><i class="fa fa-users"></i> Manage Clients</a>
                <a href="Reservations.aspx" class="quick-link"><i class="fa fa-calendar-check"></i> Manage Reservations</a>
                <a href="Reports.aspx" class="quick-link"><i class="fa fa-chart-column"></i> View Reports</a>
            </div>

            <div style="margin-top: 40px;">
                <h3 class="section-title">Car Reservations Chart</h3>
                <canvas id="reservationsChart" width="600" height="300"></canvas>
            </div>

            <div class="section-title" style="margin-top:35px;">Recent Reservations</div>
            <asp:GridView ID="gvRecentReservations" runat="server" AutoGenerateColumns="False" GridLines="None" ShowHeader="True" CssClass="car-table">
                <Columns>
                    <asp:BoundField DataField="ReservationID" HeaderText="ID" ReadOnly="true" ItemStyle-Width="35px" />
                    <asp:BoundField DataField="CarModel" HeaderText="Car" />
                    <asp:BoundField DataField="OwnerName" HeaderText="Owner" />
                    <asp:BoundField DataField="ClientName" HeaderText="Client" />
                    <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:BoundField DataField="ReservationDate" HeaderText="Reserved On" DataFormatString="{0:yyyy-MM-dd}" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <script>
      const ctx = document.getElementById('reservationsChart').getContext('2d');
      const reservationsChart = new Chart(ctx, {
        type: 'bar',
        data: {
          labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'], // example months - replace with real data if you want
          datasets: [{
            label: 'Reservations',
            data: [12, 19, 3, 5, 2, 3], // example data
            backgroundColor: '#185adb',
          }]
        },
        options: {
          responsive: true,
          scales: {
            y: { beginAtZero: true }
          }
        }
      });
    </script>

    </form>
</body>
</html>
