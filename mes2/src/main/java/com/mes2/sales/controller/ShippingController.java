package com.mes2.sales.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mes2.sales.service.ShippingService;

@Controller
@RequestMapping(value = "/sales/*")
public class ShippingController {

	private static final Logger logger = LoggerFactory.getLogger(ShippingController.class);

	@Inject
	private ShippingService pService;

	// http://localhost:8080/sales/shipping
	@GetMapping(value = "/shipping")
	public String shippingGET() throws Exception {
		logger.debug("/sales/shipping -> shippingGET 호출 ");
		logger.debug("/sales/shipping.jsp 뷰페이지로 이동");
		
		return "/sales/shipping";
	}
}
