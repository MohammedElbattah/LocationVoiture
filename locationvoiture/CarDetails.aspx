<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CarDetails.aspx.cs" Inherits="locationvoiture.CarDetails" %>

<!DOCTYPE html>
<html>
<head>
    <title>Car Details</title>
    <meta charset="utf-8" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <style>
        body {
            background: #f7f7fb;
            font-family: 'Inter', Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .main-container {
            max-width: 980px;
            margin: 38px auto 30px auto;
            background: #fff;
            border-radius: 24px;
            box-shadow: 0 8px 40px 0 rgba(34,36,38,0.11);
            padding: 44px 42px 32px 42px;
            display: flex;
            flex-wrap: wrap;
            gap: 32px;
        }
        .car-images {
            flex: 1.2 1 350px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 16px;
        }
        .main-img {
            width: 350px;
            height: 210px;
            border-radius: 18px;
            object-fit: cover;
            box-shadow: 0 3px 17px #dbeafe63;
            margin-bottom: 8px;
        }
        .gallery-row {
            display: flex;
            gap: 12px;
            justify-content: center;
        }
        .gallery-img {
            width: 90px;
            height: 60px;
            border-radius: 10px;
            object-fit: cover;
            box-shadow: 0 2px 7px #dde6ee47;
            cursor: pointer;
            border: 2.5px solid transparent;
            transition: border 0.14s;
        }
        .gallery-img.active, .gallery-img:hover {
            border: 2.5px solid #185adb;
        }
        .car-info {
            flex: 2 1 360px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .car-title {
            font-size: 2.1em;
            font-weight: 700;
            color: #232323;
            margin-bottom: 4px;
        }
        .car-reviews {
            font-size: 1.13em;
            color: #14b457;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 7px;
            margin-bottom: 7px;
        }
        .car-location {
            color: #232323;
            font-size: 1.1em;
            margin-bottom: 7px;
            opacity: 0.74;
            display: flex;
            align-items: center;
            gap: 7px;
        }
        .car-details-row {
            display: flex;
            flex-wrap: wrap;
            gap: 19px;
            margin-bottom: 2px;
        }
        .car-detail {
            display: flex;
            align-items: center;
            gap: 7px;
            color: #222;
            font-size: 1.07em;
        }
        .car-price-row {
            display: flex;
            align-items: center;
            gap: 24px;
            margin-top: 10px;
        }
        .car-from {
            color: #8c8f97;
            font-size: 1.12em;
            font-weight: 600;
        }
        .car-price {
            color: #191d21;
            font-size: 2em;
            font-weight: 800;
            margin-left: 7px;
        }
        .book-btn {
            background: #185adb;
            color: #fff;
            border: none;
            border-radius: 12px;
            padding: 16px 48px;
            font-size: 1.13em;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 2px 18px #e3e3e3;
            transition: background 0.19s;
        }
        .book-btn:hover {
            background: #0c366c;
        }
        .reserve-msg {
            color: #d33c3c;
            font-size: 1.15em;
            margin-top: 13px;
            font-weight: 600;
        }
        @media (max-width: 1100px) {
            .main-container { max-width: 99vw; padding: 24px 6vw; flex-direction: column; align-items: center;}
            .car-images { align-items: flex-start; }
        }
        @media (max-width: 700px) {
            .main-container { padding: 14px 2vw; }
            .main-img { width: 98vw; max-width: 340px; }
        }
    </style>
    <script>
        function switchMainImg(src, thumb) {
            document.getElementById('mainCarImg').src = src;
            let all = document.querySelectorAll('.gallery-img');
            all.forEach(img => img.classList.remove('active'));
            thumb.classList.add('active');
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-container">
            <div class="car-images">
                <img id="mainCarImg" runat="server" class="main-img" src="https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_1280.jpg" alt="Main Image" />
                <div class="gallery-row">
                    <asp:Repeater ID="rptGallery" runat="server">
                        <ItemTemplate>
                            <img src='<%# Container.DataItem %>' class="gallery-img <%# (Container.ItemIndex == 0 ? "active" : "") %>" onclick="switchMainImg('<%# Container.DataItem %>', this);" alt="Gallery" />
                           </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <div class="car-info">
                <div class="car-title"><asp:Label ID="lblTitle" runat="server" /></div>
                <div class="car-reviews"><i class='fa fa-star'></i> <asp:Label ID="lblRating" runat="server" /> (<asp:Label ID="lblReviews" runat="server" /> reviews)</div>
                <div class="car-location"><i class='fa fa-location-dot'></i> <asp:Label ID="lblLocation" runat="server" /></div>
                <div class="car-details-row">
                    <div class="car-detail"><i class='fa fa-gauge'></i> <asp:Label ID="lblMileage" runat="server" /> miles</div>
                    <div class="car-detail"><i class='fa fa-gears'></i> <asp:Label ID="lblTransmission" runat="server" /></div>
                </div>
                <div class="car-details-row">
                    <div class="car-detail"><i class='fa fa-gas-pump'></i> <asp:Label ID="lblFuel" runat="server" /></div>
                    <div class="car-detail"><i class='fa fa-chair'></i> <asp:Label ID="lblSeats" runat="server" /> seats</div>
                </div>
                <div class="car-price-row">
                    <span class="car-from">From <span class="car-price">DH<asp:Label ID="lblPrice" runat="server" /></span></span>
                    <asp:Button ID="btnReserve" runat="server" Text="Book Now" CssClass="book-btn" OnClick="btnReserve_Click" />
                </div>
                <asp:Label ID="lblReserveMsg" runat="server" CssClass="reserve-msg" />
            </div>
        </div>
    </form>
</body>
</html>