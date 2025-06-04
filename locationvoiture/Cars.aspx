<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cars.aspx.cs" Inherits="locationvoiture.Cars" %>

<!DOCTYPE html>
<html>
<head>
    <title>Browse Cars</title>
    <meta charset="utf-8" />
    <style>
        body {
            background: #f3f7fa;
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .header {
            background: #185adb;
            color: #fff;
            padding: 22px 0 19px 0;
            text-align: left;
            font-size: 2em;
            font-weight: 600;
            letter-spacing: 2px;
            padding-left: 40px;
        }
        .search-form {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 14px;
            margin: 35px 0 30px 0;
        }
        .search-form input,
        .search-form select {
            border: 1.5px solid #e2e8f0;
            border-radius: 7px;
            padding: 9px 10px;
            font-size: 1em;
            outline: none;
            min-width: 160px;
            transition: border 0.2s;
        }
        .search-form input:focus,
        .search-form select:focus {
            border: 1.7px solid #185adb;
        }
        .search-form .search-btn {
            background: #185adb;
            color: #fff;
            font-size: 1.09em;
            font-weight: 500;
            border: none;
            border-radius: 7px;
            padding: 10px 25px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .search-form .search-btn:hover {
            background: #103c80;
        }
        .cars-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 28px;
            max-width: 1100px;
            margin: 0 auto 44px auto;
            justify-content: center;
        }
        .car-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(24,90,219,0.06);
            width: 250px;
            padding: 18px 18px 16px 18px;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
        }
        .car-card img {
            width: 150px;
            margin-bottom: 15px;
        }
        .car-card .car-title {
            font-size: 1.19em;
            font-weight: 600;
            margin-bottom: 5px;
        }
        .car-card .car-type {
            color: #555;
            font-size: 1em;
            margin-bottom: 10px;
        }
        .car-card .car-price {
            color: #185adb;
            font-size: 1.11em;
            font-weight: 600;
            margin-bottom: 11px;
        }
        .car-card .reserve-btn {
            background: #185adb;
            color: #fff;
            border: none;
            border-radius: 7px;
            padding: 10px 18px;
            font-size: 1em;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.2s;
        }
        .car-card .reserve-btn:hover {
            background: #103c80;
        }
        .no-cars-message {
            color: #d33c3c;
            text-align: center;
            font-size: 1.2em;
            margin-top: 30px;
            margin-bottom: 60px;
        }
        @media (max-width: 1100px) {
            .cars-grid { max-width: 98vw; }
        }
        @media (max-width: 900px) {
            .cars-grid { flex-direction: column; align-items: center; }
            .header { padding-left: 20px; }
        }
    </style>
    <script>
        function reserveCar(carId) {
            var isLoggedIn = <%=(Session["UserID"] != null ? "true" : "false")%>;
            if (isLoggedIn === true || isLoggedIn === "true") {
                window.location = 'CarDetails.aspx?carid=' + encodeURIComponent(carId);
            } else {
                if (confirm('You must be registered and logged in to reserve. Go to registration now?')) {
                    window.location = 'Login.aspx';
                }
            }
        }
    </script>
</head>
<body>
    <div class="header">
        Parcourez les voitures
    </div>
    <form class="search-form" method="get">
        <input type="text" name="model" placeholder="Modèle (ex: BMW)" value="<%=Request.QueryString["model"] ?? "" %>" />
        <select name="type">
            <option value="">Tous les types</option>
            <option value="Petite" <%= (Request.QueryString["type"] == "Petite") ? "selected" : "" %>>Petite</option>
            <option value="SUV" <%= (Request.QueryString["type"] == "SUV") ? "selected" : "" %>>SUV</option>
            <option value="Moyenne" <%= (Request.QueryString["type"] == "Moyenne") ? "selected" : "" %>>Moyenne</option>
            <option value="Grande" <%= (Request.QueryString["type"] == "Grande") ? "selected" : "" %>>Grande</option>
        </select>
        <input type="number" name="minPrice" placeholder="Prix min" min="0" step="10" style="width:100px;" value="<%=Request.QueryString["minPrice"] ?? "" %>" />
        <input type="number" name="maxPrice" placeholder="Prix max" min="0" step="10" style="width:100px;" value="<%=Request.QueryString["maxPrice"] ?? "" %>" />
        <button type="submit" class="search-btn">Filtrer</button>
    </form>
    <div class="cars-grid">
        <asp:PlaceHolder ID="phCars" runat="server"></asp:PlaceHolder>
    </div>
    <asp:Label ID="lblNoCars" runat="server" CssClass="no-cars-message" />
</body>
</html>