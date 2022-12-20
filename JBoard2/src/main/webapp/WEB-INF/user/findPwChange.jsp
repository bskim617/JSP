<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script>
$(()=>{
	$('.btnNext').click((e)=>{
		e.preventDefault();
		if(!isPassMatch){
			alert('비밀번호가 일치하지 않습니다.')
			return false;
		}
		
		if(!isPassOK){
			alert('영문, 숫자, 특수문자 조합 최소5자 이상이여야 합니다.');
			return false;
		}
		
		$.ajax({
			url: '/JBoard2/user/findPwChange.do',
			method: 'post',
			data : {
					"pass":$('input[name=pass2]').val(),
					"uid":$('.uid').text()
					},
			dataType : 'json',
			success:(data)=>{
				if(data.result > 0){
					alert('비밀번호 변경에 성공하였습니다.\n다시 로그인해주시기 바랍니다.');
					location.href = '/JBoard2/user/login.do';
				}
			}
		});
	});
});
</script>
<main id="user">
    <section class="find findPwChange">
        <form action="#">
            <table>
                <caption>비밀번호 변경</caption>                        
                <tr>
                    <td>아이디</td>
                    <td class="uid">${requestScope.uid}</td>
                </tr>
                <tr>
                    <td>새 비밀번호</td>
                    <td>
                        <input type="password" name="pass1" placeholder="새 비밀번호 입력"/>
                    </td>
                </tr>
                <tr>
                    <td>새 비밀번호 확인</td>
                    <td>
                        <input type="password" name="pass2" placeholder="새 비밀번호 입력"/>
                    </td>
                </tr>
            </table>                                        
        </form>
        
        <p>
            비밀번호를 변경해 주세요.<br>
            영문, 숫자, 특수문자를 사용하여 8자 이상 입력해 주세요.                    
        </p>

        <div>
            <a href="/JBoard2/user/login.do" class="btn btnCancel">취소</a>
            <a href="/JBoard2/user/login.do" class="btn btnNext">다음</a>
        </div>
    </section>
</main>
<jsp:include page="./_footer.jsp"/>