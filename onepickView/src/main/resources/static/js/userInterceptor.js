function userInterceptor(){
	let role = localStorage.getItem("role");
	console.log("userInterceptor" + role);
	
	if(role == "ROLE_USER" || role == "ROLE_ADMIN"){
		console.log("접근 ok");
	}else{
		console.log("접근 no..");
		location.href="/custom403page";
	}
}

userInterceptor();