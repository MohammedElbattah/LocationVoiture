<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="locationvoiture.Default" %>

<!DOCTYPE html>
<html>
<head>
    <title>NextGen Car Rental | Home</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <!-- Google Fonts for Modern Look -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <style>
        body {
            background: #f7f7fb;
            font-family: 'Inter', Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        /* HEADER */
        .main-header {
            background: #fff;
            box-shadow: 0 1px 16px 0 #e2e7ef3c;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 82px;
            position: sticky;
            top: 0;
            z-index: 99;
        }
        .logo {
            font-size: 2.1em;
            color: #185adb;
            font-weight: 700;
            letter-spacing: 1px;
            margin-left: 42px;
            text-shadow: 0 1px 10px #e8eefe70;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .nav-links {
            display: flex;
            align-items: center;
            gap: 38px;
        }
        .nav-links a {
            text-decoration: none;
            color: #232323;
            font-weight: 600;
            font-size: 1.08em;
            transition: color 0.17s;
        }
        .nav-links a:hover {
            color: #185adb;
        }
        .header-btn {
            background: #185adb;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 11px 26px;
            font-size: 1em;
            font-weight: 700;
            cursor: pointer;
            margin-right: 36px;
            margin-left: 15px;
            transition: background 0.17s;
            box-shadow: 0 1px 6px #c0e4ff29;
        }
        .header-btn:hover {
            background: #103c80;
        }
        /* HERO SECTION */
        .hero {
            width: 100%;
            background: url('https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?auto=format&fit=crop&w=1400&q=80') no-repeat center center/cover;
            min-height: 290px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom-left-radius: 42px;
            border-bottom-right-radius: 42px;
            box-shadow: 0 6px 32px #bcd9f82b;
            position: relative;
        }
        .hero-content {
            background: rgba(255,255,255,0.87);
            border-radius: 18px;
            padding: 40px 50px;
            margin: 44px 0 44px 0;
            text-align: center;
            box-shadow: 0 6px 22px #d1e6ff22;
        }
        .hero-content h1 {
            font-size: 2.6em;
            color: #232323;
            font-weight: 800;
            margin-bottom: 12px;
            letter-spacing: 1.4px;
        }
        .hero-content p {
            color: #314159;
            font-size: 1.24em;
            margin-bottom: 0;
            font-weight: 500;
            opacity: 0.93;
        }
        /* SEARCH BAR */
        .search-bar {
            display: flex;
            gap: 16px;
            align-items: center;
            justify-content: center;
            padding: 16px 0 5px 0;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 10px #e3e7ed80;
            max-width: 920px;
            margin: -45px auto 20px auto;
            flex-wrap: wrap;
            position: relative;
            z-index: 5;
        }
        .search-bar input,
        .search-bar select {
            border: 1.5px solid #e2e8f0;
            border-radius: 8px;
            padding: 9px 13px;
            font-size: 1em;
            outline: none;
            min-width: 140px;
            max-width: 180px;
            transition: border 0.18s;
            margin-bottom: 5px;
        }
        .search-bar input:focus,
        .search-bar select:focus {
            border: 1.7px solid #185adb;
        }
        .search-btn {
            background: #185adb;
            color: #fff;
            font-size: 1em;
            font-weight: 700;
            border: none;
            border-radius: 8px;
            padding: 10px 28px;
            cursor: pointer;
            margin-left: 10px;
            margin-bottom: 5px;
            transition: background 0.17s;
        }
        .search-btn:hover {
            background: #103c80;
        }
        /* CAR GRID */
        .section-title {
            text-align: center;
            color: #232323;
            font-size: 2.05em;
            font-weight: 800;
            margin-top: 30px;
            margin-bottom: 10px;
        }
        .cars-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 32px;
            max-width: 1200px;
            margin: 32px auto 0 auto;
            justify-content: center;
        }
        .car-card {
            background: #fff;
            border-radius: 22px;
            box-shadow: 0 6px 28px 0 rgba(34,36,38,0.12);
            width: 350px;
            display: flex;
            flex-direction: column;
            margin-bottom: 20px;
            border: 1.5px solid #ececf4;
            overflow: hidden;
            transition: box-shadow 0.17s, transform 0.16s;
            cursor: pointer;
            position: relative;
        }
        .car-card:hover {
            box-shadow: 0 10px 44px 0 rgba(24,90,219,0.11);
            transform: translateY(-7px) scale(1.016);
            border-color: #e6eefd;
        }
        .car-card img {
            width: 100%;
            height: 190px;
            object-fit: cover;
            background: #f5f7fa;
        }
        .car-content {
            padding: 22px 24px 12px 24px;
            flex: 1 1 auto;
            display: flex;
            flex-direction: column;
        }
        .car-title {
            font-size: 1.21em;
            font-weight: 700;
            color: #222;
            margin-bottom: 8px;
            margin-top: 5px;
        }
        .car-location {
            color: #232323;
            font-size: 1.01em;
            margin-bottom: 12px;
            opacity: 0.7;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .car-details-row {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            border-bottom: 1px solid #efefef;
            padding-bottom: 11px;
            margin-bottom: 10px;
            font-size: 1em;
        }
        .car-detail {
            display: flex;
            align-items: center;
            gap: 7px;
            margin-right: 15px;
            color: #232323;
            font-size: 1em;
            margin-bottom: 7px;
        }
        .car-price-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
        }
        .car-from {
            color: #b8bcc5;
            font-size: 1.06em;
            font-weight: 600;
        }
        .car-price {
            color: #191d21;
            font-size: 1.45em;
            font-weight: 800;
            margin-left: 7px;
        }
        .see-details {
            background: #232323;
            color: #fff;
            border: none;
            border-radius: 12px;
            padding: 12px 28px;
            font-size: 1.09em;
            font-weight: 700;
            cursor: pointer;
            margin-left: 12px;
            box-shadow: 0 2px 10px #e3e3e3;
            transition: background 0.19s;
        }
        .see-details:hover {
            background: #185adb;
        }
        .no-cars-message {
            color: #ff3131;
            text-align: center;
            font-size: 1.19em;
            margin-top: 30px;
            margin-bottom: 60px;
            font-weight: 600;
        }
        .load-more-btn {
            display: block;
            margin: 18px auto 50px auto;
            background: #185adb;
            color: #fff;
            font-size: 1.12em;
            border: none;
            border-radius: 10px;
            padding: 12px 40px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 2px 18px #e3e3e3;
            transition: background 0.17s;
        }
        .load-more-btn:hover {
            background: #103c80;
        }
        /* FOOTER */
        .footer {
            background: #fff;
            border-top: 1.5px solid #e8e8ef;
            color: #232323;
            text-align: center;
            padding: 35px 12px 18px 12px;
            font-size: 1.15em;
            font-weight: 600;
            margin-top: 58px;
        }
        .footer-links {
            display: flex;
            justify-content: center;
            gap: 22px;
            margin-bottom: 13px;
        }
        .footer-links a {
            color: #185adb;
            text-decoration: none;
            font-weight: 700;
            transition: color 0.17s;
        }
        .footer-links a:hover {
            color: #103c80;
        }
        @media (max-width: 1100px) {
            .cars-grid { max-width: 98vw; }
            .car-card { width: 97vw; max-width: 420px;}
        }
        @media (max-width: 800px) {
            .main-header { flex-direction: column; height: auto; padding: 8px 0;}
            .logo { margin-left: 18px; }
            .header-btn { margin-right: 18px;}
        }
        @media (max-width: 700px) {
            .car-card { width: 100vw; max-width: 99vw; margin: 0 0 17px 0;}
            .hero-content { padding: 18px 5vw; }
        }
    </style>
    <script>
        function goToDetails(carId) {
            window.location = 'CarDetails.aspx?carid=' + encodeURIComponent(carId);
        }
    </script>
