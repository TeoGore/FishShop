function exists(input){
    //check if there's at least one char
    var almenoUnCarattere = false;

    if(input) {
    for (i=0;i<input.length;i++){
        //check all the characters
            if(input.charAt(i) != " "){
                almenoUnCarattere = true;
                break;
            }
        }
    }
    return almenoUnCarattere;
}

function checkForm(){
     var error_message = "";
     var username = document.getElementById("username").value;
     var password = document.getElementById("password").value;

    if(!exists(username)){
        error_message += "Please insert a username!\n";
        document.getElementById('username').style.backgroundColor = 'rgba(255,26,0,0.62)';
        document.getElementById('username').style.color = '#000000';
    }

    if(!exists(password)){
        error_message += "Please insert the  password!\n";
        document.getElementById('password').style.backgroundColor = 'rgba(255,26,0,0.62)';
        document.getElementById('password').style.color = '#000000';
    }

    if(error_message != ""){
        alert(error_message);
    }else{
        document.getElementsByClassName('sign-button')[0].click();
    }
}
