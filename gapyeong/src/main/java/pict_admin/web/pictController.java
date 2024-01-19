package pict_admin.web;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.mail.PasswordAuthentication;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.ImageIcon;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FilenameUtils;
import org.json.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.apache.commons.io.FilenameUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import pict_admin.service.AdminService;
import pict_admin.service.AdminVO;
import pict_admin.service.PictService;
import pict_admin.service.PictVO;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.HashMap;

@Controller
public class pictController {
	PasswordAuthentication pa;
	
	@Resource(name = "pictService")
	private PictService pictService;
	
	@Resource(name = "adminService")
	private AdminService adminService;
	

	@RequestMapping(value = "/pict_main.do")
	public String pict_main(@ModelAttribute("searchVO") AdminVO adminVO, HttpServletRequest request, ModelMap model, HttpSession session, RedirectAttributes rttr) throws Exception {
		String sessions = (String)request.getSession().getAttribute("id");
		System.out.println(sessions);
		if(sessions == null || sessions == "null") {
			return "redirect:/pict_login.do";
		}
		else {
			String user_id = (String)request.getSession().getAttribute("id");
			if(request.getSession().getAttribute("id") != null) {
				adminVO.setAdminId((String)request.getSession().getAttribute("id"));
				adminVO = adminService.get_user_info(adminVO);
				model.addAttribute("adminVO", adminVO);
			}
		
			return "redirect:/test.do";
		
		}
	}
	
	@RequestMapping(value = "/pict_login.do")
	public String login_main(@ModelAttribute("searchVO") AdminVO adminVO, HttpServletRequest request, ModelMap model, HttpServletResponse response) throws Exception {
		/*
		String userAgent = request.getHeader("user-agent");
		
		boolean mobile1 = userAgent.matches( ".*(iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson).*");
		boolean mobile2 = userAgent.matches(".*(LG|SAMSUNG|Samsung).*"); 
		if (mobile1 || mobile2) {
		    //여기 모바일일 경우
			System.out.println("피씨");
			model.addAttribute("message", "PC에서만 사용이 가능합니다.");
			model.addAttribute("retType", ":exit");
			return "pict/main/message";
		}
		*/
		String sessions = (String)request.getSession().getAttribute("id");
		if(sessions == null || sessions == "null") {
			return "pict/main/login";
		}
		else {
			//나중에 여기 계정별로 리다이렉트 분기처리
			return "redirect:/test.do";
			
		}
		
	}
	
	@RequestMapping(value = "/login.do")
	public String login(@ModelAttribute("adminVO") AdminVO adminVO, HttpServletRequest request,  ModelMap model) throws Exception {
		//처음 드러와서 세션에 정보있으면 메인으로 보내줘야함
		String inpuId = adminVO.getAdminId();
		String inputPw = adminVO.getAdminPw();
		
		adminVO = adminService.get_user_info(adminVO);

		if (adminVO != null && adminVO.getId() != null && !adminVO.getId().equals("")) {
			String user_id = adminVO.getId();
			String enpassword = encryptPassword(inputPw, inpuId);	//입력비밀번호
			
			if(enpassword.equals(adminVO.getPassword())) {
				request.getSession().setAttribute("id", adminVO.getId());
				request.getSession().setAttribute("name", adminVO.getName());
				request.getSession().setAttribute("depart", adminVO.getDepart());

				String ip = request.getRemoteAddr();
			    DateFormat format2 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			    String now = format2.format(Calendar.getInstance().getTime());
			    
			    adminVO.setLast_login_ip(ip);
			    adminVO.setLast_login_date(now);
			    adminService.insert_login_info(adminVO);
			    
			    adminVO.setAdminId(user_id);
			    adminVO = adminService.get_user_info(adminVO);
			    
				return "redirect:/pict_main.do";
				
			}
			else {
				model.addAttribute("message", "입력하신 정보가 일치하지 않습니다.");
				model.addAttribute("retType", ":location");
				model.addAttribute("retUrl", "/pict_login.do");
				return "pict/main/message";
			}
		}
		else {
			model.addAttribute("message", "입력하신 정보가 일치하지 않습니다.");
			model.addAttribute("retType", ":location");
			model.addAttribute("retUrl", "/pict_login.do");
			return "pict/main/message";
		}
	}
	@RequestMapping(value = "/user_list.do")
	public String user_list(@ModelAttribute("adminVO") AdminVO adminVO, ModelMap model, HttpServletRequest request) throws Exception {
		String session = (String)request.getSession().getAttribute("id");
		if(session == null || session == "null") {
			return "redirect:/pict_login.do";
		}
		
		model.addAttribute("search_text",adminVO.getSearch_text());
		
		
		List<?> userList = adminService.user_list(adminVO);
		model.addAttribute("resultList", userList);
		return "pict/main/user_list";
	}
	@RequestMapping(value = "/user_register.do")
	public String user_register(@ModelAttribute("adminVO") AdminVO adminVO, ModelMap model, HttpServletRequest request) throws Exception {
		String session = (String)request.getSession().getAttribute("id");
		if(session == null || session == "null") {
			return "redirect:/pict_login.do";
		}
		
		if(adminVO.getId() != null && !adminVO.equals("")) {
			//수정
			adminVO = adminService.user_select_one(adminVO);
			adminVO.setSaveType("update");
			
		}
		else {
			adminVO.setSaveType("insert");
		}
		
		model.addAttribute("adminVO", adminVO);
		return "pict/main/user_register";
	}
	@RequestMapping(value = "/user_reset.do")
	public String user_reset(@ModelAttribute("adminVO") AdminVO adminVO, ModelMap model, HttpServletRequest request) throws Exception {
		String session = (String)request.getSession().getAttribute("id");
		if(session == null || session == "null") {
			return "redirect:/pict_login.do";
		}
		
		String enpassword = encryptPassword(adminVO.getId()+"1!", adminVO.getId());	//입력비밀번호
		adminVO.setPassword(enpassword);
		adminService.user_reset(adminVO);
		
		model.addAttribute("message", "비밀번호가 초기화 되었습니다.");
		model.addAttribute("retType", ":location");
		model.addAttribute("retUrl", "/user_list.do");
		return "pict/main/message";
	}
	@RequestMapping(value = "/user_delete.do")
	public String user_delete(@ModelAttribute("adminVO") AdminVO adminVO, ModelMap model, HttpServletRequest request) throws Exception {
		String session = (String)request.getSession().getAttribute("id");
		if(session == null || session == "null") {
			return "redirect:/pict_login.do";
		}
		System.out.println(adminVO.getId());
		adminService.user_delete(adminVO);
		
		model.addAttribute("message", "삭제되었습니다.");
		model.addAttribute("retType", ":location");
		model.addAttribute("retUrl", "/user_list.do");
		return "pict/main/message";
	}
	@RequestMapping(value = "/user_save.do")
	public String user_save(@ModelAttribute("searchVO") PictVO pictVO, @ModelAttribute("adminVO") AdminVO adminVO,ModelMap model, HttpServletRequest request) throws Exception {
		String session = (String)request.getSession().getAttribute("id");
		if(session == null || session == "null") {
			return "redirect:/pict_login.do";
		}
		System.out.println("::::::::::::::"+adminVO.getPassword());
		String enpassword = encryptPassword(adminVO.getPassword(), adminVO.getId());	//입력비밀번호
		
		adminVO.setPassword(enpassword);
		String user_id = adminVO.getId();
		
		
		//중복 계정조회
		AdminVO vo = adminVO;
		vo.setAdminId(user_id);
		vo = adminService.get_user_info(vo);
		
		if(adminVO.getSaveType() != null && adminVO.getSaveType().equals("update")) {
			System.out.println("업데이트::::::::::::::::::::::");
			System.out.println(adminVO.toString());
			adminService.update_user(adminVO);	//user 정보 인설트
			model.addAttribute("message", "정상적으로 수정되었습니다.");
			model.addAttribute("retType", ":location");
			model.addAttribute("retUrl", "/user_list.do");
			return "pict/main/message";
		}
		
		else {
	        if(vo != null) {
	        	model.addAttribute("message", "동일한 아이디가 존재합니다.");
				model.addAttribute("retType", ":location");
				model.addAttribute("retUrl", "/user_register.do");
				return "pict/main/message";
	        }
	        System.out.println("인설트::::::::::::::::::::::");
	 
	        adminService.insert_user(adminVO);	//user 정보 인설트
            model.addAttribute("message", "계정발급이 완료되었습니다.");
    		model.addAttribute("retType", ":location");
    		model.addAttribute("retUrl", "/user_list.do");
    		return "pict/main/message";
		}
	}
	@RequestMapping(value = "/logout.do")
	public String logout(@ModelAttribute("searchVO") PictVO pictVO, HttpServletRequest request,  ModelMap model) throws Exception {
		request.getSession().setAttribute("id", null);
		request.getSession().setAttribute("name", null);
		
		return "redirect:/pict_login.do";
		
	}
	
