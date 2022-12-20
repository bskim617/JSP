 // 이메일 인증코드
let receiveCode = 0;
let isEmailValiOK = false;
let isEmailAuthOK = false;
let preventDoubleClick = false;

$(()=>{
	// 이메일 유효성 검사
	$('input[name=email]').focusout(function(){
		
		let email = $(this).val();
		
		if(!email.match(regEmail)){
			isEmailValiOK = false;
			$('.emailResult').css('color', 'red').text('이메일이 유효하지 않습니다.');
		}else{
			isEmailValiOK = true;
			$('.emailResult').text('');
		}
	});
	$('input[name=email]').keydown(()=>{
		isEmailOK = false;
		$('.emailResult').text('');
	});
	
	$('.auth').hide();
	
	
	// 이메일 인증
	$('#btnEmail').click(emailAuth);
	$('.btnAuth').click(()=>{
		emailAuth();
	});
	
	
	function emailAuth () {
		if(isEmailOK) return false; // 인증 성공 비활성화
		if(!isEmailValiOK) return false; // 유효성 실패 비활성화
		if(preventDoubleClick)return false;// 인증 실패 연속 시도 금지
		preventDoubleClick = true; // 1회 시도시 true
		
		let email = $('input[name=email]').val();
		if(email == ''){
			alert('이메일을 입력하세요');
		}
			
		$('.emailResult').text('인증메일 전송 중 입니다...');
		setTimeout(() => {
			$.ajax({
				url:'/JBoard2/user/emailAuth.do',
				method:'GET',
				data:{"email":email},
				dataType:'json',
				success:(data)=>{
					if(data.status > 0) // 메일전송 성공
					{
						$('.auth').show();
						$('#btnEmail').hide();
						$('.emailResult').text('이메일을 확인후 인증코드를 입력하세요.');
						isEmailAuthOK = true;
						receiveCode = data.code;
					}
					else  // 메일전송 실패
					{
						isEmailOK = false;
						alert('메일 전송이 실패했습니다. \n 다시 시도 하시기 바랍니다.');
					}
				}
			});	
		}, 1000);
	}
		
	// 인증번호 확인
	$('#btnAuth').click(()=>{
		if(!isEmailAuthOK) return false;
		if(isEmailOK) return false;
		let result = $('input[name=auth]').val();
		$('.emailResult').text('...');
		setTimeout(() => {
			if(result == receiveCode){
				$('.auth, #btnEmail').hide();
				$('.emailResult').css('color','blue').text('이메일이 인증되었습니다.');
				$('input[name=email]').attr('readonly', true);
				isEmailOK = true;
			}
			else{
				$('.emailResult').text('인증에 실패하였습니다.');
				isEmailOK = false;
			}
		}, 500);
	});
});