function companyInterceptor(){
	let role = localStorage.getItem("role");
	console.log("companyInterceptor" + role);
	
	if(role == "ROLE_COMPANY" || role == "ROLE_ADMIN"){
		console.log("접근 ok");
	}else{
		console.log("접근 no..");
		location.href="/custom403page";
	}
}

companyInterceptor();