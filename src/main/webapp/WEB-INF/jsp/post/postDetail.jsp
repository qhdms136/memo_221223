<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="d-flex justify-content-center">
	<div class="w-50">
		<h1>글 상세/수정</h1>
		<input text="text" id="subject" class="form-control" placeholder="${post.subject}">
		<textarea  rows="10" class="form-control" id="content" placeholder="${post.content}"></textarea>
		
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
				<button type="button" id="saveBtn" class="mx-3 btn btn-warning">수정</button>
			</div>
		</div>
	</div>
</div>