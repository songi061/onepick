function noMemberInterceptor(){
	let role = localStorage.getItem("role");
	console.log("noMemberInterceptor" + role);
	
	if(role == null){
		console.log("접근 ok");
	}else{
		console.log("접근 no..");
		location.href="/custom403page";
	}
}

noMemberInterceptor();

