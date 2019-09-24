function exists(input){
    //check if there's at least one char
    var almenoUnCarattere = false;

    if(input) {
    //check input is entered
    for (i=0;i<input.length;i++){
        //check all the characters
            if(input.charAt(i) != " "){
                //found at least one character different from white space
                almenoUnCarattere = true;
                break;
            }
        }
    }
    return almenoUnCarattere;
}

function integerNumber(input) {
    var answer = true;

    //parseInt works like atoi() of C/C++
    if(!parseInt(input)){
        answer = false;
    }else{
        for(var i=0; i<input.length; i++){
            if( (input.charAt(i) != "0") && (!parseInt(input.charAt(i)))){
                answer = false;
                break;
            }
        }
    }
    return answer;
}

function checkForm(login){

    if (!login){
        return needLogin(login);
    }

     var error_message = "";
     var qt = document.getElementById("quantity").value;

    if(!exists(qt)){
        error_message += "Please insert a quantity!\n";
        document.getElementById('quantity').style.backgroundColor = 'rgba(255,26,0,0.62)';
        document.getElementById('quantity').style.color = '#000000';
    }

    if(error_message != ""){
        alert(error_message);
    }else{
        if( exists(qt) && integerNumber(qt) ){
            document.getElementsByClassName('cart-button')[0].click();
        }else{
            alert("You MUST provide a valid quantity (integer)!!!\n");
        }
    }
}
