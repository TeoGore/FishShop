function calculateTotal(){
    var quantity = document.getElementsByClassName("quantity");
    var products = document.getElementsByClassName("prod-price");
    var total = 0.00;

    for (var i = 0; i < products.length; i++) {
        if (parseFloat(products[i].value) && parseInt(quantity[i].value)){
            total += parseInt(quantity[i].value)*parseFloat(products[i].value);
        }
    }
    return total;
}

function writeTotal(){
    var total = calculateTotal();
    document.getElementById('total-price').innerHTML = total + ' €';
}

function enoughMoney(credit){
    var debt = calculateTotal();
    if (credit >= debt) {
        document.getElementById('buy-button').click();
    } else {
      	alert("You need more money to buy all that fish !!!");
      	window.location.href = "profile.html";
    }
}