<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script>
$(()=>{
	$('.btnModify').click((e)=>{
		isUidOK = true;
		isPassOK = true;
	});
	
	// 비밀번호 수정
	$('#btnPwModify').click((e)=>{
		e.preventDefault();
		$.ajax({
			url:'/JBoard2/user/updatePw.do',
			method:'post',
			data:{
				"uid":$('input[name=uid]').val(),
				"pass":$('input[name=pass2]').val()
				},
			dataType:'json',
			success:(data)=>{
				if(data.result > 0){
					alert('비밀번호가 수정되었습니다.');
					$('input[name=pass1]').val('');
					$('input[name=pass2]').val('');
					isPassOK = true;
				}else{
					alert('비밀번호수정 실패.');
					isPassOK = false;
				}
			}
		});
	});
	
	// 탈퇴 처리
	$('#btnUserDelete').click((e)=>{
		e.preventDefault();
		$.ajax({
			url:'/JBoard2/user/delete.do?uid='+$('input[name=uid]').val(),
			dataType:'json',
			success:(data)=>{
				if(data.result > 0){
					alert('회원 탈퇴처리 되었습니다.')
					location.href = '/JBoard2/user/logout.do';
				}else{
					alert('회원 탈퇴처리가 실패하였습니다.')
				}
			}
		});
	});
	
});

</script>
<main id="user">
    <section class="register">
        <form action="/JBoard2/user/myInfo.do" method="post">
	        <input type="hidden" name="uid" value="${sessUser.uid}"/>
	        <input type="hidden" name="pass" value="${sessUser.pass}"/>
            <table border="1">
                <caption>회원정보 설정</caption>
                <tr>
                    <td>아이디</td>
                    <td>${sessUser.uid}</td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td>
                    	<input type="password" name="pass1" placeholder="비밀번호 입력"/>
                    	<span class="passResult"></span>
                    </td>
                     
                </tr>
                <tr>
                    <td>비밀번호 확인</td>
                    <td>
	                    <input type="password" name="pass2" placeholder="비밀번호 입력 확인"/>
	                    <button type="button" id="btnPwModify">비밀번호 수정</button>
                    </td>
                </tr>
                <tr>
                	<td>회원가입일</td>
                	<td>${sessUser.rdate}</td>
                </tr>
            </table>

            <table border="1">
                <caption>개인정보 입력</caption>
                <tr>
                    <td>이름</td>
                    <td>
                        <input type="text" name="name" value="${sessUser.name}" />
                        <span class="nameResult"></span>                        
                    </td>
                </tr>
                <tr>
                    <td>별명</td>
                    <td>
                        <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                        <input type="text" name="nick" value="${sessUser.nick}"/>
                        <button type="button" id="checkNick"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                        <span class="nickResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        <input type="email" name="email" value="${sessUser.email}"/>
                        <button type="button" id="btnEmail"><img src="../img/chk_auth.gif" alt="인증번호 받기"/></button>
                        <div class="auth">
                            <input type="text" name="auth" placeholder="인증번호 입력"/>
                            <button type="button" id="btnAuth"><img src="../img/chk_confirm.gif" alt="확인"/></button>
                        </div>
                        <span class="emailResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>휴대폰</td>
                    <td><input type="text" name="hp" value="${sessUser.hp}"/><span class="hpResult"></span></td>
                </tr>
                <tr>
                    <td>주소</td>
                    <td>
                        <input type="text" name="zip" id="zip" value="${sessUser.zip}"/>
                        <button type="button" onclick="execDaumPostcode()"><img src="../img/chk_post.gif" alt="우편번호찾기"/></button>
                        <input type="text" name="addr1" id="addr1" value="${sessUser.addr1}"/>
                        <input type="text" name="addr2" id="addr2" value="${sessUser.addr2}"/>
                    </td>
                </tr>
                <tr>
                	<td>회원탈퇴</td>
                	<td><button type="button" id="btnUserDelete">회원탈퇴</button></td>
                </tr>
                
            </table>
            <div>
                <a href="./login.do" class="btn btnCancel">취소</a>
                <input type="submit" value="회원정보수정" class="btn btnModify"/>
            </div>
        </form>
    </section>
</main>
<jsp:include page="./_footer.jsp"/>