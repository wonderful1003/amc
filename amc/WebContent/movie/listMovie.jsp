<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.13/semantic.min.css">
   
</head>

<body>


    
   <div class="wrapper">
        <!-- Banner -->
         <div class="banner-top">
            <img alt='top banner' src="../images/banners/space.jpg">
        </div> 
          <header class="header-wrapper header-wrapper--home">
			<!-- ToolBar Start /////////////////////////////////////-->
			<jsp:include page="/layout/topToolbar.jsp" />
			<!-- ToolBar End /////////////////////////////////////-->
		  </header>  
    <div class="container" id="body">
        
        <!-- Main content -->
        <!--  <section class="container"> -->
        
                <!-- Search bar -->
 			<div class="col-sm-12">
 			
                <h1 class="page-heading"> 현재 상영 영화 </h1>                
				
			    	<div class="col-md-2 text-right">          
	                      <form class="form-search" name="detailForm">
	                 
						    <label class="sr-only" for="searchKeyword">검색어</label>
						    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
						     size="15" value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
					  		  
						     <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						    <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}" />
						  	 </form>
				   </div>
				   		
				  <i class='fa fa-search' id="searchIcon" style="color:grey"></i>  &nbsp; 	
				  <i class='fa fa-microphone' id="voidSearchIcon" style="color:grey"> </i>	
				
	         	
				  <!-- Login Common PlugIn -->
				
				  <jsp:include page="/layout/loginModal.jsp" />   
				
				  
				  
				  <hr/>   
				  
             
             
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  <!-- Login Common PlugIn -->
				
               
             
                <div class="cinema-wrap">
	            	<div class="row">
				 		<c:set var="i" value="0" />
                		 <c:forEach var="movie" items="${list }">
                		 <c:set var="i" value="${i+1 }" />
                		 
	                           	<div class="col-xs-12 col-sm-3">
								  <div class=" cinema-item">
	                                <div class="cinema">
	                                    <a href='/movie/getMovie?movieNo=${movie.movieNo}&menu=movie' class="cinema__images">
	                                        <img id="poster"alt='' src="${movie.postUrl }" >                                        
	                                    </a>
	                                    <a href="/movie/getMovie?movieNo=${movie.movieNo}&menu=movie" class="movieNm">${movie.movieNm }</a>
	                                    <style>P{margin-top:0px;margin-bottom:0px;}</style>
	                                    <p ><strong>개봉일 :${movie.openDt } </strong> </p>
	                                   
	                    	    <div style="text-align: left;">
    						    
    						    </div>								
    							 
    							 <input type='hidden' name='test${movie.movieNo }'  value='${movie.movieNo }'>
     						
							    <span style="line-height:0%">
							    <c:set var="name" value="${movie.wishList.wishNo}"/>
	 								<c:if test="${name eq '0'}">
								<%-- bootstrap icon이 작동이 되질 않음      --%>
								<%-- <i class='glyphicon glyphicon-heart-empty' id="${movie.movieNo}" style="color:#FF5733;
										text-align : center; margin:0 auto;">   --%>	
								<i class='fa fa-heart-o' id="${movie.movieNo}" style="color:#FF5733;text-align : center; margin:0 auto;"> 	 
											<input type='hidden' id='scMovieNo' 	 value="${movie.movieNo}">	 
							    			<input type='hidden' id='userId'  	 	 value="${user.userId}">	
									     </i> 						
								    </c:if>	
								    
								    <c:if test="${name ne '0'}">
									    <i class='fa fa-heart' id="${movie.movieNo}" style="color:#FF5733; text-align : center; margin:0 auto;">
									    	<input type='hidden' id='scMovieNo' 	 value="${movie.movieNo}">	 
							    			<input type='hidden' id='userId'  	 	 value="${user.userId}">	 
									    </i> 						
									</c:if>	
							   </span>                                                   

	                             &nbsp;&nbsp;

	                            <span style="line-height:0%">
	                             
	                            <input type='hidden' name='screenMovieNo'  value='"+val.movieNo+"'>	                                                  
	                            <i class='fa fa-phone' id='reserve-ticket' style="color:#FB1D04; text-align : center; margin:0 auto;">예매 </i>   
	                            </span>
	                         
	                           
	                                    	     
	                                </div>
	                            </div>                      
	                    	</div>	
                		 </c:forEach>
                		  
					</div>
	           </div>     
                              
 				
 					<div class="coloum-wrapper">
	                    <div class="pagination paginatioon--full">
	                    	<c:if test="${resultPage.currentPage != 1 }">
	                            <a href='#' class="pagination__prev">prev</a>
	                    	</c:if>
	                     	<c:if test="${resultPage.maxPage !=  resultPage.currentPage}">	            
	                            <a href='#' class="pagination__next">next</a>
	                      	</c:if>
	                    </div>
	                      
	                </div>
	               
              </div>
        
        
      
    </div>
    	 <div class="clearfix"></div>	
	
	</div>	

	 
		<jsp:include page="/layout/bottomToolbar.jsp" />
		<!-- SpeechModal PlugIn -->
		
		
		
        <!-- Custom 이게있어야지 스크롤내릴시top버튼있음!!!!!!!!!!! -->
       
		<!-- ------------------------------------  -->
		<script src="/js/custom.js"></script>
		<%-- <jsp:include page="/movie/speechMovie.jsp" />  --%>
		
	
		
		
		<!--  Semantic UI modal windows pop-up 용  -->
		<div class="ui mini modal" >
		<!-- <div class="center"> -->	
		<div style="border: 1px dashed #BDBDBD; background-color: #FBFCFC;   margin-left: auto;
 		 margin-right: auto; padding: 5px; text-align: center; line-height: 30px; vertical-align:middle;">
		 <div class="header">영화 음성 검색 중....</div>
		  <div class="content" >
		   	<p>
		   		<form id="webspeech"  method="POST">  
		   		   <div class="image content">
		   				 <img class="image">
						       <img src="../images/movie/speechListening2.gif"> 
						         <div class="description">
						            
						            <div class="ui loading search">
									  <div class="ui icon input">
									     <input type="text" class="prompt" name="abc" id="speech-transcript" placeholder="Search...">
									     <i class="search icon"></i>
									  </div>
									  <div class="results"></div>
									</div>
						            
						             
						            <input type="button" value="클릭후 말해주세요 " id="speech-btn" class="positive ui button">  
						            
						            <br/><br/>
						        
						        	<div class="actions">
						        		   <i class='fa fa-check fa-3x' id="voidSearchOk" style="color:#3498DB"></i>  &nbsp;	
     								 
						        	  <div class="ui red deny button">
									              나가기 
							     	 </div>
						           </div>
						             
						         	<div class="form-group">    
							    	<input type="hidden" class="form-control" id="searchCondition" name="searchCondition"  value="1" > 
							        <input type="hidden" class="form-control" id="voiceSearchKeyword" name="searchKeyword" value="" > 
    			
      							 </div>
      							 </div>
						 </div>
		   		</form>
		  </div>
	</div>
