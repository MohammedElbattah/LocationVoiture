<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="locationvoiture.About" %>

<!DOCTYPE html>
<html>
<head>
    <title>About | NextGen Car Rental</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <!-- Google Fonts + FontAwesome -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <style>
        body {
            background: #f7f7fb;
            font-family: 'Inter', Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
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
        .about-container {
            max-width: 1000px;
            margin: 60px auto;
            padding: 0 20px;
        }
        .about-title {
            text-align: center;
            color: #232323;
            font-size: 2.2em;
            font-weight: 800;
            margin-bottom: 30px;
        }
        .about-section {
            background: #fff;
            border-radius: 16px;
            padding: 35px;
            box-shadow: 0 6px 28px rgba(34,36,38,0.08);
            font-size: 1.1em;
            line-height: 1.8;
            color: #314159;
        }
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
    </style>
</head>
<body>
    <!-- HEADER -->
    <div class="main-header">
        <span class="logo"><i class="fa fa-car"></i> NextGen Car Rental</span>
        <div class="nav-links">
            <a href="Default.aspx">Home</a>
            <a href="Cars.aspx">All Cars</a>
            <a href="About.aspx">About</a>
            <a href="Contact.aspx">Contact</a>
            <a href="Login.aspx">Login</a>
            <a href="Register.aspx" class="header-btn">Register</a>
        </div>
    </div>

    <!-- ABOUT SECTION -->
    <div class="about-container">
        <div class="about-title">About NextGen Car Rental</div>
        <div class="about-section">
            <p>
                Welcome to <strong>NextGen Car Rental</strong>, your ultimate destination for modern, hassle-free car rentals. Founded with a mission to redefine the vehicle rental experience, we combine cutting-edge technology with unbeatable service and affordable prices.
            </p>
            <p>
                Whether you're planning a weekend getaway, a business trip, or need a car for daily commuting, we offer a wide range of vehicles to suit every lifestyle—from compact city cars and sedans to luxury SUVs and convertibles.
            </p>
            <p>
                What sets us apart is our commitment to customer satisfaction. We provide real-time availability, transparent pricing, flexible pickup and return, and a user-friendly booking platform. With strategic locations and 24/7 customer support, renting a car has never been easier.
            </p>
            <p>
                Our mission is not just to provide transportation, but to empower freedom of movement with reliability, style, and peace of mind. Join thousands of happy customers and discover why NextGen is the preferred choice in modern car rentals.
            </p>
            <p>
                Thank you for choosing NextGen. Let's hit the road together!
            </p>
        </div>
    </div>

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
