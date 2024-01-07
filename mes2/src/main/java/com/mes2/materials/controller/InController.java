package com.mes2.materials.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mes2.materials.domain.Criteria;
import com.mes2.materials.domain.InDTO;
import com.mes2.materials.domain.PageVO;
import com.mes2.materials.service.InService;

@Controller
@RequestMapping(value = "/materials/*")
public class InController {

	private static final Logger logger = LoggerFactory.getLogger(InController.class);

	@Inject
	private InService iService;

	// http://localhost:8080/materials/inlist
	
	// 입고 정보 입력 - GET
	@GetMapping(value = "/in")
	public void insertInGET() throws Exception {
	}
	
	// 입고 정보 처리 - POST
		@RequestMapping(value = "/in", method = RequestMethod.POST)
		public String insertInPOST(InDTO idto, @RequestParam("product_code") String product_code,
	            @RequestParam("quantity") int quantity,
	            @RequestParam("category") String category) throws Exception {
		
			// 한글인코딩 (필터)
			// 전달정보 저장
			logger.debug(" idto : " + idto);

			// 서비스 - DB에 글쓰기(insert) 동작 호출
			iService.registerIncomingStock(idto);
			
		    // 서비스 - meta_data_product 수량 업데이트 호출
		    iService.updateQuantity(product_code, quantity, category);
			
			logger.debug(" /materials/inlist 이동 ");

			return "redirect:/materials/inlist";
		}
		
		// 입고 리스트 - GET
		@GetMapping(value = "/inlist")
		public void listAllGET(Model model, InDTO idto, Criteria cri) throws Exception {
			logger.debug("/purchase/inlist -> listAllGET() 호출 ");
			logger.debug("/purchase/inlist  뷰페이지로 이동");

			// 서비스 - 디비에 저장된 글 가져오기
			List<InDTO> inlist = iService.getIncomingStockInfo(idto);

			inlist = iService.InListPage(cri);
			
			// 페이지 블럭 정보 준비 -> view 페이지 전달
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);		
			pageVO.setTotalCount(iService.totalInCount());
			
			logger.debug(" 확인 :"+pageVO);
			model.addAttribute("pageVO", pageVO);
			
			// 데이터를 연결된 뷰페이지로 전달(Model)
			model.addAttribute("inlist", inlist);
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	@GetMapping(value = "/in")
//	public String insertInGET(Model model, @RequestParam(name = "product_code", required = false) String product_code) throws Exception {
//		List<InDTO> inList = iService.getSelect();
//		model.addAttribute("inList", inList);
//
//		  List<InDTO> detailList = iService.detailList(product_code);
//		model.addAttribute("detailList", detailList);
//		
//		
//		return "/materials/in";
//	}
//	
//
//	@PostMapping(value = "/in")
//	public String getSelectPOST(@RequestParam(name = "product_code", required = false) String product_code) throws Exception {
//		
//
//		return "/materials/in";
//	}
}