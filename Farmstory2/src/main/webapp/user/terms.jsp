<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<script>
	$(function(){
		$('.btnNext').click(function(e){
			let isCheck1 = $('input[class = terms]').is(':checked');
			let isCheck2 = $('input[class = privacy]').is(':checked');
			
			if(isCheck1 && isCheck2){
				return true;
			}else{
				alert('동의 체크를 하셈');
				return false;
			}
		});
	});
</script>
<main id="user">
    <section class="terms">
        <table border="1">
            <caption>사이트 이용약관</caption>
            <tr>
                <td>
                    <textarea name="terms">${vo.terms}</textarea>
                    <label><input type="checkbox" class="terms">&nbsp;동의합니다.</label>
                </td>
            </tr>
        </table>

        <table border="1">
            <caption>개인정보 취급방침</caption>
            <tr>
                <td>
                    <textarea name="privacy">${vo.privacy}</textarea>
                    <label><input type="checkbox" class="privacy">&nbsp;동의합니다.</label>
                </td>
            </tr>
        </table>
        
        <div>
            <a href="./login.do" class="btn btnCancel">취소</a>
            <a href="./register.do" class="btn btnNext">다음</a>
        </div>

    </section>
</main>
<jsp:include page="/WEB-INF/_footer.jsp"/>