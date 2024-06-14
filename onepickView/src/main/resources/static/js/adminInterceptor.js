function adminInterceptor(){
	let role = localStorage.getItem("role");
	console.log("adminInterceptor" + role);
	
	if(role == "ROLE_ADMIN"){
		console.log("접근 ok");
	}else{
		console.log("접근 no..");
		location.href="/custom403page";
	}
}

adminInterceptor();