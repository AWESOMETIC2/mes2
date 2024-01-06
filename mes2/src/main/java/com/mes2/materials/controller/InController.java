package com.mes2.materials.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mes2.materials.domain.Criteria;
import com.mes2.materials.domain.InDTO;
import com.mes2.materials.domain.PageVO;
import com.mes2.materials.domain.SearchDTO;
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
		public String insertInPOST(InDTO idto, Model model) throws Exception {
		
			// 한글인코딩 (필터)
			// 전달정보 저장
			logger.debug(" idto : " + idto);
			
			
			
			
			
			
			
		    // 서비스 - stock 수량 업데이트 호출
		    iService.InupdateQuantity(idto.getProduct_code(), idto.getQuantity(), idto.getCategory());
			
			logger.debug(" /materials/inlist 이동 ");

			return "redirect:/materials/inlist";
		}
		
		// 입고 리스트 - GET
		@GetMapping(value = "/inlist")
		public void listAllGET(Model model, SearchDTO sDTO, Criteria cri, 
				@RequestParam(value="searchType", required = false) String searchType,
				@RequestParam(value="keyword", required = false) String keyword) throws Exception {
		
			// 서비스 - 디비에 저장된 글 가져오기
			// 페이지 블럭 정보 준비 -> view 페이지 전달
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			pageVO.setTotalCount(iService.totalInCount(cri, searchType, keyword));
			List<InDTO> inlist = iService.searchIn(searchType, keyword, cri);
			
			model.addAttribute("pageVO", pageVO);
			
			// 데이터를 연결된 뷰페이지로 전달(Model)
			model.addAttribute("inlist", inlist);
		
		}
		

		// 상태 변경
		@PostMapping(value = "/updateInStatus")
		public String updateStatus(@RequestParam(value="in_index", required = false) int in_index) throws Exception {
			int inlist = iService.updateInStatus("complete", in_index);

			return "redirect:/materials/inlist";

		}

}
