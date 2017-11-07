package com.amc.web.sns;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.amc.service.SNSLogin.InstaService;
import com.amc.service.SNSLogin.KakaoService;
import com.amc.service.SNSLogin.NaverService;
import com.amc.service.domain.User;
import com.amc.service.user.UserService;

@RestController
@RequestMapping("/sns/*")
public class SNSRestController {
	
	@Autowired
	@Qualifier("kakaoServiceImpl")
	private KakaoService kakaoService;
	
	@Autowired
	@Qualifier("naverServiceImpl")
	private NaverService naverService;
	
	@Autowired
	@Qualifier("instaServiceImpl")
	private InstaService instaService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	//TODO : 카카오 로그인 API 시작///////////////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/kakaoGetCode", method=RequestMethod.GET)
	public String kakaoGetCode() throws Exception{
	
		System.out.println("kakao.getCode() : "+kakaoService.getCode());
		
		return "redirect:"+kakaoService.getCode();
	}
	
	@RequestMapping(value="/kakaologin", method=RequestMethod.GET)
	public String kakaoLogin(@RequestParam("code") String code) throws Exception{
	
		System.out.println("code : "+code);
		
		kakaoService.getAccessToken(code);
		//사용자 토큰 받기 메서드 불러오기 성공
		
		String data = (String)kakaoService.getHtml((kakaoService.getAccessToken(code)));
		System.out.println("data :"+data);
		
		Map<String, String> map = kakaoService.JsonStringMap(data);
		System.out.println("map : "+map);
		System.out.println("access_token :"+map.get("access_token"));
		System.out.println("refresh_token :"+map.get("refresh_token"));
		System.out.println("scope :"+map.get("scope"));
		System.out.println("token_type :"+map.get("token_type"));
		System.out.println("expires_in :"+map.get("expires_in"));
		
		//사용자 전체 정보받아오기를 시작합니다.
		String list = kakaoService.getAllList((String)map.get("access_token"));
		System.out.println("list :"+list);
		//JSON데이터 변환!
		/*Map<String, String> getAllListMap = userService.JsonStringMap(list);*/
		
		System.out.println(list.substring(4,20));
		
		/*		System.out.println("getAllListMap :"+getAllListMap);
		System.out.println("id :"+(String)getAllListMap.get("kaccount_email"));
		System.out.println("nickName :"+(String)getAllListMap.get("nickName"));
		System.out.println("profileImageURL :"+(String)getAllListMap.get("profileImageURL"));
		System.out.println("thumbnailURL :"+(String)getAllListMap.get("thumbnailURL"));
		System.out.println("countryISO"+(String)getAllListMap.get("countryISO"));
		*/		
		
		return "forward:/user/jason/loginUser";
		/*return "redirect:/user/addUser";*/ //UserController 부분에 있던 값
	}
	
	@RequestMapping( value="kakaoLogin", method=RequestMethod.POST )
	public User kakaoJsLogin(	@RequestBody User user,	HttpSession session ) throws Exception{
		System.out.println("/user/json/kakaoLogin : POST");
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if(dbUser==null){
		System.out.println("널 값이다");
		}else{
		session.setAttribute("user", dbUser);
		}
		System.out.println("dbUser : " + dbUser);
		return dbUser;
	}
	
	//TODO : 네이버 로그인 API 시작///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//http://127.0.0.1:8080/start
	@RequestMapping(value="start", method=RequestMethod.GET)
	public String naverStart() throws Exception{
		System.out.println("naver start");		
		return "redirect:"+naverService.getCode();
	}

	//TODO : CALL BACK URL
	//	//http://127.0.0.1:8080/NaverLogin
	@RequestMapping(value="NaverLogin", method=RequestMethod.GET)
	public String naverLogin(@RequestParam("code")String code, @RequestParam("state")String state) throws Exception{
		System.out.println("code : " + code);
		System.out.println("state : " + state);
		
/*		Map<String, String> mapResult = naverService.JSONStringToMap(naverService.getAccessToken(code, state));

		System.out.println("access_token :"+(String)mapResult.get("access_token"));
		System.out.println("refresh_token :"+(String)mapResult.get("refresh_token"));
		System.out.println("token_type :"+(String)mapResult.get("token_type"));
		System.out.println("expires_in :"+(String)mapResult.get("expires_in"));
		
		//사용자 전체 정보받아오기를 시작합니다.
		String list = naverService.getAllList((String)mapResult.get("token_type"), (String)mapResult.get("access_token"));
		System.out.println("list :"+list);
*/		return null;
		
		
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		
/*		String data = (String)naverService.getAllList((String)mapResult.get("token_type"), (String)mapResult.get("access_token"));
		System.out.println("data :"+data);
*/		
		
		

/*		String result = (String)naverService.getxml((String)mapResult.get("token_type"), (String)mapResult.get("access_token"));
		System.out.println("result => " + result);
*/		
/*		JSONObject jsonObject = XML.toJSONObject(result);
		System.out.println("jsonObject :"+jsonObject);
*/		
/*		JSONObject reponseData = jsonObject.getJSONObject("data");*/
		/*System.out.println("responseData :"+reponseData);
		Map<String, String> userMap = naverService.JSONStringToMap(reponseData.get("response").toString());
		System.out.println("birthday :"+(String)userMap.get("birthday"));
		System.out.println("profile_image :"+(String)userMap.get("profile_image"));
		System.out.println("gender :"+(String)userMap.get("gender"));
		System.out.println("enc_id :"+(String)userMap.get("enc_id"));
		System.out.println("nickname :"+(String)userMap.get("nickname"));
		System.out.println("name :"+(String)userMap.get("name"));
		System.out.println("id :"+(String)userMap.get("id"));
		System.out.println("email :"+(String)userMap.get("email"));
		System.out.println("age :"+(String)userMap.get("age"));
		*/
	}	

	//TODO : 인스타그램 로그인 API 시작///////////////////////////////////////////////////////////////////////////////////////////////////////////		
	@RequestMapping(value="/AMC")
	public String getCode() throws Exception{
		System.out.println("UserRestController의 getCode 메소드");
		return "redirect:"+instaService.getCode();
	}
	
	@RequestMapping(value="/getLogin")
	public String start(@RequestParam("code")String code) throws Exception{
		System.out.println("###################################################");
		System.out.println("code : "+code);
		
		return null;
	}

}
