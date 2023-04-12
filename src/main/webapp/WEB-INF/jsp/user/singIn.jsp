<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <section class="sign-in-box">
    <h1>Welcom to Memo</h1>
    <div class="contents">
    <form action="get">
      <p>
        <input type="text" id="userId" name="userId" autocomplete="off" required>
        <label for="userId"><span>아이디</span></label>
      </p> 
      <p>
        <input type="password" id="password" name="password" autocomplete="off" required>
        <label for="password"><span>비밀번호</span></label>
      </p> 
      <button type="submit" class="btn btn-primary">로그인</button>
    </form>
    <br>
    <button type="button" class="btn btn-info">회원가입</button>
    </div>
  </section>