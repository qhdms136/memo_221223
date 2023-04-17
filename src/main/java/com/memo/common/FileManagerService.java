package com.memo.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component	// spring bean
public class FileManagerService {
	// 실제 업로드 된 이미지가 저장될 경로(서버)
	public static final String FILE_UPLOAD_PATH = "C:\\jbe\\6_spring_project\\memo\\workspace\\images/";
	
	// input : MultipartFile(이미지 파일), loginId(이미지가 겹치지않게 하기위해) 
	// output : image path(String)
	public String saveFile(String loginId, MultipartFile file) {
		// 파일 디렉토리(폴더)	예) aaaa_1678694564/sun.png
		String directoryName = loginId + "_" + System.currentTimeMillis() + "/";
		String filePath = FILE_UPLOAD_PATH + directoryName;	// C:\\jbe\\6_spring_project\\memo\\workspace\\images/aaaa_1678694564/
		
		File directory = new File(filePath);
		if(directory.mkdir() == false) {
			return null;	// 폴더 만드는데 실패 시 이미지 경로 null
		}
		// 파일 업로드 : byte 단위로 업로드
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath + file.getOriginalFilename());	// 디렉토리명 + originalFileName(나중에 한글로 올리면 실행이 안되기때문에 이미지 이름을 영어로 따로 바꾸기!!!)은 사용자가 올린 파일명
			Files.write(path, bytes);	// 파일 업로드
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		// 파일 업로드가 성공했으면 이미지 url path를 리턴한다.
		// http://localhost/images/aaaa_1678694564/sun.pgn
		return "/images/" + directoryName + file.getOriginalFilename();	// originalFileName은 사용자가 올린 파일 이름
	}
}
