<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="d-flex justify-content-center">
	<div class="w-50">
		<h1>글 상세/수정</h1>
		<input text="text" id="subject" class="form-control" placeholder="제목을 입력하세요" value="${post.subject}">
		<textarea  rows="10" class="form-control" id="content" placeholder="글 내용을 입력하세요">${post.content}</textarea>
		
		<%-- 이미지가 있을 때만 이미지 영역 추가 --%>
		<c:if test="${not empty post.imagePath}">
			<div>
				<img class="mt-3" src="${post.imagePath}" alt="업로드 된 이미지" width="300">
			</div>
		</c:if>
		<div class="d-flex justify-content-end my-4">
			<input type="file" id="file" accept=".jpg, .jpeg, .png, .gif">
		</div>
		
		<div class="d-flex justify-content-between">
			<%-- a 태그로 해도됨 --%>
			<button type="button" id="postDeletBtn" class="btn btn-secondary">삭제</button>
			<div class="d-flex">
				<a href="/post/post_list_view" class="btn btn-dark">목록</a>
				<button type="button" id="saveBtn" class="mx-3 btn btn-warning" data-post-id="${post.id}">수정</button>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	$('#saveBtn').on('click', function(){
		let subject = $('#subject').val().trim();
		let content = $('#content').val();
		let file = $('#file').val();	// C:\fakepath\park-7913450__340.jpg
		// let postId = ${post.id} --> el 문법후 int 변환
		let postId = $(this).data("post-id");
		// valridation
		if(!subject) {
			alert("제목을 입력하세요.");
			return;
		}
		
		console.log(subject);
		console.log(content);
		console.log(file);
		console.log(postId);
		
		// 파일이 업로드 된 경우 확장자 체크
		if (file != '') {
			let ext = file.split(".").pop().toLowerCase();
			// alert(ext);
			if($.inArray(ext, ['jpg', 'jpeg', 'gif', 'png']) == -1){
				alert("이미지 파일만 업로드 할 수 있습니다.");
				$('#file').val(''); // 파일을 지운다.
				return;
			}
		}
		
		// 폼 태그를 자바스크립트에서 만든다(이미지 때문에)
		let formData = new FormData();
		formData.append("postId", postId);
		formData.append("subject", subject);
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]);
		
		// ajax 통신
		$.ajax({
			//request
			type:"PUT"
			, url:"/post/update"
			, data:formData
			, encType:"multipart/form-data" // 파일 업로드를 위한 필수 설정
			, processData:false	// form 태그로 보낼거냐 >> true/false >> json으로 가는걸 방지 // 파일 업로드를 위한 필수 설정
			, contentType:false // 파일 업로드를 위한 필수 설정
			
			// response
			, success:function(data){
				if (data.code == 1){
					alert("메모가 수정되었습니다.");
					location.reload(true);
				} else{
					alert(data.errorMessage);
				}
			}
			, error:function(request, status, error){
				alert("메모 수정 시 실패했습니다.");
			}
		});
	});
});
</script>