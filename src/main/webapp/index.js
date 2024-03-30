var nameLength = 0;
var addressLength = 0;
var bothEmpty = true;

var eNameLength = 0;
var phoneLength = 0;
var positionLength = 0;
var threeEmpty = true;

var priceLength = document.getElementById("price").length;
var capacityLength = document.getElementById("capacity").length;
var defectsLength = document.getElementById("defects").length;
var viewLength = document.getElementById("view").length;

var allEmpty = false;

function loadDates(){
    // Setting the min date for the check in date to be the current day because we do not want to allow customers to set
    // starting date to be in the past
    var today = new Date();
    var datetime = today.toISOString().split('T')[0];
    document.getElementById("checkindateinput").min = datetime;
}
function computeCheckout(){
    // Get the date from the checkin date, and then set the min date for the checkout date to be
    // that
    var minDate = document.getElementById("checkindateinput").value;
    document.getElementById("checkoutdateinput").min = minDate;
}

function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : evt.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function nameChange(){
    document.getElementById("name").addEventListener("keyup", function(){
        nameLength = document.getElementById("name").value.length;
        bothEmpty = (nameLength == 0) && (addressLength == 0);
        console.log(bothEmpty);

        if (bothEmpty){
            document.getElementById("submit").disabled = true;
        } else {
            document.getElementById("submit").disabled = false;
        }
    });

    document.getElementById("address").addEventListener("keyup", function(){
        addressLength = document.getElementById("address").value.length;
        bothEmpty = (nameLength == 0) && (addressLength == 0);
        console.log(bothEmpty);
        if (bothEmpty){
            document.getElementById("submit").disabled = true;
        } else {
            document.getElementById("submit").disabled = false;
        }
    });

}

function employeeChange(){
    document.getElementById("name").addEventListener("keyup", function(){
            nameLength = document.getElementById("name").value.length;
            threeEmpty = (nameLength == 0) && (phoneLength == 0) && (positionLength == 0);
            console.log(threeEmpty);

            if (threeEmpty){
                document.getElementById("submit").disabled = true;
            } else {
                document.getElementById("submit").disabled = false;
            }
        });

        document.getElementById("phone").addEventListener("keyup", function(){
            phoneLength = document.getElementById("phone").value.length;
            threeEmpty = (nameLength == 0) && (phoneLength == 0) && (positionLength == 0);
            console.log(threeEmpty);

            if (threeEmpty){
                document.getElementById("submit").disabled = true;
            } else {
                document.getElementById("submit").disabled = false;
            }
        });

        document.getElementById("position").addEventListener("keyup", function(){
            positionLength = document.getElementById("position").value.length;
            threeEmpty = (nameLength == 0) && (phoneLength == 0) && (positionLength == 0);
            console.log(threeEmpty);

            if (threeEmpty){
                document.getElementById("submit").disabled = true;
            } else {
                document.getElementById("submit").disabled = false;
            }
        });

}

function allEmptyFieldCheck(){
    document.getElementById("price").addEventListener("keyup", function(){
        priceLength = document.getElementById("price").value.length;
        allEmpty = (priceLength == 0) && (capacityLength == 0) && (defectsLength == 0) && (viewLength == 0);

        if (allEmpty) {
            document.getElementById("submit").disabled = true;
        } else {
            document.getElementById("submit").disabled = false;
        }
    });

    document.getElementById("capacity").addEventListener("keyup", function(){
        capacityLength = document.getElementById("capacity").value.length;
        allEmpty = (priceLength == 0) && (capacityLength == 0) && (defectsLength == 0) && (viewLength == 0);

        if (allEmpty) {
            document.getElementById("submit").disabled = true;
        } else {
            document.getElementById("submit").disabled = false;
        }
    });

    document.getElementById("defects").addEventListener("keyup", function(){
        defectsLength = document.getElementById("defects").value.length;
        allEmpty = (priceLength == 0) && (capacityLength == 0) && (defectsLength == 0) && (viewLength == 0);

        if (allEmpty) {
            document.getElementById("submit").disabled = true;
        } else {
            document.getElementById("submit").disabled = false;
        }
    });

    document.getElementById("view").addEventListener("keyup", function(){
        viewLength = document.getElementById("view").value.length;
        allEmpty = (priceLength == 0) && (capacityLength == 0) && (defectsLength == 0) && (viewLength == 0);

        if (allEmpty) {
            document.getElementById("submit").disabled = true;
        } else {
            document.getElementById("submit").disabled = false;
        }
    });
}