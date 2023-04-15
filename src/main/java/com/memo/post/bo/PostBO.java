package com.memo.post.bo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.memo.post.dao.PostMapper;

@Service
public class PostBO {
	
	@Autowired
	private PostMapper postMapper;
	
	public int addPost(int userId,
			String loginId,
			String subject,
			String content,
			MultipartFile file) {
		String imagePath = null;
		// TODO 서버에 이미지 업로드 후 imagePath 받아옴
		if (file != null) {
			
		}
		
		return postMapper.insertPost(userId, subject, content, imagePath);
	}
	
	public List<Map<String, Object>> getPostList(){
		return postMapper.selectPostList();
	}
}
