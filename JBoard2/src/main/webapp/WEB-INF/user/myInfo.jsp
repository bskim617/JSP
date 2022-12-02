<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/JBoard2/js/postcode.js"></script>
<script src="/JBoard2/js/validation.js"></script>
<script>
	$(function(){
		
		$('.btnPass').click(function(e){
			e.preventDefault();
			
			let uid = $('.uid').text();
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $('input[name=pass2]').val();
			
			if(pass1 != pass2){
				alert('비밀번호가 일치하지 않습니다.');
				return;
			}
			
			if(!pass2.match(regPass)){
				alert('영문, 숫자, 특수문자 조합 최소 5자 이상 이어야 합니다.');
				return;
			}
			
			let jsonData = {
				"uid": uid,
				"pass": pass2
			};
			
			$.ajax({
				url: '/JBoard2/user/myInfo.do',
				method: 'post',
				data: jsonData,
				dataType: 'json',
				success: function(data){
					
					if(data.result > 0){
						alert('새로운 비밀번호로 변경했습니다.');
					}				
				}
			});
		});
		
		
		$('.btnRegister').click(function(){
			let name = $('input[name=name]').val();
			let nick = $('input[name=nick]').val();
			let email = $('input[name=email]').val();
			let hp = $('input[name=hp]').val();
			let zip = $('input[name=zip]').val();
			let addr1 = $('input[name=addr1]').val();
			let addr2 = $('input[name=addr2]').val();
			
			let jsonData ={
					"name": name,
					"nick": nick,
					"email": email,
					"hp": hp,
					"zip": zip,
					"addr1": addr1,
					"addr2": addr2
			};
			
			$.ajax({
				url: '/JBoard2/user/myInfo.do',
				type: 'post',
				data: jsonData,
				dataType: 'json',
				success: function(data){
					
					if(data.rs > 0){
						alert('성공');
						location.href = "/JBoard2/list.do";
				}
			}
		});
		
		});
	});
		
</script>
<main id="user">
    <section class="register">
        <form action="#" method="post">
            <table border="1">
                <caption>회원정보 설정</caption>
                <tr>
                    <td>아이디</td>
                    <td class="uid">${sessUserForFindId.uid}</td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td>
                    	<input type="password" name="pass1" placeholder="비밀번호 입력"/>
                    	<span class="resultPass"></span>
                    </td>
                </tr>
                <tr>
                    <td>비밀번호 확인</td>
                    <td>
                    	<input type="password" name="pass2" placeholder="비밀번호 입력 확인"/>
                    	<button type="button" class="btn btnPass">비밀번호 수정</button>
                    </td>
                </tr>
                <tr>
                    <td>회원가입일</td>
                    <td>${sessUserForFindId.rdate}</td>
                </tr>
            </table>

            <table border="1">
                <caption>개인정보 수정</caption>
                <tr>
                    <td>이름</td>
                    <td>
                        <input type="text" name="name" value="${sessUserForFindId.name}" placeholder="이름 입력"/>
                        <span class="resultName"></span>     
                    </td>
                </tr>
                <tr>
                    <td>별명</td>
                    <td>
                        <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                        <input type="text" name="nick" value="${sessUserForFindId.nick}" placeholder="별명 입력"/>
                        <button type="button" id="btnNickCheck"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                        <span class="resultNick"></span>
                    </td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        <input type="email" name="email" value="${sessUserForFindId.email}" placeholder="이메일 입력"/>
                        <span class="resultEmail"></span>
                        <button type="button" id="btnEmail"><img src="../img/chk_auth.gif" alt="인증번호 받기"/></button>
                        <div class="auth">
                            <input type="text" name="auth" placeholder="인증번호 입력"/>
                            <button type="button" id="btnEmailConfirm"><img src="../img/chk_confirm.gif" alt="확인"/></button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>휴대폰</td>
                    <td>
                    	<input type="text" name="hp" value="${sessUserForFindId.hp}" placeholder="휴대폰 입력"/>
                    	<span class="resultHp"></span>
                    </td>
                </tr>
                <tr>
	                <td>주소</td>
	                <td>
	                    <input type="text" name="zip" id="zip" placeholder="우편번호 검색" readonly value="${sessUserForFindId.zip}"/>
	                    <button type="button" onclick="postcode()"><img src="/JBoard2/img/chk_post.gif" alt="우편번호 찾기"/></button>
	                    <input type="text" name="addr1" id="addr1" placeholder="기본주소 검색" readonly value="${sessUserForFindId.addr1}"/>
	                    <input type="text" name="addr2" id="addr2" placeholder="상세주소 입력" value="${sessUserForFindId.addr2}"/>
	                </td>
	            </tr>
	            <tr>
	            	<td>회원탈퇴</td>
	            	<td>
	            		<button type="button" name="gd" class="gd" style="padding:6px; background: #ed2f2f; color: #fff;">회원탈퇴</button>
	            	</td>
	            </tr>
                
            </table>

            <div>
                <a href="/JBoard2/list.do" class="btn btnCancel">취소</a>
                <input type="button" value="회원수정" class="btn btnRegister"/>
            </div>

        </form>

    </section>
</main>
<jsp:include page="./_footer.jsp"/>