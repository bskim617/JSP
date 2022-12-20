$(()=>{
	let btnRemove = document.getElementsByClassName("btnRemove")[0]; 
	btnRemove.addEventListener("click", e=>{
		let result = confirm('삭제하시겠습니까?');
		if(result) e.defaultPrevented();
		else e.preventDefault();
	});
	
	let cmtContent = document.querySelectorAll("textarea")[1];
	cmtContent.addEventListener("focus", (e)=>{
		let eTarget = e.target;
		if(eTarget.value == "댓글내용 입력") eTarget.value = "";
	});	
	cmtContent.addEventListener("focusout", (e)=>{
		let eTarget = e.target;
		if(eTarget.value == "") eTarget.value = "댓글내용 입력";
	});	
	
	// 댓글쓰기
	$('.btnComplete').click(e=>{
		e.preventDefault();
		let jsonData = {"uid":$('input[name=uid]').val(),
						"parent":$('input[name=parent]').val(),
						"content":$('.commentForm textarea[name=content]').val(),
						}
		$.ajax({
			url:'/JBoard2/commentWrite.do',
			method:'post',
			data:jsonData,
			dataType:'json',
			success:(data)=>{
				$('.empty').remove();
				let tag = 
				`<article>
                	<span class="nick">${data.nick}</span>
                	<span class="date">${data.rdate}</span>
                	<p class="content">${data.content}</p>                        
                	<div>
                    	<a href="#" data-no="${data.no}" data-par="${data.parent}" class="remove">삭제</a>
                    	<a href="#" data-no="${data.no}" class="modify">수정</a>
                	</div>
            	</article>`;
            	
            	$('.commentList').append(tag);
            	$('.commentForm textarea[name=content]').val('댓글내용 입력');
			}
		});	
	});
	
	// 댓글 삭제, 수정
	let commentList = document.getElementsByClassName("commentList")[0];
	commentList.addEventListener("click", e=>{
		e.preventDefault();
		let tar = e.target;
		let varClass = tar.getAttribute("class");
		let no = tar.dataset.no;
		let parent = tar.dataset.par;
		if(varClass == "remove"){
			let url = `/JBoard2/commentDelete.do?no=${no}&parent=${parent}`;
			let result = confirm('삭제하시겠습니까?');
			if(result){
				fetch(url)
				.then(resp=>resp.json())
				.then(data=>{
					if(data.result > 0){
						let article = tar.parentElement.parentElement;
						article.remove();
						let allArticle = document.querySelectorAll('article');
						if(allArticle.length == 0){
							let commentList = document.getElementsByClassName("commentList")[0];
							const pTag = document.createElement("p");
							pTag.innerHTML = "등록된 댓글이 없습니다.";
							pTag.setAttribute("class","empty");
							commentList.appendChild(pTag);
						}
					}
				});
			}	
		}else if (varClass == "modify"){
			tar.previousElementSibling.style.visibility = "hidden";
			tar.textContent = "수정완료";
			let editComment = tar.parentElement.previousElementSibling;
			if(tar.textContent == "수정완료"){
				editComment.style.background = "white";
				editComment.setAttribute("contenteditable", true);
				let txtValue = editComment.textContent;
				editComment.textContent = '';
				editComment.focus();
				editComment.textContent = txtValue;	
			}
						
			tar.addEventListener("click", ()=>{
				if(tar.textContent == "수정완료"){
					let url = '/JBoard2/commentModify.do';
					fetch(url, {
							    method: 'POST', // *GET, POST, PUT, DELETE 등
							    headers: {
		    						"Content-Type": "application/json",
  								},
							    body: JSON.stringify({
									no: no,
									content: editComment.textContent						
								}), // body의 데이터 유형은 반드시 "Content-Type" 헤더와 일치해야 함
						  })
					.then(resp=>resp.json())
					.then(data=>{
						console.log(data);
						console.log(data.result);
						if(data.result > 0){
							tar.previousElementSibling.style.visibility = "visible";
							tar.textContent = "수정";
							editComment.setAttribute("contenteditable", false);
							editComment.style.background = "";
						}
					})
				}
			});
		}
	});
});