	@RequestMapping(value = "/main.do")
	public String main(@ModelAttribute("searchVO") PictVO pictVO, HttpServletRequest request, ModelMap model, HttpSession session, RedirectAttributes rttr) throws Exception {
		//List<?> board_list = pictService.board_list_latest(pictVO);
		//model.addAttribute("resultList", board_list);
		
		return "pict/main/main";
	}
	@RequestMapping(value = "/main_poster.do")
	public String main_poster(@ModelAttribute("searchVO") PictVO pictVO, HttpServletRequest request, ModelMap model, HttpSession session, RedirectAttributes rttr) throws Exception {
		//List<?> board_list = pictService.board_list_latest(pictVO);
		//model.addAttribute("resultList", board_list);
		
		return "pict/main/main_poster";
	}
	
	//인증센터
	@RequestMapping(value = "/center_main.do")
	public String center_main(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String update = "2023-08-02 14:00:00";
		String now = formatter.format(date);
		Date update_date = formatter.parse(update);
		Date now_date = formatter.parse(now);
		
		String session = (String)request.getSession().getAttribute("name");
		
		if(now_date.after(update_date)) {
			if(session == null || session == "null") {
				return "redirect:/center_login.do";
			}
			else {
				return "redirect:/center_caution.do";
			}
		}
		else {
			return "redirect:/center_noti.do";
		} 
		
	}
	//로그인
	@RequestMapping(value = "/center_login.do")
	public String center_login(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String update = "2023-08-02 14:00:00";
		String now = formatter.format(date);
		Date update_date = formatter.parse(update);
		Date now_date = formatter.parse(now);
		
		String session = (String)request.getSession().getAttribute("name");
		if(now_date.after(update_date)) {
			if(session == null || session == "null") {
				return "pict/center/center_login";
			}
			else {
				return "redirect:/center_caution.do";
			}
		}
		else {
			return "redirect:/center_noti.do";
		}
	}
	//주소지
	@RequestMapping(value = "/center_address.do")
	public String login_address(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {

		model.addAttribute("pictVO", pictVO);
		return "/pict/center/center_login2";
	
	}
	//안내사항
	@RequestMapping(value = "/center_caution.do")
	public String center_caution(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String update = "2023-08-02 14:00:00";
		String now = formatter.format(date);
		Date update_date = formatter.parse(update);
		Date now_date = formatter.parse(now);
		
		String session = (String)request.getSession().getAttribute("name");
		if(now_date.after(update_date)) {
			if(session == null || session == "null") {
				return "redirect:/center_login.do";
			}
			else {
				return "/pict/center/center_caution";
			}
		}
		else {
			return "redirect:/center_noti.do";
		}
		
	}
	//점검중안내
	@RequestMapping(value = "/center_noti.do")
	public String center_noti(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String update = "2023-08-02 14:00:00";
		String now = formatter.format(date);
		Date update_date = formatter.parse(update);
		Date now_date = formatter.parse(now);
		
		String session = (String)request.getSession().getAttribute("name");
		if(now_date.after(update_date)) {
			if(session == null || session == "null") {
				return "redirect:/center_login.do";
			}
			else {
				return "/pict/center/center_caution";
			}
		}
		else {
			return "/pict/center/center_noti";
		}
		
		
	}
	
	//업로드
	@RequestMapping(value = "/center_upload.do")
	public String center_upload(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {
		String session = (String)request.getSession().getAttribute("name");
		
		if(session == null || session == "null") {
			return "redirect:/center_login.do";
		}
		
		return "/pict/center/center_upload";
	}
	//마이페이지
	@RequestMapping(value = "/center_mypage.do")
	public String center_mypage(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		String session = (String)request.getSession().getAttribute("name");
		String user_id = (String)request.getSession().getAttribute("idx");
		String mobile = (String)request.getSession().getAttribute("mobile");
		
		if(session == null || session == "null") {
			return "redirect:/center_login.do";
		}
		pictVO.setUser_id(user_id);
		PictVO vo = new PictVO();
		vo = pictService.user_bill_accept(pictVO);
		List<PictVO> bill_list = pictService.user_bill_list(pictVO);
		
		model.addAttribute("resultList", bill_list);
		model.addAttribute("vo", vo);
		
		return "/pict/center/center_mypage";
	}
	//센터 로그인
	@RequestMapping(value = "/login_center.do")
	public String login_center(@ModelAttribute("serchVO") PictVO pictVO, HttpServletRequest request,  ModelMap model) throws Exception {
		//처음 드러와서 세션에 정보있으면 메인으로 보내줘야함
		String input_name = pictVO.getName();
		String input_mobile = pictVO.getMobile();
		
		pictVO = pictService.center_get_user_info(pictVO);

		if (pictVO != null && pictVO.getName() != null && !pictVO.getMobile().equals("")) {
			if((pictVO.getAddress() == null || pictVO.getAddress().equals(null) || pictVO.getAddress().equals("")) && (pictVO.getAddress_ty() == null || pictVO.getAddress_ty().equals(""))) {
				model.addAttribute("pictVO", pictVO);
				model.addAttribute("message", "주소지 정보가 없습니다.<br>주소지 입력 페이지로 이동합니다.");
				model.addAttribute("retType", ":submit");
				model.addAttribute("retUrl", "/center_address.do");
				return "pict/main/message";
			}
			
			if(input_name.equals(pictVO.getName()) && input_mobile.equals(pictVO.getMobile())) {
				request.getSession().setAttribute("idx", pictVO.getIdx()+"");
				request.getSession().setAttribute("mobile", pictVO.getMobile());
				request.getSession().setAttribute("name", pictVO.getName());
				
				model.addAttribute("message", "");
				model.addAttribute("retType", ":location");
				model.addAttribute("retUrl", "/center_caution.do");
				return "pict/main/message";
				
			}
			else {
				model.addAttribute("message", "입력하신 정보가 일치하지 않습니다.");
				model.addAttribute("retType", ":location");
				model.addAttribute("retUrl", "/center_login.do");
				return "pict/main/message";
			}
		}
		else {
			PictVO vo = new PictVO();
			vo.setName(input_name);
			vo.setMobile(input_mobile);
			pictService.center_address_insert(vo);
			
			model.addAttribute("pictVO", vo);
			model.addAttribute("message", "주소지 정보가 없습니다.<br>주소지 입력 페이지로 이동합니다.");
			model.addAttribute("retType", ":submit");
			model.addAttribute("retUrl", "/center_address.do");
			return "pict/main/message";
			
			
		}
	}
	//주소 후 로그인
	@RequestMapping(value = "/login_address.do")
	public String login_address(@ModelAttribute("searchVO") PictVO pictVO, HttpServletRequest request,  ModelMap model) throws Exception {
		System.out.println(request.getParameter("idx"));
		System.out.println("타기전::::::::::::::::::::::"+pictVO.getIdx());
		pictService.center_address_update(pictVO);
		System.out.println("타기후::::::::::::::::::::::"+pictVO.getIdx());
		request.getSession().setAttribute("idx", pictVO.getIdx()+"");
		request.getSession().setAttribute("mobile", pictVO.getMobile());
		request.getSession().setAttribute("name", pictVO.getName());
		
		model.addAttribute("message", "");
		model.addAttribute("retType", ":location");
		model.addAttribute("retUrl", "/center_caution.do");
		return "pict/main/message";
	}
	//센터로그아웃
	@RequestMapping(value = "/center_logout.do")
	public String center_logout(@ModelAttribute("searchVO") PictVO pictVO, HttpServletRequest request,  ModelMap model) throws Exception {
		request.getSession().setAttribute("idx", null);
		request.getSession().setAttribute("mobile", null);
		request.getSession().setAttribute("name", null);
		
		return "redirect:/center_login.do";
		
	}
	//테스트
    @RequestMapping(value = "/test.do")
	public String test(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {
    	List<PictVO> reference_list = pictService.test_user_list(pictVO);
		model.addAttribute("resultList", reference_list);
		
		String userAgent = request.getHeader("user-agent");
		
		boolean mobile1 = userAgent.matches( ".*(iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson).*");
		boolean mobile2 = userAgent.matches(".*(LG|SAMSUNG|Samsung).*"); 
		if (mobile1 || mobile2) {
		    //여기 모바일일 경우
			
			model.addAttribute("type", "mobile");
			
		}
		else {
			model.addAttribute("type", "pc");
		}
		
		
		return "pict/test";
	}
    @RequestMapping(value = "/test_list.do")
	public String test_list(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {
    	List<PictVO> reference_list = pictService.test_list(pictVO);
		int total = 0;
		int cnt = 0;
		if(reference_list.size() > 0 && reference_list.get(0).getCnt() != null) {
			cnt = Integer.parseInt(reference_list.get(0).getCnt());//티켓매수 세팅
		}
			
		model.addAttribute("cnt", cnt);
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		for (int i = 0; i < reference_list.size(); i++) {
			if(reference_list.get(i).getUse_at() != null && reference_list.get(i).getUse_at().equals("1"))
				if(reference_list.get(i).getPrice() != null)
					total += Integer.parseInt(reference_list.get(i).getPrice());
		}
		model.addAttribute("total", total);
		
		if((pictVO.getSearch_text() == null && pictVO.getSearch_mobile() == null) || (pictVO.getSearch_text().equals("") && pictVO.getSearch_mobile().equals(""))) {
			model.addAttribute("resultList", "");
		}
		else {
			model.addAttribute("resultList", reference_list);
		}
		model.addAttribute("pictVO", pictVO);
		
		return "pict/test_list";
	}
    //영수증 출력(관리자)
    @RequestMapping(value = "/print_list.do")
	public String print_list(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {
    	
    	List<PictVO> reference_list = pictService.test_user_list(pictVO);
		model.addAttribute("resultList", reference_list);
		model.addAttribute("pictVO", pictVO);
		
		return "pict/print_list";
	}
    
    @RequestMapping(value = "/print_recipt.do")
	public String print_recipt(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {
    	
    	
    	//pictVO = pictService.bill_info(pictVO);
    	List<PictVO> reference_list = pictService.bill_img_list(pictVO);

    	
		model.addAttribute("resultList", reference_list);
		model.addAttribute("pictVO", pictVO);
		pictService.bill_print(pictVO);
		return "pict/print_recipt";
	}
    
    @RequestMapping(value = "/print_ajax.do")
    @ResponseBody
	public Map<String, Object> print_ajax(@RequestParam Map<String, Object> input) throws Exception {
    	Map<String, Object> returnMap = new HashMap<>();
    	PictVO pictVO = new PictVO();
    	System.out.println(input+"@########################");
    	
    	
    	pictVO.setUser_id(input.get("user_id").toString());
    	//pictVO.setUser_id("10248");
    	Map<String, Object> map = pictService.print_person(pictVO);
    	System.out.println("222222222222222222222222222222222222222222");
    	List<PictVO> codeList = (List<PictVO>) map.get("resultList");
    	System.out.println("3333333333333333333333333333333333333333333333333");
        returnMap.put("list", codeList);
    	System.out.println(codeList);
		
		
		return returnMap;
	}
    
    
    
    @RequestMapping(value = "/test_register.do")
	public String test_register(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {
    	String search_text = pictVO.getSearch_text_form();
    	String search_num = pictVO.getSearch_num_form();
    	String use_at_name = pictVO.getUse_at_name();
		if(pictVO.getIdx() != 0) {
			//수정
			pictVO = pictService.test_list_one(pictVO);
			pictVO.setSaveType("update");
			
		}
		else {
			pictVO.setSaveType("insert");
		}
		pictVO.setSearch_text_form(search_text);
		pictVO.setSearch_num_form(search_num);
		pictVO.setUse_at_name(use_at_name);
		model.addAttribute("pictVO", pictVO);
		return "pict/test_register";
	}
    @RequestMapping(value = "/test_user_register.do")
	public String test_user_register(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {
    	String referer = (String)request.getHeader("REFERER");
    	
		
    	pictVO = pictService.test_user_one(pictVO);
		model.addAttribute("pictVO", pictVO);
		
		model.addAttribute("history_url", referer);
		return "pict/test_user_register";
	}
    @RequestMapping(value = "/test_user_save.do", method = RequestMethod.POST)
	public String test_user_save(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, MultipartHttpServletRequest request) throws Exception {
   
    	
    	if(pictVO.getSaveType() != null && pictVO.getSaveType().equals("update")) {
    		pictService.update_user_info(pictVO);
    	}
    	else {
    		pictService.insert_user_info(pictVO);
    	}
    	
    	
		model.addAttribute("message", "정상적으로 등록되었습니다.");
		model.addAttribute("retType", ":location");
		model.addAttribute("retUrl", pictVO.getHistory_url());
		
		
		
		return "pict/main/message";
	}
    @RequestMapping(value = "/test_save.do", method = RequestMethod.POST)
	public String test_save(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, MultipartHttpServletRequest request) throws Exception {
    	String search_text = pictVO.getSearch_text_form();
    	String search_num = pictVO.getSearch_num_form();
    	String search_text_form = pictVO.getSearch_text_form();
    	String use_at_name = pictVO.getUse_at_name();
    	
    	pictVO.setUse_at(pictVO.getUse_at().substring(0,1));
    	
		if(pictVO.getSaveType() != null && pictVO.getSaveType().equals("update")) {
			pictService.bill_update(pictVO);
			model.addAttribute("message", "정상적으로 수정되었습니다.");
			model.addAttribute("retType", ":location");
			model.addAttribute("retUrl", "/test_list.do?search_text=" +search_text+"&search_mobile=" + search_num + "&search_text_form=" + search_text_form+"&use_at="+use_at_name );
			return "pict/main/message";
		}
		else {
			pictService.bill_insert(pictVO);
			model.addAttribute("message", "정상적으로 저장되었습니다.");
			model.addAttribute("retType", ":location");
			model.addAttribute("retUrl", "/test_list.do?search_text=" +search_text+"&search_mobile=" + search_num + "&search_text_form=" + search_text_form+"&use_at="+use_at_name );
			return "pict/main/message";	
		}
	}
    @RequestMapping(value = "/test_confirm.do", method = RequestMethod.POST)
	public String test_confirm(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, MultipartHttpServletRequest request) throws Exception {
    	String search_text = pictVO.getSearch_text_form();
    	String search_num = pictVO.getSearch_num_form();
		String[] applIdArr = pictVO.getCheck_list().split(",");
        for(int i=0; i<applIdArr.length; i++) {
        	pictVO.setIdx(Integer.parseInt(applIdArr[i]));
        	pictService.confirm_update(pictVO);
        }
        model.addAttribute("message", "정상적으로 처리되었습니다.");
		model.addAttribute("retType", ":location");
		model.addAttribute("retUrl", "/test_list.do?search_text=" +search_text+"&search_mobile=" + search_num);
		return "pict/main/message";	
	}
    @RequestMapping(value = "/test_excel.do", method = RequestMethod.POST)
   	public String test_excel(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, MultipartHttpServletRequest request,
   			@RequestParam("attach_excel") MultipartFile attach_excel) throws Exception {
    	
    	try {
	    	List<PictVO> dataList = new ArrayList<>();
	        String extension = FilenameUtils.getExtension(attach_excel.getOriginalFilename()); // 3
	
	        if (!extension.equals("xlsx") && !extension.equals("xls")) {
	          throw new IOException("엑셀파일만 업로드 해주세요.");
	        }
	
	        Workbook workbook = null;
	
	        if (extension.equals("xlsx")) {
	          workbook = new XSSFWorkbook(attach_excel.getInputStream());
	        } else if (extension.equals("xls")) {
	          workbook = new HSSFWorkbook(attach_excel.getInputStream());
	        }
	
	        Sheet worksheet = workbook.getSheetAt(0);
	
	        for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); i++) { // 4
	        	Row row = worksheet.getRow(i);
	        	String ticket = row.getCell(0).getStringCellValue();	//대표티켓번호
	        	String cnt = row.getCell(1).getNumericCellValue()+"".replaceAll(".0", "");	//최종티켓 매수
	        	String name = row.getCell(2).getStringCellValue();	//주문자명
	        	String mobile = row.getCell(3).getStringCellValue().replaceAll("-", "");//휴대전화번호

	        	/*
	        	String pay_method = row.getCell(4).getStringCellValue();//결제방식 얼리버드/ 일반

	        	if(pay_method.equals("일반")) {
	        		pay_method = "0";
	        	}
	        	else {
	        		pay_method = "1";
	        	}
	        	*/
	        	pictVO.setTicket(ticket);
	        	cnt = cnt.replaceAll(".0","");
	        	pictVO.setCnt(cnt);
	        	pictVO.setName(name);
	        	pictVO.setMobile(mobile);
	        	//pictVO.setPay_method(pay_method);
	        	
	        	PictVO vo = new PictVO();
	        	vo.setName(name);
	        	vo.setMobile(mobile);
	        	vo.setTicket(ticket);
	        	vo = pictService.select_user(vo);
  
	        	if(vo == null || (vo.getName() == null && vo.getMobile() == null)) {	//데이터 조회했을때 없으면 insert
	        		pictService.insert_user_info(pictVO);
	        	}
	        	else {	//사전등록은 하셨음 영수증도 올리겠지? 그럼 매수 업데이트
	        		pictVO.setIdx(vo.getIdx());
	        		int total_cnt = Integer.parseInt(cnt) + Integer.parseInt(vo.getCnt());
	        		pictVO.setCnt(total_cnt+"");
	        		pictService.update_user_info(pictVO);
	        	}
	          
	        }
	    	
	    	
	    	model.addAttribute("message", "정상적으로 처리되었습니다.");
	    	model.addAttribute("retType", ":location");
	        model.addAttribute("retUrl", "/test.do");
	        return "pict/main/message";
    	}
    	catch(Exception e) {
    		System.out.println(e);
    		model.addAttribute("message", "엑셀업로드 오류 발생.");
	    	model.addAttribute("retType", ":location");
	        model.addAttribute("retUrl", "/test.do");
	        return "pict/main/message";
    	}
        	
   	}
    
    
    //이미지 리사이징 메소드
    public static BufferedImage resize(InputStream input, int width, int height) throws IOException{
    	BufferedImage inputImage = ImageIO.read(input);
    	BufferedImage outImgage = new BufferedImage(width, height, inputImage.getType());
    	
    	Graphics2D g2D = outImgage.createGraphics();
    	g2D.drawImage(inputImage, 0, 0, width, height, null);
    	g2D.dispose();
    	
    	return outImgage; 
    }
    @RequestMapping(value = "/test2.do", method = RequestMethod.POST)
    @ResponseBody
	public String test2(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, MultipartHttpServletRequest request,
			@RequestParam("attach_file") MultipartFile attach_file
			) throws Exception {
    	String user_id = request.getSession().getAttribute("idx")+"";
		
    	String msg = "정상적으로 저장되었습니다.";
    	if(attach_file.getSize() != 0) {	//애드벌룬
    		UUID uuid = UUID.randomUUID();
			String uploadPath = fileUpload(request, attach_file, (String)request.getSession().getAttribute("id"), uuid);
			String filepath = "/user1/upload_file/billconcert/";
			//String filepath = "D:\\user1\\upload_file\\billconcert\\";
			String filename = uuid+uploadPath.split("#####")[1];
			
			/*
			File file = new File(filepath+filename);
			InputStream input = new FileInputStream(file);
			Image img = new ImageIcon(file.toString()).getImage();
			int width = 720;
			int height = 1280;
			BufferedImage resize = resize(input, width, height);
			ImageIO.write(resize, "jpg", new File(filepath+filename));
			*/
			pictVO.setImg_url(filepath+filename);
			pictVO.setIdx(Integer.parseInt(user_id));
			
			pictService.bill_insert(pictVO);
			System.out.println("방금드간키:::::::::::::::::::::::"+pictVO.getIdx());
		}

		try {
			pictVO = pictService.bill_select(pictVO);
			
			String apiURL = "https://j47zqn4a1v.apigw.ntruss.com/custom/v1/24537/af4b6aa9d71b101495711fd1962d82a706f97238f1bcbf9e346d7dcb605c8ab8/document/receipt";
			String secretKey = "R0tvUG9PS2VGdVpNZWtpY3BzenBGSVJ6bUtnZlRiZXk=";
			String imageFile = //"http://www.chuncheonkoreaopen.org"+pictVO.getImg_url();
				pictVO.getImg_url();
			//"D:\\test\\"+pictVO.getImg_url();
			
			
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setUseCaches(false);
			con.setDoInput(true);
			con.setDoOutput(true);
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/json; charset=utf-8");
			con.setRequestProperty("X-OCR-SECRET", secretKey);

			JSONObject json = new JSONObject();
			json.put("version", "V2");
			json.put("requestId", UUID.randomUUID().toString());
			json.put("timestamp", System.currentTimeMillis());
			JSONObject image = new JSONObject();
			image.put("format", "jpg");
			//image should be public, otherwise, should use data
			FileInputStream inputStream = new FileInputStream(imageFile);
			byte[] buffer = new byte[inputStream.available()];
			inputStream.read(buffer);
			inputStream.close();
			image.put("data", buffer);
			image.put("name", "demo");
			JSONArray images = new JSONArray();
			images.put(image);
			
			json.put("images", images);
			String postParams = json.toString();

			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(postParams);
			wr.flush();
			wr.close();

			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			
			
			JSONParser parser = new JSONParser();
			//전체 파싱
			JSONObject obj = (JSONObject) parser.parse( response.toString() );
			JSONObject jsonObj = (JSONObject) obj;
			
			//images 데이터 문자열
			String str = jsonObj.get("images").toString();
			String match = "[^0-9]";
			System.out.println(str);
			//사업장 파싱
			String name = "";
			if(str.split("name").length > 1 &&
				str.split("name")[2].split("text").length > 1 &&
				str.split("name")[2].split("text")[1].split("\",").length > 1)
			name = str.split("name")[2].split("text")[1].split("\",")[0];
			name = name.replaceAll("\":\"", "");
			name = name.replaceAll(" ", "");
			pictVO.setName(name);
			System.out.println("사업장 끝");
			//사업자등록번호 파싱
			String biz_num = "";
			if(str.split("bizNum").length > 1 &&
				str.split("bizNum")[1].split("text").length > 1 &&
				str.split("bizNum")[1].split("text")[1].split("\",").length > 1)
			biz_num = str.split("bizNum")[1].split("text")[1].split("\",")[0];
			biz_num = biz_num.replaceAll(match, "");
			pictVO.setBiz_num(biz_num);
			System.out.println("사업자등록번호 끝");
			//주소 파싱
			String address = "";
			if(str.split("addresses").length > 1 &&
				str.split("addresses")[1].split("text").length > 1 &&
				str.split("addresses")[1].split("text")[1].split("\",").length > 1)
			address = str.split("addresses")[1].split("text")[1].split("\",")[0];
			address = address.replaceAll("\":\"", "");
			pictVO.setAddress(address);
			System.out.println("주소 끝");
			//승인번호 파싱
			String confirm_num = "";
			if(str.split("confirmNum").length > 1 &&
				str.split("confirmNum")[1].split("text").length > 1 &&
				str.split("confirmNum")[1].split("text")[1].split("\"}").length > 1)
			confirm_num = str.split("confirmNum")[1].split("text")[1].split("\"}")[0];
			confirm_num = confirm_num.replaceAll(match, "");
			pictVO.setConfirm_num(confirm_num);
			System.out.println("승인번호 끝");
			//승인날짜 파싱
			String date = "";
			if(str.split("date").length > 1 &&
				str.split("date")[1].split("text").length > 1 &&
				str.split("date")[1].split("text")[1].split("\",").length > 1)
			date = str.split("date")[1].split("text")[1].split("\",")[0];
			date = date.replaceAll(match, "");
			pictVO.setDate(date);
			System.out.println("승인날짜 끝");
			
			//금액 파싱
			String price = "0";
			if(str.split("totalPrice").length > 1 &&
				str.split("totalPrice")[1].split("price").length > 1 &&
				str.split("totalPrice")[1].split("price")[1].split("value").length > 1 &&
				str.split("totalPrice")[1].split("price")[1].split("value")[1].split("\"}").length > 1)
				
			price = str.split("totalPrice")[1].split("price")[1].split("value")[1].split("\"}")[0];
			price = price.replaceAll(match, "");
			pictVO.setPrice(price);
			System.out.println("금액 끝");
		
			String flag = "success";
			//영수증 미인증 대상 업체 리스트
			List<PictVO> non_hospital = pictService.non_hospital(pictVO);	//병원리스트
			List<PictVO> confirm_num_list = pictService.confirm_num_list(pictVO);//승인번호 조회
			List<PictVO> non_list = pictService.non_list(pictVO);	//대형마트리스트
			
			
			System.out.println("사업장 :::::::::" + name);
			System.out.println("사업자등록번호 :::::::::" + biz_num);
			System.out.println("사업장주소 :::::::::" + address);
			System.out.println("승인번호:::::::::" + confirm_num);
			System.out.println("승인날짜:::::::::" + date);
			System.out.println("승인금액:::::::::" + price);
			
			
			System.out.println(address.contains("제천"));
			
			//필수정보들 있는지 확인
			if((name.equals("") || biz_num.equals("") || address.equals("") || price.equals("0")) ) {
				System.out.println("승인번호 제외 내용들중에 뭔가 없어");
				flag = "content";
			}
			//필수정보중에 제천여부 확인
			if(!address.contains("제천")) {
				System.out.println("제천이 아니래");
				flag = "space";
			}
			//대형마트 불가
			if(non_list.size() > 0) {
				System.out.println("대형마트야");
				flag = "mart";
			}
			//병원 불가
			if(non_hospital.size() > 0) {
				System.out.println("병원이야");
				flag = "hospital";
			}
			//승인번호 중복이면 체크
			if(!confirm_num.equals("")) {
				if(confirm_num_list.size() > 0) {
					System.out.println("승인번호 중복이야");
					flag = "confirm_num";
				}
			}
			else {
				flag = "confirm_num_space";
			}
			
			//flag 컬럼에 confirm_num기입하고 패스
			if(flag.equals("confirm_num")){
				PictVO dupleVO = new PictVO();
				dupleVO.setIdx(pictVO.getIdx());
				dupleVO.setFlag(flag);
				pictService.bill_update(dupleVO);
				return "confirm_num";
			}
			if(flag.equals("success")){
				pictVO.setUse_at("1");
			}
			else {
				pictVO.setUse_at("0");
			}
			
			pictVO.setFlag(flag);
			
			
		} catch (Exception e) {
			System.out.println("zzzzzzzzzzzzzzzzzzzzzzz");
			System.out.println(e);
			return "N";
		}
		
		
		pictService.bill_update(pictVO);
		System.out.println("여기 Y직전");
		return "Y";
		//model.addAttribute("message", msg);
		//model.addAttribute("retType", ":alert");
		//return "pict/main/message";
	}
    @RequestMapping(value = "/test3.do", method = RequestMethod.POST)
    @ResponseBody
	public String test3(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, MultipartHttpServletRequest request,
			@RequestParam("attach_file") MultipartFile attach_file
			) throws Exception {
    	String user_id = pictVO.getUser_id();
    	String msg = "정상적으로 저장되었습니다.";
    	if(attach_file.getSize() != 0) {	//애드벌룬
    		UUID uuid = UUID.randomUUID();
			String uploadPath = fileUpload(request, attach_file, (String)request.getSession().getAttribute("id"), uuid);
			String filepath = "/user1/upload_file/billconcert/";
			//String filepath = "D:\\user1\\upload_file\\billconcert\\";
			String filename = uuid+uploadPath.split("#####")[1];
			pictVO.setImg_url(filepath+filename);
			pictVO.setIdx(Integer.parseInt(user_id));
			
			System.out.println(user_id + "kjasbdkajsbdkajdbakjsdbakjdbakjbakjbaksjdbaksjbd");
			pictService.bill_insert(pictVO);
			System.out.println("방금드간키:::::::::::::::::::::::"+pictVO.getIdx());
		}

		try {
			pictVO = pictService.bill_select(pictVO);
			
			String apiURL = "https://j47zqn4a1v.apigw.ntruss.com/custom/v1/22988/672aca9a2a1e25c91af1dc994f754750952df305d12eba9a82d5254d7ad90775/document/receipt";
			String secretKey = "bWVDS0NGWUNmam5lRWF5U3VEWld6UXBFQlR6SmNlV20=";
			String imageFile = //"http://www.chuncheonkoreaopen.orgg"+pictVO.getImg_url();
				pictVO.getImg_url();
			//"D:\\test\\"+pictVO.getImg_url();
			
			
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setUseCaches(false);
			con.setDoInput(true);
			con.setDoOutput(true);
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/json; charset=utf-8");
			con.setRequestProperty("X-OCR-SECRET", secretKey);

			JSONObject json = new JSONObject();
			json.put("version", "V2");
			json.put("requestId", UUID.randomUUID().toString());
			json.put("timestamp", System.currentTimeMillis());
			JSONObject image = new JSONObject();
			image.put("format", "jpg");
			//image should be public, otherwise, should use data
			FileInputStream inputStream = new FileInputStream(imageFile);
			byte[] buffer = new byte[inputStream.available()];
			inputStream.read(buffer);
			inputStream.close();
			image.put("data", buffer);
			image.put("name", "demo");
			JSONArray images = new JSONArray();
			images.put(image);
			
			json.put("images", images);
			String postParams = json.toString();

			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(postParams);
			wr.flush();
			wr.close();

			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			
			
			JSONParser parser = new JSONParser();
			//전체 파싱
			JSONObject obj = (JSONObject) parser.parse( response.toString() );
			JSONObject jsonObj = (JSONObject) obj;
			
			//images 데이터 문자열
			String str = jsonObj.get("images").toString();
			String match = "[^0-9]";
			System.out.println(str);
			//사업장 파싱
			String name = "";
			if(str.split("name").length > 1 &&
				str.split("name")[2].split("text").length > 1 &&
				str.split("name")[2].split("text")[1].split("\",").length > 1)
			name = str.split("name")[2].split("text")[1].split("\",")[0];
			name = name.replaceAll("\":\"", "");
			name = name.replaceAll(" ", "");
			pictVO.setName(name);
			System.out.println("사업장 끝");
			//사업자등록번호 파싱
			String biz_num = "";
			if(str.split("bizNum").length > 1 &&
				str.split("bizNum")[1].split("text").length > 1 &&
				str.split("bizNum")[1].split("text")[1].split("\",").length > 1)
			biz_num = str.split("bizNum")[1].split("text")[1].split("\",")[0];
			biz_num = biz_num.replaceAll(match, "");
			pictVO.setBiz_num(biz_num);
			System.out.println("사업자등록번호 끝");
			//주소 파싱
			String address = "";
			if(str.split("addresses").length > 1 &&
				str.split("addresses")[1].split("text").length > 1 &&
				str.split("addresses")[1].split("text")[1].split("\",").length > 1)
			address = str.split("addresses")[1].split("text")[1].split("\",")[0];
			address = address.replaceAll("\":\"", "");
			pictVO.setAddress(address);
			System.out.println("주소 끝");
			//승인번호 파싱
			String confirm_num = "";
			if(str.split("confirmNum").length > 1 &&
				str.split("confirmNum")[1].split("text").length > 1 &&
				str.split("confirmNum")[1].split("text")[1].split("\"}").length > 1)
			confirm_num = str.split("confirmNum")[1].split("text")[1].split("\"}")[0];
			System.out.println(confirm_num);
			confirm_num = confirm_num.replaceAll(match, "");
			pictVO.setConfirm_num(confirm_num);
			System.out.println("승인번호 끝");
			//승인날짜 파싱
			String date = "";
			if(str.split("date").length > 1 &&
				str.split("date")[1].split("text").length > 1 &&
				str.split("date")[1].split("text")[1].split("\",").length > 1)
			date = str.split("date")[1].split("text")[1].split("\",")[0];
			date = date.replaceAll(match, "");
			pictVO.setDate(date);
			System.out.println("승인날짜 끝");
			
			//금액 파싱
			String price = "0";
			if(str.split("totalPrice").length > 1 &&
				str.split("totalPrice")[1].split("price").length > 1 &&
				str.split("totalPrice")[1].split("price")[1].split("text").length > 1 &&
				str.split("totalPrice")[1].split("price")[1].split("text")[1].split("\"}").length > 1)
				
			price = str.split("totalPrice")[1].split("price")[1].split("text")[1].split("\"}")[0];
			price = price.replaceAll(match, "");
			pictVO.setPrice(price);
			System.out.println("금액 끝");
		
			String flag = "success";
			//영수증 미인증 대상 업체 리스트
			List<PictVO> non_hospital = pictService.non_hospital(pictVO);	//병원리스트
			List<PictVO> confirm_num_list = pictService.confirm_num_list(pictVO);//승인번호 조회
			List<PictVO> non_list = pictService.non_list(pictVO);	//대형마트리스트
			
			//필수정보들 있는지 확인
			if((name.equals("") || biz_num.equals("") || address.equals("") || price.equals("0")) ) {
				System.out.println("승인번호 제외 내용들중에 뭔가 없어");
				flag = "content";
			}
			//승인번호 중복이면 체크
			if(!confirm_num.equals("")) {
				if(confirm_num_list.size() > 0) {
					System.out.println("승인번호 중복이야");
					flag = "confirm_num";
				}
			}
			
			//필수정보중에 제천여부 확인
			if(!address.contains("제천")) {
				System.out.println("제천이 아니래");
				flag = "space";
			}
			//대형마트 불가
			if(non_list.size() > 0) {
				System.out.println("대형마트야");
				flag = "mart";
			}
			//병원 불가
			if(non_hospital.size() > 0) {
				System.out.println("병원이야");
				flag = "hospital";
			}
			//flag 컬럼에 confirm_num기입하고 패스
			if(flag.equals("confirm_num")){
				
			}
			if(flag.equals("success")){
				pictVO.setUse_at("1");
			}
			else {
				pictVO.setUse_at("0");
			}
			
			pictVO.setFlag(flag);
			System.out.println("사업장 :::::::::" + name);
			System.out.println("사업자등록번호 :::::::::" + biz_num);
			System.out.println("사업장주소 :::::::::" + address);
			System.out.println("승인번호:::::::::" + confirm_num);
			System.out.println("승인날짜:::::::::" + date);
			System.out.println("승인금액:::::::::" + price);
			
		} catch (Exception e) {
			System.out.println("zzzzzzzzzzzzzzzzzzzzzzz");
			System.out.println(e);
			return "N";
		}
		
		
		pictService.bill_update(pictVO);
		System.out.println("여기 Y직전");
		return "Y";
		//model.addAttribute("message", msg);
		//model.addAttribute("retType", ":alert");
		//return "pict/main/message";
	}
    @RequestMapping(value = "/test_user_list.do")
	public String test_user_list(@ModelAttribute("searchVO") PictVO pictVO, ModelMap model, HttpServletRequest request) throws Exception {

		List<PictVO> reference_list = pictService.test_user_list(pictVO);
		model.addAttribute("resultList", reference_list);
		model.addAttribute("pictVO", pictVO);
		
		return "pict/test_user_list";
	}

    //메소드
 	public static String encryptPassword(String password, String id) throws Exception {
 		if (password == null) return "";
 		if (id == null) return ""; // KISA 보안약점 조치 (2018-12-11, 신용호)
 		byte[] hashValue = null; // 해쉬값
 	
 		MessageDigest md = MessageDigest.getInstance("SHA-256");
 		md.reset();
 		md.update(id.getBytes());
 		hashValue = md.digest(password.getBytes());
 	
 		return new String(Base64.encodeBase64(hashValue));
     }
 	public String fileUpload(MultipartHttpServletRequest request, MultipartFile uploadFile, String target, UUID uuid) {
     	String path = "";
     	String fileName = "";
     	OutputStream out = null;
     	PrintWriter printWriter = null;
     	long fileSize = uploadFile.getSize();
     	try {
     		fileName = uploadFile.getOriginalFilename();
     		byte[] bytes = uploadFile.getBytes();
     		
 			path = getSaveLocation(request, uploadFile);
     		
     		File file = new File(path);
     		if(fileName != null && !fileName.equals("")) {
     			if(file.exists()) {
     				file = new File(path + uuid + fileName);
     			}
     		}
     		out = new FileOutputStream(file);
     		out.write(bytes);
     		
     		
     	}
     	catch(Exception e) {
     		e.printStackTrace();
     	}
     	
     	return path + "#####" + fileName;
     }
    private String getSaveLocation(MultipartHttpServletRequest request, MultipartFile uploadFile) {
     	String uploadPath = "/user1/upload_file/billconcert/";
     	//String uploadPath = "D:\\user1\\upload_file\\billconcert\\";
     	return uploadPath;
     }
  
}