</div>
	
</body>
       
    
  <!--  ///////////////////////// JavaScript ////////////////////////// -->   
   
    <script type="text/javascript">
  //=============    검색 / page 두가지 경우 모두  Event  처리 =============	
				
	  			function fncGetPageList(currentPage) {
	  
	  				//alert("1111")
	  
					$("#currentPage").val(currentPage)
					
					var aa = $("#currentPage").val(currentPage);
	  				//alert("next page #" + aa);
					
					$(".form-search").attr("method","POST").attr("action", "/movie/getMovieList?menu=search").submit();
				
					
				}
			    
			     //============= "검색"  Event  처리 =============	
				 $(function() {
					 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
					$( "button.btn.btn-default" ).on("click" , function() {
						fncGetPageList(1);
					});
					
				 });
				
				//============= "검색 Icon"  Event  처리 =============	
				 $(function() {
					 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
					$( ".btn.btn-md.btn--danger.search__button").on("click" , function() {
						
						//alert("searchbutton called")
						fncGetPageList(1);
					});
					
				 });
				
				
				//============= "Banner Top Clieck "  Event  처리 =============	
				 $(function() {
					 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
					$( ".banner-top").on("click" , function() {
						
						//alert("Banner Top Clieck ")
						self.location = "/index.jsp";
					});
					
				 });
				
				//============= "검색 Icon"  Event  처리 =============	
				 $(function() {
					 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
					$( "#searchIcon").on("click" , function() {
						
						//alert("searchbutton called")
						fncGetPageList(1);
					});
					
				 });
				
				
				//============= "검색 Enter KeyDown "  Event  처리 =============	
				 $(function() {
					 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
					$( "input[name=searchKeyword]").keydown(function(key) {
						
						if(key.keyCode == 13) { //키가 13이면 실행 ) Enter Key는 13
							fncGetPageList(1);					
						}
					});
					
				 });
				
				
			
				
				//============= "음성 검색 실행 함수 " 처리 =============	
			   function fncWebSpeech() {
		    		// document.addPurchase.submit();
		    		// alert("speech post call...")
		    		$("#webspeech").attr("method","POST").attr("action","/movie/getMovieList?menu=movie").submit();
		    	}
		    	
		    	$(function() {
		    			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		    			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
		    			 $( "#voidSearchOk" ).on("click" , function() {
		    					//Debug..
		    					// <!-- <a href="javascript:history.go(-1)"></a> -->
		    					//console.log("value : "+$("#voidSearchOk" ).val());
		    					fncWebSpeech()
		    			});
		    	});	
				
			
	    	   (function (window, undefined) {
	                "use strict";
	                
	                var document = window.document,
	                    docElement = document.documentElement,
	                    SpeechRecognition = window.webkitSpeechRecognition ||
	                                        window.mozSpeechRecognition ||
	                                        window.msSpeechRecognition ||
	                                        window.oSpeechRecognition ||
	                                        window.SpeechRecognition;
	                function addClass(className) {
	                    docElement.className = docElement.className + ' ' + className;
	                }
	                docElement.className = docElement.className.replace(/(^|\s)no-js(\s|$)/, '$1js$2');
	                if ( SpeechRecognition !== undefined ) {
	                    addClass('feature');
	                } else {
	                    addClass('no-feature');
	                }
	            })(window);
	    	   
	    	   
	    	   var speech_text ="";   
	    	    
	           (function speechFunction(window, undefined) {
	               "use strict";
	               var speechBtn = document.getElementById('speech-btn'),
	                   SpeechRecognition = window.webkitSpeechRecognition ||
	                                       window.mozSpeechRecognition ||
	                                       window.msSpeechRecognition ||
	                                       window.oSpeechRecognition ||
	                                       window.SpeechRecognition,
	                   speechTranscript = document.getElementById('speech-transcript'),
	                   
	                  
	                   sr;
	               if ( SpeechRecognition !== undefined ) {
	                   sr = new SpeechRecognition();
	                   speechBtn.addEventListener('click', function () {
	                       sr.start();
	                   });
	                   sr.onaudiostart = function () {
	                       speechBtn.setAttribute('disabled', 'disabled');
	                       speechBtn.value = "말해주세요!";                             
	                       
	                   };
	                   sr.onspeechstart = function () {
	                       speechBtn.value = "듣고 있습니다....";
	                   };
	                   sr.onspeechend = function () {
	                       speechBtn.value = '...그리고 끝내주세요...';
	                   };
	                   sr.onend = function () {
	                       speechBtn.value = '계속 하려면 여기를 클릭해주세요!';
	                       speechBtn.removeAttribute('disabled');
	                   };
	                   sr.onresult = function (event) {
	                       speechTranscript.value = event.results[0][0].transcript;
	                      
	                       console.log("speechTranscript :: " + speechTranscript.value);
	                       $("#voidSearchOk").val(speechTranscript.value);
	                       // alert("speeach2 : "+$("#voidSearchOk").val()); 
	                       
	                       var voiceSearch = $("#voidSearchOk").val();
	                       $("#voiceSearchKeyword").val(voiceSearch);
	                       //alert("speeach2"  + voiceSearch);                  
	                       
	                   };
	               }
	          })(window);
		    	

				
				// 음성 Pop-up 재 구성 
			    /* $('#voidSearchIcon').click(function (e){
			    	alert("aaaa")
			        e.preventDefault();
			        $('#speechCall').removeClass('close').addClass('open');
			    });
			
			    $('.speech-overlay-close').click(function (e) {
			        e.preventDefault;
			        $('.speech-overlay').removeClass('open').addClass('close');

			        setTimeout(function(){
			            $('.speech-overlay').removeClass('close');}, 500);
			    });
 				*/
			    
					//============= "음성 검색 Icon"  Event  처리 =============	
				  $(function() {
					 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
					$( "#voidSearchIcon").on("click" , function() {
						//alert("modal start...")
						$('.ui.modal')  
						  .modal('show')
						;
						/* self.location = "/movie/getMovieList?menu=voiceRegniiton"; */
					});
					
				 }); 
				
				
					//============= "WishList(찜) Event 처리" DeleteWish Event  처리 =============	
				$(function() {
						 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						 
						  $(document).on("click", ".fa-heart-o", function () {

								
								//var movieNo = $(this).next().val();		
								//var movieNo = $($(this).find('glyphicon glyphicon-heart-empty')).val();					 
				
								var movieNo = $(this).find('#scMovieNo').val();		
								var userId = $(this).find('#userId').val();			
								
								
								if(userId == null || userId == ''){
									alert("로그인 후 이용 가능합니다.");
									$('.overlay').removeClass('close').addClass('open');
									//exit();
								} else {
								
								
								// alert("movieNo: " + movieNo); 					
								// alert("userId: " + userId); 
								
							 	    $(this).removeClass('fa fa-heart-o').addClass('fa fa-heart');
													
									$.ajax( 
											{
												url : "/movie/json/switchWishList?movie.movieNo="+movieNo+"&user.userId="+userId+"&wishFlag=movie",									
												type : "GET" ,							
											}).done(function(data) {
										//정상 통신인 경우
										if (data == 'add') {
											var msg = '찜하기 신청';
											alert(msg);
										} else {
											alert("찜하기 취소");
										}
									})
								}
							})
						//})
						 
						 $(document).on("click", ".fa-heart", function () {
								
								
							 //var movieNo = $(this).next().val();		
							 //var movieNo = $($(this).find('glyphicon glyphicon-heart-empty')).val();					 
			
							var movieNo = $(this).find('#scMovieNo').val();		
							var userId = $(this).find('#userId').val();			
							
							// alert("movieNo: " + movieNo); 					
							// alert("userId: " + userId); 
							
							if(userId == null || userId == ''){
								alert("로그인 후 이용 가능합니다.");							
								$('.overlay').removeClass('close').addClass('open');
								exit();
							} else { 

								$(this).removeClass('fa fa-heart').addClass('fa fa-heart-o');
										
								$.ajax( 
										{
											url : "/movie/json/switchWishList?movie.movieNo="+movieNo+"&user.userId="+userId+"&wishFlag=movie",									
											type : "GET" ,							
										}).done(function(data) {
									//정상 통신인 경우
									if (data == 'add') {
										var msg = '찜하기 신청';
										alert(msg);
									} else {
										alert("찜하기 취소");
									}
								})
							}
						})
					});
				//});
				
				
			//============= "예약  Event 처리"  Event  처리 =============	
				$(function() {
					 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
					$("span:contains('예매')" ).on("click" , function() {
						 self.location = "/booking/getScreenMovieList";	
					});	
				});
					
				$(".pagination__next").on("click", function() {
		        	
		        	//alert("next")
		        	
		            searchKeyword = $("input[name='searchKeyword']").val();

		            var currentPage = $("#currentPage").val()
		            
		            //alert("currentPage :: " + currentPage)          
		  
		            currentPage =  parseInt(currentPage) + 1;
		       
		          
		            fncGetPageList(currentPage);
		        });

		        $(".pagination__prev").on("click", function() {
		            var currentPage = $("#currentPage").val()
		      
		            //alert("prev")
		            currentPage = parseInt(currentPage) - 1
		            
		            fncGetPageList(currentPage);

		          
		        });
			    
		        function changeCSS() {
		            if ($(document).innerWidth() < 768) {

		                $(".cinema-item").css("width", "fit-content");
		            } else {

		                $(".cinema-item").css("width", "auto");
		            }

		            if ($(document).innerWidth() >= 768 && $(document).innerWidth() < 990) {
		       
		                $(".cinema-item").css("height", "500px");
		            } else {
		         
		                $(".cinema-item").css("height", "auto");
		            }

		        }
		        

	            $(document).ready(function() {
	                init_CinemaList();
	                
	                //alert($('html').height() )
	                //alert(window.outerHeight)
	                $('.boxshadow').css("box-shadow", "0 0 0px rgba(0, 0, 0, 0)")
	                
	            	/*    if($('html').height() < window.outerHeight){
	                	$('html').css('height', '100%');
	                } */
	                
	                $("#movie-search-sort").css("width", "200px");        
	                changeCSS()
	                $(window).resize(function() {
	                    changeCSS();
	                })
	                
	            });
	            
		</script>
		
		<!--  ///////////////////////// CSS ////////////////////////// -->
