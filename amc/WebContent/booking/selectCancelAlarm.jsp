<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.springframework.util.StringUtils" %>
<!doctype html>
<html>
<head>
   <!-- Basic Page Needs -->
        <meta charset="utf-8">
        <title>Americode Cinema-booking2</title>
        <meta name="description" content="A Template by Gozha.net">
        <meta name="keywords" content="HTML, CSS, JavaScript">
        <meta name="author" content="Gozha.net">
    
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  		<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
		<!--  ///////////////////////// Sweetalert CDN ////////////////////////// -->
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    	<link href="http://fonts.googleapis.com/earlyaccess/hanna.css" rel="stylesheet">
  
      
      <!-- hanna font -->
      <link href="http://fonts.googleapis.com/earlyaccess/hanna.css" rel="stylesheet">
  
  <script type="text/javascript">

  function listener(event){      
      document.getElementById('child').contentWindow.postMessage(event.data,"*");
      $("input[name='seats']").val(event.data);
      
        $.ajax({
               url : "/booking/json/getDisplaySeatNo/"+event.data+"/500",                  
               method : "GET" ,
               dataType : "json" ,
               headers : {
                  "Accept" : "application/json",
                  "Content-Type" : "application/json"
               },                  
               success : function(JSONData, status) {
                  console.log('SeatNo 받아옴 : '+JSONData.seatNo);
                       if(JSONData != ""){
                          $("#seatNo").html(JSONData.seatNo);
                       }//end of if문
               }
      });//end of ajax
           
   }



      
      if (window.addEventListener){
           addEventListener("message", listener, false);
      } else {
           attachEvent("onmessage", listener)
      }

         
      function confirmSeat(){
         
         var clientId = $("input[name='clientId']").val();
         
           $.ajax(
                  {
                     url : "/booking/json/confirmSeat/"+clientId,            
                     method : "GET" ,
                     async : false,
                     dataType : "json" ,
                     headers : {
                        "Accept" : "application/json",
                        "Content-Type" : "application/json"
                     },
                     
                     success : function(JSONData, status) {
                        console.log('SeatNo 받아옴 : '+JSONData.seatNo);                        
                            if(JSONData != ""){
                               console.log('ajax로 좌석 rollback resCode: '+jsonData);
                            }//end of if문
                     }
            });//end of ajax
         
      }   
         
      function addCancelAlarm(){
         var userId = $("input[name='userId']").val(); 
         var alarmSeatNo = $("input[name='seats']").val(); 
         var screenContentNo = $("input[name='screenContentNo']").val();
         
         if( userId == null || userId == ''){
            swal({
                 title: '신청 실패',
                 html: $('<div>')
                   .addClass('some-class')
                   .text('로그인 상태가 아닙니다'),
                 animation: false,
                 customClass: 'animated swing'
               })
            return;
         }

         $.ajax({
                   url: "/alarm/json/addCancelAlarm?"+
                		 "user.userId="+userId+
                		 "&alarmSeatNo="+alarmSeatNo+
                		 "&alarmFlag=C"+
                		 "&screenContent.screenContentNo="+screenContentNo,
                   type: 'POST',
                }).done(function(result) {
                   console.log("result : " + result);
                   if ( result == 'success' ) {
                      var msg = '취소표 알림 신청 성공';
                      swal({
                           //position: 'top-right',
                           type: 'success',
                           title: '취소표 알림 신청 성공!',
                           showConfirmButton: true,
                           timer: 2000
                         })
                   } else if( result == 'exceed'){
                      swal(
                              '취소표알림 자리 수 초과!',
                              '신청 가능한 취소표알림 수 초과 (1인당 최대4 좌석)',
                              'error'
                            )
                   } else {
                      swal(
                              '중복 좌석 신청!',
                              '신청한 좌석 중 기존에 중복된 좌석이 있습니다.'+"\n"+result,
                              'error'
                            )
                   }
                });
      }    
        
     function addBooking(){
         
        $("form").attr("method" , "POST").attr("action" , "/booking/addBooking").submit();   
        
     }


   function selectCancelAlarm(){
      $("form").attr("method" , "POST").attr("action" , "/alarm/selectCancelAlarm").submit();
   }


   </script> 
</head>

