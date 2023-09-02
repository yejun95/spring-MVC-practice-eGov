<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Spring MVC02</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		loadList();
	});

	function loadList() {
		$.ajax({
			url : 'board/selectAll',
			type : 'get',
			dataType : 'json',
			success : makeView, // 콜백함수
			error : function() {alert("error");}
		});
	};

	function makeView(data) {
		let listHtml = "<table class='table table-bordered'>";
			listHtml += "<tr>";
			listHtml += "<td>번호</td>";
			listHtml += "<td>제목</td>";
			listHtml += "<td>작성자</td>";
			listHtml += "<td>작성일</td>";
			listHtml += "<td>조회수</td>";
			listHtml += "</tr>";
		$.each(data, function(index, obj){
			listHtml += "<tr>";
			listHtml += "<td>"+obj.idx+"</td>";
			listHtml += "<td id='titleff"+obj.idx+"'><a href='javascript:goContent("+obj.idx+", "+obj.content+")' >"+obj.title+"</a></td>";
			listHtml += "<td>"+obj.writer+"</td>";
			listHtml += "<td>"+obj.indate.split(' ')[0]+"</td>";
			listHtml += "<td id='countff"+obj.idx+"'>"+obj.count+"</td>";
			listHtml += "</tr>";
			
			listHtml += "<tr id='c"+obj.idx+"' style='display:none'>"
			listHtml += "<td>내용</td>"
			listHtml += "<td colspan='4'>"
			listHtml += "<textarea id='contentff"+obj.idx+"' rows='7' class='form-control' readonly></textarea>"
			listHtml += "</br>"
			listHtml += "<span id='updateBtn"+obj.idx+"'><button class='btn btn-success' btn-sm onclick='goUpdateForm("+obj.idx+")'>수정화면</button></span>&nbsp"
			listHtml += "<button class='btn btn-warning' btn-sm onclick='goDelete("+obj.idx+")'>삭제</button>"
			listHtml += "</td>"
			listHtml += "</tr>"
			
		});
			listHtml += "<tr>";
			listHtml += "<td>";
			listHtml += "<button class='btn btn-primary' onclick='goForm()'>글쓰기</button>";
			listHtml += "</td>";
			listHtml += "</tr>";
			
			listHtml += "</table>";
		$("#view").html(listHtml);
		$("#view").css('display', 'block');
		$("#wform").css('display', 'none');
		
		// value 값 초기화
		$('#title').val('');
		$('#content').val('');
		$('#writer').val('');
	};
	
	// 글쓰기 폼으로
	function goForm() {
		$("#view").css('display', 'none');
		$("#wform").css('display', 'block');
	};
	
	// boardList로
	function goList() {
		$("#view").css('display', 'block');
		$("#wform").css('display', 'none');
		$("#fclear").trigger("click");
	};

	// 글쓰기
	function goInsert() {
		let fData = $("#frm").serialize();
		
		$.ajax({
			url: 'board/add',
			type: 'post',
			data: fData,
			success: loadList,
			error: function(){ alert('error');}
		});
	}
	
	// 게시글 상세보기
	function goContent(idx, content) {
		if($("#c"+idx).css("display") == "none") {
			$("#c"+idx).css('display', 'table-row');
			$("#contentff"+idx).attr("readonly", true);
			
			$.ajax({
				url : "board/selectOne/"+idx,
				type : "get",
				dataType : "json",
				success : function(data) {
					$("#contentff"+idx).text(data.content);
				},
				error : function(){ alert("err");}
			});
		} else {
			$("#c"+idx).css('display', 'none');
			$("#contentff"+idx).text(content);
			
			$.ajax({
				url : "board/count/"+idx,
				type : "put",
				dataType : "json",
				success : function(data) {
					$("#countff"+idx).text(data.count); // val.(data.count)로 하게되면 새로고침해야 바뀜
				},
				error : function() { alert("err");}
				
			});
		};
	};
	
	// 게시글 삭제
	function goDelete(idx) {
		$.ajax({
			url: "board/delete/"+idx,
 			type: "delete",
			success: loadList,
			error: function(){ alert("err");}
		});
	};
	
	// 게시글 수정화면
	function goUpdateForm(idx) {
		let title = $("#titleff"+idx).text();
		let newInput = "<input type='text' id='newInputff"+idx+"' calss='form-control' value='"+title+"'/>"
		$("#contentff"+idx).attr("readonly", false);
		$("#titleff"+idx).html(newInput);
		
		let newButton = "<button class='btn btn-primary btn-sm' onclick='goUpdate("+idx+")'>수정</button>"
		$("#updateBtn"+idx).html(newButton);
	};
	
	function goUpdate(idx) {
		let title = $("#newInputff"+idx).val();
		let content = $("#contentff"+idx).val();
		
		$.ajax({
			url : "board/update",
			type : "put",
			data : JSON.stringify({"idx" : idx, "title" : title, "content" : content}),
			contentType: "application/json;charset=utf8",
			success : loadList,
			error : function() { alert("err"); }
		});
	};
	
</script>
</head>
<body>

	<div class="container">
		<h2>Spring MVC02</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Board</div>
			<div class="panel-body" id="view"></div>
			<div class="panel-body" id="wform" style="display: none">
				<form id="frm">
					<table class="table">
						<tr>
							<td>제목</td>
							<td><input type="text" id="title" name="title" calss="form-control" /></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea rows="7" class="form-control" id="content" name="content"></textarea></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td><input type="text" id="writer" name="writer" calss="form-control" /></td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
								<button type="reset" class="btn btn-warning btn-sm" id="fclear">취소</button>
								<button type="button" class="btn btn-warning btn-sm" onclick="goList()">리스트</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="panel-footer">인프런_스프1탄_박매일</div>
		</div>
	</div>

</body>
</html>