</head>
<body>
    <!-- HEADER -->
    <div class="main-header">
        <span class="logo"><i class="fa fa-car"></i> NextGen Car Rental</span>
        <div class="nav-links">
            <a href="Default.aspx">Home</a>
            <a href="Cars.aspx">All Cars</a>
            <a href="About.aspx">About</a>
            <a href="Login.aspx">Login</a>
            <a href="Register.aspx" class="header-btn">Register</a>
        </div>
    </div>
    <!-- HERO SECTION -->
    <div class="hero">
        <div class="hero-content">
            <h1>Find, Book, and Drive the Perfect Car</h1>
            <p>From city cruisers to adventure SUVs – NextGen brings you the best rental deals with instant booking, seamless experience, and zero hassle.</p>
        </div>
    </div>
    <!-- SEARCH BAR -->
    <form id="form1" runat="server">
        <div class="search-bar">
            <asp:TextBox ID="txtModel" runat="server" placeholder="Model (e.g., BMW)" />
            <asp:DropDownList ID="ddlType" runat="server">
                <asp:ListItem Text="All Types" Value="" />
                <asp:ListItem Text="Sedan" Value="Sedan" />
                <asp:ListItem Text="SUV" Value="SUV" />
                <asp:ListItem Text="Hatchback" Value="Hatchback" />
                <asp:ListItem Text="Convertible" Value="Convertible" />
            </asp:DropDownList>
            <asp:TextBox ID="txtMinPrice" runat="server" placeholder="Min Price" TextMode="Number" style="width:100px;" />
            <asp:TextBox ID="txtMaxPrice" runat="server" placeholder="Max Price" TextMode="Number" style="width:100px;" />
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="search-btn" OnClick="btnSearch_Click" />
        </div>
        <div class="section-title">Popular Cars</div>
        <div class="cars-grid">
            <asp:PlaceHolder ID="phCars" runat="server"></asp:PlaceHolder>
        </div>
        <asp:Button ID="btnLoadMore" runat="server" Text="Load More" CssClass="load-more-btn" OnClick="btnLoadMore_Click" />
        <asp:Label ID="lblNoCars" runat="server" CssClass="no-cars-message" />
    </form>
    <!-- FOOTER -->
    <div class="footer">
        <div class="footer-links">
            <a href="Default.aspx">Home</a> |
            <a href="Cars.aspx">All Cars</a> |
        </div>
        &copy; <%= DateTime.Now.Year %> NextGen Car Rental. All rights reserved.
    </div>
</body>
</html>