<body>
    <div class="wrapper place-wrapper">
        <!-- Banner -->
        <div class="banner-top">
            <img alt='top banner' src="/images/banners/space.jpg">
        </div>

        <!-- Header section -->
        <header class="header-wrapper header-wrapper--home">
         <!-- ToolBar Start /////////////////////////////////////-->
         <jsp:include page="/layout/topToolbar.jsp" />
         <!-- ToolBar End /////////////////////////////////////-->
        </header>
        
        <!-- Main content -->
        <div class="place-form-area">
        <section class="container">
            <div class="order-container">
            	<div class="row">
            		<p/>
            		<p/>
            		<p/>
            	</div>
                <div class="order" style="padding-top:10px">
                    <img class="order__images" alt='' src="../images/cinema/Cancel.jpg">
                    <p class="order__title">Cancel Alarm <br><span class="order__descript">request Cancelalarm</span></p>
                    <div class="order__control">
                        <a href="#" class="order__control-btn active">Alarm</a>
                    </div>
                </div>
            </div>
                <div class="order-step-area">
                    <div class="order-step first--step">Select CancelAlarm Seats</div>
                </div>
            
            <div class="choose-sits">
                <div class="choose-sits__info choose-sits__info--first">
                    <ul>
                       <li class="sits-price marker--none"><strong>취소표 알림은 1인 최대 4좌석 까지 신청 가능합니다</strong></li>
                       <li class="sits-price marker--none"><strong></strong></li>
                    </ul>
                </div>

                <div class="choose-sits__info">
                    <ul>
                        <li class="sits-state sits-state--not">Not available</li>
                        <li class="sits-state sits-state--your">Yourd choice</li>
                    </ul>
                </div>
          </div>
          <!--  only UI -->
   
         <div class="col-sm-8 com-md-9">   
            <iframe id="child" src="http://183.98.215.171:52273/cancelAlarm?screenNo=${screenContent.screenContentNo}" 

            style='width:100%; height:400px'  frameborder='0' align='center'>       
                    <p>Your browser does not support iframes.</p>
            </iframe>
            <!-- style='width:100%' -->
         </div>
         <div class="col-sm-4 col-md-3">
            <div class="row"><p/></div>
            <div class="row"><p/></div>
            <div class="row"><p/></div>
            <div class="category category--popular marginb-sm">
                      <h3 class="category__title">Selected<br><span class="title-edition">CancelAlarm Info</span></h3>
                      <ul>
						<li><span class="category__item hanna">Seats: <span id="seatNo"></span></span></li>
                      </ul>
            </div>
            <button class="ui brown button" style="width:100%; height:50%;" onClick="javascript:addCancelAlarm()"><font size="4px">취소표 알리미</font><p/><font size="4px" color="white">신&nbsp;청</font></button>
         </div>
        </section>  
       
         <input type="hidden" name="clientId" value=""/>
         <form id="addBooking">
         <input type="hidden" name="userId" value="${sessionScope.user.userId}"/>
         <input type="hidden" name="screenContentNo" value="${screenContent.screenContentNo}"/>
         <input type="hidden" name="bookingSeatNo" value=""/>         
         <input type="hidden" name="headCount" value=""/>
         <input type="hidden" name="totalTicketPrice" value=""/>
         <!-- <input type="hidden" name="impId" value=""/> -->
         <!-- <input type="hidden" name="qrUrl" value=""/> -->   
         <input type="hidden" name="impId" value="temp_imp_uid"/>
         <input type="hidden" name="qrUrl" value="temp_qrUrl"/>
         <input type="hidden" name="displaySeat" value="temp_displaySeat"/>
         <input type="hidden" name="seats" value=""/>
      </form>
                
       </div>
       
        <jsp:include page="/layout/bottomToolbar.jsp" />
		<jsp:include page="/layout/loginModal.jsp" />       
     </div>
  


   <!-- JavaScript-->
		<script src="/js/external/modernizr.custom.js"></script>
	
		<script src="/js/external/jquery-migrate-1.2.1.min.js"></script>

        <!-- jQuery UI -->
        <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
        <!-- Bootstrap 3--> 
        <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script>

        <!-- Mobile menu -->
        <script src="/js/jquery.mobile.menu.js"></script>
         <!-- Select -->
        <script src="/js/external/jquery.selectbox-0.2.min.js"></script>

        <!-- Custom -->
        <script src="/js/custom.js"></script>
      
      <script type="text/javascript">
            $(document).ready(function() {
                init_BookingOne();
            });
    		
      </script>
      
      <!-- Custom -->
      <script src="/js/custom.js"></script>
</body>
 <style>
      html{
         height: auto;
      }
      
      .hanna{ 
	  font-family: 'Hanna', sans-serif; 
	  font-size: 120%;
	   line-height:4.3em
	 }
	 button.btn--pay{
        margin-bottom:10px;
        margin-right:10px;
        background-color: #90bf34;
        border: solid 1px #90bf34;
        color: #ffffff;
		padding: 10px 30px;
		-webkit-border-radius: 3px;
		-moz-border-radius: 3px;
		border-radius: 3px;
		-webkit-box-shadow: 0 0 10px rgba(0, 0, 0, 0.16), inset 0 2px rgba(255, 255, 255, 0.2);
		-moz-box-shadow: 0 0 10px rgba(0, 0, 0, 0.16), inset 0 2px rgba(255, 255, 255, 0.2);
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.16), inset 0 2px rgba(255, 255, 255, 0.2);
		font: 18px 'Hanna';
		text-transform: uppercase;
		-webkit-transition: 0.3s;
		-o-transition: 0.3s;
		transition: 0.3s;       
    }
    .def{
    	font-family: 'Jeju Gothic', sans-serif;
    }
 </style>
</html>