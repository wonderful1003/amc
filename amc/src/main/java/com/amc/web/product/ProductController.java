package com.amc.web.product;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.amc.service.product.ProductService;
import com.amc.common.Page;
import com.amc.common.Search;
import com.amc.service.domain.Product;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 3}")
	int pageSize;

	@Autowired
	@Qualifier("uploadFilePath")
	private FileSystemResource fsr;
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public String addProduct() throws Exception {
		return "redirect:addProduct.jsp";
	}
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product,
							@RequestParam(value="file", required=false) MultipartFile file) throws Exception {

		product.setProdImage("");
		if(file != null && !file.isEmpty()){
			product.setProdImage(file.getOriginalFilename());
		}
		
		productService.addProduct(product);
		
		return "forward:addProductConfirm.jsp";
	}
	
	@RequestMapping( value="deleteProduct", method=RequestMethod.GET )
	public String deleteProduct( @RequestParam("prodNo") int prodNo,									
									Model model ) throws Exception{
		System.out.println("/product/deleteProduct : GET");
		productService.deleteProduct(prodNo);
		model.addAttribute("menu", "manage");
		
		return "forward:/product/getGoodsList";
	}
	
	@RequestMapping( value="getGoodsProduct", method=RequestMethod.GET)
	public String getGoodsProduct( @RequestParam("prodNo") int prodNo,
								@RequestParam(value="menu",defaultValue="") String menu ,
								Model model ) throws Exception {
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);
		
		double totalStock	= product.getTotalStock();
		double Stock		= product.getStock();
		double sale 		= 100-Stock/totalStock*100;
		int result = (int)sale;
		
		product.setSalesStock(result);
		
		System.out.println( "판매 현황 좀 보고싶은데 :"+product.getSalesStock());
		
		if(menu!=""){
			if(menu.equals("manage")){
				return "forward:updateProduct?prodNo="+prodNo;
			}
		}
		return "forward:getGoodsProduct.jsp";
	}
	
	@RequestMapping( value="getSnackProduct", method=RequestMethod.GET)
	public String getSnackProduct( @RequestParam("prodNo") int prodNo,
								@RequestParam(value="menu",defaultValue="") String menu ,
								Model model ) throws Exception {
		
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);
		
		if(menu!=""){
			if(menu.equals("manage")){
				return "forward:updateProduct?prodNo="+prodNo;
			}
		}
		return "forward:getSnackProduct.jsp";
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{
		
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);
		return "forward:updateProduct.jsp";
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product, 
								 @RequestParam(value="file", required=false) MultipartFile file, 
								 Model model) throws Exception{
		product.setProdImage("");
		if(file != null && !file.isEmpty()){
			product.setProdImage(file.getOriginalFilename());
		}
		
		productService.updateProduct(product);
		product=productService.getProduct(product.getProdNo());		
		model.addAttribute("product", product);
		
		if(product.getProdType()!="G"){
				return "forward:getGoodsProduct.jsp?menu=manage&prodNo="+product.getProdNo();
		}
		return "forward:getSnackProduct.jsp?menu=manage&prodNo="+product.getProdNo();
	}
			
	@RequestMapping(value="getGoodsList")
	public String getGoodsList( @ModelAttribute("search") Search search , Model model , 								
								@RequestParam("menu") String menu, @RequestParam("searchKeyword") String searchKeyword,
								HttpSession session) throws Exception{
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		if(search.getSearchCondition() == null){
			search.setSearchCondition("1");
		}
		if(menu.equals("manage")){
			search.setStockView(true);
		}
		search.setPageSize(12);
		search.setPageUnit(pageUnit);		
		// Business logic 수행
		Map<String , Object> map=productService.getGoodsList(search);
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$############# MAP :"+map);
		
//		Product product = new Product();
//		
//		double totalStock	= ((Product)map.get("product")).getTotalStock();
//		double Stock		= ((Product)map.get("product")).getStock();
//		double sale 		= Stock/totalStock*100;
//		int result = (int)sale;
//		
//		product.setSalesStock(result);
		
		System.out.println(map.get("list"));
		System.out.println((Product)map.get("product"));
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		/*model.addAttribute(arg0, arg1);*/
		/*model.addAttribute("search", map.get(search));*/
		
		System.out.println("session 이거뭐야 :"+session.getAttribute("user"));
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@LIST :"+map.get("list"));
		System.out.println("############################### MAP :"+map);
		
		return "forward:/product/listGoodsProduct.jsp?menu="+menu;
	}
	
	@RequestMapping(value="getSnackList")
	public String getSnackList( @ModelAttribute("search") Search search , Model model ,
								@RequestParam("menu") String menu, @RequestParam("searchKeyword") String searchKeyword,
								HttpSession session) throws Exception{
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		if(search.getSearchCondition() == null){
			search.setSearchCondition("1");
		}
		if(menu.equals("manage")){
			search.setStockView(true);
		}
		search.setPageSize(12);
		search.setPageUnit(pageUnit);
		// Business logic 수행
		Map<String , Object> map=productService.getSnackList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listSnackProduct.jsp?menu="+menu;
	}

}
