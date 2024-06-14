package com.example.onepickView.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	@Value("${spring.servlet.multipart.location}")
	String uploadPath;
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/images/**").addResourceLocations("file:///" + uploadPath);
	}
	
//	 @Override
//	 public void addInterceptors(InterceptorRegistry registry) {
//	        registry.addInterceptor(adminInterceptor)
//	                .addPathPatterns("/admin/**") // 인터셉터를 적용할 URL 패턴
//	                .excludePathPatterns("/exclude-path"); // 제외할 URL 패턴
//	        
//	        registry.addInterceptor(memberInterceptor)
//	        .addPathPatterns("/member/**") // 인터셉터를 적용할 URL 패턴
//	        .excludePathPatterns("/member/mem_login") // 제외할 URL 패턴
//	        .excludePathPatterns("/member/mem_regist"); // 제외할 URL 패턴
//	    }
}