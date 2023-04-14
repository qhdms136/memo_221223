<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="w-50">
		<h1>글쓰기</h1>
		<input text="text" id="subject" class="form-control" placeholder="제목을 입력하세요">
		<textarea  rows="10" class="form-control" id="content" placeholder="내용을 입력하세요"></textarea>
		<div class="d-flex justify-content-end my-4">
			<input type="file" id="file" accept=".jpg, .jpeg, .png, .gif">
		</div>
		
		<div class="d-flex justify-content-between">
			<%-- a 태그로 해도됨 --%>
			<button type="button" id="postListBtn" class="btn btn-dark">목록</button>
			<div class="d-flex">
				<button type="button" id="clearBtn" class="btn btn-secondary">모두 지우기</button>
				<button type="button" id="saveBtn" class="mx-3 btn btn-warning">저장하기</button>
			</div>
		</div>
	</div>
</div>


<script>
$(document).ready(function(){
	// 목록 버튼 클릭 => 글 목록으로 이동
	$('#postListBtn').on('click', function(){
		location.href="/post/post_list_view";
	});
	
	// 모두 지우기 버튼
	$('#clearBtn').on('click', function(){
		// 값을 넣으면 그 값으로 세팅
		$('#subject').val("");
		$('#content').val("");
	});
	
	// 글 저장
	$('#saveBtn').on('click', function(){
		
		// validation
		let subject = $('#subject').val().trim();
		let content = $('#content').val();
		let file = $('#file').val();	// C:\fakepath\playtime.png 이미지 경로로 저장
		
		if(!subject) {
			alert("제목을 입력하세요");
			return;
		}
		// alert(file);
		
		// 파일이 업로드 된 경우에만 확장자 체크
		if(file != "") {
			// 확장자만 뽑아서 소문자로 바꿔 검사
			let ext = file.split(".").pop().toLowerCase();
			// alert(ext);
			if($.inArray(ext, ['jpg', 'jpeg', 'png', 'gif']) == -1) {
				alert("이미지 파일만 업로드 할 수 있습니다.");
				$('#file').val(""); // 파일을 비운다.
				return;
			}
		}
		
		// 서버 AJAX
		// 이미지를 업로드 할 때는 form 태그가 반드시 있어야 한다.
		// append 함수는 폼 태그의 name 속성과 같다.
		let formData = new FormData();
		formData.append("subject", subject);	//(name, let 변수)
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]);
		
		$.ajax({	// 사이즈가 크면 원래 쓰던 구문으로
			// request
			type:"POST"
			, url:"/post/create"
			, data:formData
			, enctype:"multipart/form-data" // 파일 업로드를 위한 필수 설정
			, processData:false // 파일 업로드를 위한 필수 설정
			, contentType:false // 파일 업로드를 위한 필수 설정
			// response
			, success:function(data){
				if(data.code == 1){
					// 성공
					alert("메모가 저장되었습니다.");
					location.href="/post/post_list_view";
				} else {
					// 실패
					alert(data.errorMessage);
				}
			}
			, error:function(request, status, error){
				alert("글을 저장하는데 실패했습니다.");
			}
		});
	});
});
</script>