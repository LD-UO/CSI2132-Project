<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="index.css">
    <title>Welcome!</title>
</head>
<body onload="loadDates()">
    <div class="container-fluid">
        <h1>Logo will go here</h1>
    </div>
    <div class="container-fluid" id="welcome-banner">
        <div id="welcome-message">
            <h3 id="slogan">Book stress free with</h3>
            <br>
            <h1 id="service-name">PLACEHOLDER NAME FOR OUR WEBSITE</h1>
        </div>
    </div>

    <!-- TODO: Will need to update this to be the right webpage once we get to that point -->
    <!-- Will need to add the action and method to the form! -->

    <div id="datewrapper">
        <br>
        <br>
        <div id="dateinput">
            <div id="disclaimer">
                <p>We here at <strong>COMPANY NAME</strong> pride ourselves on our high quality reservation system that
                has provided millions of customers with accommodations for decades.
                But, no need to hear it from us, <strong>try it out for yourself below!</strong> </p>
            </div>
            <form>
                <div id="checkindiv">
                    <label for="checkin">Check-in Date: </label>
                    <br>
                    <input id="checkindateinput" name="checkin" type="date" required onchange="computeCheckout()">
                </div>
                <div id="checkoutdiv">
                    <label for="checkout">Check-out Date: </label>
                    <br>
                    <input id="checkoutdateinput" name="checkout" type="date" required>
                </div>
                <br>
                <button id="submitbutton" type="submit">Check Availability!</button>
            </form>
        </div>
        <br>
        <br>
    </div>

    <!-- Including the necessary Bootstrap javascript files -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="index.js"></script>
</body>
</html>
