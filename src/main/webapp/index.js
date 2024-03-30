var nameLength = 0;
var addressLength = 0;
var bothEmpty = true;

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