<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);


	.page-heading {
		font-family: 'Jeju Gothic', sans-serif;
		margin-top: 100px
	}
	
	body {
		font-family: 'Noto Sans KR', sans-serif;
	}


	
	 #body {
           padding-top: 70px;
           }
           .thumbnail {
           width: 300px;
           height: 250px;
           overflow: auto;
     }	
     
     .cinema .cinema__images:before {
	    content: '';
	    width: 100%;
	    height: 100%;
	    background-color: rgba(76, 65, 69, 0);
	    position: absolute;
	    top: 0;
	    left: 0;
	    opacity: 1;
	    -webkit-transition: 0.5s;
	    -o-transition: 0.5s;
	    transition: 0.5s;
	   }
     
     
     #searchIcon
      {     color: #fff;       		
   			text-shadow: 1px 1px 1px #ccc;
   			font-size: 1.5em;
      }
      
    #voidSearchIcon
      {     color: #fff;       		
   			text-shadow: 1px 1px 1px #ccc;
   			font-size: 1.5em;
      }
     

	.countPage {
 		 	font-size: 13px;
   		 	margin-top: 10px;
	}

	.search{
		 	margin-right : 30px;
	}


	.movieNm {
		  font-size: 16px;
		  font-weight: bold;
		  display: block;
		  margin-bottom: 5px;
		  margin-top: 5px;

	}
	
	#poster{
		height : calc(50vh - 100px);	
		width : auto;	
		height:260px; 
		margin-left: auto;
		margin-right: auto; 
		display: table;

	}
	
	.countPage {
	font-size: 13px;
	margin-top: 10px;
	}
	
	
	.page-heading {
		margin-top: 100px
	}
	
	
	.search {
		margin-right: 30px;
	}
	
	.page-heading {
		margin-top: 100px
	}
	
	option {
		width: 140px;
		top: 37px !important;
		border: none;
		padding: 14px 7px;
		z-index: 23;
		background-color: #4c4145;
		-webkit-box-shadow: 0 0 10px rgba(0, 0, 0, 0.16);
		-moz-box-shadow: 0 0 10px rgba(0, 0, 0, 0.16);
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.16);
	}
	
	
	input, select {
		height: 30px;
		width: auto;
		border: none;
		box-shadow: none;
		border: 1px solid #dbdee1;
		-webkit-border-radius: 3px;
		-moz-border-radius: 3px;
		border-radius: 3px;
		font-size: 13px;
		color: #b4b1b2;
	}

	select {
		font-family: 'Jeju Gothic', sans-serif;
	}
		
	
	.search .search__field {
	  display: inline-block;
	  width: 100%;
	  padding: 9px 200px 9px 19px;
	  margin-top: 14px;
	  line-height: 18px;
	  -webkit-border-radius: 3px;
	  -moz-border-radius: 3px;
	  border-radius: 3px;
	  border: solid 1px #dbdee1;
	  background-color: #fff;
	  color: #4c4145;
	  font-size: 13px;
 
	}
	
	
	.cinema-item {
		border: dashed 1px #969b9f;
		margin: 5px;
		padding-top: 15px;
		padding-left: 5px;
		padding-right: 5px;
		border-radius: 5px;
		/* 	border-radius: 10px; */
	}
		

	p {
		font-size: 13px;
		font-weight: lighter;
	}
	
	p strong {
		font-weight: nomal;
	}
	
	.search .sbHolder .sbOptions {
	  width: 400px;
	  top: 37px !important;
	  border: none;
	  padding: 14px 7px;
	  z-index: 23;
	  background-color: #4c4145;
	  -webkit-box-shadow: 0 0 10px rgba(0, 0, 0, 0.16);
	  -moz-box-shadow: 0 0 10px rgba(0, 0, 0, 0.16);
	  box-shadow: 0 0 10px rgba(0, 0, 0, 0.16);
	}
	
	
	.page-heading {
		font-family: 'Jeju Gothic', sans-serif;
		margin-top: 100px
	}
	
	
	/* Overlay style */
	.speech-overlay {
	  position: fixed;
	  width: 100%;
	  height: 100%;
	  top: 0;
	  left: 0;
	  background: rgba(0,255,0,0.3);
	  /* background: rgba(76, 65, 69, 0.6); */
	  z-index: 300;
	}
	/* Overlay closing cross */
	.speech-overlay .speech-overlay-close {
	  width: 60px;
	  height: 60px;
	  position: absolute;
	  right: 15px;
	  top: 0px;
	  overflow: hidden;
	  border: none;
	  background-color: transparent;
	  color: transparent;
	  outline: none;
	  z-index: 310;
	}
	.speech-overlay .speech-close:before {
	  content: "\f00d";
	  font-size: 13px;
	  font-family: "FontAwesome";
	  color: #4c4145;
	  position: absolute;
	  top: 4px;
	  left: 0;
	  width: 100%;
	  text-align: center;
	}
	.speech-overlay-hugeinc {
	  opacity: 0;
	  visibility: hidden;
	  -webkit-transition: opacity 0.5s, visibility 0s 0.5s;
	  transition: opacity 0.5s, visibility 0s 0.5s;
	}
	.speech-overlay-hugeinc.open {
	  opacity: 1;
	  visibility: visible;
	  -webkit-transition: opacity 0.5s;
	  transition: opacity 0.5s;
	}
	.speech-overlay-hugeinc .speech {
	  -webkit-perspective: 1200px;
	  perspective: 1200px;
	  opacity: 0.4;
	  -webkit-transform: translateY(-25%) rotateX(35deg);
	  transform: translateY(-25%) rotateX(35deg);
	  -webkit-transition: -webkit-transform 0.5s, opacity 0.5s;
	  transition: transform 0.5s, opacity 0.5s;
	}
	.speech-overlay-hugeinc.open .speech {
	  opacity: 1;
	  -webkit-transform: rotateX(0deg);
	  transform: rotateX(10deg);
	}
	.speech-overlay-hugeinc.close .speech {
	  -webkit-transform: translateY(25%) rotateX(-35deg);
	  transform: translateY(25%) rotateX(-35deg);
	}	
	
	.speech .success {
	  background-color: #ffd564;
	  font: 18px 'aleobold', sans-serif;
	  text-transform: uppercase;
	  color: #4c4145;
	  text-align: center;
	  padding-bottom: 28px;
	  padding-top: 39px;
	  margin-top: 50px;
	  margin-bottom: 58px;
	}

	.speech {
  	 background-color: #ffffff;
  	 padding-top: 58px;
     padding-bottom: 22px;
	}
	.speech .speech__title {
	  font-size: 22px;
	  font-family: 'aleobold', sans-serif;
	  line-height: 20px;
	  color: #4c4145;
	  text-transform: uppercase;
	  text-align: center;
	  margin: 0;
	  margin-bottom: 28px;
	}
	.speech .speech__title .speech-edition {
	  font-size: 16px;
	  font-weight: normal;
	  font-family: 'aleoitalic', sans-serif;
	  text-transform: none;
	}
	.speech .speech__tracker {
	  text-align: center;
	  font: 16px 'aleoitalic', sans-serif;
	  color: #4c4145;
	  margin: 33px 0 35px;
	}
	.speech .form__tracker {
	  font-size: 13px;
	  display: block;
	  margin-top: 39px;
	}
	.speech .form__tracker:hover {
	  color: #fe505a;
	}
	.speech .speech__input {
	  font-size: 13px;
	  color: #b4b1b2;
	  width: 100%;
	  -webkit-box-shadow: none;
	  box-shadow: none;
	  -webkit-appearance: none;
	  border: 1px solid #dbdee1;
	  -webkit-border-radius: 3px;
	  -moz-border-radius: 3px;
	  border-radius: 3px;
	  margin: 5px 0;
	  padding: 9px 20px 8px;
	}
	.speech .speech__check-info {
	  font-family: 'Roboto', sans-serif;
	  font-size: 13px;
	  color: #b4b1b2;
	  display: block;
	  margin-top: 3px;
	  margin-bottom: 27px;
	}
	.speech .speech__control {
	  text-align: center;
	}
	
   .no-js .content,
   .feature .no,
   .no-feature .yes,
   .no-feature .example {
   
    display: none;
    }
   
   
    html{
     height: auto;
    }
      
</style>	

 <!-- Semantic  UI Applied -->
 <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.13/semantic.js"></script>


</html>
