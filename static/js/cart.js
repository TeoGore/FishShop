function calculateTotal(){
    var quantity = document.getElementsByClassName("quantity");
    var products = document.getElementsByClassName("prod-price");
    var total = 0.00;

    for (var i = 0; i < products.length; i++) {
        if (parseFloat(products[i].value) && parseInt(quantity[i].value)){
            total += parseInt(quantity[i].value)*parseFloat(products[i].value);
        }
    }
    document.getElementById('total-price').innerHTML = total + ' €';
}