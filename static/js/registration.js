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

function checkPasswords(){
    var password = document.getElementById('password').value;
    var repeated_password = document.getElementById('password_repeated').value;

    if(exists(password) && exists(repeated_password) && password != repeated_password){
        document.getElementById('password_repeated').style.backgroundColor = 'rgba(255,26,0,0.62)';
        document.getElementById('password_repeated').style.color = '#000000';
        document.getElementById('password-error').innerHTML = 'Passwords MUST be equal!';
        document.getElementById('password-error').style.backgroundColor = 'rgba(255,26,0,0.62)';
    }
};

function checkForm(){
     var error_message = "";
     var username = document.getElementById("username").value;
     var email = document.getElementById("email").value;
     var password = document.getElementById("password").value;
     var repeated_password = document.getElementById("password_repeated").value;

    if(!exists(username)){
        error_message += "Please insert a username!\n";
        document.getElementById('username').style.backgroundColor = 'rgba(255,26,0,0.62)';
        document.getElementById('username').style.color = '#000000';
    }

    if(!exists(email)){
        error_message += "Please insert a valid email address!\n";
        document.getElementById('email').style.backgroundColor = 'rgba(255,26,0,0.62)';
        document.getElementById('email').style.color = '#000000';
    }

    if(!exists(password)){
        error_message += "Please insert the password!\n";
        document.getElementById('password').style.backgroundColor = 'rgba(255,26,0,0.62)';
        document.getElementById('password').style.color = '#000000';
    }

    if(!exists(repeated_password)){
        error_message += "Please insert the password twice (for verification)!\n";
        document.getElementById('passwordrepeated').style.backgroundColor = 'rgba(255,26,0,0.62)';
        document.getElementById('passwordrepeated').style.color = '#000000';
    }

    if( exists(password) && exists(repeated_password) && password!=repeated_password) {
        error_message += "Passwords fields MUST have the same value!!!\n";
    }

    if(error_message != ""){
        alert(error_message);
    }else{
        if( exists(password) && exists(repeated_password) && password==repeated_password){
            document.getElementsByClassName('sign-button')[0].click();
        }else{
            alert("Passwords fields MUST have the same value!!!\n");
        }
    }
}
