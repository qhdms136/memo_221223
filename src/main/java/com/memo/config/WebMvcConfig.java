package com.memo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.memo.common.FileManagerService;
import com.memo.interceptor.PermissionInterceptor;

@Configuration // 설정을 위한 srping bean 
public class WebMvcConfig implements WebMvcConfigurer{
	
	@Autowired
	private PermissionInterceptor interceptor;
	
	// 서버에 업로드 된 이미지와 웹 이미지 주소와의 매핑 설정
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry
		.addResourceHandler("/images/**")	// 웹 이미지 주소 http://localhost/images/aaaa_1681727962154/sig2.png
		.addResourceLocations("file:///" + FileManagerService.FILE_UPLOAD_PATH);	//window / 3개, mac /2개	// 실제 파일 위치
	}
	
	// interceptor 설정 추가
	public void addInterceptors(InterceptorRegistry registry) {
		registry
		.addInterceptor(interceptor)
		.addPathPatterns("/**")		//  /** 아래 디렉토리까지 모두 확인
		.excludePathPatterns("/favicon.ico", "/error", "/static/**", "/user/sign_out");	
	}
}
