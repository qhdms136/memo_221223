package com.memo.post;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.memo.post.bo.PostBO;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/post")
@RestController
public class PostRestController {
	
	@Autowired
	private PostBO postBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("subject") String subject,
			@RequestParam(value="content", required=false) String content,
			@RequestParam(value="file", required=false) MultipartFile file,
			HttpSession session){
		
		// 세션에서 유저 정보 꺼내오기
		int userId = (int)session.getAttribute("userId");
		String userloginId = (String)session.getAttribute("userLoginId");
		// db insert
		int rowCount = postBO.addPost(userId, userloginId, subject, content, file);
		
		// 응답
		Map<String, Object> result = new HashMap<>();
		if(rowCount > 0) {
			result.put("code", 1);
			result.put("result", "성공");		
		} 	else {
			result.put("code", 500);
			result.put("errorMessage", "메모를 저장하지 못했습니다.");
		}
		return result;
	}
	
}
