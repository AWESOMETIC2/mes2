package com.mes2.materials.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mes2.materials.domain.InDTO;
import com.mes2.materials.service.InService;


@Controller
@RequestMapping(value = "/materials/*")
public class InController {

	private static final Logger logger = LoggerFactory.getLogger(InController.class);

	@Inject
	private InService iService;

	
	@RequestMapping(value="/in")
	public String inSelect() {
		return "/materials/in";
	}
	
	// http://localhost:8088/materials/in
	@GetMapping(value = "/inlist")
	public @ResponseBody List<InDTO> inSelect(InDTO in) throws Exception {
		
		List<InDTO> list = iService.inSelect(in);
		
		logger.debug("/materials/in -> inGET() 호출 ");
		logger.debug("/materials/in.jsp 뷰페이지로 이동");
		
		return list;
	}


	

}
