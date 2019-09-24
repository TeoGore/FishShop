function needLogin(login){
	if (!login){
		alert("You need to sign in first!!!");
		window.location.href = "login.html";
	}
}

function logout(){
	alert("You signed out correctly!");
	window.location.href = "home.html";
}