<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="./_header.jsp"/>
<script src="/JBoard2/js/comment.js"></script>
<main id="board">
    <section class="view">
        
        <table border="0">
            <caption>글보기</caption>
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" value="${vo.title}" readonly/></td>
            </tr>
            <c:if test="${vo.file ne 0}">
            <tr>
                <th>파일</th>
                <td><a href="/JBoard2/download.do?fno=${vo.fno}">${vo.oriName}</a>&nbsp;<span>${vo.download}</span>회 다운로드</td>
            </tr>
            </c:if>
            <tr>
                <th>내용</th>
                <td>
                    <textarea name="content" readonly>${vo.content}</textarea>
                </td>
            </tr>                    
        </table>
        
        <div>
        	<c:if test="${sessUser.uid eq vo.uid}">
            <a href="./delete.do?no=${vo.no}" class="btn btnRemove">삭제</a>
            <a href="./modify.do?no=${vo.no}" class="btn btnModify">수정</a>
            </c:if>
            <a href="./list.do" class="btn btnList">목록</a>
        </div>

        <!-- 댓글목록 -->
        <section class="commentList">
            <h3>댓글목록</h3>                   
			<c:forEach var="comment" items="${comments}">
            <article>
                <span class="nick">${comment.nick}</span>
                <span class="date">${comment.rdate}</span>
                <p class="content">${comment.content}</p>
                <c:if test="${sessUser.uid eq comment.uid}">                        
                <div>
                    <a href="#" data-no="${comment.no}" data-par="${comment.parent}" class="remove">삭제</a>
                    <a href="#" data-no="${comment.no}" class="modify">수정</a>
                </div>
                </c:if>
            </article>
			</c:forEach>

			<c:if test="${empty comments}">
            <p class="empty">등록된 댓글이 없습니다.</p>
            </c:if>

        </section>

        <!-- 댓글쓰기 -->
        <section class="commentForm">
            <h3>댓글쓰기</h3>
            <form action="#">
            <input type="hidden" name="uid" value="${sessUser.uid}">
            <input type="hidden" name="parent" value="${vo.no}">
                <textarea name="content">댓글내용 입력</textarea>
                <div>
                    <a href="./list.do" class="btn btnCancel">취소</a>
                    <input type="submit" value="작성완료" class="btn btnComplete"/>
                </div>
            </form>
        </section>

    </section>
</main>
<jsp:include page="./_footer.jsp"/>